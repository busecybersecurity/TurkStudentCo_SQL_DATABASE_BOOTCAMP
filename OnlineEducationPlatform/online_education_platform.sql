-- Safely drops all tables and their dependencies (for a clean start)
DROP TABLE IF EXISTS MemberProgress, Answers, Questions, Quizzes, Lessons, Reviews, BlogComments, BlogPosts, CertificateAssignments, Certificates, Enrollments, Courses, Instructors, Categories, Members CASCADE;

-- ======================================================================
-- Online Education Platform Database Design Project with PostgreSQL
-- (Enhanced and Comprehensive Version)
-- ======================================================================

-- Function: Automatically updates the updated_at column
-- Automatically sets the 'updated_at' column to the current time whenever a row is updated.
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 1. Members Table
-- Stores users' basic information, role definitions, and profile image URLs
CREATE TABLE IF NOT EXISTS Members (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- In a real system, this should be hashed!
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    avatar_url VARCHAR(255), -- URL for the profile image
    role VARCHAR(20) NOT NULL DEFAULT 'student', -- User role: 'student', 'instructor', 'admin'
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP -- Date and time when the record was last updated
);

-- Trigger: Automatically updates the updated_at column in the Members table
CREATE TRIGGER trg_members_updated_at
BEFORE UPDATE ON Members
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 2. Categories Table
-- Used to organize and classify courses by topic.
CREATE TABLE IF NOT EXISTS Categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP -- Date and time when the record was last updated
);

-- Trigger: Automatically updates the updated_at column in the Categories table
CREATE TRIGGER trg_categories_updated_at
BEFORE UPDATE ON Categories
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 3. Instructors Table
-- Stores instructor-specific details and identifies a member in the Members table as an instructor.
CREATE TABLE IF NOT EXISTS Instructors (
    id SERIAL PRIMARY KEY,
    member_id INTEGER UNIQUE NOT NULL, -- References the Members table (each member can have only one instructor record)
    specialization VARCHAR(100), -- Area of expertise (e.g., Data Science, Web Development)
    bio TEXT, -- Short biography
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was created
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_instructor_member FOREIGN KEY (member_id) REFERENCES Members(id) ON DELETE CASCADE -- Delete the instructor record if the member is deleted
);

-- Trigger: Automatically updates the updated_at column in the Instructors table
CREATE TRIGGER trg_instructors_updated_at
BEFORE UPDATE ON Instructors
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 4. Courses Table
-- Contains details about the courses on the platform. Instructor information is retrieved from the Instructors table.
CREATE TABLE IF NOT EXISTS Courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(200) NOT NULL,
    description TEXT,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    instructor_id INTEGER NOT NULL, -- Instructor ID (references the Instructors table)
    category_id INTEGER,
    preview_video_url VARCHAR(255), -- Course preview video URL
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was created
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_course_category
        FOREIGN KEY (category_id)
        REFERENCES Categories(id)
        ON DELETE SET NULL, -- Set the course's category to NULL if the category is deleted
    CONSTRAINT fk_course_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES Instructors(id)
        ON DELETE SET NULL, -- Set the course's instructor to NULL if the instructor is deleted
    CONSTRAINT chk_dates CHECK (end_date >= start_date) -- Ensures that the end date is not earlier than the start date
);

-- Trigger: Automatically updates the updated_at column in the Courses table
CREATE TRIGGER trg_courses_updated_at
BEFORE UPDATE ON Courses
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 5. Lessons Table
-- Stores the lessons, content, and videos belonging to each course.
CREATE TABLE IF NOT EXISTS Lessons (
    id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    lesson_title VARCHAR(255) NOT NULL, -- Lesson title
    content TEXT, -- Lesson text content
    video_url VARCHAR(255), -- Lesson video URL
    duration_minutes INTEGER, -- Lesson duration (minutes)
    order_in_course INTEGER NOT NULL, -- Lesson order within the course
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was created
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_lesson_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(id)
        ON DELETE CASCADE -- Delete the lessons if the course is deleted
);

-- Trigger: Automatically updates the updated_at column in the Lessons table
CREATE TRIGGER trg_lessons_updated_at
BEFORE UPDATE ON Lessons
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 6. Quizzes Table
-- Stores quizzes associated with lessons.
CREATE TABLE IF NOT EXISTS Quizzes (
    id SERIAL PRIMARY KEY,
    lesson_id INTEGER NOT NULL,
    quiz_title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was created
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_quiz_lesson
        FOREIGN KEY (lesson_id)
        REFERENCES Lessons(id)
        ON DELETE CASCADE -- Delete the quizzes if the lesson is deleted
);

