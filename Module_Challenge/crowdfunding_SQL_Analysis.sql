-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cf_id as live_campaign_id, SUM(backers_count) as backers_count
FROM campaign
WHERE outcome = 'live'
GROUP BY cf_id
ORDER BY backers_count DESC

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT cf_id as live_campaign_id, COUNT (cf_id) as backers_count
FROM backers
GROUP BY live_campaign_id
ORDER BY backers_count DESC

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT c.first_name,
	c.last_name,
	c.email,
	(cam.goal - cam.pledged) as "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM campaign AS cam
LEFT JOIN contacts AS c
ON (cam.contact_id = c.contact_id)
WHERE cam.outcome = 'live'
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount


-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT b.email,
	b.first_name,
	b.last_name,
	b.cf_id,
	cam.company_name,
	cam.description,
	cam.end_date,
	(cam.goal - cam.pledged) as "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers as b
LEFT JOIN campaign as cam
ON (b.cf_id = cam.cf_id)
WHERE cam.outcome = 'live'
ORDER BY b.last_name;

-- Check the table
SELECT * from email_backers_remaining_goal_amount



