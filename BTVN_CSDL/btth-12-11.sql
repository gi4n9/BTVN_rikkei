USE session05_qlct;

ALTER TABLE building
ADD CONSTRAINT FK_hostBuilding
FOREIGN KEY (host_id) REFERENCES Host(id);

ALTER TABLE building
ADD CONSTRAINT FK_contractorBuilding
FOREIGN KEY (contractor_id) REFERENCES Contractor(id);

-- Hiển thị thông tin công trình có chi phí cao nhất
SELECT * FROM building 
WHERE cost = (
	SELECT MAX(cost) FROM building
);

-- Hiển thị thông tin công trình có chi phí lớn hơn tất cả các công trình được xây dựng ở Cần Thơ
SELECT * FROM building
WHERE cost > ALL(
	SELECT cost FROM building
	WHERE city = 'can tho'
);

-- Hiển thị thông tin công trình có chi phí lớn hơn một trong các công trình được xây dựng ở Cần Thơ
SELECT * FROM building
WHERE cost > ANY(
	SELECT cost FROM building
	WHERE city = 'can tho'
);

-- Hiển thị thông tin công trình chưa có kiến trúc sư thiết kế
SELECT * FROM building
WHERE id NOT IN (
	SELECT DISTINCT building_id FROM design
);

-- Hiển thị thông tin các kiến trúc sư cùng năm sinh và cùng nơi tốt nghiệp
SELECT a1.name AS `Họ và tên`, a1.birthday AS `Năm sinh`, a1.place AS `Nơi tốt nghiệp`
FROM architect AS a1
JOIN architect AS a2
    ON a1.birthday = a2.birthday 
    AND a1.place = a2.place
    AND a1.id != a2.id
ORDER BY a1.birthday, a1.place;

-- Hiển thị thù lao trung bình của từng kiến trúc sư
SELECT architect_id , AVG(benefit) AS `Thu lao trung binh` 
FROM design
GROUP BY architect_id;

-- Hiển thị chi phí đầu tư cho các công trình ở mỗi thành phố
SELECT COUNT(id) AS `Số lượng công trình`, cost AS `Giá`
FROM building
GROUP BY city;

-- Tìm các công trình có chi phí trả cho kiến trúc sư lớn hơn 50
SELECT b.name AS `Tên công trình`, SUM(d.benefit) AS `Chi phí trả cho kiến trúc sư`
FROM building AS b
JOIN design AS d ON d.building_id = b.id
JOIN architect AS a ON a.id = d.architect_id
GROUP BY b.id, b.name
HAVING SUM(d.benefit) > 50;

-- Tìm các thành phố có ít nhất một kiến trúc sư tốt nghiệp
SELECT DISTINCT b.id, b.name, d.benefit 
FROM `building` AS b 
LEFT JOIN `design` AS d
ON b.id = d.building_id;

-- Hiển thị tên công trình, tên chủ nhân và tên chủ thầu của công trình đó
SELECT DISTINCT b.id, b.name AS `Công trình`, h.name AS `Chủ nhân`, c.name AS `Nhà thầu`
FROM building AS b 
INNER JOIN `host` AS h
ON b.host_id = h.id
INNER JOIN `contractor` AS c
ON b.contractor_id = c.id;

-- Hiển thị tên công trình (building), tên kiến trúc sư (architect) và thù lao của kiến trúc sư ở mỗi công trình (design)
SELECT b.name AS `Tên công trình`, a.name AS `Tên kiến trúc sư`, d.benefit
FROM design AS d
INNER JOIN building AS b
ON d.building_id = b.id
INNER JOIN architect AS a
ON d.architect_id = a.id;

-- Hãy cho biết tên và địa chỉ công trình (building) do chủ thầu Công ty xây dựng số 6 thi công (contractor)
SELECT b.name AS `Tên công trình`, b.address AS `Địa chỉ công trình`
FROM building AS b
WHERE contractor_id = 1;

-- Tìm tên và địa chỉ liên lạc của các chủ thầu (contractor) thi công công trình ở Cần Thơ (building) do kiến trúc sư Lê Kim Dung thiết kế (architect, design)
SELECT c.name AS `Tên chủ thầu`, c.address AS `Địa chỉ liên lạc`
FROM building AS b
JOIN design AS d ON d.building_id = b.id
JOIN architect AS a ON a.id = d.architect_id
JOIN contractor AS c ON c.id = b.contractor_id
WHERE b.city = 'can tho' AND a.name = 'le kim dung';

