Select *from patients;

-- verify the insert patients data
select count(*)from patients;

#Age Distribution
select floor(datediff(curdate(),date_of_birth)/365)as Age,
count(*)as total_patients
from patients
group by age
order by age;

SELECT CASE 
        WHEN FLOOR(DATEDIFF(CURDATE(), date_of_birth)/365) < 20 THEN 'Under 20'
        WHEN FLOOR(DATEDIFF(CURDATE(), date_of_birth)/365) BETWEEN 18 AND 35 THEN '21-35'
        WHEN FLOOR(DATEDIFF(CURDATE(), date_of_birth)/365) BETWEEN 36 AND 60 THEN '36-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total
FROM patients
GROUP BY age_group
ORDER BY total DESC;

#patients by city
Select city, count(*)as total_patients
from patients
group by city
order by total_patients desc;

-- Gender ratio
Select gender, count(*)
from patients
group by gender;
-- 
-- Recently registered patients (Last 30 Days)
Select * from patients
where registration_date>=date_sub(curdate(),interval 30 day);

#verify the appointments data-- 
Select count(*) from appointments;

-- Appointments per doctor
Select doctor_id,count(*) as total_appointments
from appointments
group by doctor_id
order by total_appointments desc;

#Monthly appointments trend
Select Month(appointment_date)as months ,
count(*) as total_appointments
from appointments
group by months
order by months;

#Today is appointments
Select * from appointments
where Date(appointment_date)=curdate();

#Doctor Workload Ranking
Select doctor_id, count(*)as total,
rank() over (order by count(*)desc)
as workload_rank
from appointments
group by doctor_id;

-- Cancellation rate per doctor-- 
Select d.first_name ,count(*) as total,
Sum(case when a.appointment_status='Cancelled'  then 1 else 0 End)as cancelled,
Round(sum(case when a.appointment_status='Cancelled' then  1 else 0 end)/Count(*) * 100,2)as cancellation_rate_percent
from doctors d
join appointments a
On d.doctor_id=a.doctor_id
group by d.doctor_id
order by cancellation_rate_percent desc;


