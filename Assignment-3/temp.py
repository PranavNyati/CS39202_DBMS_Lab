#  DBMS Lab Assignment 3
#  Name: Pranav Nyati
#  Roll No: 20CS30037


import mysql.connector
from mysql.connector import Error
from mysql.connector import errorcode

def choose_query():

    print("Enter a query number from 1 to 13:")
    input_query = int(input())

    proc_name = 'Bypass Surgery'

    if input_query == 13:
        print("Enter the procededure name:")
        proc_name = input()

    query_dict = {}

    query_dict[1] = """
                    SELECT Physician.Name
                    FROM Physician
                    INNER JOIN Trained_In ON Trained_In.PhysicianID = Physician.EmployeeID  
                    INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Trained_In.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';
                    """

    query_dict[2] = """
                    SELECT Physician.Name 
                    FROM Physician 
                    INNER JOIN Trained_In ON Trained_In.PhysicianID = Physician.EmployeeID 
                    INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Trained_In.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery'
                    INNER JOIN Affiliated_with ON Affiliated_with.PhysicianID = Physician.EmployeeID
                    INNER JOIN Department ON Affiliated_with.DepartmentID = Department.DepartmentID and Department.Name = 'Cardiology';
                    """

    query_dict[3] = """
                    SELECT Nurse.Name
                    FROM Nurse
                    INNER JOIN On_Call ON Nurse.EmployeeID = On_Call.NurseID
                    INNER JOIN Room ON Room.BlockFloor = On_Call.BlockFloor and Room.BlockCode = On_Call.BlockCode and Room.RoomNo = 123;
                    """
    
    query_dict[4] = """
                    SELECT Patient.Name, Patient.Address 
                    FROM Patient
                    INNER JOIN Prescribes ON Patient.SSN = Prescribes.PatientSSN
                    INNER JOIN Medication ON Medication.Code = Prescribes.Medic_Code and Medication.Name = 'remdesivir';    
                    """

    query_dict[5] = """      
                    SELECT Patient.Name, Patient.InsuranceID 
                    FROM Patient
                    INNER JOIN Stay ON Stay.PatientSSN = Patient.SSN
                    INNER JOIN Room ON Stay.RoomNo = Room.RoomNo and Room.Type = 'ICU' and DATEDIFF (Stay.End , Stay.Start ) > 15;
                    """
                
    query_dict[6] = """
                    SELECT DISTINCT Nurse.Name
                    FROM Nurse
                    INNER JOIN Undergoes ON Nurse.EmployeeID = Undergoes.AssistingNurseID
                    INNER JOIN Med_Procedure ON Undergoes.ProcedureCode = Med_Procedure.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';
                    """

    query_dict[7] = """
                    SELECT DISTINCT Nurse.Name, Nurse.Position, Physician.Name
                    FROM Nurse
                    INNER JOIN Undergoes ON Nurse.EmployeeID = Undergoes.AssistingNurseID
                    INNER JOIN Physician ON Undergoes.PhysicianID = Physician.EmployeeID
                    INNER JOIN Med_Procedure ON Undergoes.ProcedureCode = Med_Procedure.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';
                    """

    query_dict[8] = """
                    SELECT Physician.Name
                    FROM Physician
                    INNER JOIN Undergoes ON Undergoes.PhysicianID = Physician.EmployeeID
                    WHERE (Undergoes.PhysicianID , Undergoes.ProcedureCode ) NOT IN (SELECT PhysicianID, ProcedureCode FROM Trained_In);
                    """
    
    
    query_dict[9] = """
                    SELECT Physician.Name
                    FROM Physician
                    INNER JOIN Undergoes ON Physician.EmployeeID = Undergoes.PhysicianID
                    INNER JOIN Trained_In ON Trained_In.PhysicianID = Undergoes.PhysicianID and Trained_In.ProcedureCode = Undergoes.ProcedureCode and Undergoes.ProcedureDate > Trained_In.CertificationExpires;   
                    """
    
    query_dict[10] = """
                     SELECT Physician.Name, Med_Procedure.ProcedureName, Undergoes.ProcedureDate , Patient.Name
                     FROM Physician
                     INNER JOIN Undergoes ON Physician.EmployeeID = Undergoes.PhysicianID
                     INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Undergoes.ProcedureCode
                     INNER JOIN Patient ON Undergoes.PatientSSN = Patient.SSN
                     INNER JOIN Trained_In ON Trained_In.PhysicianID = Undergoes.PhysicianID and Trained_In.ProcedureCode = Undergoes.ProcedureCode and Undergoes.ProcedureDate > Trained_In.CertificationExpires;                
                     """

    query_dict[11] = """
                    WITH Patient_Data AS(
                    SELECT Patient.SSN, Patient.Name, Patient.PCP, COUNT(Patient.SSN)
                    FROM Patient
                    INNER JOIN Appointment a1 ON Patient.SSN = a1.PatientSSN
                    INNER JOIN Affiliated_with  aw1 ON aw1.PhysicianID = a1.PhysicianID
                    INNER JOIN Physician ph1 ON ph1.EmployeeID = a1.PhysicianID
                    INNER JOIN Department d1 ON d1.DepartmentID = aw1.DepartmentID and d1.Name = 'Cardiology'
                    GROUP BY Patient.SSN
                    HAVING COUNT(Patient.SSN) > 1
                    )
                    SELECT DISTINCT p1.Name, ph2.Name
                    FROM Patient_Data
                    INNER JOIN Patient p1 ON p1.SSN = Patient_Data.SSN
                    INNER JOIN Appointment a2 ON a2.PatientSSN = p1.SSN
                    INNER JOIN Affiliated_with aw2 ON aw2.PhysicianID = a2.PhysicianID
                    INNER JOIN Department d2 ON d2.DepartmentID = aw2.DepartmentID and d2.HeadID != a2.PhysicianID
                    INNER JOIN Prescribes prs1 ON prs1.PatientSSN = Patient_Data.SSN and prs1.PhysicianID = Patient_Data.PCP
                    INNER JOIN Undergoes u1 ON u1.PatientSSN = Patient_Data.SSN 
                    INNER JOIN Med_Procedure mp1 ON mp1.ProcedureCode = u1.ProcedureCode
                    INNER JOIN Physician ph2 ON p1.PCP = ph2.EmployeeID
                    WHERE mp1.cost > 5000;
                    """

    query_dict[12] = """
                    WITH Med_Freq AS (
                    SELECT Medic_Code, Count(*) as med_count
                    FROM Prescribes
                    GROUP BY Medic_Code
                    )
                    SELECT Name, Brand
                    FROM Med_Freq 
                    INNER JOIN Medication ON Medication.Code = Med_Freq.Medic_Code
                    WHERE Med_Freq.med_count = (SELECT MAX(med_count) FROM Med_Freq);
                    """

    query_dict[13] = """
                    SELECT Physician.Name
                    FROM Physician
                    INNER JOIN Trained_In ON Trained_In.PhysicianID = Physician.EmployeeID  
                    INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Trained_In.ProcedureCode and Med_Procedure.ProcedureName = '{0}';
                     """.format(proc_name)
    
    return query_dict[input_query]


