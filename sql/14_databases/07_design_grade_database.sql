-- CREATE TABLE IF NOT EXISTS Students (
--   id int PRIMARY KEY,
--   first_name varchar(100),
--   last_name varchar(100)
-- );

-- CREATE TABLE IF NOT EXISTS Courses (
--   id int PRIMARY KEY,
--   name varchar(100)
-- );

-- CREATE TABLE IF NOT EXISTS Grades (
--   student_id int,
--   course_id int,
--   grade int
-- );

-- CREATE UNIQUE INDEX GradesStudentsIdCourseId ON Grades (student_id, course_id);

-- INSERT INTO Courses (id, name) VALUES (1, 'Math');
-- INSERT INTO Courses (id, name) VALUES (2, 'Physics');
-- INSERT INTO Courses (id, name) VALUES (3, 'Literature');
-- INSERT INTO Courses (id, name) VALUES (4, 'Chemistry');
-- INSERT INTO Courses (id, name) VALUES (5, 'Software development');

-- -- puts 50.times.map { |i| "INSERT INTO Students (id, first_name, last_name) VALUES (#{i + 1}, '#{Faker::Name.first_name}', '#{Faker::Name.last_name}');" }

-- INSERT INTO Students (id, first_name, last_name) VALUES (1, 'Jakayla', 'Oberbrunner');
-- INSERT INTO Students (id, first_name, last_name) VALUES (2, 'Jose', 'Quitzon');
-- INSERT INTO Students (id, first_name, last_name) VALUES (3, 'Kay', 'Reichert');
-- INSERT INTO Students (id, first_name, last_name) VALUES (4, 'Kelton', 'Emard');
-- INSERT INTO Students (id, first_name, last_name) VALUES (5, 'Bethany', 'Kunze');
-- INSERT INTO Students (id, first_name, last_name) VALUES (6, 'Eli', 'Swaniawski');
-- INSERT INTO Students (id, first_name, last_name) VALUES (7, 'Mafalda', 'Deckow');
-- INSERT INTO Students (id, first_name, last_name) VALUES (8, 'Patrick', 'Legros');
-- INSERT INTO Students (id, first_name, last_name) VALUES (9, 'Violet', 'Tremblay');
-- INSERT INTO Students (id, first_name, last_name) VALUES (10, 'Flavio', 'Reinger');
-- INSERT INTO Students (id, first_name, last_name) VALUES (11, 'Jace', 'Kuhic');
-- INSERT INTO Students (id, first_name, last_name) VALUES (12, 'Pansy', 'O''Kon');
-- INSERT INTO Students (id, first_name, last_name) VALUES (13, 'Eleazar', 'Crooks');
-- INSERT INTO Students (id, first_name, last_name) VALUES (14, 'Destiney', 'Christiansen');
-- INSERT INTO Students (id, first_name, last_name) VALUES (15, 'Lisandro', 'Kutch');
-- INSERT INTO Students (id, first_name, last_name) VALUES (16, 'Edmund', 'Ratke');
-- INSERT INTO Students (id, first_name, last_name) VALUES (17, 'Torrance', 'Jast');
-- INSERT INTO Students (id, first_name, last_name) VALUES (18, 'Ramiro', 'Haag');
-- INSERT INTO Students (id, first_name, last_name) VALUES (19, 'Yvonne', 'Labadie');
-- INSERT INTO Students (id, first_name, last_name) VALUES (20, 'Francis', 'Quigley');
-- INSERT INTO Students (id, first_name, last_name) VALUES (21, 'Creola', 'Miller');
-- INSERT INTO Students (id, first_name, last_name) VALUES (22, 'Simeon', 'Steuber');
-- INSERT INTO Students (id, first_name, last_name) VALUES (23, 'Ursula', 'Willms');
-- INSERT INTO Students (id, first_name, last_name) VALUES (24, 'Aron', 'Block');
-- INSERT INTO Students (id, first_name, last_name) VALUES (25, 'Eulalia', 'Johnson');
-- INSERT INTO Students (id, first_name, last_name) VALUES (26, 'Katarina', 'Moen');
-- INSERT INTO Students (id, first_name, last_name) VALUES (27, 'Alana', 'Ortiz');
-- INSERT INTO Students (id, first_name, last_name) VALUES (28, 'Maymie', 'Koepp');
-- INSERT INTO Students (id, first_name, last_name) VALUES (29, 'Helen', 'Kozey');
-- INSERT INTO Students (id, first_name, last_name) VALUES (30, 'Danial', 'Medhurst');
-- INSERT INTO Students (id, first_name, last_name) VALUES (31, 'Cyril', 'Blanda');
-- INSERT INTO Students (id, first_name, last_name) VALUES (32, 'Ariel', 'Ebert');
-- INSERT INTO Students (id, first_name, last_name) VALUES (33, 'Gerhard', 'Jenkins');
-- INSERT INTO Students (id, first_name, last_name) VALUES (34, 'Ursula', 'Hane');
-- INSERT INTO Students (id, first_name, last_name) VALUES (35, 'Myles', 'Eichmann');
-- INSERT INTO Students (id, first_name, last_name) VALUES (36, 'Brielle', 'Kling');
-- INSERT INTO Students (id, first_name, last_name) VALUES (37, 'Ozella', 'Bartoletti');
-- INSERT INTO Students (id, first_name, last_name) VALUES (38, 'Tyrell', 'Brekke');
-- INSERT INTO Students (id, first_name, last_name) VALUES (39, 'Ernesto', 'Kihn');
-- INSERT INTO Students (id, first_name, last_name) VALUES (40, 'Linwood', 'Deckow');
-- INSERT INTO Students (id, first_name, last_name) VALUES (41, 'Zack', 'Conn');
-- INSERT INTO Students (id, first_name, last_name) VALUES (42, 'Zaria', 'Hettinger');
-- INSERT INTO Students (id, first_name, last_name) VALUES (43, 'Sammy', 'Graham');
-- INSERT INTO Students (id, first_name, last_name) VALUES (44, 'Keyon', 'Huel');
-- INSERT INTO Students (id, first_name, last_name) VALUES (45, 'Elwyn', 'Moen');
-- INSERT INTO Students (id, first_name, last_name) VALUES (46, 'Ludwig', 'Sauer');
-- INSERT INTO Students (id, first_name, last_name) VALUES (47, 'Luis', 'Kuphal');
-- INSERT INTO Students (id, first_name, last_name) VALUES (48, 'Eleonore', 'Lang');
-- INSERT INTO Students (id, first_name, last_name) VALUES (49, 'Christiana', 'Shanahan');
-- INSERT INTO Students (id, first_name, last_name) VALUES (50, 'Domenico', 'Cummerata');

