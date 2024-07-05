:- use_module(library(odbc)). % Not necessary

start :- connect_SQL, nl,
        write('-----Connected!'),nl,
         drop_tables, nl, 
        write('-----Dropped tables!'),nl,
         create_tables, nl,
        write('-----Created tables!'),nl,
         insert_values, nl,
        write('-----Values inserted!'),nl,
         select_queries, nl,
         disconnect_SQL,
        write('-----Disonnected!'),nl.


connect_SQL :- 
    odbc_connect( ks_db, _Connection, [user(root), alias(ks_db), password(root),open(once)]).

disconnect_SQL :- 
    odbc_disconnect(ks_db).  

create(Query):- 
    odbc_query(ks_db, Query, _Affected).
    
drop_tables :- create('DROP TABLE IF EXISTS students_courses'),
               create('DROP TABLE IF EXISTS courses'),
               create('DROP TABLE IF EXISTS students').

create_tables :- 
    create('CREATE TABLE courses (
                course_id varchar(8) ,
                course_name varchar(20) ,
                ECTS int(11) ,
                check(ECTS >= 2 and ECTS <= 6),
            PRIMARY KEY (course_id)
        );'),    
    create('CREATE TABLE students (
                student_id varchar(8) ,
                student_name varchar(20) ,
                registration_acadYear varchar(10) ,
                TotalPassedECTS int(11) ,
                check(TotalPassedECTS >= 0 and TotalPassedECTS <= 240),
            PRIMARY KEY (student_id)
        );'),
    create('CREATE TABLE students_courses (
                course_id varchar(8) ,
                student_id varchar(8) ,
                grade double ,
                check(grade >= 0 and grade <= 10),
            PRIMARY KEY (course_id, student_id),
            FOREIGN KEY (course_id) REFERENCES courses(course_id) ,
            FOREIGN KEY (student_id) REFERENCES students(student_id)
        );').



insert_values :- 
    Query='INSERT INTO courses VALUES("TP70L1", "Knowledge Systems", 6)',
    odbc_query(ks_db, Query, _Affected),
    Query1='INSERT INTO courses VALUES("TP70Y1", "Embedded Systems", 6)',
    odbc_query(ks_db, Query1, _Affected),
    Query2='INSERT INTO courses VALUES("TP70Y2", "Computer Vision", 6)',
    odbc_query(ks_db, Query2, _Affected),

    Query3='INSERT INTO students VALUES("tp4737", "Sfinarolaki El", "2017", 149)',
    odbc_query(ks_db, Query3, _Affected),
    Query4='INSERT INTO students VALUES("th1717", "Sfakianaki Antonia", "2015", 200)',
    odbc_query(ks_db, Query4, _Affected),
    Query5='INSERT INTO students VALUES("tp1234", "Panagiotou Maria", "2014", 32)',
    odbc_query(ks_db, Query5, _Affected),

    Query6='INSERT INTO students_courses VALUES("TP70L1", "tp4737", 10)',
    odbc_query(ks_db, Query6, _Affected),
    Query7='INSERT INTO students_courses VALUES("TP70Y1", "th1717", 5)',
    odbc_query(ks_db, Query7, _Affected),
    Query8='INSERT INTO students_courses VALUES("TP70Y1", "tp1234", 3)',
    odbc_query(ks_db, Query8, _Affected).


% Fetch records
select_queries :- 
    Query_1='SELECT * FROM courses',nl,
    write("-Courses"), nl,nl,
    findall(
        [CourseID, CourseName, ECTS],
        odbc_query(ks_db, Query_1, row(CourseID, CourseName, ECTS)),
        Result_1 ),
    write(Result_1), nl,


    Query_2='SELECT * FROM students',nl,
    nl, write("-Students"), nl,nl,
    findall(
        [StudentID, StudentName , Registration_acadYear , TotalPassedECTS],
        odbc_query(ks_db, Query_2, row(StudentID, StudentName , Registration_acadYear , TotalPassedECTS)),
        Result_2 ),
    write(Result_2), nl,

    Query_3='SELECT C.course_id, SC.student_id 
            FROM courses C , students_courses SC 
            WHERE SC.course_id = C.course_id',nl,
        write("-Students with Courses"), nl,nl,
    findall(
        [CourseID, StudentID],
        odbc_query(ks_db, Query_3, row(CourseID, StudentID)),
        Result_3),
    write(Result_3), nl,

    Query_4='SELECT S.student_name, S.student_id, C.course_id, SC.grade 
            FROM courses C , students S , students_courses SC
            WHERE S.student_id = SC.student_id and C.course_id = SC.course_id and grade < 7',nl,
    
    nl, write("-Students with Courses and grade < 7"), nl,nl,
    findall(
        [StudentName , StudentID , CourseID,  Grade],
        odbc_query(ks_db, Query_4, row(StudentName, StudentID, CourseID, Grade)),
        Result_4 ),
    write(Result_4), nl. 


