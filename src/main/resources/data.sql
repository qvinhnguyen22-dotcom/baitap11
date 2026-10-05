-- ====================================================================
-- SCRIPT KHỞI TẠO DỮ LIỆU MẪU CHO BOOKSTORE (ĐỀ SỐ 02)
-- Sinh viên: Nguyễn Quang Vinh - MSSV: 24133074
-- ====================================================================

-- 1. THÊM TÁC GIẢ MẪU (AUTHOR)
IF NOT EXISTS (SELECT 1 FROM author WHERE author_name = N'Nguyễn Nhật Ánh')
    INSERT INTO author (author_name, date_of_birth) VALUES (N'Nguyễn Nhật Ánh', '1955-05-07');
IF NOT EXISTS (SELECT 1 FROM author WHERE author_name = N'J.K. Rowling')
    INSERT INTO author (author_name, date_of_birth) VALUES (N'J.K. Rowling', '1965-07-31');
IF NOT EXISTS (SELECT 1 FROM author WHERE author_name = N'Nam Cao')
    INSERT INTO author (author_name, date_of_birth) VALUES (N'Nam Cao', '1915-10-29');
IF NOT EXISTS (SELECT 1 FROM author WHERE author_name = N'Dale Carnegie')
    INSERT INTO author (author_name, date_of_birth) VALUES (N'Dale Carnegie', '1888-11-24');
IF NOT EXISTS (SELECT 1 FROM author WHERE author_name = N'Haruki Murakami')
    INSERT INTO author (author_name, date_of_birth) VALUES (N'Haruki Murakami', '1949-01-12');
IF NOT EXISTS (SELECT 1 FROM author WHERE author_name = N'Paulo Coelho')
    INSERT INTO author (author_name, date_of_birth) VALUES (N'Paulo Coelho', '1947-08-24');
IF NOT EXISTS (SELECT 1 FROM author WHERE author_name = N'George Orwell')
    INSERT INTO author (author_name, date_of_birth) VALUES (N'George Orwell', '1903-06-25');
IF NOT EXISTS (SELECT 1 FROM author WHERE author_name = N'Arthur Conan Doyle')
    INSERT INTO author (author_name, date_of_birth) VALUES (N'Arthur Conan Doyle', '1859-05-22');


-- 2. THÊM SÁCH MẪU (BOOKS - 15 CUỐN ĐA DẠNG)
IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1001)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1001, N'Mắt Biếc', N'NXB Trẻ', 110000.00, N'Truyện dài tình cảm nổi tiếng và xúc động sâu lắng của nhà văn Nguyễn Nhật Ánh.', '2019-01-01', 'mat_biec.jpg', 50);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1002)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1002, N'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', N'NXB Trẻ', 125000.00, N'Bức tranh tuổi thơ hồn nhiên, trong trẻo ở một làng quê nghèo miền Trung.', '2018-05-20', 'hoa_vang.jpg', 30);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1003)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1003, N'Harry Potter và Hòn Đá Phù Thủy', N'NXB Trẻ', 200000.00, N'Tập 1 mở màn thế giới phù thủy kỳ diệu tại trường Hogwarts của J.K. Rowling.', '2020-10-10', 'harry_potter.jpg', 100);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1004)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1004, N'Cho Tôi Xin Một Vé Đi Tuổi Thơ', N'NXB Trẻ', 95000.00, N'Tác phẩm giúp người lớn tìm lại những ước mơ và cảm xúc trong trẻo thời thơ ấu.', '2021-03-15', 'cho_toi_xin_mot_ve.jpg', 45);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1005)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1005, N'Harry Potter và Phòng Chứa Bí Mật', N'NXB Trẻ', 210000.00, N'Cuộc phiêu lưu năm hai đầy hiểm nguy với lời nguyền căn phòng bí mật tại Hogwarts.', '2021-08-20', 'harry_potter_2.jpg', 60);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1006)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1006, N'Chí Phèo', N'NXB Văn Học', 65000.00, N'Kiệt tác văn học hiện thực phê phán phản ánh bi kịch tha hóa của người nông dân.', '2019-11-10', 'chi_pheo.jpg', 35);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1007)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1007, N'Lão Hạc', N'NXB Kim Đồng', 55000.00, N'Câu chuyện đẫm nước mắt về lòng tự trọng và tình phụ tử thiêng liêng.', '2020-05-18', 'lao_hac.jpg', 40);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1008)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1008, N'Đắc Nhân Tâm', N'NXB Tổng Hợp TP.HCM', 105000.00, N'Nghệ thuật thu phục lòng người và xây dựng mối quan hệ thành công nhất thời đại.', '2022-01-05', 'dac_nhan_tam.jpg', 80);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1009)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1009, N'Quẳng Gánh Lo Đi Và Vui Sống', N'NXB Tổng Hợp TP.HCM', 98000.00, N'Lời khuyên thực tiễn giúp giải tỏa lo âu, sống an nhiên và hạnh phúc mỗi ngày.', '2021-06-12', 'quang_ganh_lo.jpg', 50);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1010)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1010, N'Rừng Na Uy', N'NXB Hội Nhà Văn', 145000.00, N'Tiểu thuyết sâu lắng về tình yêu, sự mất mát và nỗi cô đơn của tuổi trẻ.', '2018-09-22', 'rung_na_uy.jpg', 25);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1011)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1011, N'Kafka Bên Bờ Biển', N'NXB Hội Nhà Văn', 160000.00, N'Chuyến hành trình siêu thực pha trộn huyền thoại và suy ngẫm triết học nhân sinh.', '2020-12-01', 'kafka_ben_bo_bien.jpg', 30);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1012)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1012, N'Nhà Giả Kim', N'NXB Hà Nội', 89000.00, N'Cuốn sách truyền cảm hứng đi tìm kho báu đích thực và theo đuổi ước mơ.', '2022-04-10', 'nha_gia_kim.jpg', 90);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1013)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1013, N'Một Chín Tám Tư (1984)', N'NXB Văn Học', 135000.00, N'Tiểu thuyết phản địa đàng kinh điển cảnh báo về quyền lực chuyên chế toàn trị.', '2019-07-15', '1984.jpg', 40);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1014)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1014, N'Chuyện Ở Nông Trại', N'NXB Hội Nhà Văn', 85000.00, N'Truyện ngụ ngôn châm biếm sâu cay và bất hủ của nhà văn George Orwell.', '2020-03-25', 'chuyen_o_nong_trai.jpg', 35);

