# Pewlett_Hackard-_Challenge
Using SQL to determine the number of retiring employees per title and identify employees who are eligible to participate in a mentorship program. at Pewlett Hackard.

---

## Overview of the analysis:
Pewlett Hackard (PH) is a large company with several thousand employees, and has been around for a long time. With the rate of baby boomers retiring, it wants to identify those eligible for retirement and those eligibile for mentorship based on certain criteria. As a human resources researcher, this report intends to find the answers to the who and how many employees will be retiring in an effort to future-proof PH's growth.

The data for this research consists of six separate CSV files that have mainly been operated from Excel and VBA. This data will be imported into a centralized relational database known as SQL to help efficiently organize the company's human resources information. Using SQL, this analysis will particularly determine the number of retiring employees per title, and identify employees who are eligible to participate in a mentorship program. 

---

## Results: 
There are four major points that can be made in regards to this analysis:

- There is a large number of retention and loyalty at Pewlett-Hackard.
  - The initial query retrieved the following items: employee number, first name, last name, title, "from" date, and "to" date. This was filtered based on the birth date from 1952 to 1955. 
  - The code for this query as referenced within the SQL file was found using the following syntax:

            SELECT  e.emp_no,
                e.first_name,
            e.last_name,
                tt.title,
                tt.from_date,
                tt.to_date
            INTO emp_retire
            FROM employees as e
            INNER JOIN titles as tt
            ON (e.emp_no = tt.emp_no)
            WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
            ORDER BY e.emp_no;

  - Based on this query, it can observed that there can be multiple titles per employee, as illustrated in the figure below. It can be inferred that many of the employees eligible for retirement have been with company for a long time, and are therefore quite loyal to the enterprise that has allowed them to professionally develop. This loyal workforce is in of itself deserving of the name "Silver Tsunami."

    ![Non-Unique_Retirement_Titles](Resources\non-unique_retirement_titles.png) 

- The actual number of retirees based on birth dates is 72,458.
  - Upon further refinement, the query can retrieve the same employee information for the first occurrence of the employee number in each row. This would return a set of data where the employees are not duplicated due to promotions or multiple titles. The set of data will be further filtered to exclude all the emplyees that have left the company, and only keep those currently employed.  
  - The code for this query as referenced within the SQL file was found using the following syntax:

        SELECT DISTINCT ON (ret.emp_no) ret.emp_no,
            ret.first_name,
        ret.last_name,
            ret.title
        INTO unique_titles
        FROM emp_retire as ret
        WHERE (ret.to_date = '9999-01-01')
        ORDER BY ret.emp_no, ret.title ASC;

  - Based on the sheer number of eligible employees for retirement, and as indicated in the figure below, there is going to be a larger need for more workers to fill those spots or develop younger professionals through a mentorship program.

    ![Unique_Retirement_Titles](Resources\unique_retirement_titles.png) 

- There will be a significant need for senior-level positions.
  - The number of senior engineers and senior staff retirees is 25,916 and 24,926, respectively. 

    ![Grouped_Retirement_Titles](Resources\group_title_count.png) 

   - These numbers were found by taking the afforementioned data tables, and querying using the `COUNT` and `GROUP BY` functions to aggregate based on title. The syntax for this code can found from the following lines:

            SELECT COUNT(ut.emp_no), ut.title
            INTO retiring_titles
            FROM unique_titles as ut
            GROUP BY ut.title
            ORDER BY COUNT(ut.emp_no) DESC;   

- The number of eligible mentors is significantly less than the amount of eligible retirees.
  - The number of eligible mentors 1,549. 
  - The mentors were found by created a query of current employees with the birth date in the year 1965. 
  - The retrievable data included the employee number, first name, last name, birth date, title, "from" date, and "to" date. The list was also filtered for unique mentor identification using the `DISTINCT` function. The code for this query involved joining two tables, and the syntax can be followed as such: 

        SELECT DISTINCT ON (e.emp_no) e.emp_no,
            e.first_name,
        e.last_name,
            e.birth_date,
            de.from_date,
            de.to_date,
            tt.title
        INTO mentor_list
        FROM employees as e
        INNER JOIN dept_emp as de
        ON (e.emp_no = de.emp_no)
        INNER JOIN titles as tt
        ON (e.emp_no = tt.emp_no)
        WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
            AND (de.to_date = '9999-01-01')
        ORDER BY e.emp_no, tt.title ASC;

  - Based on the above constraints, the following table is developed to illustrate a list of names that can be used for potential mentors.

    ![Eligible_Mentors](Resources\mentor_eligibility_list.png) 

---

## Summary: 
In essence, there are 72,458 roles that could potentially be needed to fill as the "silver tsunami" takes course. There is a greater need for workforce development to fill many of these higher-level positions in the future.

There is a significant lack of qualified employees in the departments to mentor the next generation of Pewlett Hackard employees. Based on the birth year of 1965 alone, the following grouped query can find the number of mentors within each department. 

![Eligible_Mentors_Count](Resources\mentor_eligibility_titles.png) 

The senior engineer position does not even make it to the second spot on this list. Furthermore, in the worst case, if all the potential retirees retired on one day that means that for every senior engineer mentor and senior staff mentor there would be about 153 and 43 mentees under them. This is an unrealistic number. To make matters worse, there are no manger mentors in this list that can fill the positions of the manager retirees. 

These inflated values, assuming relative accuracy, can best be sorted by increased the number of mentors perhaps for years 1960 through 1965. This is a pretty large span, but it can be shorter depending on the allowed relationship of mentors to mentees. In this filter, it has been found there are a lot more mentors available that ease the impact of the "silver tsunami." The query results in the following table:

![Eligible_Mentors_Count_Updated](Resources\mentor_eligibility_titles_updated.png) 

This means that if all the potential retirees retired on one day then for every senior engineer mentor and senior staff mentor there would be about 3 and 1 mentees under them. Additionally, there would be mentors available for the manager position. These ratios are a lot more reasonable, and can assist Pewlett-Hackard in future-proofing their company from knolwedge transfer losses.