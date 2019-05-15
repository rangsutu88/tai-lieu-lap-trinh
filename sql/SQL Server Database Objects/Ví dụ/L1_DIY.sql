--// LAB 1. Do It Yourself

CREATE DATABASE AptechClasses
GO

USE AptechClasses

CREATE TABLE Class (
	ClassCode     VARCHAR(10) PRIMARY KEY,
	HeadTeacher   VARCHAR(30),
	Room          VARCHAR(30),
	TimeSlot      VARCHAR(30),
	CloseDate     DATETIME
)
GO

CREATE TABLE Student (
	RollNo       VARCHAR(10) PRIMARY KEY,
	ClassCode    VARCHAR(10) REFERENCES Class(ClassCode),
	FullName     VARCHAR(30),
	Male         BIT,
	BirthDate    DATETIME,
	Address      VARCHAR(30),
	Province     CHAR(2),
	Email        VARCHAR(30)
)
GO

CREATE TABLE Subject (
	SubjectCode   VARCHAR(10) PRIMARY KEY,
	SubjectName   VARCHAR(40),
	WTest         BIT,
    PTest         BIT,
	WTest_per     SMALLINT,
    PTest_per     INT
)
GO

CREATE TABLE Mark (
	RollNo        VARCHAR(10) REFERENCES Student(RollNo),
	SubjectCode   VARCHAR(10) REFERENCES Subject(SubjectCode),
	WMark         FLOAT,
	PMark         FLOAT,
	Mark          FLOAT
)
GO