-- Hãy cho biết nơi tốt nghiệp của các kiến trúc sư (architect) đã thiết kế (design) công trình Khách Sạn Quốc Tế ở Cần Thơ (building)
SELECT a.name AS `Tên kiến trúc suw`, a.place AS `Nơi tốt nghiệp`
FROM building AS b
JOIN design AS d ON d.building_id = b.id
JOIN architect AS a ON a.id = d.architect_id
WHERE b.name = 'khach san quoc te' AND b.city = 'can tho';

-- Cho biết họ tên, năm sinh, năm vào nghề của các công nhân có chuyên môn hàn hoặc điện (worker) đã tham gia các công trình (work) mà chủ thầu Lê Văn Sơn (contractor) đã trúng thầu (building)
SELECT wkr.name AS `Họ tên`, wkr.birthday AS `Năm sinh`, wkr.year AS `Năm vào nghề`
FROM building AS b
JOIN contractor AS c ON b.contractor_id = c.id
JOIN `work` AS w ON w.building_id = b.id
JOIN worker AS wkr ON wkr.id = w.worker_id
WHERE c.name = 'le van son';

-- Những công nhân nào (worker) đã bắt đầu tham gia công trình Khách sạn Quốc Tế ở Cần Thơ (building) trong giai đoạn từ ngày 15/12/1994 đến 31/12/1994 (work) số ngày tương ứng là bao nhiêu
SELECT wkr.name AS `Họ và tên`, DATEDIFF('1994-12-31', w.date) AS `Số ngày`
FROM work AS w
JOIN building AS b ON b.id = w.building_id
JOIN worker AS wkr ON wkr.id = w.worker_id
WHERE b.name = 'khach san quoc te' AND b.city = 'can tho' AND w.date BETWEEN '1994-12-15' AND '1994-12-31';

-- Cho biết họ tên và năm sinh của các kiến trúc sư đã tốt nghiệp ở TP Hồ Chí Minh (architect) và đã thiết kế ít nhất một công trình (design) có kinh phí đầu tư trên 400 triệu đồng (building)
SELECT a.name AS `Họ và tên`, a.birthday AS `Năm sinh`
FROM building AS b
JOIN design AS d ON b.id = d.building_id
JOIN architect AS a ON a.id = d.architect_id
WHERE a.place = 'tp hcm' AND b.cost > 400;

-- Cho biết tên công trình có kinh phí cao nhất
SELECT `name` 
FROM building 
WHERE cost = (
	SELECT MAX(cost) FROM building 
);

-- Cho biết tên các kiến trúc sư (architect) vừa thiết kế các công trình (design) do Phòng dịch vụ sở xây dựng (contractor) thi công vừa thiết kế các công trình do chủ thầu Lê Văn Sơn thi công
SELECT a.name AS `Tên kiến trúc sư`
FROM building AS b
JOIN design AS d ON d.building_id = b.id
JOIN architect AS a ON d.architect_id = a.id
JOIN contractor AS c ON b.contractor_id = c.id
WHERE c.name = 'phong dich vu so xd' AND c.name = 'le van son';

-- Cho biết họ tên các công nhân (worker) có tham gia (work) các công trình ở Cần Thơ (building) nhưng không có tham gia công trình ở Vĩnh Long
SELECT DISTINCT wkr.name AS `Họ và tên`
FROM building AS b
JOIN work AS w ON w.building_id = b.id
JOIN worker AS wkr ON wkr.id = w.worker_id 
WHERE b.city = 'can tho'
AND w.worker_id NOT IN (
	SELECT w.worker_id
    FROM work AS w
    JOIN building AS b ON b.id = w.building_id
    WHERE b.city = 'vinh long'
);

-- Cho biết tên của các chủ thầu đã thi công các công trình có kinh phí lớn hơn tất cả các công trình do chủ thầu phòng Dịch vụ Sở xây dựng thi công
SELECT DISTINCT c.name AS `Tên chủ thầu`
FROM contractor AS c
JOIN building AS b ON c.id = b.contractor_id
WHERE b.cost > (
	SELECT MAX(b2.cost)
    FROM building AS b2
    JOIN contractor AS c2 ON b2.contractor_id = c2.id
    WHERE c2.name = 'phong dich vu so xd'
);

