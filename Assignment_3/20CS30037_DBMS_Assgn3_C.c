// DBMS Lab Assignment 3 -> C program to fetch data from the database using ODBC
// Name: Pranav Nyati
// Roll No: 20CS30037


#include<stdio.h>
#include<windows.h>
#include <string.h>
#include <sql.h>
#include <sqlext.h>


SQLHENV  h_env = NULL;
SQLHDBC  h_odbc = NULL;

int Connect_Database_odbc(SQLCHAR* ds, SQLCHAR* user, SQLCHAR* pw)
{
    SQLRETURN  rc;

    h_odbc = NULL;
    h_env = NULL;

    // Allocate environment handle
    //SQL_NULL_HANDLE:  no parent handle is being used
    
    rc = SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &h_env);  
    if (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO) 
    {
        //  Set the ODBC version environment attribute
        rc = SQLSetEnvAttr(h_env, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0); 

        if (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO) 
        {
            // Allocate connection handle 
            rc = SQLAllocHandle(SQL_HANDLE_DBC, h_env, &h_odbc); 

            if (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO) 
            {
                // Set login timeout to 15 seconds. 
                SQLSetConnectAttr(h_odbc, SQL_LOGIN_TIMEOUT, (SQLPOINTER)15, 0);

                // Connect to data source
                rc = SQLConnect(h_odbc, ds, SQL_NTS, user, SQL_NTS, pw, SQL_NTS);
	
                if (rc  == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO)
                    return 1;
            }
            
        }
        else(printf("Failure in connecting to the database. Please check your credentials and try again!\n"));
    }
    return 0;
}


int Disconnect_Database_odbc()
{
    if(h_odbc) 
    {
        // Disconnect from data source
        SQLDisconnect(h_odbc);	
        // Free connection handle
        SQLFreeHandle(SQL_HANDLE_DBC, h_odbc);
    }

    if(h_env) SQLFreeHandle(SQL_HANDLE_ENV, h_env);

    // reset the global variables to NULL
    h_odbc=NULL;
    h_env=NULL;
    
    return 1;
}

SQLRETURN fetch_single_query_data(SQLHSTMT sql_handle, SQLCHAR* sql_query)
{
  //access database using the query stored in sql_query
  SQLRETURN rc = SQLExecDirect(sql_handle, sql_query, SQL_NTS);
  if(rc !=SQL_SUCCESS) 
  {
    printf("cannot access the entered query! Please check the query and try again!\n");
    SQLFreeHandle(SQL_HANDLE_STMT, sql_handle);
    return 0;
  }

  rc = SQLFetch(sql_handle);
  return rc;
}

void print_single_query_data(SQLHSTMT sql_handle, SQLCHAR* sql_query, SQLRETURN *rc, int ncols) 
{
  SQLLEN n;
    while(1)
    {
      
      if(*rc ==SQL_SUCCESS || *rc ==SQL_SUCCESS_WITH_INFO)
      {
        for (int i = 1; i <= ncols; i++)
        {
          SQLCHAR *str_var = (SQLCHAR*)malloc(100*sizeof(SQLCHAR));
          *rc =SQLGetData(sql_handle, i, SQL_C_CHAR, str_var, 100, &n);
            
          if (i != ncols){
            printf("%s",str_var);
            for(int j=0;j<25-strlen(str_var);++j)printf(" ");
          }
           if (i == ncols)
            printf("%s\n",str_var);

          free(str_var);
        }
      }

      // if no data left to fetch, break the loop
      else if(SQL_NO_DATA == *rc ) break;
      else
      {
        printf("%s\n", "fail to fetch data");
        break;
      }

      *rc = SQLFetch(sql_handle);
    }
    for (int i = 0; i < ncols; ++i)
      printf("------------------------");
    printf("\n");

    return;
}



