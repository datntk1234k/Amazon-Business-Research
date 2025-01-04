-- Xóa phần thập phân của cột Age, và loại bỏ phần Nah, dữ liệu gốc là 11.400 dòng sau khi sửa đổi còn 11.000
SELECT 
    CAST(FLOOR(CAST(Delivery_person_Age AS FLOAT)) AS INT) AS Delivery_person_Age_Integer
FROM 
    [dbo].[cleaned_test]
WHERE 
    Delivery_person_Age <> 'NaN' -- Loại bỏ các giá trị 'NaN'
    AND ISNUMERIC(Delivery_person_Age) = 1; -- Chỉ chọn các giá trị số 

-- Thêm vào column 
-- Bước 1: Thêm cột mới
ALTER TABLE [dbo].[cleaned_test]
ADD Delivery_person_Age_Integer INT;

-- Bước 2: Cập nhật giá trị vào cột mới
UPDATE [dbo].[cleaned_test]
SET Delivery_person_Age_Integer = CAST(FLOOR(CAST(Delivery_person_Age AS FLOAT)) AS INT)
WHERE Delivery_person_Age <> 'NaN' -- Loại bỏ các giá trị 'NaN'
  AND ISNUMERIC(Delivery_person_Age) = 1; -- Chỉ chọn các giá trị số


-- Xóa phần thập phân của cột Ratings, và loại bỏ phần Nah, dữ liệu gốc là 11.400 
-- Bước 1: Thêm cột mới cho giá trị nguyên của [Delivery_person_Ratings]
ALTER TABLE [dbo].[cleaned_test]
ADD Delivery_person_Ratings_Integer INT;

-- Bước 2: Cập nhật giá trị vào cột mới
UPDATE [dbo].[cleaned_test]
SET Delivery_person_Ratings_Integer = CAST(FLOOR(CAST(Delivery_person_Ratings AS FLOAT)) AS INT)
WHERE Delivery_person_Ratings <> 'NaN' -- Loại bỏ các giá trị 'NaN'
  AND ISNUMERIC(Delivery_person_Ratings) = 1; -- Chỉ chọn các giá trị số

-- Xóa dữ liệu có số 0 trong cột [Restaurant_latitude] 
ALTER TABLE [dbo].[cleaned_test]
ALTER COLUMN Restaurant_latitude FLOAT;

UPDATE [dbo].[cleaned_test]
SET Restaurant_latitude = NULL
WHERE Restaurant_latitude = 0;


-- Xóa dữ liệu có số 0 trong cột [Restaurant_longitude] 
ALTER TABLE [dbo].[cleaned_test]
ALTER COLUMN [Restaurant_longitude] FLOAT;
	UPDATE [dbo].[cleaned_test]
	SET [Restaurant_longitude] = NULL
	WHERE  [Restaurant_longitude]= 0;

-- Chỉnh lại thời gian cho order_date
-- Tạo cột tạm cho ngày chuẩn hóa
ALTER TABLE [dbo].[cleaned_test]
ADD Standardized_Order_Date DATE;

-- Chuyển đổi và lưu trữ các giá trị hợp lệ trong cột tạm
UPDATE [dbo].[cleaned_test]
SET Standardized_Order_Date = 
    CASE 
        WHEN ISDATE(Order_Date) = 1 THEN TRY_CAST(Order_Date AS DATE) 
        ELSE NULL
    END;

-- Kiểm tra lại các giá trị không hợp lệ
-- Tạo cột tạm cho ngày chuẩn hóa
ALTER TABLE [dbo].[cleaned_test]
ADD Standardized_Order_Date DATE;

-- Chuyển đổi và lưu trữ các giá trị hợp lệ trong cột tạm
UPDATE [dbo].[cleaned_test]
SET Standardized_Order_Date = 
    CASE 
        WHEN ISDATE(Order_Date) = 1 THEN TRY_CAST(Order_Date AS DATE) 
        ELSE NULL
    END;

-- Kiểm tra lại các giá trị không hợp lệ
SELECT Order_Date 
FROM [dbo].[cleaned_test]
WHERE Standardized_Order_Date IS NULL AND Order_Date IS NOT NULL;


-- Xóa nah cho cột Time Order 
DELETE FROM [dbo].[cleaned_test]
WHERE Time_Orderd = 'NaN';

-- Xóa các dòng có giá trị NaN trong cột multiple_deliveries
UPDATE [dbo].[cleaned_test]
SET multiple_deliveries = CAST(CAST(multiple_deliveries AS FLOAT) AS INT)
WHERE ISNUMERIC(multiple_deliveries) = 1 

DELETE FROM [dbo].[cleaned_test]
WHERE multiple_deliveries = 'NaN';