-- Cho biết họ tên các kiến trúc sư có thù lao thiết kế một công trình nào đó dưới giá trị trung bình thù lao thiết kế cho một công trình
SELECT a.name AS `Họ và tên`
FROM design AS d 
JOIN architect AS a ON d.architect_id = a.id
WHERE d.benefit < (
	SELECT AVG(d2.benefit) FROM design AS d2
);

-- Tìm tên và địa chỉ những chủ thầu đã trúng thầu công trình có kinh phí thấp nhất
SELECT h.name AS `Tên chủ thầu`, h.address AS `địa chỉ chủ thầu`
FROM host AS h
JOIN building AS b ON b.host_id = h.id
WHERE cost = (
	SELECT MIN(b2.cost) FROM building AS b2
);

-- Tìm họ tên và chuyên môn của các công nhân (worker) tham gia (work) các công trình do kiến trúc sư Le Thanh Tung thiet ke (architect) (design)
SELECT wkr.name AS `Họ tên`, wkr.skill AS `Chuyên môn`
FROM worker AS wkr
JOIN work AS w ON wkr.id = w.worker_id
JOIN building AS b ON b.id = w.building_id
JOIN design AS d ON d.building_id = b.id
JOIN architect AS a ON a.id = d.architect_id
WHERE a.name = 'le thanh tung'; 

-- Tìm các cặp tên của chủ thầu có trúng thầu các công trình tại cùng một thành phố
SELECT DISTINCT c1.name AS `Chủ thầu 1`, c2.name AS `Chủ thầu 2`, b1.city AS `Thành phố`
FROM building AS b1
JOIN building AS b2 ON b1.city = b2.city AND b1.contractor_id < b2.contractor_id
JOIN contractor AS c1 ON b1.contractor_id = c1.id
JOIN contractor AS c2 ON b2.contractor_id = c2.id
ORDER BY b1.city, c1.name, c2.name;

-- Tìm tổng kinh phí của tất cả các công trình theo từng chủ thầu
SELECT c.name AS `Tên chủ thầu`, SUM(b.cost) AS `Tổng kinh phí`
FROM contractor AS c
JOIN building AS b ON c.id = b.contractor_id 
GROUP BY c.id, c.name
ORDER BY SUM(b.cost) DESC;

-- Cho biết họ tên các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25 triệu
SELECT a.name AS `Họ và tên`, SUM(d.benefit) AS `Tổng thù lao`
FROM architect AS a
JOIN design AS d ON d.architect_id = a.id
JOIN building AS b ON b.id = d.building_id 
GROUP BY a.id, a.name
HAVING SUM(d.benefit) > 25;

-- Cho biết số lượng các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25 triệu
SELECT COUNT(*) AS `Số lượng kiến trúc sư`
FROM (
    SELECT a.id
    FROM architect AS a
    JOIN design AS d ON d.architect_id = a.id
    JOIN building AS b ON b.id = d.building_id 
    GROUP BY a.id
    HAVING SUM(d.benefit) > 25
) AS architects_fee_above_25m;

-- Tìm tổng số công nhân đã than gia ở mỗi công trình
SELECT b.name AS `Tên công trình`,COUNT(w.worker_id) AS `Tổng số công nhân`
FROM building AS b
JOIN work AS w ON w.building_id = b.id
GROUP BY b.id, b.name;

-- Tìm tên và địa chỉ công trình có tổng số công nhân tham gia nhiều nhất
SELECT b.name AS `Tên công trình`, b.address AS `Địa chỉ`, COUNT(w.worker_id) AS `Tổng số công nhân`
FROM building AS b
JOIN work AS w ON w.building_id = b.id
GROUP BY b.id, b.name, b.address
ORDER BY `Tổng số công nhân` DESC
LIMIT 1;

-- Cho biêt tên các thành phố và kinh phí trung bình cho mỗi công trình của từng thành phố tương ứng
SELECT b.city AS `Tên thành phố`, AVG(b.cost) AS `Kinh phí trung bình`
FROM building AS b
GROUP BY b.city;

