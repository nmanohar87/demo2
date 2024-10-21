       IDENTIFICATION DIVISION.
       PROGRAM-ID. MergeEmployeeData.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT InputFile1 ASSIGN TO 'EMPLOYEE1.DAT'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT InputFile2 ASSIGN TO 'EMPLOYEE2.DAT'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OutputFile ASSIGN TO 'MERGED_EMPLOYEE.DAT'
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  InputFile1.
       01  EmployeeRecord1.
           05  EmployeeID1    PIC 9(5).
           05  EmployeeName1  PIC X(30).
       
       FD  InputFile2.
       01  EmployeeRecord2.
           05  EmployeeID2    PIC 9(5).
           05  EmployeeSalary  PIC 9(7).
       
       FD  OutputFile.
       01  OutputRecord.
           05  EmployeeIDOut   PIC 9(5).
           05  EmployeeNameOut PIC X(30).
           05  EmployeeSalaryOut PIC 9(7).

       WORKING-STORAGE SECTION.
       01  EndOfFile1        PIC X VALUE 'N'.
       01  EndOfFile2        PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           OPEN INPUT InputFile1
           OPEN INPUT InputFile2
           OPEN OUTPUT OutputFile

           PERFORM UNTIL EndOfFile1 = 'Y' OR EndOfFile2 = 'Y'
               READ InputFile1 INTO EmployeeRecord1
                   AT END
                       MOVE 'Y' TO EndOfFile1
                   NOT AT END
                       READ InputFile2 INTO EmployeeRecord2
                           AT END
                               MOVE 'Y' TO EndOfFile2
                           NOT AT END
                               IF EmployeeID1 = EmployeeID2
                                   MOVE EmployeeID1 TO EmployeeIDOut
                                   MOVE EmployeeName1 TO EmployeeNameOut
                                   MOVE EmployeeSalary TO EmployeeSalaryOut
                                   WRITE OutputRecord
                               END-IF
                       END-READ
               END-READ
           END-PERFORM

           CLOSE InputFile1
           CLOSE InputFile2
           CLOSE OutputFile

           STOP RUN.
