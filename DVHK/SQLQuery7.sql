-- Tạo cơ sở dữ liệu và sử dụng
CREATE DATABASE ResidenceManagement;
USE ResidenceManagement;

-- Tạo bảng Roles
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName VARCHAR(20) NOT NULL UNIQUE CHECK (RoleName IN ('Citizen', 'Police', 'Admin'))
);

INSERT INTO Roles (RoleName) VALUES
('Citizen'),
('Police'),
('Admin');

-- Tạo bảng Users
CREATE TABLE Users ( 
    IDCard VARCHAR(20) PRIMARY KEY, 
    FirstName VARCHAR(50) NOT NULL, 
    LastName VARCHAR(50) NOT NULL, 
    Gender VARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female')),
    City VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE, 
    Password VARCHAR(255) NOT NULL, 
    RoleID INT NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL UNIQUE, 
    Address TEXT NOT NULL,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Tạo bảng Households
CREATE TABLE Households ( 
    HouseholdID INT PRIMARY KEY IDENTITY(1,1), 
    HeadOfHouseholdID VARCHAR(20), 
    Address TEXT NOT NULL, 
    CreatedDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (HeadOfHouseholdID) REFERENCES Users(IDCard)
);

-- Tạo bảng Registrations
CREATE TABLE Registrations ( 
    RegistrationID INT PRIMARY KEY IDENTITY(1,1), 
    IDCard VARCHAR(20), 
    RegistrationType VARCHAR(20) NOT NULL CHECK (RegistrationType IN ('Permanent', 'Temporary', 'TemporaryStay')), 
    StartDate DATE NOT NULL, 
    EndDate DATE NULL, 
    Status VARCHAR(20) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Approved', 'Rejected')), 
    Relationship VARCHAR(50) NOT NULL,
    HeadOfHouseholdID VARCHAR(20) NOT NULL,   
    ApprovedBy VARCHAR(20), 
    Address TEXT NOT NULL, 
    City VARCHAR(50) NOT NULL,
    Comments TEXT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IDCard) REFERENCES Users(IDCard),
    FOREIGN KEY (ApprovedBy) REFERENCES Users(IDCard)
);

-- Tạo bảng HouseholdMembers
CREATE TABLE HouseholdMembers ( 
    MemberID INT PRIMARY KEY IDENTITY(1,1), 
    HouseholdID INT, 
    IDCard VARCHAR(20), 
    Relationship VARCHAR(50) NOT NULL,
    FOREIGN KEY (HouseholdID) REFERENCES Households(HouseholdID),
    FOREIGN KEY (IDCard) REFERENCES Users(IDCard)
);

-- Tạo bảng Notifications
CREATE TABLE Notifications ( 
    NotificationID INT PRIMARY KEY IDENTITY(1,1), 
    IDCard VARCHAR(20), 
    Message TEXT NOT NULL, 
    SentDate DATETIME DEFAULT CURRENT_TIMESTAMP, 
    IsRead BIT DEFAULT 0,
    FOREIGN KEY (IDCard) REFERENCES Users(IDCard)
);