-- -- puts (1..50).flat_map { |student_id| (1..5).map { |course_id| "INSERT INTO Grades (student_id, course_id, grade) VALUES (#{student_id}, #{course_id}, #{rand(100)});" } }

-- INSERT INTO Grades (student_id, course_id, grade) VALUES (1, 1, 45);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (1, 2, 79);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (1, 3, 66);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (1, 4, 76);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (1, 5, 32);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (2, 1, 0);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (2, 2, 25);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (2, 3, 17);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (2, 4, 9);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (2, 5, 99);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (3, 1, 74);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (3, 2, 75);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (3, 3, 0);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (3, 4, 89);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (3, 5, 53);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (4, 1, 57);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (4, 2, 87);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (4, 3, 87);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (4, 4, 0);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (4, 5, 81);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (5, 1, 41);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (5, 2, 37);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (5, 3, 82);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (5, 4, 92);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (5, 5, 81);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (6, 1, 83);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (6, 2, 33);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (6, 3, 97);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (6, 4, 34);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (6, 5, 57);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (7, 1, 40);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (7, 2, 72);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (7, 3, 65);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (7, 4, 40);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (7, 5, 32);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (8, 1, 76);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (8, 2, 30);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (8, 3, 74);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (8, 4, 16);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (8, 5, 32);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (9, 1, 91);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (9, 2, 74);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (9, 3, 61);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (9, 4, 42);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (9, 5, 82);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (10, 1, 97);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (10, 2, 86);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (10, 3, 90);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (10, 4, 20);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (10, 5, 61);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (11, 1, 64);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (11, 2, 29);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (11, 3, 99);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (11, 4, 63);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (11, 5, 31);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (12, 1, 0);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (12, 2, 29);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (12, 3, 86);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (12, 4, 27);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (12, 5, 69);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (13, 1, 60);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (13, 2, 17);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (13, 3, 66);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (13, 4, 86);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (13, 5, 41);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (14, 1, 73);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (14, 2, 1);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (14, 3, 5);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (14, 4, 3);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (14, 5, 37);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (15, 1, 99);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (15, 2, 6);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (15, 3, 91);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (15, 4, 42);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (15, 5, 94);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (16, 1, 95);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (16, 2, 86);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (16, 3, 59);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (16, 4, 84);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (16, 5, 93);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (17, 1, 65);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (17, 2, 28);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (17, 3, 10);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (17, 4, 37);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (17, 5, 2);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (18, 1, 80);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (18, 2, 77);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (18, 3, 29);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (18, 4, 19);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (18, 5, 74);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (19, 1, 76);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (19, 2, 24);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (19, 3, 96);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (19, 4, 5);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (19, 5, 20);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (20, 1, 58);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (20, 2, 10);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (20, 3, 99);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (20, 4, 12);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (20, 5, 31);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (21, 1, 9);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (21, 2, 28);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (21, 3, 57);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (21, 4, 82);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (21, 5, 88);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (22, 1, 41);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (22, 2, 5);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (22, 3, 69);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (22, 4, 68);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (22, 5, 81);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (23, 1, 0);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (23, 2, 38);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (23, 3, 93);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (23, 4, 39);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (23, 5, 39);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (24, 1, 60);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (24, 2, 43);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (24, 3, 31);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (24, 4, 27);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (24, 5, 82);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (25, 1, 87);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (25, 2, 53);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (25, 3, 40);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (25, 4, 31);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (25, 5, 5);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (26, 1, 72);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (26, 2, 35);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (26, 3, 16);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (26, 4, 17);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (26, 5, 33);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (27, 1, 45);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (27, 2, 88);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (27, 3, 49);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (27, 4, 11);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (27, 5, 42);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (28, 1, 51);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (28, 2, 83);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (28, 3, 92);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (28, 4, 54);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (28, 5, 58);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (29, 1, 59);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (29, 2, 57);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (29, 3, 17);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (29, 4, 45);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (29, 5, 60);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (30, 1, 48);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (30, 2, 96);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (30, 3, 75);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (30, 4, 52);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (30, 5, 14);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (31, 1, 91);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (31, 2, 21);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (31, 3, 26);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (31, 4, 24);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (31, 5, 21);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (32, 1, 35);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (32, 2, 3);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (32, 3, 76);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (32, 4, 58);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (32, 5, 65);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (33, 1, 84);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (33, 2, 11);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (33, 3, 58);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (33, 4, 87);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (33, 5, 60);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (34, 1, 38);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (34, 2, 78);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (34, 3, 24);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (34, 4, 60);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (34, 5, 41);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (35, 1, 72);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (35, 2, 83);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (35, 3, 11);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (35, 4, 43);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (35, 5, 98);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (36, 1, 43);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (36, 2, 11);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (36, 3, 92);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (36, 4, 78);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (36, 5, 79);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (37, 1, 21);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (37, 2, 94);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (37, 3, 43);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (37, 4, 28);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (37, 5, 68);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (38, 1, 19);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (38, 2, 39);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (38, 3, 46);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (38, 4, 28);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (38, 5, 67);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (39, 1, 63);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (39, 2, 22);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (39, 3, 28);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (39, 4, 53);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (39, 5, 3);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (40, 1, 4);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (40, 2, 82);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (40, 3, 72);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (40, 4, 0);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (40, 5, 80);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (41, 1, 10);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (41, 2, 75);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (41, 3, 26);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (41, 4, 71);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (41, 5, 61);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (42, 1, 38);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (42, 2, 23);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (42, 3, 63);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (42, 4, 93);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (42, 5, 13);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (43, 1, 95);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (43, 2, 82);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (43, 3, 12);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (43, 4, 79);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (43, 5, 28);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (44, 1, 81);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (44, 2, 99);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (44, 3, 24);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (44, 4, 4);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (44, 5, 50);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (45, 1, 69);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (45, 2, 53);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (45, 3, 19);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (45, 4, 36);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (45, 5, 83);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (46, 1, 39);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (46, 2, 31);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (46, 3, 16);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (46, 4, 87);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (46, 5, 86);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (47, 1, 27);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (47, 2, 37);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (47, 3, 70);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (47, 4, 34);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (47, 5, 25);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (48, 1, 14);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (48, 2, 91);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (48, 3, 55);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (48, 4, 71);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (48, 5, 58);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (49, 1, 30);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (49, 2, 89);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (49, 3, 97);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (49, 4, 19);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (49, 5, 75);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (50, 1, 7);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (50, 2, 92);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (50, 3, 4);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (50, 4, 14);
-- INSERT INTO Grades (student_id, course_id, grade) VALUES (50, 5, 33);

