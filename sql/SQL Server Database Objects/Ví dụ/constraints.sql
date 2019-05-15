CREATE DATABASE Test

CREATE TABLE Student
(
	RollNo  CHAR(10) PRIMARY KEY, -- constraint at column level
    StudentName VARCHAR(20)
)

CREATE TABLE Subject
(
	Code VARCHAR(10) PRIMARY KEY,
    SubjectName VARCHAR(30)
)

ALTER TABLE Subject
ADD CONSTRAINT uniqueSubjectName UNIQUE (SubjectName)

CREATE TABLE Mark
(
	RollNo CHAR(10) REFERENCES Student(RollNo),
    Code VARCHAR(10) REFERENCES Subject(Code),
    WMark FLOAT,
    PMark FLOAT,
	PRIMARY KEY (RollNo, Code) -- constraint at table level
)

ALTER TABLE Mark
ADD CONSTRAINT checkWmark CHECK (WMark >= 0 AND WMark <= 100)

ALTER TABLE Mark
ADD CONSTRAINT checkPmark CHECK (PMark >= 0 AND PMark <= 25)

ALTER TABLE Mark
DROP CONSTRAINT FK__Mark__RollNo__014935CB

ALTER TABLE Mark
ADD CONSTRAINT FK_Mark_Student FOREIGN KEY (RollNo) REFERENCES Student(RollNo)
ON DELETE CASCADE
ON UPDATE CASCADE