-- Chèn dữ liệu vào Users với mật khẩu 'admin123' (băm SHA-256)
INSERT INTO Users (IDCard, FirstName, LastName, Gender, City, Email, Password, RoleID, PhoneNumber, Address)
VALUES
-- 1 Admin
('123456789', 'Admin', 'User', 'Male', 'Ha Noi', 'chungocdung2@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 3, '0901234567', '123 Nguyen Trai, Thanh Xuan, Ha Noi'),
-- 5 Police
('123456790', 'Minh', 'Nguyen', 'Male', 'Ha Noi', 'minhnguyen@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 2, '0901234568', '123 Nguyen Trai, Thanh Xuan, Ha Noi'),
('123456791', 'Lan', 'Tran', 'Female', 'TP Ho Chi Minh', 'lantran@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 2, '0901234569', '456 Le Loi, Quan 1, TP Ho Chi Minh'),
('123456792', 'Hieu', 'Pham', 'Male', 'Da Nang', 'hieupham@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 2, '0901234570', '789 Tran Hung Dao, Hai Chau, Da Nang'),
('123456793', 'Hoa', 'Le', 'Female', 'Ha Noi', 'hoale@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 2, '0901234571', '123 Nguyen Trai, Thanh Xuan, Ha Noi'),
('123456794', 'Tuan', 'Vu', 'Male', 'TP Ho Chi Minh', 'tuanvu@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 2, '0901234572', '456 Le Loi, Quan 1, TP Ho Chi Minh'),
-- 44 Citizens
('123456795', 'Anh', 'Nguyen', 'Female', 'An Giang', 'anhnguyen@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345001', '456 Le Loi, Long Xuyen, An Giang'),
('123456796', 'Bao', 'Tran', 'Male', 'Ba Ria - Vung Tau', 'baotran@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345002', '101 Pham Van Dong, Vung Tau, Ba Ria - Vung Tau'),
('123456797', 'Chi', 'Pham', 'Female', 'Bac Giang', 'chipham@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345003', '202 Nguyen Hue, Bac Giang'),
('123456798', 'Dung', 'Le', 'Male', 'Bac Kan', 'dungle@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345004', '303 Le Duan, Bac Kan'),
('123456799', 'Hanh', 'Vu', 'Female', 'Bac Lieu', 'hanhvu@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345005', '404 Hoang Dieu, Bac Lieu'),
('123456800', 'Khanh', 'Nguyen', 'Male', 'Bac Ninh', 'khanhnguyen@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345006', '789 Tran Hung Dao, Bac Ninh'),
('123456801', 'Linh', 'Tran', 'Female', 'Ben Tre', 'linhtran@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345007', '505 Ba Trieu, Ben Tre'),
('123456802', 'Nam', 'Pham', 'Male', 'Binh Dinh', 'nampham@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345008', '606 Ly Thuong Kiet, Quy Nhon, Binh Dinh'),
('123456803', 'Oanh', 'Le', 'Female', 'Binh Duong', 'oanhle@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345009', '707 Tran Phu, Thu Dau Mot, Binh Duong'),
('123456804', 'Phong', 'Vu', 'Male', 'Binh Phuoc', 'phongvu@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345010', '123 Nguyen Trai, Dong Xoai, Binh Phuoc'),
('123456805', 'Quynh', 'Nguyen', 'Female', 'Binh Thuan', 'quynhnguyen@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345011', '101 Pham Van Dong, Phan Thiet, Binh Thuan'),
('123456806', 'Son', 'Tran', 'Male', 'Ca Mau', 'sontran@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345012', '456 Le Loi, Ca Mau'),
('123456807', 'Tam', 'Pham', 'Female', 'Can Tho', 'tampham@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345013', '789 Tran Hung Dao, Ninh Kieu, Can Tho'),
('123456808', 'Vinh', 'Le', 'Male', 'Cao Bang', 'vinhle@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345014', '202 Nguyen Hue, Cao Bang'),
('123456809', 'Yen', 'Vu', 'Female', 'Da Nang', 'yenvu@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345015', '789 Tran Hung Dao, Hai Chau, Da Nang'),
('123456810', 'Binh', 'Nguyen', 'Male', 'Dak Lak', 'binhnguyen@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345016', '202 Nguyen Hue, Buon Ma Thuot, Dak Lak'),
('123456811', 'Chau', 'Tran', 'Female', 'Dak Nong', 'chautran@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345017', '303 Le Duan, Gia Nghia, Dak Nong'),
('123456812', 'Duy', 'Pham', 'Male', 'Dien Bien', 'duypham@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345018', '404 Hoang Dieu, Dien Bien Phu, Dien Bien'),
('123456813', 'Giang', 'Le', 'Female', 'Dong Nai', 'giangle@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345019', '505 Ba Trieu, Bien Hoa, Dong Nai'),
('123456814', 'Hung', 'Vu', 'Male', 'Dong Thap', 'hungvu@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345020', '606 Ly Thuong Kiet, Cao Lanh, Dong Thap'),
('123456815', 'Khoa', 'Nguyen', 'Male', 'Gia Lai', 'khoanguyen@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345021', '303 Le Duan, Pleiku, Gia Lai'),
('123456816', 'Lam', 'Tran', 'Female', 'Ha Giang', 'lamtran@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345022', '707 Tran Phu, Ha Giang'),
('123456817', 'Mai', 'Pham', 'Female', 'Ha Nam', 'maipham@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345023', '123 Nguyen Trai, Phu Ly, Ha Nam'),
('123456818', 'Nhi', 'Le', 'Female', 'Ha Noi', 'nhile@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345024', '123 Nguyen Trai, Thanh Xuan, Ha Noi'),
('123456819', 'Phuc', 'Vu', 'Male', 'Ha Tinh', 'phucvu@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345025', '456 Le Loi, Ha Tinh'),
('123456820', 'Quang', 'Nguyen', 'Male', 'Hai Duong', 'quangnguyen@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345026', '404 Hoang Dieu, Hai Duong'),
('123456821', 'Thao', 'Tran', 'Female', 'Hai Phong', 'thaotran@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345027', '789 Tran Hung Dao, Hong Bang, Hai Phong'),
('123456822', 'Trung', 'Pham', 'Male', 'Hau Giang', 'trungpham@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345028', '202 Nguyen Hue, Vi Thanh, Hau Giang'),
('123456823', 'Van', 'Le', 'Female', 'Hoa Binh', 'vanle@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345029', '303 Le Duan, Hoa Binh'),
('123456824', 'Xuan', 'Vu', 'Female', 'Hung Yen', 'xuanvu@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345030', '404 Hoang Dieu, Hung Yen'),
('123456825', 'An', 'Nguyen', 'Male', 'Khanh Hoa', 'annguyen@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345031', '505 Ba Trieu, Nha Trang, Khanh Hoa'),
('123456826', 'Bac', 'Tran', 'Male', 'Kien Giang', 'bactran@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345032', '606 Ly Thuong Kiet, Rach Gia, Kien Giang'),
('123456827', 'Cuc', 'Pham', 'Female', 'Kon Tum', 'cucpham@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345033', '707 Tran Phu, Kon Tum'),
('123456828', 'Dan', 'Le', 'Male', 'Lai Chau', 'danle@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345034', '123 Nguyen Trai, Lai Chau'),
('123456829', 'Ha', 'Vu', 'Female', 'Lam Dong', 'havu@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345035', '456 Le Loi, Da Lat, Lam Dong'),
('123456830', 'Kien', 'Nguyen', 'Male', 'Lang Son', 'kiennguyen@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345036', '606 Ly Thuong Kiet, Lang Son'),
('123456831', 'Ly', 'Tran', 'Female', 'Lao Cai', 'lytran@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345037', '707 Tran Phu, Lao Cai'),
('123456832', 'Nhat', 'Pham', 'Male', 'Long An', 'nhatpham@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345038', '123 Nguyen Trai, Tan An, Long An'),
('123456833', 'Phu', 'Le', 'Male', 'Nam Dinh', 'phule@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345039', '456 Le Loi, Nam Dinh'),
('123456834', 'Sang', 'Vu', 'Male', 'Nghe An', 'sangvu@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345040', '789 Tran Hung Dao, Vinh, Nghe An'),
('123456835', 'Thanh', 'Nguyen', 'Female', 'Ninh Binh', 'thanhnguyen@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345041', '707 Tran Phu, Ninh Binh'),
('123456836', 'Tu', 'Tran', 'Male', 'Ninh Thuan', 'tutran@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345042', '202 Nguyen Hue, Phan Rang, Ninh Thuan'),
('123456837', 'Vy', 'Pham', 'Female', 'Phu Tho', 'vypham@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345043', '303 Le Duan, Viet Tri, Phu Tho'),
('123456838', 'Xuong', 'Le', 'Male', 'TP Ho Chi Minh', 'xuongle@gmail.com', '51ff20a57253f7f0ee3a9bffe86a86a2141c716b2f554b2bf6429df50e538c13', 1, '0912345044', '456 Le Loi, Quan 1, TP Ho Chi Minh');

-- Chèn dữ liệu vào Households
INSERT INTO Households (HeadOfHouseholdID, Address)
VALUES
('123456790', '123 Nguyen Trai, Thanh Xuan, Ha Noi'),
('123456795', '456 Le Loi, Long Xuyen, An Giang'),
('123456800', '789 Tran Hung Dao, Bac Ninh'),
('123456805', '101 Pham Van Dong, Phan Thiet, Binh Thuan'),
('123456810', '202 Nguyen Hue, Buon Ma Thuot, Dak Lak'),
('123456815', '303 Le Duan, Pleiku, Gia Lai'),
('123456820', '404 Hoang Dieu, Hai Duong'),
('123456825', '505 Ba Trieu, Nha Trang, Khanh Hoa'),
('123456830', '606 Ly Thuong Kiet, Lang Son'),
('123456835', '707 Tran Phu, Ninh Binh');

-- Chèn dữ liệu vào HouseholdMembers
INSERT INTO HouseholdMembers (HouseholdID, IDCard, Relationship)
VALUES
-- Hộ 1: Minh Nguyen (5 thành viên)
(1, '123456790', 'Head'),
(1, '123456791', 'Wife'),
(1, '123456792', 'Child'),
(1, '123456793', 'Child'),
(1, '123456794', 'Father'),
-- Hộ 2: Anh Nguyen (6 thành viên)
(2, '123456795', 'Head'),
(2, '123456796', 'Husband'),
(2, '123456797', 'Child'),
(2, '123456798', 'Child'),
(2, '123456799', 'Mother'),
(2, '123456789', 'Cousin'),
-- Hộ 3: Khanh Nguyen (5 thành viên)
(3, '123456800', 'Head'),
(3, '123456801', 'Wife'),
(3, '123456802', 'Child'),
(3, '123456803', 'Child'),
(3, '123456804', 'Father'),
-- Hộ 4: Quynh Nguyen (5 thành viên)
(4, '123456805', 'Head'),
(4, '123456806', 'Husband'),
(4, '123456807', 'Child'),
(4, '123456808', 'Child'),
(4, '123456809', 'Mother'),
-- Hộ 5: Binh Nguyen (5 thành viên)
(5, '123456810', 'Head'),
(5, '123456811', 'Wife'),
(5, '123456812', 'Child'),
(5, '123456813', 'Child'),
(5, '123456814', 'Father'),
-- Hộ 6: Khoa Nguyen (5 thành viên)
(6, '123456815', 'Head'),
(6, '123456816', 'Wife'),
(6, '123456817', 'Child'),
(6, '123456818', 'Child'),
(6, '123456819', 'Father'),
-- Hộ 7: Quang Nguyen (5 thành viên)
(7, '123456820', 'Head'),
(7, '123456821', 'Wife'),
(7, '123456822', 'Child'),
(7, '123456823', 'Child'),
(7, '123456824', 'Mother'),
-- Hộ 8: An Nguyen (5 thành viên)
(8, '123456825', 'Head'),
(8, '123456826', 'Wife'),
(8, '123456827', 'Child'),
(8, '123456828', 'Child'),
(8, '123456829', 'Mother'),
-- Hộ 9: Kien Nguyen (5 thành viên)
(9, '123456830', 'Head'),
(9, '123456831', 'Wife'),
(9, '123456832', 'Child'),
(9, '123456833', 'Child'),
(9, '123456834', 'Father'),
-- Hộ 10: Thanh Nguyen (4 thành viên)
(10, '123456835', 'Head'),
(10, '123456836', 'Husband'),
(10, '123456837', 'Child'),
(10, '123456838', 'Child');

-- Chèn dữ liệu vào Registrations
INSERT INTO Registrations (IDCard, RegistrationType, StartDate, EndDate, Status, Relationship, HeadOfHouseholdID, ApprovedBy, Address, City, Comments)
VALUES
('123456790', 'Permanent', '2025-04-01', NULL, 'Approved', 'Head', '123456790', '123456789', '123 Nguyen Trai, Thanh Xuan, Ha Noi', 'Ha Noi', 'Approved by Admin'),
('123456791', 'Temporary', '2025-04-15', '2025-10-15', 'Approved', 'Wife', '123456790', '123456789', '123 Nguyen Trai, Thanh Xuan, Ha Noi', 'Ha Noi', 'Temporary stay for 6 months'),
('123456795', 'Permanent', '2025-05-01', NULL, 'Approved', 'Head', '123456795', '123456790', '456 Le Loi, Long Xuyen, An Giang', 'An Giang', 'Approved by Police Minh'),
('123456796', 'TemporaryStay', '2025-05-15', '2025-08-15', 'Pending', 'Husband', '123456795', NULL, '456 Le Loi, Long Xuyen, An Giang', 'An Giang', 'Awaiting approval'),
('123456800', 'Permanent', '2025-06-01', NULL, 'Approved', 'Head', '123456800', '123456791', '789 Tran Hung Dao, Bac Ninh', 'Bac Ninh', 'Approved by Police Lan'),
('123456805', 'Temporary', '2025-06-15', '2025-12-15', 'Approved', 'Head', '123456805', '123456792', '101 Pham Van Dong, Phan Thiet, Binh Thuan', 'Binh Thuan', 'Temporary registration'),
('123456810', 'Permanent', '2025-07-01', NULL, 'Approved', 'Head', '123456810', '123456793', '202 Nguyen Hue, Buon Ma Thuot, Dak Lak', 'Dak Lak', 'Approved by Police Hoa'),
('123456815', 'Temporary', '2025-07-15', '2026-01-15', 'Pending', 'Head', '123456815', NULL, '303 Le Duan, Pleiku, Gia Lai', 'Gia Lai', 'Pending approval'),
('123456820', 'Permanent', '2025-08-01', NULL, 'Approved', 'Head', '123456820', '123456794', '404 Hoang Dieu, Hai Duong', 'Hai Duong', 'Approved by Police Tuan'),
('123456835', 'Temporary', '2025-08-15', '2026-02-15', 'Approved', 'Head', '123456835', '123456789', '707 Tran Phu, Ninh Binh', 'Ninh Binh', 'Temporary stay approved by Admin'),
('123456792', 'Temporary', '2025-09-01', '2026-03-01', 'Pending', 'Child', '123456790', NULL, '123 Nguyen Trai, Thanh Xuan, Ha Noi', 'Ha Noi', 'Pending temporary registration for Hieu'),
('123456797', 'TemporaryStay', '2025-09-15', '2025-12-15', 'Pending', 'Child', '123456795', NULL, '456 Le Loi, Long Xuyen, An Giang', 'An Giang', 'Pending temporary stay for Chi'),
('123456801', 'Permanent', '2025-10-01', NULL, 'Pending', 'Wife', '123456800', NULL, '789 Tran Hung Dao, Bac Ninh', 'Bac Ninh', 'Pending permanent registration for Linh'),
('123456806', 'Temporary', '2025-10-15', '2026-04-15', 'Pending', 'Husband', '123456805', NULL, '101 Pham Van Dong, Phan Thiet, Binh Thuan', 'Binh Thuan', 'Pending temporary registration for Son'),
('123456811', 'TemporaryStay', '2025-11-01', '2026-02-01', 'Pending', 'Wife', '123456810', NULL, '202 Nguyen Hue, Buon Ma Thuot, Dak Lak', 'Dak Lak', 'Pending temporary stay for Chau');

-- Chèn dữ liệu vào Notifications
INSERT INTO Notifications (IDCard, Message, SentDate, IsRead)
VALUES
('123456790', 'Your permanent registration at 123 Nguyen Trai, Thanh Xuan, Ha Noi has been approved.', '2025-04-02 10:00:00', 1),
('123456791', 'Your temporary registration from 2025-04-15 to 2025-10-15 has been approved.', '2025-04-16 14:30:00', 0),
('123456795', 'Your permanent registration at 456 Le Loi, Long Xuyen, An Giang has been approved.', '2025-05-02 09:15:00', 1),
('123456796', 'Your temporary stay registration from 2025-05-15 to 2025-08-15 is pending approval.', '2025-05-16 11:00:00', 0),
('123456792', 'Your temporary registration from 2025-09-01 to 2026-03-01 is pending approval.', '2025-09-02 13:45:00', 0),
('123456789', 'System update scheduled for 2025-10-01. Please prepare accordingly.', '2025-09-25 08:00:00', 1),
('123456815', 'Your temporary registration from 2025-07-15 to 2026-01-15 is pending approval.', '2025-07-16 15:30:00', 0),
('123456835', 'Your temporary registration from 2025-08-15 to 2026-02-15 has been approved.', '2025-08-16 10:30:00', 1),
('123456797', 'Your temporary stay registration from 2025-09-15 to 2025-12-15 is pending approval.', '2025-09-16 12:00:00', 0),
('123456820', 'Please prepare for a household inspection on 2025-11-01.', '2025-10-25 09:00:00', 1);
