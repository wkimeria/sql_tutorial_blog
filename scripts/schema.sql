/* Schema */

DROP TABLE `accounts`;
DROP TABLE `enrollments`;
DROP TABLE `CourseInstructors`;
DROP TABLE `instructors`;
DROP TABLE `courses`;
DROP TABLE `students`;
DROP TABLE `coursePricings`;

CREATE TABLE `coursePricings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('course','lab','combined') NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_UNIQUE` (`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `courses` (
  `courseId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `credits` int(11) NOT NULL,
  `type` enum('course','lab','combined') NOT NULL,
  PRIMARY KEY (`courseId`),
  UNIQUE KEY `courseId_UNIQUE` (`courseId`),
  KEY `type` (`type`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`type`) REFERENCES `coursePricings` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `students` (
  `studentId` int(11) NOT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`studentId`),
  UNIQUE KEY `studentId_UNIQUE` (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `instructors` (
  `instructorId` int(11) NOT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`instructorId`),
  UNIQUE KEY `instructorId_UNIQUE` (`instructorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* Course Instructors */
CREATE TABLE `CourseInstructors` (
  `courseInstructorId` int(11) NOT NULL,
  `instructorId` int(11) NOT NULL,
  `courseId` int(11) NOT NULL,
  PRIMARY KEY (`courseInstructorId`),
  KEY `courses_ibfk_2` (`instructorId`),
  KEY `courses_ibfk_3` (`courseId`),
  CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`instructorId`) REFERENCES `instructors` (`instructorId`),
  CONSTRAINT `courses_ibfk_3` FOREIGN KEY (`courseId`) REFERENCES `courses` (`courseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* enrollments */
CREATE TABLE `enrollments` (
  `courseInstructorId` int(11) NOT NULL,
  `studentId` int(11) NOT NULL,
  PRIMARY KEY (`courseInstructorId`,`studentId`),
  KEY `courses_ibfk_5` (`studentId`),
  CONSTRAINT `courses_ibfk_4` FOREIGN KEY (`courseInstructorId`) REFERENCES `CourseInstructors` (`courseInstructorId`),
  CONSTRAINT `courses_ibfk_5` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentId` int(11) NOT NULL,
  `total` float unsigned zerofill NOT NULL,
  `paid` float unsigned zerofill NOT NULL,
  `balance` float unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_ibfk_6` (`studentId`),
  CONSTRAINT `courses_ibfk_6` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/* data */

/* Course pricings */

INSERT coursePricings(type, price) SELECT 'course', 1999.99;
INSERT coursePricings(type, price) SELECT 'lab', 699.99;
INSERT coursePricings(type, price) SELECT 'combined', 2500.00;

/* courses */

INSERT courses(courseId, name, credits, type) SELECT 101, 'African American History', 3, 'course';
INSERT courses(courseId, name, credits, type) SELECT 102, 'Introduction to Sociology', 3, 'course';
INSERT courses(courseId, name, credits, type) SELECT 103, 'College Algebra', 3, 'course';
INSERT courses(courseId, name, credits, type) SELECT 104, 'Physics I (with Lab)', 4, 'combined';
INSERT courses(courseId, name, credits, type) SELECT 105, 'Practical Physics', 4, 'lab';
INSERT courses(courseId, name, credits, type) SELECT 106, 'Introduction to Artificial Intelligence', 3, 'course';
INSERT courses(courseId, name, credits, type) SELECT 107, 'Figure Drawing', 3, 'course';
INSERT courses(courseId, name, credits, type) SELECT 108, 'African Writers: From Chinua Achebe to Okot P Bitek', 3, 'course';
INSERT courses(courseId, name, credits, type) SELECT 109, 'College Algebra with Practical Applications', 3, 'combined';
INSERT courses(courseId, name, credits, type) SELECT 110, 'Calculus I', 3, 'course';
INSERT courses(courseId, name, credits, type) SELECT 111, 'Calculus II', 3, 'course';
INSERT courses(courseId, name, credits, type) SELECT 112, 'Introduction to Programming using Python', 3, 'course';
INSERT courses(courseId, name, credits, type) SELECT 113, 'Introduction to Programming using Lisp', 3, 'course';
INSERT courses(courseId, name, credits, type) SELECT 114, 'Introduction to Programming using COBOL (with Lab)', 3, 'combined';

/* students */

INSERT students(studentId, firstName, lastName) SELECT 1001, 'John', 'Kamaru';
INSERT students(studentId, firstName, lastName) SELECT 1002,  'Thomas', 'Jin';
INSERT students(studentId, firstName, lastName) SELECT 1003,  'Lucia', 'Lopez';
INSERT students(studentId, firstName, lastName) SELECT 1004,  'Mauricio', 'Green';
INSERT students(studentId, firstName, lastName) SELECT 1005,  'Xie', 'Chung';
INSERT students(studentId, firstName, lastName) SELECT 1006,  'Maria', 'Perez';
INSERT students(studentId, firstName, lastName) SELECT 1007,  'Jatinder', 'Singh';
INSERT students(studentId, firstName, lastName) SELECT 1008,  'Mohammed', 'Gawande';
INSERT students(studentId, firstName, lastName) SELECT 1009,  'Awori', 'Otieno';
INSERT students(studentId, firstName, lastName) SELECT 1010,  'Samuel', 'Johnston';
INSERT students(studentId, firstName, lastName) SELECT 1011,  'Maureen', 'Solano';
INSERT students(studentId, firstName, lastName) SELECT 1012,  'Cynthia', 'Galeano';
INSERT students(studentId, firstName, lastName) SELECT 1013,  'Miriam', 'Schuyler';
INSERT students(studentId, firstName, lastName) SELECT 1014,  'Mark', 'Luther';
INSERT students(studentId, firstName, lastName) SELECT 1015,  'Claire', 'Donovan';
INSERT students(studentId, firstName, lastName) SELECT 1016,  'Lydiah', 'Ulrich';
INSERT students(studentId, firstName, lastName) SELECT 1017,  'Jose', 'Perez';
INSERT students(studentId, firstName, lastName) SELECT 1018,  'Jacques', 'Anquetil';
INSERT students(studentId, firstName, lastName) SELECT 1019,  'Baratunde', 'Johnson';
INSERT students(studentId, firstName, lastName) SELECT 1020,  'Lydiah', 'Ulrich';
INSERT students(studentId, firstName, lastName) SELECT 1021,  'Aruna', 'Patel';
INSERT students(studentId, firstName, lastName) SELECT 1022,  'Sarah', 'Abebi';
INSERT students(studentId, firstName, lastName) SELECT 1023,  'Allison', 'Hacker';

/* Instructors */

INSERT instructors(instructorId, firstName, lastName) SELECT 1, 'James', 'Koinange';
INSERT instructors(instructorId, firstName, lastName) SELECT 2,  'Paolo', 'Salvodelli';
INSERT instructors(instructorId, firstName, lastName) SELECT 3,  'Miriam', 'Azavedo';
INSERT instructors(instructorId, firstName, lastName) SELECT 4,  'Wanjiku', 'Njeri';
INSERT instructors(instructorId, firstName, lastName) SELECT 5,  'Tina', 'Ho';
INSERT instructors(instructorId, firstName, lastName) SELECT 6,  'Frank', 'Blumenthal';
INSERT instructors(instructorId, firstName, lastName) SELECT 7,  'Radamanth', 'Nemes';
INSERT instructors(instructorId, firstName, lastName) SELECT 8,  'Grumpy', 'McStumpy';
INSERT instructors(instructorId, firstName, lastName) SELECT 9,  'Samira', 'Khan';

/* course instructors */

INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 300, 1, 102;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 301, 1, 108;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 302, 2, 104;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 303, 2, 105;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 304, 3, 103;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 305, 3, 112;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 306, 3, 113;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 307, 3, 114;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 308, 4, 108;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 309, 4, 102;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 310, 5, 112;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 311, 5, 107;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 312, 6, 112;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 313, 6, 102;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 314, 7, 106;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 315, 8, 110;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 316, 8, 111;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 317, 9, 101;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 318, 9, 109;
INSERT CourseInstructors(courseInstructorId, instructorId, courseId) SELECT 319, 9, 110;

/* enrollments */

INSERT enrollments(courseInstructorId, studentId) SELECT 300, 1001;
INSERT enrollments(courseInstructorId, studentId) SELECT 301, 1001;
INSERT enrollments(courseInstructorId, studentId) SELECT 302, 1001;

INSERT enrollments(courseInstructorId, studentId) SELECT 300, 1002;
INSERT enrollments(courseInstructorId, studentId) SELECT 303, 1002;

INSERT enrollments(courseInstructorId, studentId) SELECT 315, 1003;
INSERT enrollments(courseInstructorId, studentId) SELECT 303, 1003;
INSERT enrollments(courseInstructorId, studentId) SELECT 301, 1003;

INSERT enrollments(courseInstructorId, studentId) SELECT 318, 1004;
INSERT enrollments(courseInstructorId, studentId) SELECT 303, 1004;
INSERT enrollments(courseInstructorId, studentId) SELECT 306, 1004;

INSERT enrollments(courseInstructorId, studentId) SELECT 304, 1005;
INSERT enrollments(courseInstructorId, studentId) SELECT 307, 1005;
INSERT enrollments(courseInstructorId, studentId) SELECT 310, 1005;

INSERT enrollments(courseInstructorId, studentId) SELECT 310, 1006;
INSERT enrollments(courseInstructorId, studentId) SELECT 316, 1006;

INSERT enrollments(courseInstructorId, studentId) SELECT 304, 1007;
INSERT enrollments(courseInstructorId, studentId) SELECT 306, 1007;

INSERT enrollments(courseInstructorId, studentId) SELECT 312, 1008;
INSERT enrollments(courseInstructorId, studentId) SELECT 318, 1008;

INSERT enrollments(courseInstructorId, studentId) SELECT 304, 1009;
INSERT enrollments(courseInstructorId, studentId) SELECT 311, 1009;

INSERT enrollments(courseInstructorId, studentId) SELECT 304, 1010;
INSERT enrollments(courseInstructorId, studentId) SELECT 311, 1010;
INSERT enrollments(courseInstructorId, studentId) SELECT 307, 1010;
INSERT enrollments(courseInstructorId, studentId) SELECT 316, 1010;
INSERT enrollments(courseInstructorId, studentId) SELECT 317, 1010;

INSERT enrollments(courseInstructorId, studentId) SELECT 304, 1011;
INSERT enrollments(courseInstructorId, studentId) SELECT 311, 1011;
INSERT enrollments(courseInstructorId, studentId) SELECT 307, 1011;
INSERT enrollments(courseInstructorId, studentId) SELECT 316, 1011;
INSERT enrollments(courseInstructorId, studentId) SELECT 317, 1011;

INSERT enrollments(courseInstructorId, studentId) SELECT 305, 1012;

INSERT enrollments(courseInstructorId, studentId) SELECT 305, 1013;

INSERT enrollments(courseInstructorId, studentId) SELECT 305, 1014;

INSERT enrollments(courseInstructorId, studentId) SELECT 300, 1015;
INSERT enrollments(courseInstructorId, studentId) SELECT 302, 1015;
INSERT enrollments(courseInstructorId, studentId) SELECT 304, 1015;
INSERT enrollments(courseInstructorId, studentId) SELECT 307, 1015;
INSERT enrollments(courseInstructorId, studentId) SELECT 315, 1015;

INSERT enrollments(courseInstructorId, studentId) SELECT 307, 1016;
INSERT enrollments(courseInstructorId, studentId) SELECT 315, 1016;

INSERT enrollments(courseInstructorId, studentId) SELECT 307, 1017;
INSERT enrollments(courseInstructorId, studentId) SELECT 315, 1017;

INSERT enrollments(courseInstructorId, studentId) SELECT 310, 1018;
INSERT enrollments(courseInstructorId, studentId) SELECT 319, 1018;

INSERT enrollments(courseInstructorId, studentId) SELECT 311, 1019;
INSERT enrollments(courseInstructorId, studentId) SELECT 319, 1019;

INSERT enrollments(courseInstructorId, studentId) SELECT 302, 1020;
INSERT enrollments(courseInstructorId, studentId) SELECT 305, 1020;

INSERT enrollments(courseInstructorId, studentId) SELECT 303, 1021;
INSERT enrollments(courseInstructorId, studentId) SELECT 307, 1021;

INSERT enrollments(courseInstructorId, studentId) SELECT 309, 1022;
INSERT enrollments(courseInstructorId, studentId) SELECT 318, 1022;

INSERT enrollments(courseInstructorId, studentId) SELECT 305, 1023;

/* accounts */