-- Solution

SELECT MIN(Courses.name) as "Course", AVG(Grades.grade) as "Avg grade"
FROM Courses, Grades
WHERE Grades.course_id = Courses.id
GROUP BY Grades.course_id
ORDER BY AVG(Grades.grade) desc;

-- Top 10% by count
SELECT * FROM (
  SELECT MIN(Students.first_name) as "First name", MIN(Students.last_name) as "Last name", AVG(Grades.grade)
  FROM Grades, Students, Courses
  WHERE Grades.student_id = Students.id AND Courses.id = Grades.course_id
  GROUP BY Students.id
  ORDER BY AVG(Grades.grade) desc
) AS sub_query
LIMIT (SELECT COUNT(*) * 0.1 FROM Students);

-- Top 10% best by comparing real percentile value
SELECT * FROM (
  SELECT MIN(Students.first_name) as "First name", MIN(Students.last_name) as "Last name", AVG(Grades.grade) as "avg_grade"
  FROM Grades, Students, Courses
  WHERE Grades.student_id = Students.id AND Courses.id = Grades.course_id
  GROUP BY Students.id
  ORDER BY AVG(Grades.grade) desc
) AS sub_query
WHERE sub_query.avg_grade >= (
  SELECT percentile_disc(0.9)
  WITHIN GROUP (order by avg_grade)
  FROM (
    SELECT AVG(Grades.grade) as "avg_grade" FROM Grades GROUP BY Grades.student_id
  ) as aggregated
);

SELECT percentile_disc(0.9)
WITHIN GROUP (order by avg_grade)
FROM (
  SELECT AVG(Grades.grade) as "avg_grade" FROM Grades GROUP BY Grades.student_id
) as aggregated;