-- Cho biết họ tên các công nhân có tổng số ngày tham gia vào các công trình lớn hơn tổng số ngày tham gia của công nhân Nguyễn Hồng Vân
SELECT wkr.name AS `Họ và tên công nhân`, SUM(w.total) AS `Tổng số ngày tham gia`
FROM worker AS wkr
JOIN work AS w ON w.worker_id = wkr.id
GROUP BY wkr.id, wkr.name
HAVING SUM(w.total) > (
    SELECT SUM(w2.total) 
    FROM worker AS wkr2
    JOIN work AS w2 ON w2.worker_id = wkr2.id
    WHERE wkr2.name = 'nguyen hong van'
);

-- Cho biết tổng số công trình mà mỗi chủ thầu đã thi công tại mỗi thành phố
SELECT b.city AS `Tên thành phố`, c.name AS `Tên chủ thầu`, COUNT(b.id) AS `Tổng số công trình`
FROM building AS b
JOIN contractor AS c ON c.id = b.contractor_id
GROUP BY b.city, c.name;

-- Cho biết họ tên công nhân có tham gia ở tất cả các công trình
SELECT wkr.name AS `Họ và tên công nhân`
FROM worker AS wkr
JOIN work AS w ON w.worker_id = wkr.id
GROUP BY wkr.id, wkr.name
HAVING COUNT(DISTINCT w.building_id) = (SELECT COUNT(*) FROM building); 

-- Exercise 6

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    salary FLOAT
);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255) UNIQUE
);

CREATE TABLE Employee_Department (
    employee_id INT,
    department_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    PRIMARY KEY (employee_id, department_id)
);

INSERT INTO Employees (employee_id, name, age, salary) VALUES
(1, 'Nguyễn Văn A', 30, 45000),
(2, 'Trần Thị B', 25, 60000),
(3, 'Lê Kim C', 35, 55000),
(4, 'Phạm Minh D', 28, 70000),
(5, 'Vũ Thị E', 40, 80000);

INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Kế toán'),
(2, 'Nhân sự'),
(3, 'Kinh doanh'),
(4, 'IT');

INSERT INTO Employee_Department (employee_id, department_id) VALUES
(1, 1), (1, 2),
(2, 3),
(3, 4),
(4, 1), (4, 3),
(5, 2), (5, 4);

-- Liệt kê tất cả các nhân viên trong bộ phận "Kế toán"
SELECT e.employee_id, e.name
FROM Employees AS e
JOIN Employee_Department AS ed ON e.employee_id = ed.employee_id
JOIN Departments d ON ed.department_id = d.department_id
WHERE d.department_name = 'Kế toán';

-- Tìm các nhân viên có mức lương lớn hơn 50,000
SELECT employee_id, name, salary
FROM Employees
WHERE salary > 50000;

-- Hiển thị tất cả các bộ phận và số lượng nhân viên trong từng bộ phận
SELECT d.department_name, COUNT(ed.employee_id) AS num_employees
FROM Departments AS d
LEFT JOIN Employee_Department AS ed ON d.department_id = ed.department_id
GROUP BY d.department_name;

-- Tìm ra các thành viên có mức lương cao nhất theo từng bộ phận
SELECT e.employee_id, e.name, e.salary, d.department_name
FROM Employees AS e
JOIN Employee_Department AS ed ON e.employee_id = ed.employee_id
JOIN Departments AS d ON ed.department_id = d.department_id
WHERE e.salary = (
    SELECT MAX(e1.salary)
    FROM Employees AS e1
    JOIN Employee_Department AS ed1 ON e1.employee_id = ed1.employee_id
    JOIN Departments AS d1 ON ed1.department_id = d1.department_id
    WHERE d1.department_name = d.department_name
);

-- Tìm các bộ phận có tổng mức lương của nhân viên vượt quá 100,000
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM Departments AS d
JOIN Employee_Department AS ed ON d.department_id = ed.department_id
JOIN Employees e ON ed.employee_id = e.employee_id
GROUP BY d.department_name
HAVING SUM(e.salary) > 100000;

-- Liệt kê tất cả các nhân viên làm việc trong hơn 2 bộ phận khác nhau
SELECT e.employee_id, e.name, COUNT(ed.department_id) AS num_departments
FROM Employees AS e
JOIN Employee_Department AS ed ON e.employee_id = ed.employee_id
GROUP BY e.employee_id, e.name
HAVING COUNT(ed.department_id) > 2;

