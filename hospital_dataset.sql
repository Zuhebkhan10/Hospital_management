Create database Hospital_Management;
use Hospital_Management;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender ENUM('Male','Female','Other'),
    date_of_birth DATE,
    phone VARCHAR(15),
    email VARCHAR(150),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    registration_date DATE
);
INSERT INTO patients (
    first_name,
    last_name,
    gender,
    date_of_birth,
    phone,
    email,
    address,
    city,
    state,
    registration_date
)
SELECT 
    ELT(FLOOR(1 + RAND()*10),
        'Rahul','Priya','Amit','Sneha','Arjun',
        'Pooja','Vikram','Anjali','Rohit','Neha'),
        
    ELT(FLOOR(1 + RAND()*10),
        'Sharma','Verma','Patel','Reddy','Gupta',
        'Khan','Iyer','Mehta','Das','Nair'),
        
    ELT(FLOOR(1 + RAND()*3),
        'Male','Female','Other'),
        
    DATE_SUB(CURDATE(), INTERVAL FLOOR(18 + RAND()*60)*365 DAY),
    
    CONCAT('9', FLOOR(100000000 + RAND()*900000000)),
    
    CONCAT('patient', 
           t1.n + t2.n*10 + t3.n*100 + t4.n*1000,
           '@hospital.com'),
    
    CONCAT(FLOOR(1 + RAND()*999), ' Main Street'),
    
    ELT(FLOOR(1 + RAND()*8),
        'Mumbai','Delhi','Hyderabad','Chennai',
        'Bangalore','Kolkata','Pune','Ahmedabad'),
        
    ELT(FLOOR(1 + RAND()*8),
        'Maharashtra','Delhi','Telangana','Tamil Nadu',
        'Karnataka','West Bengal','Maharashtra','Gujarat'),
        
    DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*1000) DAY)

FROM 
    (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
    (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
    (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
    (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) t4
LIMIT 2500;
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    specialization VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(150),
    consultation_fee DECIMAL(10,2),
    hire_date DATE
);
INSERT INTO doctors (
    first_name,
    last_name,
    specialization,
    phone,
    email,
    consultation_fee,
    hire_date
)
SELECT 
    ELT(FLOOR(1 + RAND()*8),
        'Raj','Meena','Arun','Kavita','Sameer','Divya','Nitin','Asha'),
    ELT(FLOOR(1 + RAND()*8),
        'Kumar','Shah','Rao','Singh','Patel','Joshi','Bose','Nair'),
    ELT(FLOOR(1 + RAND()*6),
        'Cardiology','Orthopedics','Neurology',
        'Dermatology','Pediatrics','General'),
    CONCAT('98', FLOOR(10000000 + RAND()*90000000)),
    CONCAT('doctor', FLOOR(RAND()*1000), '@hospital.com'),
    ROUND(300 + RAND()*700,2),
    DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*2000) DAY)
FROM 
    (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
    (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2
LIMIT 100;

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    appointment_status ENUM('Scheduled','Completed','Cancelled'),
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
INSERT INTO appointments (
    patient_id,
    doctor_id,
    appointment_date,
    appointment_status,
    reason
)
SELECT 
    FLOOR(1 + RAND()*2500),  -- assumes 2500 patients
    FLOOR(1 + RAND()*100),   -- assumes 100 doctors
    DATE_SUB(NOW(), INTERVAL FLOOR(RAND()*365) DAY),
    ELT(FLOOR(1 + RAND()*3),
        'Scheduled','Completed','Cancelled'),
    ELT(FLOOR(1 + RAND()*6),
        'Fever','Routine Checkup','Back Pain',
        'Skin Allergy','Headache','Follow-up')
FROM 
    (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
    (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
    (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5) t3
LIMIT 6000;

CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT,
    diagnosis VARCHAR(255),
    treatment_description TEXT,
    treatment_cost DECIMAL(10,2),
    treatment_date DATE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);
INSERT INTO treatments (
    appointment_id,
    diagnosis,
    treatment_description,
    treatment_cost,
    treatment_date
)
SELECT 
    a.appointment_id,
    
    ELT(FLOOR(1 + RAND()*8),
        'Fever',
        'Back Pain',
        'Migraine',
        'Skin Allergy',
        'Hypertension',
        'Diabetes',
        'Fracture',
        'Viral Infection'),
        
    ELT(FLOOR(1 + RAND()*6),
        'Prescribed medication and rest',
        'Recommended physiotherapy sessions',
        'Minor surgical procedure performed',
        'Blood tests and follow-up required',
        'Lifestyle changes and medication',
        'Advanced diagnostic imaging required'),
        
    ROUND(500 + RAND()*7000, 2),
    
    DATE(a.appointment_date)

FROM appointments a
LEFT JOIN treatments t 
    ON a.appointment_id = t.appointment_id
WHERE 
    a.appointment_status = 'Completed'
    AND t.appointment_id IS NULL
LIMIT 1500;

CREATE TABLE billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT,
    total_amount DECIMAL(10,2),
    payment_status ENUM('Paid','Pending','Partially Paid'),
    payment_method VARCHAR(50),
    billing_date DATE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);
INSERT INTO billing (
    appointment_id,
    total_amount,
    payment_status,
    payment_method,
    billing_date
)
SELECT 
    a.appointment_id,
    
    -- Consultation + random treatment cost
    ROUND(
        (300 + RAND()*700) +   -- consultation fee range
        (500 + RAND()*5000),   -- treatment cost range
    2),
    
    ELT(FLOOR(1 + RAND()*3),
        'Paid','Pending','Partially Paid'),
        
    ELT(FLOOR(1 + RAND()*4),
        'Cash','Credit Card','UPI','Insurance'),
        
    DATE(a.appointment_date)

FROM appointments a
LEFT JOIN billing b 
    ON a.appointment_id = b.appointment_id
WHERE 
    a.appointment_status = 'Completed'
    AND b.appointment_id IS NULL;