-- Trigger: Automatically updates the updated_at column in the Quizzes table
CREATE TRIGGER trg_quizzes_updated_at
BEFORE UPDATE ON Quizzes
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 7. Questions Table
-- Stores questions associated with quizzes.
CREATE TABLE IF NOT EXISTS Questions (
    id SERIAL PRIMARY KEY,
    quiz_id INTEGER NOT NULL,
    question_text TEXT NOT NULL,
    question_type VARCHAR(50) NOT NULL, -- E.g., 'multiple_choice', 'true_false', 'short_answer'
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was created
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_question_quiz
        FOREIGN KEY (quiz_id)
        REFERENCES Quizzes(id)
        ON DELETE CASCADE -- Delete the questions if the quiz is deleted
);

-- Trigger: Automatically updates the updated_at column in the Questions table
CREATE TRIGGER trg_questions_updated_at
BEFORE UPDATE ON Questions
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 8. Answers Table
-- Stores answer options associated with questions.
CREATE TABLE IF NOT EXISTS Answers (
    id SERIAL PRIMARY KEY,
    question_id INTEGER NOT NULL,
    answer_text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE, -- Indicates whether the answer is correct
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was created
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_answer_question
        FOREIGN KEY (question_id)
        REFERENCES Questions(id)
        ON DELETE CASCADE -- Delete the answers if the question is deleted
);

-- Trigger: Automatically updates the updated_at column in the Answers table
CREATE TRIGGER trg_answers_updated_at
BEFORE UPDATE ON Answers
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 9. Enrollments Table
-- Tracks which courses users have enrolled in.
CREATE TABLE IF NOT EXISTS Enrollments (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_enrollment_member
        FOREIGN KEY (member_id)
        REFERENCES Members(id)
        ON DELETE CASCADE, -- Delete the enrollments if the member is deleted
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(id)
        ON DELETE CASCADE, -- Delete the enrollments if the course is deleted
    CONSTRAINT unique_enrollment UNIQUE (member_id, course_id) -- Prevents a user from enrolling in the same course more than once
);

-- Trigger: Automatically updates the updated_at column in the Enrollments table
CREATE TRIGGER trg_enrollments_updated_at
BEFORE UPDATE ON Enrollments
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 10. Certificates Table
-- Contains information about certificates issued for completed courses.
CREATE TABLE IF NOT EXISTS Certificates (
    id SERIAL PRIMARY KEY,
    certificate_code VARCHAR(100) UNIQUE NOT NULL,
    issued_date DATE,
    course_id INTEGER, -- Indicates which course the certificate belongs to
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_certificate_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(id)
        ON DELETE SET NULL -- Set the certificate's course reference to NULL if the course is deleted
);

-- Trigger: Automatically updates the updated_at column in the Certificates table
CREATE TRIGGER trg_certificates_updated_at
BEFORE UPDATE ON Certificates
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 11. Certificate Assignments Table
-- Records which user received which certificate.
CREATE TABLE IF NOT EXISTS CertificateAssignments (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    certificate_id INTEGER NOT NULL,
    assignment_date DATE,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_cert_assignment_member
        FOREIGN KEY (member_id)
        REFERENCES Members(id)
        ON DELETE CASCADE, -- Delete the certificate assignments if the member is deleted
    CONSTRAINT fk_cert_assignment_certificate
        FOREIGN KEY (certificate_id)
        REFERENCES Certificates(id)
        ON DELETE CASCADE, -- Delete the assignments if the certificate is deleted
    CONSTRAINT unique_cert_assignment UNIQUE (member_id, certificate_id) -- Prevents a user from receiving the same certificate more than once
);

-- Trigger: Automatically updates the updated_at column in the CertificateAssignments table
CREATE TRIGGER trg_certificate_assignments_updated_at
BEFORE UPDATE ON CertificateAssignments
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 12. Blog Posts Table
-- Contains blog posts shared by users on the platform.
CREATE TABLE IF NOT EXISTS BlogPosts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    published_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    author_id INTEGER NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_blog_author
        FOREIGN KEY (author_id)
        REFERENCES Members(id)
        ON DELETE CASCADE -- Delete the blog posts if the author (member) is deleted
);

