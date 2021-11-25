
-- creation of schema for social media app 
create schema socialApp;
use socialApp;

-- creation of table for user details
CREATE TABLE `socialapp`.`user_profile` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `gender` VARCHAR(45) NULL,
  `dob` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`));
  
-- creation of profile status table for users
CREATE TABLE `socialapp`.`profile_status` (
  `user_id` INT NOT NULL,
  `active_status` VARCHAR(45) NOT NULL DEFAULT 'no',
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `socialapp`.`user_profile` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
-- creation of friends table for user
CREATE TABLE `socialapp`.`friends` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `friend_id` VARCHAR(45) NOT NULL,
  `friend_name` VARCHAR(45) NOT NULL,
  `user` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT 'CURRENT_TIMESTAMP' ;,
  PRIMARY KEY (`id`),
  INDEX `user_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `user`
    FOREIGN KEY (`user`)
    REFERENCES `socialapp`.`user_profile` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- creation of posts table for user
CREATE TABLE `socialapp`.`posts` (
  `post_id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(200) NOT NULL,
  `user_id_from` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`post_id`),
  INDEX `user_id_from_idx` (`user_id_from` ASC) VISIBLE,
  CONSTRAINT `user_id_from`
    FOREIGN KEY (`user_id_from`)
    REFERENCES `socialapp`.`user_profile` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
ALTER TABLE `socialapp`.`posts` 
CHANGE COLUMN `created_at` `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ;
    
    
-- creation of comments table for user
CREATE TABLE `socialapp`.`comments` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `user_id_from` INT NOT NULL,
  `content` VARCHAR(200) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  INDEX `on_post_idx` (`post_id` ASC) VISIBLE,
  INDEX `comment_from_user_idx` (`user_id_from` ASC) VISIBLE,
  CONSTRAINT `on_post`
    FOREIGN KEY (`post_id`)
    REFERENCES `socialapp`.`posts` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comment_from_user`
    FOREIGN KEY (`user_id_from`)
    REFERENCES `socialapp`.`user_profile` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- creation of likes table for user
CREATE TABLE `socialapp`.`likes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `like_on_post_idx` (`post_id` ASC) VISIBLE,
  INDEX `user_liked_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `like_on_post`
    FOREIGN KEY (`post_id`)
    REFERENCES `socialapp`.`posts` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_liked`
    FOREIGN KEY (`user_id`)
    REFERENCES `socialapp`.`user_profile` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- creation of login details column for user
CREATE TABLE `socialapp`.`login_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `login_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `login_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `login_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `socialapp`.`user_profile` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
-- inserting data into user_profile table
insert into user_profile(user_id,email,username,password,first_name,last_name,gender,dob) values('1','abc@gmail.com','abc','abc123','abc','xyz','male','12-98-2001');
insert into user_profile(email,username,password,first_name,last_name,gender,dob) values('def@gmail.com','def','def123','def','xyz','male','12-12-2003');
insert into user_profile(email,username,password,first_name,last_name,gender,dob) values('ghi@gmail.com','ghi','ghi123','ghi','xyz','male','12-12-2004');
insert into user_profile(email,username,password,first_name,last_name,gender,dob) values('jkl@gmail.com','jkl','jkl123','jkl','xyz','male','12-12-2005');
insert into user_profile(email,username,password,first_name,last_name,gender,dob) values('mno@gmail.com','mno','mno123','mno','xyz','male','12-12-2006'); 
 
-- inserting data into profile_status table 
insert into profile_status(user_id, active_status) values(1,'yes');
insert into profile_status(user_id) values(2);
insert into profile_status(user_id, active_status) values(3,'yes');
insert into profile_status(user_id, active_status) values(4,'yes');
insert into profile_status(user_id) values(5);   

-- inserting data into login details table
insert into login_details(user_id) values(1);
insert into login_details(user_id) values(2);
insert into login_details(user_id) values(3);
insert into login_details(user_id) values(4);
insert into login_details(user_id) values(5);
insert into login_details(user_id) values(1);
insert into login_details(user_id) values(3);
insert into login_details(user_id) values(4);

-- inserting data into friends table
insert into friends(friend_id, friend_name, user) values(1, 'abc', 2);
insert into friends(friend_id, friend_name, user) values(1, 'abc', 4);
insert into friends(friend_id, friend_name, user) values(2, 'def', 1);
insert into friends(friend_id, friend_name, user) values(4, 'jkl', 1);
insert into friends(friend_id, friend_name, user) values(10, 'asa', 1);
insert into friends(friend_id, friend_name, user) values(22, 'yybgf', 5);

-- inserting data into posts table
insert into posts(content, user_id_from) values('Fuel prices increasing causing trouble to common people',1);
insert into posts(content, user_id_from) values('5 ways to improve mental health',2);
insert into posts(content, user_id_from) values('Sustainable developement of the nature',4);
insert into posts(content, user_id_from) values('10 hacks to start waking up early',5);

-- inserting data into comments table
insert into comments(post_id, user_id_from, content) values(1,2,'Wow!!');
insert into comments(post_id, user_id_from, content) values(1,4,'Is this real!');
insert into comments(post_id, user_id_from, content) values(2,1,'This is amazing');
insert into comments(post_id, user_id_from, content) values(4,4,'Sad story!');
insert into comments(post_id, user_id_from, content) values(3,5,'Lets get on to our feet');
insert into comments(post_id, user_id_from, content) values(1,4,'Hard luck Boys!');
insert into comments(post_id, user_id_from, content) values(4,4,'Well, this is good news for some');


-- inserting data into likes table
insert into likes(post_id, user_id) values(1,2);
insert into likes(post_id, user_id) values(1,4);
insert into likes(post_id, user_id) values(2,1);
insert into likes(post_id, user_id) values(2,3);
insert into likes(post_id, user_id) values(3,1);
insert into likes(post_id, user_id) values(3,5);
insert into likes(post_id, user_id) values(4,5);