IF NOT EXISTS (SELECT 1 FROM books WHERE isbn = 1015)
    INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) 
    VALUES (1015, N'Sherlock Holmes Toàn Tập', N'NXB Văn Học', 260000.00, N'Tuyển tập các vụ phá án kinh điển của thám tử lừng danh thế giới Sherlock Holmes.', '2021-09-09', 'sherlock_holmes.jpg', 55);


-- 3. GẮN SÁCH VỚI TÁC GIẢ (BẢNG BOOK_AUTHOR)
INSERT INTO book_author (bookid, author_id)
SELECT b.bookid, a.author_id 
FROM books b 
INNER JOIN author a ON (
    (b.isbn = 1001 AND a.author_name = N'Nguyễn Nhật Ánh') OR
    (b.isbn = 1002 AND a.author_name = N'Nguyễn Nhật Ánh') OR
    (b.isbn = 1003 AND a.author_name = N'J.K. Rowling') OR
    (b.isbn = 1004 AND a.author_name = N'Nguyễn Nhật Ánh') OR
    (b.isbn = 1005 AND a.author_name = N'J.K. Rowling') OR
    (b.isbn = 1006 AND a.author_name = N'Nam Cao') OR
    (b.isbn = 1007 AND a.author_name = N'Nam Cao') OR
    (b.isbn = 1008 AND a.author_name = N'Dale Carnegie') OR
    (b.isbn = 1009 AND a.author_name = N'Dale Carnegie') OR
    (b.isbn = 1010 AND a.author_name = N'Haruki Murakami') OR
    (b.isbn = 1011 AND a.author_name = N'Haruki Murakami') OR
    (b.isbn = 1012 AND a.author_name = N'Paulo Coelho') OR
    (b.isbn = 1013 AND a.author_name = N'George Orwell') OR
    (b.isbn = 1014 AND a.author_name = N'George Orwell') OR
    (b.isbn = 1015 AND a.author_name = N'Arthur Conan Doyle')
)
WHERE NOT EXISTS (
    SELECT 1 FROM book_author ba WHERE ba.bookid = b.bookid AND ba.author_id = a.author_id
);


-- 4. THÊM TÀI KHOẢN MẪU (USERS - MẬT KHẨU: 123456)
IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'admin@gmail.com')
    INSERT INTO users (email, fullname, phone, passwd, signup_date, is_admin, is_verified) 
    VALUES ('admin@gmail.com', N'Quản Trị Viên', 909123456, '123456', GETDATE(), 1, 1);

IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'user1@gmail.com')
    INSERT INTO users (email, fullname, phone, passwd, signup_date, is_admin, is_verified) 
    VALUES ('user1@gmail.com', N'Nguyễn Văn A', 909876543, '123456', GETDATE(), 0, 1);

IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'user2@gmail.com')
    INSERT INTO users (email, fullname, phone, passwd, signup_date, is_admin, is_verified) 
    VALUES ('user2@gmail.com', N'Trần Thị B', 909112233, '123456', GETDATE(), 0, 1);

IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'user3@gmail.com')
    INSERT INTO users (email, fullname, phone, passwd, signup_date, is_admin, is_verified) 
    VALUES ('user3@gmail.com', N'Lê Hoàng C', 909334455, '123456', GETDATE(), 0, 1);


-- 5. THÊM ĐÁNH GIÁ MẪU (RATING / REVIEWS)
-- Mắt Biếc
INSERT INTO rating (userid, bookid, rating, review_text)
SELECT u.id, b.bookid, 5, N'Sách rất hay và cảm động!'
FROM users u, books b WHERE u.email = 'user1@gmail.com' AND b.isbn = 1001
AND NOT EXISTS (SELECT 1 FROM rating r WHERE r.userid = u.id AND r.bookid = b.bookid);

INSERT INTO rating (userid, bookid, rating, review_text)
SELECT u.id, b.bookid, 4, N'Tình tiết câu chuyện sâu lắng, rất đáng đọc.'
FROM users u, books b WHERE u.email = 'user2@gmail.com' AND b.isbn = 1001
AND NOT EXISTS (SELECT 1 FROM rating r WHERE r.userid = u.id AND r.bookid = b.bookid);

-- Harry Potter 1
INSERT INTO rating (userid, bookid, rating, review_text)
SELECT u.id, b.bookid, 5, N'Truyện viễn tưởng tuyệt vời, mở ra thế giới phép thuật kỳ diệu.'
FROM users u, books b WHERE u.email = 'user1@gmail.com' AND b.isbn = 1003
AND NOT EXISTS (SELECT 1 FROM rating r WHERE r.userid = u.id AND r.bookid = b.bookid);

-- Cho Tôi Xin Một Vé Đi Tuổi Thơ
INSERT INTO rating (userid, bookid, rating, review_text)
SELECT u.id, b.bookid, 5, N'Đọc cuốn này thấy nhớ tuổi thơ da diết, giọng văn hóm hỉnh!'
FROM users u, books b WHERE u.email = 'user2@gmail.com' AND b.isbn = 1004
AND NOT EXISTS (SELECT 1 FROM rating r WHERE r.userid = u.id AND r.bookid = b.bookid);

-- Đắc Nhân Tâm
INSERT INTO rating (userid, bookid, rating, review_text)
SELECT u.id, b.bookid, 5, N'Cuốn sách gối đầu giường về giao tiếp và thấu hiểu con người.'
FROM users u, books b WHERE u.email = 'user3@gmail.com' AND b.isbn = 1008
AND NOT EXISTS (SELECT 1 FROM rating r WHERE r.userid = u.id AND r.bookid = b.bookid);

-- Nhà Giả Kim
INSERT INTO rating (userid, bookid, rating, review_text)
SELECT u.id, b.bookid, 5, N'Khi bạn khao khát một điều gì đó, cả vũ trụ sẽ hợp lực giúp bạn đạt được.'
FROM users u, books b WHERE u.email = 'user1@gmail.com' AND b.isbn = 1012
AND NOT EXISTS (SELECT 1 FROM rating r WHERE r.userid = u.id AND r.bookid = b.bookid);

-- 1984
INSERT INTO rating (userid, bookid, rating, review_text)
SELECT u.id, b.bookid, 5, N'Một kiệt tác ám ảnh và đầy sức nặng tư tưởng.'
FROM users u, books b WHERE u.email = 'user3@gmail.com' AND b.isbn = 1013
AND NOT EXISTS (SELECT 1 FROM rating r WHERE r.userid = u.id AND r.bookid = b.bookid);