-- Trigger: Automatically updates the updated_at column in the BlogPosts table
CREATE TRIGGER trg_blog_posts_updated_at
BEFORE UPDATE ON BlogPosts
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 13. Member Progress Tracking Table
-- Tracks users' progress in lessons and quizzes.
CREATE TABLE IF NOT EXISTS MemberProgress (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    lesson_id INTEGER NOT NULL,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE, -- Has the lesson been completed?
    completion_date TIMESTAMP, -- Completion date (if completed)
    score INTEGER, -- Quiz score (if the lesson includes a quiz)
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was created
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_progress_member FOREIGN KEY (member_id) REFERENCES Members(id) ON DELETE CASCADE,
    CONSTRAINT fk_progress_lesson FOREIGN KEY (lesson_id) REFERENCES Lessons(id) ON DELETE CASCADE,
    CONSTRAINT unique_member_lesson_progress UNIQUE (member_id, lesson_id) -- A member can have only one progress record for each lesson
);

-- Trigger: Automatically updates the updated_at column in the MemberProgress table
CREATE TRIGGER trg_member_progress_updated_at
BEFORE UPDATE ON MemberProgress
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 14. Course Reviews and Ratings Table
-- Stores users' comments and ratings about courses.
CREATE TABLE IF NOT EXISTS Reviews (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5), -- Rating from 1 to 5
    comment_text TEXT, -- Review text
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was created (review_date yerine)
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_review_member FOREIGN KEY (member_id) REFERENCES Members(id) ON DELETE CASCADE,
    CONSTRAINT fk_review_course FOREIGN KEY (course_id) REFERENCES Courses(id) ON DELETE CASCADE,
    CONSTRAINT unique_member_course_review UNIQUE (member_id, course_id) -- A member can submit only one review for each course
);

-- Trigger: Automatically updates the updated_at column in the Reviews table
CREATE TRIGGER trg_reviews_updated_at
BEFORE UPDATE ON Reviews
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 15. Blog Comments Table
-- Stores comments users make on blog posts.
CREATE TABLE IF NOT EXISTS BlogComments (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    blog_post_id INTEGER NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was created
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the record was last updated
    CONSTRAINT fk_blog_comment_member FOREIGN KEY (member_id) REFERENCES Members(id) ON DELETE CASCADE,
    CONSTRAINT fk_blog_comment_post FOREIGN KEY (blog_post_id) REFERENCES BlogPosts(id) ON DELETE CASCADE
);

-- Trigger: Automatically updates the updated_at column in the BlogComments table
CREATE TRIGGER trg_blog_comments_updated_at
BEFORE UPDATE ON BlogComments
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- ========================
-- INSERTING SAMPLE DATA
-- ========================

-- Members (roles and avatar_url updated)
INSERT INTO Members (username, email, password, first_name, last_name, role, avatar_url)
VALUES
('coderzeynep', 'zeynep@gmail.com', 'hashedpass1', 'Zeynep', 'Yılmaz', 'instructor', 'https://placehold.co/100x100/F06292/FFFFFF?text=ZY'), -- Instructor
('mrrobot', 'elliot@fsociety.com', 'mrrobot123', 'Elliot', 'Alderson', 'student', 'https://placehold.co/100x100/42A5F5/FFFFFF?text=EA'),
('techqueen', 'ayse@codehub.org', 'queenbee99', 'Ayşe', 'Kaya', 'instructor', 'https://placehold.co/100x100/FFD54F/FFFFFF?text=AK'), -- Instructor
('adminuser', 'admin@platform.com', 'adminpass', 'Platform', 'Admin', 'admin', 'https://placehold.co/100x100/81C784/FFFFFF?text=PA'); -- Administrator

-- Instructorler (Yeni tabloya veri ekleniyor)
INSERT INTO Instructors (member_id, specialization, bio)
VALUES
((SELECT id FROM Members WHERE username = 'coderzeynep'), 'Software Development, Python', 'An experienced software developer and instructor.'),
((SELECT id FROM Members WHERE username = 'techqueen'), 'Data Science, SQL', 'A data analysis and visualization specialist.');

-- Categories
INSERT INTO Categories (category_name)
VALUES
('Software'),
('Design'),
('Data Science'),
('Marketing');

-- Courses (using instructor_id and preview_video_url)
INSERT INTO Courses (course_name, description, start_date, end_date, instructor_id, category_id, preview_video_url)
VALUES
('Python 101', 'Python course for beginners', '2024-05-01 00:00:00', '2024-06-01 00:00:00', (SELECT id FROM Instructors WHERE member_id = (SELECT id FROM Members WHERE username = 'coderzeynep')), 1, 'https://example.com/preview_python101.mp4'),
('Data Visualization', 'Data analysis through visual explanations', '2024-05-10 00:00:00', '2024-06-15 00:00:00', (SELECT id FROM Instructors WHERE member_id = (SELECT id FROM Members WHERE username = 'techqueen')), 3, 'https://example.com/preview_datavis.mp4'),
('Basic Python Course', 'Basic Python course for beginners', '2025-02-01 00:00:00', '2025-03-01 00:00:00', (SELECT id FROM Instructors WHERE member_id = (SELECT id FROM Members WHERE username = 'coderzeynep')), 1, NULL),
('Data Analysis with SQL', 'Data querying techniques and the use of SQL', '2025-03-10 00:00:00', '2025-04-10 00:00:00', (SELECT id FROM Instructors WHERE member_id = (SELECT id FROM Members WHERE username = 'techqueen')), 3, 'https://example.com/preview_sql.mp4');

