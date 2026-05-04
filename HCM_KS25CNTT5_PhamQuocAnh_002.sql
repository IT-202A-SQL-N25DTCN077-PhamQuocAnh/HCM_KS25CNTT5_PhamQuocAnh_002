create database CenterManagement;

use CenterManagement;

create table if not exists course(
	course_id int primary key,
    course_name varchar(255) not null,
    teacher varchar(255) not null,
    tuititon_fee decimal (18,2) not null check(tuititon_fee > 0),
    duration time not null
);

create table if not exists students(
	student_id int primary key auto_increment,
    fullname varchar(255) not null,
    email varchar(255) unique,
    phone varchar(15) not null,
    birthday date not null
);

create table if not exists enrollments(
	enrollment_id int primary key auto_increment,
    student_id int not null,
    created_at timestamp default current_timestamp,
    payment varchar(15) not null,
    foreign key (student_id) references students(student_id)
);

create table if not exists enrollment_detail(
    enrollment_id int not null,
    course_id int not null,
    status varchar(15) not null,
    final_score decimal(3,2) not null check(final_score >= 0 and final_score <= 10),
    primary key(enrollment_id, course_id),
    foreign key (enrollment_id) references enrollments(enrollment_id) on delete cascade,
    foreign key (course_id) references course(course_id) on delete cascade
);

-- Alter: Thêm cột Ghi_chu (kiểu văn bản) vào bảng Enrollment.
-- Alter: Đổi tên cột Giảng viên thành Giao_Vien.
-- Drop: Viết câu lệnh xóa bảng Enrollment_Detail và bảng Enrollment.

alter table enrollments
add column Ghi_chu text;

alter table course
change column teacher Giao_Vien varchar(255);

-- drop table enrollments, enrollment_detail, students, course;

-- Insert: Thêm ít nhất 5 bản ghi cho mỗi bảng (Dữ liệu cần có sự liên kết giữa các bảng qua khóa ngoại).
-- Update: Giảm Học phí đi 10% cho tất cả các khóa học do giảng viên 'Trần Anh' phụ trách.
-- Delete: Xóa thông tin những học viên chưa cung cấp địa chỉ Email (Email là NULL).

insert into course(course_id, course_name, Giao_Vien, tuititon_fee, duration ) values
(1, 'Lập trình Python cơ bản', 'Nguyễn Văn A',3500000, '40:00:00'),
(2, 'Thiết kế đồ họa Photoshop','Trần Thị B',2800000, '30:00:00'),
(3, 'Tiếng Anh giao tiếp','Lê Hoàng D',4500000,'60:00:00'),
(6, 'Digital Marketing chuyên sâu','Trần Anh', 6000000, '48:00:00'),
(7, 'Kỹ năng quản lý thời gian','Trần Anh', 1500000,'08:00:00');

insert into students (student_id, fullname, email, phone, birthday) values
(1,'Nguyễn Văn An','an@gmail.com', '0901234567','2000-01-15'),
(2,'Trần Thị Bích','bich@gmail.com','0912345678','2001-05-20'),
(3,'Lê Hoàng Dũng','dung@gmail.com','0923456789','1999-11-08'),
(4,'Phạm Minh Khoa','khoa@gmail.com','0934567890','2000-07-22'),
(5,'Huỳnh Thanh Mai','mai@gmail.com','0945678901','2002-03-10'),
(6,'Võ Hoàng Nam', null, '0956789012', '2001-12-01');

insert into enrollments (student_id, payment) VALUES
(1,'Credit Card'),
(2,'Bank Transfer'),
(3,'Cash'),
(4,'Credit Card'),
(5,'Cash'),
(6,'Bank Transfer');

insert into enrollment_detail(enrollment_id, course_id, status, final_score) values
(1, 1, 'Dang hoc', 8.50),
(2, 2, 'Dang hoc', 9.00),
(3, 3, 'Bao luu', 7.50),
(4, 6, 'Dang hoc', 8.75),
(5, 7, 'Bao luu', 4.00),
(6, 1, 'Dang hoc', 6.50);

update course 
set tuititon_fee = tuititon_fee * 0.9 
where giao_vien = 'Trần Anh' and course_id > 0;

delete from students where email is null;

select * from course
where tuititon_fee between 1000000 and 3000000;