-- 6. THÊM ĐƠN HÀNG MẪU ĐẦY ĐỦ 8 TRẠNG THÁI (ORDERS & ORDER_DETAILS)
IF OBJECT_ID('orders', 'U') IS NOT NULL
BEGIN
    -- 6.1 Đơn hàng mới
    IF NOT EXISTS (SELECT 1 FROM orders WHERE receiver_phone = '0909876543' AND status = N'Đơn hàng mới')
    BEGIN
        INSERT INTO orders (user_id, order_date, receiver_name, receiver_phone, receiver_address, notes, payment_method, status, total_amount)
        SELECT u.id, DATEADD(hour, -1, GETDATE()), N'Nguyễn Văn A', '0909876543', N'Số 1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Giao giờ hành chính', 'COD', N'Đơn hàng mới', 220000.00
        FROM users u WHERE u.email = 'user1@gmail.com';

        INSERT INTO order_details (order_id, book_id, quantity, price)
        SELECT o.id, b.bookid, 2, b.price
        FROM orders o, books b, users u
        WHERE o.user_id = u.id AND u.email = 'user1@gmail.com' AND o.status = N'Đơn hàng mới' AND b.isbn = 1001
        AND NOT EXISTS (SELECT 1 FROM order_details od WHERE od.order_id = o.id AND od.book_id = b.bookid);
    END

    -- 6.2 Đã xác nhận
    IF NOT EXISTS (SELECT 1 FROM orders WHERE receiver_phone = '0909876543' AND status = N'Đã xác nhận')
    BEGIN
        INSERT INTO orders (user_id, order_date, receiver_name, receiver_phone, receiver_address, notes, payment_method, status, total_amount)
        SELECT u.id, DATEADD(hour, -4, GETDATE()), N'Nguyễn Văn A', '0909876543', N'Số 1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Gọi trước khi giao', 'COD', N'Đã xác nhận', 200000.00
        FROM users u WHERE u.email = 'user1@gmail.com';

        INSERT INTO order_details (order_id, book_id, quantity, price)
        SELECT o.id, b.bookid, 1, b.price
        FROM orders o, books b, users u
        WHERE o.user_id = u.id AND u.email = 'user1@gmail.com' AND o.status = N'Đã xác nhận' AND b.isbn = 1003
        AND NOT EXISTS (SELECT 1 FROM order_details od WHERE od.order_id = o.id AND od.book_id = b.bookid);
    END

    -- 6.3 Chuẩn bị hàng
    IF NOT EXISTS (SELECT 1 FROM orders WHERE receiver_phone = '0909876543' AND status = N'Chuẩn bị hàng')
    BEGIN
        INSERT INTO orders (user_id, order_date, receiver_name, receiver_phone, receiver_address, notes, payment_method, status, total_amount)
        SELECT u.id, DATEADD(hour, -12, GETDATE()), N'Nguyễn Văn A', '0909876543', N'Số 1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Đóng gói cẩn thận giúp mình', 'COD', N'Chuẩn bị hàng', 105000.00
        FROM users u WHERE u.email = 'user1@gmail.com';

        INSERT INTO order_details (order_id, book_id, quantity, price)
        SELECT o.id, b.bookid, 1, b.price
        FROM orders o, books b, users u
        WHERE o.user_id = u.id AND u.email = 'user1@gmail.com' AND o.status = N'Chuẩn bị hàng' AND b.isbn = 1008
        AND NOT EXISTS (SELECT 1 FROM order_details od WHERE od.order_id = o.id AND od.book_id = b.bookid);
    END

    -- 6.4 Vận chuyển
    IF NOT EXISTS (SELECT 1 FROM orders WHERE receiver_phone = '0909876543' AND status = N'Vận chuyển')
    BEGIN
        INSERT INTO orders (user_id, order_date, receiver_name, receiver_phone, receiver_address, notes, payment_method, status, total_amount)
        SELECT u.id, DATEADD(day, -1, GETDATE()), N'Nguyễn Văn A', '0909876543', N'Số 1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Chuyển phát nhanh', 'COD', N'Vận chuyển', 125000.00
        FROM users u WHERE u.email = 'user1@gmail.com';

        INSERT INTO order_details (order_id, book_id, quantity, price)
        SELECT o.id, b.bookid, 1, b.price
        FROM orders o, books b, users u
        WHERE o.user_id = u.id AND u.email = 'user1@gmail.com' AND o.status = N'Vận chuyển' AND b.isbn = 1002
        AND NOT EXISTS (SELECT 1 FROM order_details od WHERE od.order_id = o.id AND od.book_id = b.bookid);
    END

    -- 6.5 Giao hàng
    IF NOT EXISTS (SELECT 1 FROM orders WHERE receiver_phone = '0909876543' AND status = N'Giao hàng')
    BEGIN
        INSERT INTO orders (user_id, order_date, receiver_name, receiver_phone, receiver_address, notes, payment_method, status, total_amount)
        SELECT u.id, DATEADD(day, -2, GETDATE()), N'Nguyễn Văn A', '0909876543', N'Số 1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Shipper đang đi giao', 'COD', N'Giao hàng', 95000.00
        FROM users u WHERE u.email = 'user1@gmail.com';

        INSERT INTO order_details (order_id, book_id, quantity, price)
        SELECT o.id, b.bookid, 1, b.price
        FROM orders o, books b, users u
        WHERE o.user_id = u.id AND u.email = 'user1@gmail.com' AND o.status = N'Giao hàng' AND b.isbn = 1004
        AND NOT EXISTS (SELECT 1 FROM order_details od WHERE od.order_id = o.id AND od.book_id = b.bookid);
    END

    -- 6.6 Đã giao
    IF NOT EXISTS (SELECT 1 FROM orders WHERE receiver_phone = '0909876543' AND status = N'Đã giao')
    BEGIN
        INSERT INTO orders (user_id, order_date, receiver_name, receiver_phone, receiver_address, notes, payment_method, status, total_amount)
        SELECT u.id, DATEADD(day, -3, GETDATE()), N'Nguyễn Văn A', '0909876543', N'Số 1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Đã nhận đủ sách', 'COD', N'Đã giao', 89000.00
        FROM users u WHERE u.email = 'user1@gmail.com';

        INSERT INTO order_details (order_id, book_id, quantity, price)
        SELECT o.id, b.bookid, 1, b.price
        FROM orders o, books b, users u
        WHERE o.user_id = u.id AND u.email = 'user1@gmail.com' AND o.status = N'Đã giao' AND b.isbn = 1012
        AND NOT EXISTS (SELECT 1 FROM order_details od WHERE od.order_id = o.id AND od.book_id = b.bookid);
    END

    -- 6.7 Đơn hàng hủy
    IF NOT EXISTS (SELECT 1 FROM orders WHERE receiver_phone = '0909876543' AND status = N'Đơn hàng hủy')
    BEGIN
        INSERT INTO orders (user_id, order_date, receiver_name, receiver_phone, receiver_address, notes, payment_method, status, total_amount)
        SELECT u.id, DATEADD(day, -4, GETDATE()), N'Nguyễn Văn A', '0909876543', N'Số 1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Khách hàng thay đổi ý định', 'COD', N'Đơn hàng hủy', 145000.00
        FROM users u WHERE u.email = 'user1@gmail.com';

        INSERT INTO order_details (order_id, book_id, quantity, price)
        SELECT o.id, b.bookid, 1, b.price
        FROM orders o, books b, users u
        WHERE o.user_id = u.id AND u.email = 'user1@gmail.com' AND o.status = N'Đơn hàng hủy' AND b.isbn = 1010
        AND NOT EXISTS (SELECT 1 FROM order_details od WHERE od.order_id = o.id AND od.book_id = b.bookid);
    END

    -- 6.8 Đơn hàng hoàn
    IF NOT EXISTS (SELECT 1 FROM orders WHERE receiver_phone = '0909876543' AND status = N'Đơn hàng hoàn')
    BEGIN
        INSERT INTO orders (user_id, order_date, receiver_name, receiver_phone, receiver_address, notes, payment_method, status, total_amount)
        SELECT u.id, DATEADD(day, -5, GETDATE()), N'Nguyễn Văn A', '0909876543', N'Số 1 Võ Văn Ngân, TP. Thủ Đức, TP.HCM', N'Không liên lạc được người nhận', 'COD', N'Đơn hàng hoàn', 135000.00
        FROM users u WHERE u.email = 'user1@gmail.com';

        INSERT INTO order_details (order_id, book_id, quantity, price)
        SELECT o.id, b.bookid, 1, b.price
        FROM orders o, books b, users u
        WHERE o.user_id = u.id AND u.email = 'user1@gmail.com' AND o.status = N'Đơn hàng hoàn' AND b.isbn = 1013
        AND NOT EXISTS (SELECT 1 FROM order_details od WHERE od.order_id = o.id AND od.book_id = b.bookid);
    END
END;