int db_fetch_query_sql()
{

  // sql_handle is the handle to the MySQL statement/query
  SQLHSTMT sql_handle;

  // rc is used to store the return code of the ODBC functions
  SQLRETURN  rc;
    
  //variable to store the query based on the user input
  SQLCHAR* sql_query = (SQLCHAR*)malloc(10000*sizeof(SQLCHAR));

  // if the connection to the database is not established, return 0
  if(h_odbc == NULL || h_env == NULL) return 0;

  rc = SQLAllocHandle(SQL_HANDLE_STMT, h_odbc, &sql_handle);
  if(!(rc == SQL_SUCCESS||rc == SQL_SUCCESS_WITH_INFO)) return 0;

  int i;
  printf("\nEnter a query number from 1 to 13 to fetch the query: \n");
  scanf("%d", &i);
  if(i==-1){
    printf("\nExiting the program.....\n");
    return -1;
  }

  if(i==1)
  {
    char query[1200] =
    "SELECT Physician.Name "
    "FROM Physician "
    "INNER JOIN Trained_In ON Trained_In.PhysicianID = Physician.EmployeeID "
    "INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Trained_In.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';";
    
    strcpy(sql_query, query);
  
    rc = fetch_single_query_data(sql_handle, sql_query);

    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)  //indicating that MYSQL has data corresponding to this query
      {
        printf("------------------------");
        printf("\nPhysician Name\n");
        printf("------------------------\n");
      }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query
    
    print_single_query_data(sql_handle, sql_query, &rc, 1);

  }
  
  else if(i==2)
  {
    char query[1200] = 
    "SELECT Physician.Name "
    "FROM Physician "
    "INNER JOIN Trained_In ON Trained_In.PhysicianID = Physician.EmployeeID " 
    "INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Trained_In.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery' "
    "INNER JOIN Affiliated_with ON Affiliated_with.PhysicianID = Physician.EmployeeID "
    "INNER JOIN Department ON Affiliated_with.DepartmentID = Department.DepartmentID and Department.Name = 'Cardiology';";

    strcpy(sql_query, query);

    rc = fetch_single_query_data(sql_handle, sql_query);

    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {
      printf("------------------------");
      printf("\nPhysician Name\n");
      printf("------------------------\n");
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query
    
    print_single_query_data(sql_handle, sql_query, &rc, 1);
  }
  
  else if(i==3)
  {
    char query[1200] =
  
    "SELECT Nurse.Name "
    "FROM Nurse "
    "INNER JOIN On_Call ON Nurse.EmployeeID = On_Call.NurseID "
    "INNER JOIN Room ON Room.BlockFloor = On_Call.BlockFloor and Room.BlockCode = On_Call.BlockCode and Room.RoomNo = 123;";
    
    strcpy(sql_query, query);
    
    rc = fetch_single_query_data(sql_handle, sql_query);

    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {
      printf("------------------------");
      printf("\nNurse Name\n");
      printf("------------------------\n");
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query
  
    print_single_query_data(sql_handle, sql_query, &rc, 1);

  }

  else if(i==4)
  {
    
    char query[1200] =
    "SELECT Patient.Name, Patient.Address "
    "FROM Patient "
    "INNER JOIN Prescribes ON Patient.SSN = Prescribes.PatientSSN "
    "INNER JOIN Medication ON Medication.Code = Prescribes.Medic_Code and Medication.Name = 'remdesivir';";

    strcpy(sql_query, query);

    rc = fetch_single_query_data(sql_handle, sql_query);

    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {//if the query hasn't returned empty set
      printf("------------------------------------------------");
      printf("\nPatient Name"); 
      for(int j=0;j<25-strlen("Patient Name");++j)printf(" ");
      printf("Patient Address\n");
      printf("------------------------------------------------\n");
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query
    
    print_single_query_data(sql_handle, sql_query, &rc, 2);

  }
  

  else if(i==5)
  {
    
    char query[1200] =
    "SELECT Patient.Name, Patient.InsuranceID " 
    "FROM Patient "
    "INNER JOIN Stay ON Stay.PatientSSN = Patient.SSN "
    "INNER JOIN Room ON Stay.RoomNo = Room.RoomNo and Room.Type = 'ICU' and DATEDIFF (Stay.End , Stay.Start ) > 15;";
            
    strcpy(sql_query, query);

    rc = fetch_single_query_data(sql_handle, sql_query);
  
    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {//if the query hasn't returned empty set
      printf("------------------------------------------------");
      printf("\nPatient Name");
      for(int j=0;j<25-strlen("Patient Name");++j)printf(" ");
      printf("Patient Inusrance ID\n");
      printf("------------------------------------------------\n");
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query
    
    print_single_query_data(sql_handle, sql_query, &rc, 2);

  }
  
  else if(i==6)
  {
   
    char query[1200] =
    "SELECT DISTINCT Nurse.Name "
    "FROM Nurse "
    "INNER JOIN Undergoes ON Nurse.EmployeeID = Undergoes.AssistingNurseID "
    "INNER JOIN Med_Procedure ON Undergoes.ProcedureCode = Med_Procedure.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';";
    

    strcpy(sql_query, query);

    rc = fetch_single_query_data(sql_handle, sql_query);

    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {//if the query hasn't returned empty set
      printf("------------------------");
      printf("\nNurse Name \n");
      printf("------------------------\n");
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query

    print_single_query_data(sql_handle, sql_query, &rc, 1);
  }
  
  else if(i==7)
  {
    
    char query[1200] =
    "SELECT DISTINCT Nurse.Name, Nurse.Position, Physician.Name "
    "FROM Nurse "
    "INNER JOIN Undergoes ON Nurse.EmployeeID = Undergoes.AssistingNurseID "
    "INNER JOIN Physician ON Undergoes.PhysicianID = Physician.EmployeeID "
    "INNER JOIN Med_Procedure ON Undergoes.ProcedureCode = Med_Procedure.ProcedureCode and Med_Procedure.ProcedureName = 'Bypass Surgery';";

    strcpy(sql_query, query);

    rc = fetch_single_query_data(sql_handle, sql_query);
    
    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {//if the query hasn't returned empty set
      printf("------------------------------------------------------------------------");
      printf("\nNurse Name");
      for(int j=0;j<25-strlen("Nurse Name");++j)printf(" ");
      printf("Nurse Position");
      for(int j=0;j<25-strlen("Nurse Position");++j)printf(" ");
      printf("Physician Name\n");
      printf("-------------------------------------------------------------------------\n");
      
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query

    print_single_query_data(sql_handle, sql_query, &rc, 3);
  }
  
  else if(i==8)
  {
    char query[1200] =
    "SELECT Physician.Name "
    "FROM Physician "
    "INNER JOIN Undergoes ON Undergoes.PhysicianID = Physician.EmployeeID "
    "WHERE (Undergoes.PhysicianID , Undergoes.ProcedureCode ) NOT IN (SELECT PhysicianID, ProcedureCode FROM Trained_In);";
    
    strcpy(sql_query, query);

    rc = fetch_single_query_data(sql_handle, sql_query);

    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {//if the query hasn't returned empty set
      printf("-------------------------");
      printf("\nPhysician Name \n");
      printf("------------------------\n");
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query
    
    print_single_query_data(sql_handle, sql_query, &rc, 1);
  }
  
  else if(i==9)
  {
    
    char query[1200] =
    "SELECT Physician.Name "
    "FROM Physician "
    "INNER JOIN Undergoes ON Physician.EmployeeID = Undergoes.PhysicianID "
    "INNER JOIN Trained_In ON Trained_In.PhysicianID = Undergoes.PhysicianID and Trained_In.ProcedureCode = Undergoes.ProcedureCode and Undergoes.ProcedureDate > Trained_In.CertificationExpires;";
    
    strcpy(sql_query, query);
    rc = fetch_single_query_data(sql_handle, sql_query);
    
    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {
      printf("------------------------");
      printf("\nPhysician Name \n");
      printf("------------------------\n");
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query
    
    print_single_query_data(sql_handle, sql_query, &rc, 1);
  }
  
  else if(i==10)
  {
   
    char query[1200] =

    "SELECT Physician.Name, Med_Procedure.ProcedureName, Undergoes.ProcedureDate , Patient.Name "
    "FROM Physician "
    "INNER JOIN Undergoes ON Physician.EmployeeID = Undergoes.PhysicianID "
    "INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Undergoes.ProcedureCode "
    "INNER JOIN Patient ON Undergoes.PatientSSN = Patient.SSN "
    "INNER JOIN Trained_In ON Trained_In.PhysicianID = Undergoes.PhysicianID and Trained_In.ProcedureCode = Undergoes.ProcedureCode and Undergoes.ProcedureDate > Trained_In.CertificationExpires;";

    strcpy(sql_query, query);

    rc = fetch_single_query_data(sql_handle, sql_query);

    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {//if the query hasn't returned empty set
      printf("------------------------------------------------------------------------------------------------");
      printf("\nPhysician Name");
      for(int j=0;j<25-strlen("Physician Name");++j)printf(" ");
      printf("Procedure Name");
      for(int j=0;j<25-strlen("Procedure Name");++j)printf(" ");
      printf("Date");
      for(int j=0;j<25-strlen("Date");++j)printf(" ");
      printf("Patient Name\n");
      printf("------------------------------------------------------------------------------------------------\n");
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query

    print_single_query_data(sql_handle, sql_query, &rc, 4);
  }
  
  else if(i==11)
  {

    char query[1200] =
    "WITH Patient_Data AS( "
    "SELECT Patient.SSN, Patient.Name, Patient.PCP, COUNT(Patient.SSN) "
    "FROM Patient "
    "INNER JOIN Appointment a1 ON Patient.SSN = a1.PatientSSN "
    "INNER JOIN Affiliated_with  aw1 ON aw1.PhysicianID = a1.PhysicianID "
    "INNER JOIN Physician ph1 ON ph1.EmployeeID = a1.PhysicianID "
    "INNER JOIN Department d1 ON d1.DepartmentID = aw1.DepartmentID and d1.Name = 'Cardiology' "
    "GROUP BY Patient.SSN "
    "HAVING COUNT(Patient.SSN) > 1 "
    ") "
    "SELECT DISTINCT p1.Name, ph2.Name "
    "FROM Patient_Data "
    "INNER JOIN Patient p1 ON p1.SSN = Patient_Data.SSN "
    "INNER JOIN Appointment a2 ON a2.PatientSSN = p1.SSN "
    "INNER JOIN Affiliated_with aw2 ON aw2.PhysicianID = a2.PhysicianID "
    "INNER JOIN Department d2 ON d2.DepartmentID = aw2.DepartmentID and d2.HeadID != a2.PhysicianID "
    "INNER JOIN Prescribes prs1 ON prs1.PatientSSN = Patient_Data.SSN and prs1.PhysicianID = Patient_Data.PCP "
    "INNER JOIN Undergoes u1 ON u1.PatientSSN = Patient_Data.SSN "
    "INNER JOIN Med_Procedure mp1 ON mp1.ProcedureCode = u1.ProcedureCode "
    "INNER JOIN Physician ph2 ON p1.PCP = ph2.EmployeeID "
    "WHERE mp1.cost > 5000;";

    strcpy(sql_query, query);

    rc = fetch_single_query_data(sql_handle, sql_query);
    

    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {//if the query hasn't returned empty set
      printf("------------------------------------------------");
      printf("\nPatient Name");
      for(int j=0;j<25-strlen("Patient Name");++j)printf(" ");
      printf("Physician Name\n");
      printf("------------------------------------------------\n");
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query
    
    print_single_query_data(sql_handle, sql_query, &rc, 2);
  }
  
  else if(i==12)
  {
    
    char query[1200] =
    "WITH Med_Freq AS ( "
    "SELECT Medic_Code, Count(*) as med_count "
    "FROM Prescribes "
    "GROUP BY Medic_Code "
    ") "
    "SELECT Name, Brand "
    "FROM Med_Freq "
    "INNER JOIN Medication ON Medication.Code = Med_Freq.Medic_Code "
    "WHERE Med_Freq.med_count = (SELECT MAX(med_count) FROM Med_Freq);" ;

    strcpy(sql_query, query);

    rc = fetch_single_query_data(sql_handle, sql_query);

    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {//if the query hasn't returned empty set
      printf("------------------------------------------------");
      printf("\nMedicine Name");
      for(int j=0;j<25-strlen("Medicine Name");++j)printf(" ");
      printf("Medicine Brand\n");
      printf("------------------------------------------------\n");
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query
    
    print_single_query_data(sql_handle, sql_query, &rc, 2);
  }
  
  else if(i==13)
  {
    char input[200];
    char c;
    printf("Enter a Procedure Name to be added to the query: ");
    scanf("%c", &c);
    int j=0;
    

    while(1){
      scanf("%c",&input[j]);
      if (input[j]=='\n'){
        input[j]='\0'; 
        break;
      }
      j++;
      
    }
    char query[1200] = 
    "SELECT Physician.Name "
    "FROM Physician "
    "INNER JOIN Trained_In ON Trained_In.PhysicianID = Physician.EmployeeID "
    "INNER JOIN Med_Procedure ON Med_Procedure.ProcedureCode = Trained_In.ProcedureCode and Med_Procedure.ProcedureName = '";
    strcat(query,input);
    strcat(query,"';");


    strcpy(sql_query, query);

    rc = fetch_single_query_data(sql_handle, sql_query);

    if(rc==SQL_SUCCESS||rc==SQL_SUCCESS_WITH_INFO)
    {
      printf("------------------------");
      printf("\nPhysician Name\n");
      printf("------------------------\n");
    }
    else if(SQL_NO_DATA==rc) printf("The given database has no match corresponding to this query!\n"); // MYSQL database has no data corresponding to this query
    
    print_single_query_data(sql_handle, sql_query,  &rc, 1);
   }

}


int main(void)
{
  //Connect to database using DSN, username and password
  Connect_Database_odbc("PRANAV_N", "20CS30037", "20CS30037");
  
  // User should enter query until -1 is pressed
  while(1){
    printf("\nEnter -1 to exit!\n");
    if(db_fetch_query_sql()==-1)break;
  }

  // after user is done, disconnect from database
  Disconnect_Database_odbc();
  return 0;
}