# print("Enter username: ")
# username = input()
# print("Enter password: ")
# password = input()
# print("Enter the name of database: ")
# database = input()



config = {
  'user': '20CS30037',
  'password': '20CS30037',
  'host': '10.5.18.70',
  'database': '20CS30037',
  'raise_on_warnings': True,
  'connection_timeout': 180,
}


try:

    connection = mysql.connector.connect(**config)

    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)

        cursor = connection.cursor()
        # global connection timeout arguments
        global_connect_timeout = 'SET GLOBAL connect_timeout=180'
        global_wait_timeout = 'SET GLOBAL connect_timeout=180'
        global_interactive_timeout = 'SET GLOBAL connect_timeout=180'

        cursor.execute(global_connect_timeout)
        cursor.execute(global_wait_timeout)
        cursor.execute(global_interactive_timeout)

        connection.commit()

except Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Invalid username or password!")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist!")
    else:
        print(err)

# finally:
#     if connection.is_connected():
#         print("hi")
#         # cursor.close()
#         # cursor.execute("SELECT * from Physician")
#         query = choose_query()
#         cursor.execute(query)
#         result = cursor.fetchall()
#         print(result)
#         connection.close()
#         print("MySQL connection is closed")

finally:
    if connection.is_connected():
        print("hi")
        # cursor.close()
        # cursor.execute("SELECT * from Physician")
        query = choose_query()
        cursor.execute(query)
        result = cursor.fetchall()
        print(result)
        connection.close()
        print("MySQL connection is closed")