-- Lessons (inserting data into the new table)
INSERT INTO Lessons (course_id, lesson_title, content, video_url, duration_minutes, order_in_course)
VALUES
((SELECT id FROM Courses WHERE course_name = 'Python 101'), 'Introduction and Setup', 'Fundamentals of the Python programming language and development environment setup.', 'https://example.com/python101_lesson1.mp4', 30, 1),
((SELECT id FROM Courses WHERE course_name = 'Python 101'), 'Variables and Data Types', 'Python\'daki temel veri tipleri ve değişken tanımlamaları.', 'https://example.com/python101_lesson2.mp4', 45, 2),
((SELECT id FROM Courses WHERE course_name = 'Data Visualization'), 'Matplotlib Fundamentals', 'Veri görselleştirme kütüphanesi Matplotlib\'e giriş.', 'https://example.com/datavis_lesson1.mp4', 60, 1);

-- Quizzes (inserting data into the new table)
INSERT INTO Quizzes (lesson_id, quiz_title, description)
VALUES
((SELECT id FROM Lessons WHERE lesson_title = 'Introduction and Setup'), 'Python Introduction Quiz', 'A short test of basic Python knowledge after the introductory lesson.'),
((SELECT id FROM Lessons WHERE lesson_title = 'Matplotlib Fundamentals'), 'Matplotlib Fundamentals Quiz', 'Test your knowledge with questions about the Matplotlib library.');

-- Questions (inserting data into the new table)
INSERT INTO Questions (quiz_id, question_text, question_type)
VALUES
((SELECT id FROM Quizzes WHERE quiz_title = 'Python Introduction Quiz'), 'What type of language is Python?', 'multiple_choice'),
((SELECT id FROM Quizzes WHERE quiz_title = 'Python Introduction Quiz'), 'Is Python an interpreted language?', 'true_false'),
((SELECT id FROM Quizzes WHERE quiz_title = 'Matplotlib Fundamentals Quiz'), 'What is Matplotlib used for?', 'short_answer');

-- Answers (inserting data into the new table)
INSERT INTO Answers (question_id, answer_text, is_correct)
VALUES
((SELECT id FROM Questions WHERE question_text = 'What type of language is Python?'), 'Interpreted', TRUE),
((SELECT id FROM Questions WHERE question_text = 'What type of language is Python?'), 'Compiled', FALSE),
((SELECT id FROM Questions WHERE question_text = 'Is Python an interpreted language?'), 'Yes', TRUE),
((SELECT id FROM Questions WHERE question_text = 'Is Python an interpreted language?'), 'No', FALSE),
((SELECT id FROM Questions WHERE question_text = 'What is Matplotlib used for?'), 'Data visualization', TRUE); -- Example of a correct answer for a short-answer question

-- Enrollments
INSERT INTO Enrollments (member_id, course_id)
VALUES
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM Courses WHERE course_name = 'Python 101')),
((SELECT id FROM Members WHERE username = 'techqueen'), (SELECT id FROM Courses WHERE course_name = 'Data Visualization'));

-- Certificates
INSERT INTO Certificates (certificate_code, issued_date, course_id)
VALUES
('PY2024-001', '2024-06-02', (SELECT id FROM Courses WHERE course_name = 'Python 101')),
('DATA2024-002', '2024-06-16', (SELECT id FROM Courses WHERE course_name = 'Data Visualization'));

-- Certificate Assignments
INSERT INTO CertificateAssignments (member_id, certificate_id, assignment_date)
VALUES
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM Certificates WHERE certificate_code = 'PY2024-001'), '2024-06-03'),
((SELECT id FROM Members WHERE username = 'techqueen'), (SELECT id FROM Certificates WHERE certificate_code = 'DATA2024-002'), '2024-06-05');

-- Blog Posts
INSERT INTO BlogPosts (title, content, author_id)
VALUES
('Where Should I Start with Software Development?', 'I think it is important to learn the fundamentals first and then practice a lot. Remember, you learn by writing code!', (SELECT id FROM Members WHERE username = 'coderzeynep')),
('My Data Science Journey', 'I have always been interested in this field, and eventually I found myself exploring it in depth. The world of data is truly fascinating!', (SELECT id FROM Members WHERE username = 'techqueen'));

