-- ============================================
-- Scriptum Book Database
-- Database Schema and Initial Data
-- ============================================

CREATE DATABASE IF NOT EXISTS `bookdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `bookdb`;

-- ============================================
-- Table: author
-- ============================================
DROP TABLE IF EXISTS `author`;
CREATE TABLE `author` (
  `author_name` varchar(45) NOT NULL,
  `birth_date` date NOT NULL,
  `author_id` int DEFAULT NULL,
  `biography` text,
  PRIMARY KEY (`author_name`,`birth_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `author` VALUES 
('Φιόντορ Ντοστογιέφσκι','1821-11-11',267,'Ρώσος μυθιστοριογράφος που εμβάθυνε στην ανθρώπινη ψυχολογία και τα υπαρξιακά διλήμματα, δημιουργώντας κλασικά έργα όπως οι Αδελφοί Καραμαζόφ.'),
('Χούλιο Κορτάσαρ','1914-08-26',202,'Αργεντινός συγγραφέας του μαγικού ρεαλισμού, γνωστός για την πειραματική του γραφή και το εμβληματικό μυθιστόρημα Κουτσό.');

-- ============================================
-- Table: publisher
-- ============================================
DROP TABLE IF EXISTS `publisher`;
CREATE TABLE `publisher` (
  `publisher_id` int NOT NULL,
  `founded_date` date DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `address` varchar(25) DEFAULT NULL,
  `phone` bigint DEFAULT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `publisher` VALUES 
(503,'1982-02-18','kaktos@publishing.com','Athens, Greece',NULL),
(518,'1897-06-19','classicpub@mail.com','Thessaloniki, Greece',NULL);

-- ============================================
-- Table: book
-- ============================================
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `isbn` char(13) NOT NULL,
  `book_id` int DEFAULT NULL,
  `book_title` varchar(100) DEFAULT NULL,
  `page_count` int DEFAULT NULL,
  `publication_year` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `language` varchar(45) DEFAULT NULL,
  `genre` varchar(15) DEFAULT NULL,
  `publisher_id` int NOT NULL,
  `author_name` varchar(45) NOT NULL,
  `author_birth_date` date NOT NULL,
  PRIMARY KEY (`isbn`),
  KEY `fk_Book_Publisher` (`publisher_id`),
  KEY `fk_Book_Author` (`author_name`,`author_birth_date`),
  CONSTRAINT `fk_Book_Author` FOREIGN KEY (`author_name`, `author_birth_date`) REFERENCES `author` (`author_name`, `birth_date`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Book_Publisher` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `book` VALUES 
('9789602962763',52,'Ο Μέγας Ιεροεξεταστής',NULL,2019,NULL,NULL,'fiction',518,'Φιόντορ Ντοστογιέφσκι','1821-11-11'),
('9789608397934',24,'Το κουτσό',NULL,2018,NULL,NULL,'fiction',503,'Χούλιο Κορτάσαρ','1914-08-26');

-- ============================================
-- Table: user
-- ============================================
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `bio` text,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `user` VALUES 
(101,'AlexandrosS','alex@mail.com','2022-04-25',NULL),
(102,'ReadingBeast','jorge@mail.com','2020-01-17',NULL),
(103,'ElenaBooks','elena@mail.com','2019-12-12',NULL);

-- ============================================
-- Table: booklist
-- ============================================
DROP TABLE IF EXISTS `booklist`;
CREATE TABLE `booklist` (
  `booklist_id` int NOT NULL,
  `booklist_name` varchar(50) DEFAULT NULL,
  `book_count` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`booklist_id`),
  KEY `fk_Booklist_User` (`user_id`),
  CONSTRAINT `fk_Booklist_User` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `booklist` VALUES 
(456,'To Read',58,101),
(478,'Goated Books',13,102);

-- ============================================
-- Table: booklist_contains_book
-- ============================================
DROP TABLE IF EXISTS `booklist_contains_book`;
CREATE TABLE `booklist_contains_book` (
  `booklist_id` int NOT NULL,
  `isbn` char(13) NOT NULL,
  `reading_status` enum('want-to-read','currently-reading','read') DEFAULT NULL,
  PRIMARY KEY (`booklist_id`,`isbn`),
  KEY `fk_Contains_Book` (`isbn`),
  CONSTRAINT `fk_Contains_Book` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE CASCADE,
  CONSTRAINT `fk_Contains_Booklist` FOREIGN KEY (`booklist_id`) REFERENCES `booklist` (`booklist_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `booklist_contains_book` VALUES 
(456,'9789608397934','read'),
(478,'9789602962763','currently-reading');

-- ============================================
-- Table: reading_challenge
-- ============================================
DROP TABLE IF EXISTS `reading_challenge`;
CREATE TABLE `reading_challenge` (
  `challenge_id` int NOT NULL,
  `challenge_name` varchar(30) DEFAULT NULL,
  `challenge_year` int DEFAULT NULL,
  `challenge_type` varchar(20) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`challenge_id`),
  KEY `fk_Challenge_User` (`user_id`),
  CONSTRAINT `fk_Challenge_User` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `reading_challenge` VALUES 
(903,'classic month',NULL,NULL,'2025-01-01','2025-01-31',102),
(918,'year of history',NULL,NULL,'2024-01-01','2024-12-31',103);

-- ============================================
-- Table: user_follows_user
-- ============================================
DROP TABLE IF EXISTS `user_follows_user`;
CREATE TABLE `user_follows_user` (
  `follower_user_id` int NOT NULL,
  `followed_user_id` int NOT NULL,
  PRIMARY KEY (`follower_user_id`,`followed_user_id`),
  KEY `fk_Followed` (`followed_user_id`),
  CONSTRAINT `fk_Followed` FOREIGN KEY (`followed_user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Follower` FOREIGN KEY (`follower_user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `user_follows_user` VALUES 
(101,102),
(102,103);

-- ============================================
-- Table: user_participates_reading_challenge
-- ============================================
DROP TABLE IF EXISTS `user_participates_reading_challenge`;
CREATE TABLE `user_participates_reading_challenge` (
  `user_id` int NOT NULL,
  `challenge_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`challenge_id`),
  KEY `fk_Participates_Challenge` (`challenge_id`),
  CONSTRAINT `fk_Participates_Challenge` FOREIGN KEY (`challenge_id`) REFERENCES `reading_challenge` (`challenge_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Participates_User` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `user_participates_reading_challenge` VALUES 
(102,903),
(103,918);

-- ============================================
-- Table: user_rates_book
-- ============================================
DROP TABLE IF EXISTS `user_rates_book`;
CREATE TABLE `user_rates_book` (
  `user_id` int NOT NULL,
  `isbn` char(13) NOT NULL,
  `rating_value` tinyint NOT NULL,
  PRIMARY KEY (`user_id`,`isbn`),
  KEY `fk_Rate_Book` (`isbn`),
  CONSTRAINT `fk_Rate_Book` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE CASCADE,
  CONSTRAINT `fk_Rate_User` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `user_rates_book` VALUES 
(102,'9789608397934',5),
(103,'9789602962763',5);

-- ============================================
-- Table: user_reviews_book
-- ============================================
DROP TABLE IF EXISTS `user_reviews_book`;
CREATE TABLE `user_reviews_book` (
  `user_id` int NOT NULL,
  `isbn` char(13) NOT NULL,
  `review_id` int DEFAULT NULL,
  `review_text` text,
  `likes_count` int DEFAULT '0',
  `review_date` date DEFAULT NULL,
  PRIMARY KEY (`user_id`,`isbn`),
  KEY `fk_Review_Book` (`isbn`),
  CONSTRAINT `fk_Review_Book` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE CASCADE,
  CONSTRAINT `fk_Review_User` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `user_reviews_book` VALUES 
(102,'9789602962763',720,'Το σπουδαιότερο λογοτέχνημα που γράφτηκε ποτέ',25,'2025-11-17'),
(102,'9789608397934',708,'Ένα αντιμυθιστόρημα που όμοιο του δεν έχει γραφτεί ποτέ.',13,'2022-07-22');

-- ============================================
-- Views
-- ============================================

-- View: active_users_view
-- Shows users who have posted reviews after 2025-01-01
DROP VIEW IF EXISTS `active_users_view`;
CREATE VIEW `active_users_view` AS 
SELECT DISTINCT u.username 
FROM user u 
JOIN user_reviews_book ur ON u.user_id = ur.user_id 
WHERE ur.review_date > '2025-01-01';

-- View: user_reviews_view
-- Shows all user reviews with book titles
DROP VIEW IF EXISTS `user_reviews_view`;
CREATE VIEW `user_reviews_view` AS 
SELECT 
  u.username, 
  b.book_title, 
  ur.review_text, 
  ur.review_date, 
  ur.likes_count 
FROM user_reviews_book ur 
JOIN book b ON ur.isbn = b.isbn 
JOIN user u ON ur.user_id = u.user_id;
