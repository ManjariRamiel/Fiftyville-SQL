-- Keep a log of any SQL queries you execute as you solve the mystery.
-- I am looking for a theft on Humphrey Street on July 28, 2025.
SELECT *
FROM crime_scene_reports
WHERE year = 2025 AND month = 7 AND day = 28
   AND street = 'Humphrey Street';
 -- The report says three witnesses mention the bakery; reading their interviews
 SELECT name, transcript
 FROM interviews
 WHERE year = 2025 AND month = 7 AND day = 28
    AND transcript LIKE '%bakery%';

-- Ruth: thieft left the bakery lot within 10 minutes of the theft(10:15)
SELECT license_plate
FROM bakery_security_logs
WHERE year = 2025 AND month = 7 AND day = 28
    AND hour = 10 AND minute BETWEEN 15 AND 25
    AND activity = 'exit';

-- People whose cars left the bakery lot in that window
SELECT name
FROM people
WHERE licence_plate IN (
    SELECT license_plate
    FROM bakery_security_logs
    WHERE year = 2025 AND month = 7 AND day = 28
        AND hour = 10 AND minute BETWEEN 5 AND 15
        AND activity = 'exit'
);