-- Member Progress Tracking (inserting data into the new table)
INSERT INTO MemberProgress (member_id, lesson_id, is_completed, completion_date, score)
VALUES
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM Lessons WHERE lesson_title = 'Introduction and Setup'), TRUE, '2024-05-05 10:00:00', NULL), -- Lesson completed
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM Lessons WHERE lesson_title = 'Variables and Data Types'), FALSE, NULL, NULL), -- Lesson not completed yet
((SELECT id FROM Members WHERE username = 'techqueen'), (SELECT id FROM Lessons WHERE lesson_title = 'Matplotlib Fundamentals'), TRUE, '2024-06-01 15:30:00', 90); -- Lesson completed and quiz score recorded

-- Course Reviews and Ratings (inserting data into the new table)
INSERT INTO Reviews (member_id, course_id, rating, comment_text)
VALUES
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM Courses WHERE course_name = 'Python 101'), 5, 'A great introductory course; it was very useful! The instructor's explanations were excellent.'),
((SELECT id FROM Members WHERE username = 'techqueen'), (SELECT id FROM Courses WHERE course_name = 'Data Visualization'), 4, 'The explanations were good, but some sections could have included more examples. Overall, I was satisfied.');

-- Blog Comments (inserting data into the new table)
INSERT INTO BlogComments (member_id, blog_post_id, comment_text)
VALUES
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM BlogPosts WHERE title = 'Where Should I Start with Software Development?'), 'Very accurate points, thank you! A great guide for beginners.'),
((SELECT id FROM Members WHERE username = 'adminuser'), (SELECT id FROM BlogPosts WHERE title = 'My Data Science Journey'), 'Thank you for your effort; this was an informative post. It increased my interest in data science!');

-- ========================
-- INDEXING (CRITICAL FOR PERFORMANCE)
-- ========================

-- Indexes on foreign key columns (improve JOIN performance)
CREATE INDEX idx_members_email ON Members (email);
CREATE INDEX idx_members_username ON Members (username);
CREATE INDEX idx_members_role ON Members (role); -- For role-based queries
CREATE INDEX idx_instructors_member_id ON Instructors (member_id);
CREATE INDEX idx_courses_category_id ON Courses (category_id);
CREATE INDEX idx_courses_instructor_id ON Courses (instructor_id);
CREATE INDEX idx_enrollments_member_id ON Enrollments (member_id);
CREATE INDEX idx_enrollments_course_id ON Enrollments (course_id);
CREATE INDEX idx_certificates_course_id ON Certificates (course_id);
CREATE INDEX idx_certificate_assignments_member_id ON CertificateAssignments (member_id);
CREATE INDEX idx_certificate_assignments_certificate_id ON CertificateAssignments (certificate_id);
CREATE INDEX idx_blog_posts_author_id ON BlogPosts (author_id);
CREATE INDEX idx_lessons_course_id ON Lessons (course_id);
CREATE INDEX idx_quizzes_lesson_id ON Quizzes (lesson_id);
CREATE INDEX idx_questions_quiz_id ON Questions (quiz_id);
CREATE INDEX idx_answers_question_id ON Answers (question_id);
CREATE INDEX idx_member_progress_member_id ON MemberProgress (member_id);
CREATE INDEX idx_member_progress_lesson_id ON MemberProgress (lesson_id);
CREATE INDEX idx_reviews_member_id ON Reviews (member_id);
CREATE INDEX idx_reviews_course_id ON Reviews (course_id);
CREATE INDEX idx_blog_comments_member_id ON BlogComments (member_id);
CREATE INDEX idx_blog_comments_blog_post_id ON BlogComments (blog_post_id);

-- Indexes on other frequently searched columns (speed up WHERE conditions)
CREATE INDEX idx_courses_course_name ON Courses (course_name);
CREATE INDEX idx_categories_category_name ON Categories (category_name);
CREATE INDEX idx_certificates_certificate_code ON Certificates (certificate_code);
CREATE INDEX idx_lessons_lesson_title ON Lessons (lesson_title);
CREATE INDEX idx_quizzes_quiz_title ON Quizzes (quiz_title);
CREATE INDEX idx_blog_posts_title ON BlogPosts (title);
CREATE INDEX idx_members_registration_date ON Members (registration_date); -- For sorting/filtering by registration date
CREATE INDEX idx_courses_start_date ON Courses (start_date); -- For searching by course start date
