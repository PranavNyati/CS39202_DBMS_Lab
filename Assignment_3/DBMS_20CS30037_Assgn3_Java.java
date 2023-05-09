// DBMS Lab Assignment 3 -> Java program to fetch data from the database using JDBC
// Name: Pranav Nyati
// Roll No: 20CS30037


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class DBMS_20CS30037_Assgn3_Java {

    private static String mysql_driver_jdbc = "com.mysql.cj.jdbc.Driver";  // mysql driver 
    private static String mysql_server_url = "jdbc:mysql://10.5.18.71:3306/20CS30037";  // mysql server url
    private static String mysql_username = "20CS30037";  // mysql username
    private static String mysql_user_password = "20CS30037"; // mysql user password
    public static void main(String[] args) {
            
        try(Connection connection = DriverManager.getConnection(mysql_server_url, mysql_username, mysql_user_password)) {

            Class.forName(mysql_driver_jdbc); 
            Statement statement =connection.createStatement();  
           
            Scanner sc= new Scanner(System.in);
            System.out.println("Enter a query number from 1 to 13 to fetch the query:");
            int query_num = sc.nextInt(); 
            String query_string;
            ResultSet query_result;
            
            switch(query_num) {

                case 1:   // if the user wants to execute query 1
                    query_string = 
                        "SELECT Physician.Name " +
                        "FROM Physician " +
                        "INNER JOIN Trained_In ON Trained_In.PhysicianID = Physician.EmployeeID " +
                        "INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Trained_In.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';";
                    
                    query_result = statement.executeQuery(query_string); 
                
                    // print the query result in a tabular format
                    if (query_result.next() == true) {  // if there is at least one row matching the query

                        System.out.println("---------------------");
                        System.out.println("    Physician Name");
                        System.out.println("---------------------");

                        System.out.print("    ");
                        System.out.println(query_result.getString(1));
                        
                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1));
                        }  
                    }

                    else { // if there is no row matching the query
                        System.out.println("No match for this query in the database!");
                    }
                    
                    System.out.println("---------------------");    
                    break;
                
                
                case 2:  // if the user wants to execute query 2

                    query_string = 
                        "SELECT Physician.Name " +
                        "FROM Physician " +
                        "INNER JOIN Trained_In ON Trained_In.PhysicianID = Physician.EmployeeID " +
                        "INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Trained_In.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery' " +
                        "INNER JOIN Affiliated_with ON Affiliated_with.PhysicianID = Physician.EmployeeID " +
                        "INNER JOIN Department ON Affiliated_with.DepartmentID = Department.DepartmentID and Department.Name = 'Cardiology';";
                    
                    query_result = statement.executeQuery(query_string);

                    // print the query result in a tabular format
                    if (query_result.next() == true) {  // if there is at least one row matching the query

                        System.out.println("---------------------");
                        System.out.println("    Physician Name");
                        System.out.println("---------------------");

                        System.out.print("    ");
                        System.out.println(query_result.getString(1));
                        
                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1));
                        }  
                    }

                    else { // if there is no row matching the query
                        System.out.println("No match for this query in the database!");
                    }
                    
                    System.out.println("---------------------");      
                    break;
                
                
                case 3:

                    query_string =
                        "SELECT Nurse.Name " +
                        "FROM Nurse " +
                        "INNER JOIN On_Call ON Nurse.EmployeeID = On_Call.NurseID " +
                        "INNER JOIN Room ON Room.BlockFloor = On_Call.BlockFloor and Room.BlockCode = On_Call.BlockCode and Room.RoomNo = 123;";
                    
                    query_result = statement.executeQuery(query_string); 

                    // print the query result in a tabular format
                    if (query_result.next() == true) {  // if there is at least one row matching the query
                                            
                        System.out.println("---------------------");
                        System.out.println("    Nurse Name");
                        System.out.println("---------------------");

                        System.out.print("    ");
                        System.out.println(query_result.getString(1));
                        
                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1));
                        }  
                    }

                    else {
                        System.out.println("No match for this query in the database!");
                    }
                    
                    System.out.println("---------------------");     
                    break;

                case 4:

                    query_string =
                        "SELECT Patient.Name, Patient.Address " +
                        "FROM Patient " +
                        "INNER JOIN Prescribes ON Patient.SSN = Prescribes.PatientSSN " +
                        "INNER JOIN Medication ON Medication.Code = Prescribes.Medic_Code and Medication.Name = 'remdesivir';";

                    query_result = statement.executeQuery(query_string); 

                    // print the query result in a tabular format
                    if (query_result.next() == true) {  // if there is at least one row matching the query
                        
                        System.out.println("------------------------------------------------");
                        System.out.print("    Patient Name");
                        System.out.println("             Patient Address");
                        System.out.println("------------------------------------------------");

                        System.out.print("    ");
                        System.out.println(query_result.getString(1)+ " ".repeat(25-(query_result.getString(1)).length()) + query_result.getString(2));

                        
                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1)+ " ".repeat(25-(query_result.getString(1)).length()) + query_result.getString(2));
                        }  
                    }

                    else {
                        System.out.println("No match for this query in the database!");
                    }

                    System.out.println("------------------------------------------------");
                    break;
                
                
                case 5:

                    query_string =
                            "SELECT Patient.Name, Patient.InsuranceID " +
                            "FROM Patient " +
                            "INNER JOIN Stay ON Stay.PatientSSN = Patient.SSN " +
                            "INNER JOIN Room ON Stay.RoomNo = Room.RoomNo and Room.Type = 'ICU' and DATEDIFF (Stay.End , Stay.Start ) > 15;";
                    
                    query_result = statement.executeQuery(query_string);

                    // print the query result in a tabular format
                    if (query_result.next() == true) {  // if there is at least one row matching the query
                        
                        System.out.println("-----------------------------------------------------");
                        System.out.print("    Patient Name");
                        System.out.println("             Patient Insurance ID");
                        System.out.println("-----------------------------------------------------");

                        System.out.print("    ");
                        System.out.println(query_result.getString(1)+ " ".repeat(25-(query_result.getString(1)).length()) + query_result.getString(2));

                        
                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1)+ " ".repeat(25-(query_result.getString(1)).length()) + query_result.getString(2));
                        }  
                    }

                    else {
                        System.out.println("No match for this query in the database!");
                    }

                    System.out.println("-----------------------------------------------------");
                    break;

                
                case 6:
                
                    query_string =
                        "SELECT DISTINCT Nurse.Name " +
                        "FROM Nurse " +
                        "INNER JOIN Undergoes ON Nurse.EmployeeID = Undergoes.AssistingNurseID " +
                        "INNER JOIN Med_Procedure ON Undergoes.ProcedureCode = Med_Procedure.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';";

                    query_result = statement.executeQuery(query_string); 

                    // print the query result in a tabular format
                    if (query_result.next() == true) {  // if there is at least one row matching the query
                    
                        System.out.println("---------------------");
                        System.out.println("    Nurse Name");
                        System.out.println("---------------------");
                        
                        System.out.print("    ");
                        System.out.println(query_result.getString(1));
                        
                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1));
                        }  
                    }

                    else {
                        System.out.println("No match for this query in the database!");
                    }
                    
                    System.out.println("---------------------");     
                    
                    break;

                
                case 7:

                    query_string =
                        "SELECT DISTINCT Nurse.Name, Nurse.Position, Physician.Name " +
                        "FROM Nurse " +
                        "INNER JOIN Undergoes ON Nurse.EmployeeID = Undergoes.AssistingNurseID " +
                        "INNER JOIN Physician ON Undergoes.PhysicianID = Physician.EmployeeID " +
                        "INNER JOIN Med_Procedure ON Undergoes.ProcedureCode = Med_Procedure.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';";

                    query_result = statement.executeQuery(query_string); 
                    
                    if (query_result.next() == true) {  // if there is at least one row matching the query
                        
                        System.out.println("---------------------------------------------------------------------------");
                        System.out.print("    Nurse Name");
                        System.out.print("               Nurse Position");
                        System.out.println("           Physician Name");
                        System.out.println("---------------------------------------------------------------------------");
                        
                        System.out.print("    ");
                        System.out.println(query_result.getString(1)+ " ".repeat(25-(query_result.getString(1)).length()) + query_result.getString(2)+ " ".repeat(25-(query_result.getString(2)).length()) + query_result.getString(3));

                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1)+ " ".repeat(25-(query_result.getString(1)).length()) + query_result.getString(2)+ " ".repeat(25-(query_result.getString(2)).length()) + query_result.getString(3));
                        }     
                    }
                        
                    else {
                        System.out.println("No match for this query in the database!");
                    }

                    System.out.println("---------------------------------------------------------------------------");
                    break;
                
                case 8:

                    query_string =
                        "SELECT Physician.Name " + 
                        "FROM Physician " +
                        "INNER JOIN Undergoes ON Undergoes.PhysicianID = Physician.EmployeeID " +
                        "WHERE (Undergoes.PhysicianID , Undergoes.ProcedureCode ) NOT IN (SELECT PhysicianID, ProcedureCode FROM Trained_In);";

                    query_result = statement.executeQuery(query_string); 

                    // print the query result in a tabular format
                    if (query_result.next() == true) {  // if there is at least one row matching the query
                        
                        System.out.println("-----------------------");
                        System.out.println("    Physician Name");
                        System.out.println("-----------------------");
                          
                        System.out.print("    ");
                        System.out.println(query_result.getString(1));
                        
                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1));
                        }  
                    }

                    else {
                        System.out.println("No match for this query in the database!");
                    }
                    
                    System.out.println("-----------------------");      
                    break;


                case 9:

                    query_string =
                        "SELECT Physician.Name " +
                        "FROM Physician " +
                        "INNER JOIN Undergoes ON Physician.EmployeeID = Undergoes.PhysicianID " +
                        "INNER JOIN Trained_In ON Trained_In.PhysicianID = Undergoes.PhysicianID and Trained_In.ProcedureCode = Undergoes.ProcedureCode and Undergoes.ProcedureDate > Trained_In.CertificationExpires;";
    
                    query_result = statement.executeQuery(query_string); 

                    // print the query result in a tabular format
                    if (query_result.next() == true) {  // if there is at least one row matching the query
                        
                        System.out.println("-----------------------");
                        System.out.println("    Physician Name");
                        System.out.println("-----------------------");

                        System.out.print("    ");
                        System.out.println(query_result.getString(1));
                        
                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1));
                        }  
                    }

                    else {
                        System.out.println("No match for this query in the database!");
                    }
                    
                    System.out.println("-----------------------");      
                    break;

                case 10:

                    query_string =
                        "SELECT Physician.Name, Med_Procedure.ProcedureName, Undergoes.ProcedureDate , Patient.Name " +
                        "FROM Physician " +
                        "INNER JOIN Undergoes ON Physician.EmployeeID = Undergoes.PhysicianID " +
                        "INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Undergoes.ProcedureCode " +
                        "INNER JOIN Patient ON Undergoes.PatientSSN = Patient.SSN " +
                        "INNER JOIN Trained_In ON Trained_In.PhysicianID = Undergoes.PhysicianID and Trained_In.ProcedureCode = Undergoes.ProcedureCode and Undergoes.ProcedureDate > Trained_In.CertificationExpires;";
                
                    query_result = statement.executeQuery(query_string);

                    if (query_result.next() == true) {  // if there is at least one row matching the query
                        
                    
                        System.out.println("-------------------------------------------------------------------------------------------------------------");
                        System.out.print("    Physician Name");
                        System.out.print("              Procedure Name");
                        System.out.print("                Date");
                        System.out.println("                          Patient Name");
                        System.out.println("-------------------------------------------------------------------------------------------------------------");                        
                            
                        System.out.print("    ");                        
                        System.out.println(query_result.getString(1)+ " ".repeat(28-(query_result.getString(1)).length()) + query_result.getString(2)+ " ".repeat(30-(query_result.getString(2)).length()) + query_result.getString(3)+ " ".repeat(30-(query_result.getString(3)).length()) + query_result.getString(4));

                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1)+ " ".repeat(28-(query_result.getString(1)).length()) + query_result.getString(2)+ " ".repeat(30-(query_result.getString(2)).length()) + query_result.getString(3)+ " ".repeat(30-(query_result.getString(3)).length()) + query_result.getString(4));
                        }     
                    }
                            
                    else {
                        System.out.println("No match for this query in the database!");
                    }
                    
                    System.out.println("-------------------------------------------------------------------------------------------------------------");
                    break;

                case 11:

                    query_string =
                        "WITH Patient_Data AS( " +
                        "SELECT Patient.SSN, Patient.Name, Patient.PCP, COUNT(Patient.SSN) " +
                        "FROM Patient " +
                        "INNER JOIN Appointment a1 ON Patient.SSN = a1.PatientSSN " +
                        "INNER JOIN Affiliated_with  aw1 ON aw1.PhysicianID = a1.PhysicianID " + 
                        "INNER JOIN Physician ph1 ON ph1.EmployeeID = a1.PhysicianID " +
                        "INNER JOIN Department d1 ON d1.DepartmentID = aw1.DepartmentID and d1.Name = 'Cardiology' " +
                        "GROUP BY Patient.SSN " +
                        "HAVING COUNT(Patient.SSN) > 1 " +
                        ") " +
                        "SELECT DISTINCT p1.Name, ph2.Name " +
                        "FROM Patient_Data " +
                        "INNER JOIN Patient p1 ON p1.SSN = Patient_Data.SSN " +
                        "INNER JOIN Appointment a2 ON a2.PatientSSN = p1.SSN " +
                        "INNER JOIN Affiliated_with aw2 ON aw2.PhysicianID = a2.PhysicianID " +
                        "INNER JOIN Department d2 ON d2.DepartmentID = aw2.DepartmentID and d2.HeadID != a2.PhysicianID " +
                        "INNER JOIN Prescribes prs1 ON prs1.PatientSSN = Patient_Data.SSN and prs1.PhysicianID = Patient_Data.PCP " +
                        "INNER JOIN Undergoes u1 ON u1.PatientSSN = Patient_Data.SSN " +
                        "INNER JOIN Med_Procedure mp1 ON mp1.ProcedureCode = u1.ProcedureCode " +
                        "INNER JOIN Physician ph2 ON p1.PCP = ph2.EmployeeID " +
                        "WHERE mp1.cost > 5000;";

                    query_result = statement.executeQuery(query_string);

                    // print the query result in a tabular format
                    if (query_result.next() == true) {  // if there is at least one row matching the query
                        

                        System.out.println("-----------------------------------------------------");
                        System.out.print("    Patient Name");
                        System.out.println("             Physician Name");
                        System.out.println("-----------------------------------------------------");                     
                        
                        System.out.print("    ");
                        System.out.println(query_result.getString(1)+ " ".repeat(25-(query_result.getString(1)).length()) + query_result.getString(2));

                        
                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1)+ " ".repeat(25-(query_result.getString(1)).length()) + query_result.getString(2));
                        }  
                    }

                    else {
                        System.out.println("No match for this query in the database!");
                    }

                    System.out.println("-----------------------------------------------------");               
                    break;

                case 12:

                    query_string =
                        "WITH Med_Freq AS ( " +
                        "SELECT Medic_Code, Count(*) as med_count " +
                        "FROM Prescribes " +
                        "GROUP BY Medic_Code " +
                        ") " +
                        "SELECT Name, Brand " +
                        "FROM Med_Freq " +
                        "INNER JOIN Medication ON Medication.Code = Med_Freq.Medic_Code " +
                        "WHERE Med_Freq.med_count = (SELECT MAX(med_count) FROM Med_Freq);" ;
      
                    query_result = statement.executeQuery(query_string); 

                    // print the query result in a tabular format
                    if (query_result.next() == true) {  // if there is at least one row matching the query

                        System.out.println("-----------------------------------------------------");
                        System.out.print("    Medicine Name");
                        System.out.println("             Medicine Brand");
                        System.out.println("-----------------------------------------------------");                        
                        
                        System.out.print("    ");
                        System.out.println(query_result.getString(1)+ " ".repeat(25-(query_result.getString(1)).length()) + query_result.getString(2));

                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1)+ " ".repeat(25-(query_result.getString(1)).length()) + query_result.getString(2));
                        }  
                    }

                    else {
                        System.out.println("No match for this query in the database!");
                    }

                    System.out.println("-----------------------------------------------------");               
                    break;                    
                
                case 13:
                    
                    sc.nextLine();
                    System.out.println("Enter a Procedure Name to be added to the query: ");
                    String input_procedure = sc.nextLine(); 

                    query_string =     
                        "SELECT Physician.Name " +
                        "FROM Physician " +
                        "INNER JOIN Trained_In ON Trained_In.PhysicianID = Physician.EmployeeID " +
                        "INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Trained_In.ProcedureCode and Med_Procedure.ProcedureName = '" + input_procedure  + "';";
                
                    query_result = statement.executeQuery(query_string); 

                    // print the query result in a tabular format
                    if (query_result.next() == true) {  // if there is at least one row matching the query
                                            
                        System.out.println("---------------------");
                        System.out.println("    Physician Name");
                        System.out.println("---------------------");
                        
                        System.out.print("    ");
                        System.out.println(query_result.getString(1));
                        
                        while(query_result.next())  {
                            System.out.print("    ");
                            System.out.println(query_result.getString(1));
                        }  
                    }

                    else {
                        System.out.println("No match for this query in the database!");
                    }
                    
                    System.out.println("---------------------");                    
                    break;

                default:
                    System.out.println("Invalid Input! Please try again with a correct query number from 1 to 13."); 
              
              }
            sc.close();
        } 
        catch (Exception e) {
            System.out.println(e);
        }
    }
}