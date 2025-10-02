USE `GYM`;

# Inserting some data into the tables so we can test these queries:
INSERT INTO `Member` (Name, DateOfBirth, PhoneNumber, Email)
VALUES 
('Isabel Van Der Veen', '2002-03-15', '123-456-7891', 'vandervi1@newpaltz.edu'),
('Ava Allen', '2003-02-23', '567-891-2938', 'allena17@newpaltz.edu');

SELECT * FROM `Member`;

INSERT INTO `MembershipType` (TypeName, Cost, Duration)
VALUES 
('Monthly', 50.00, 1),
('Annual', 500.00, 12);

SELECT * FROM `MembershipType`;

INSERT INTO `Membership` (StartDate, EndDate, Status, MemberID, TypeID)
VALUES 
('2023-01-01', '2023-12-31', 'active', 1, 2),
('2023-11-01', '2023-11-30', 'active', 2, 1);

SELECT * FROM `Membership`;

INSERT INTO`Payment` (Amount, PaymentDate, PaymentStatus, MembershipID) 
VALUES (500, '2023-01-01', 'paid', 5), (50.00, '2023-11-01', 'paid', 6);

SELECT * FROM `payment`;

# Subquery to find members who are enrolled in a membership:
SELECT Name, PhoneNumber, Email
FROM Member
WHERE MemberID IN (SELECT MemberID FROM Membership);

# Listing all of the active memberships with the individual members and membership types
SELECT m.Name, mt.TypeName, ms.StartDate, ms.EndDate
FROM Membership ms
JOIN Member m ON ms.MemberID = m.MemberID
JOIN MembershipType mt ON ms.TypeID = mt.TypeID
WHERE ms.Status = 'active';

# Calculating the total revnue from memberships
SELECT SUM(Amount) AS TotalRevenue
FROM Payment
WHERE PaymentStatus = 'paid';

# Finding the COUNT for memberships for each 'status (active, pending, expired)
SELECT Status, COUNT(MembershipID) AS MembershipCount
FROM Membership
GROUP BY Status; 

# Filtering by Emails ending in .edu
SELECT Name, Email
FROM Member
WHERE Email LIKE '%.edu';

#  Listing all active members that started on or after '2023-01-01' and have a duration of longer than 6 months
SELECT m.Name, ms.StartDate, mt.TypeName, mt.Duration
FROM Membership ms
JOIN Member m ON ms.MemberID = m.MemberID
JOIN MembershipType mt ON ms.TypeID = mt.TypeID
WHERE ms.Status = 'active' 
  AND ms.StartDate >= '2023-01-01'
  AND mt.Duration > 6;
  
SELECT * FROM Member;
SELECT * FROM Membership;
SELECT * FROM MembershipType;
SELECT * FROM Payment; 