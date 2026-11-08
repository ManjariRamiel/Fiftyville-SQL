-- Find the thief: left the bakery lot, withdrew at Leggett Street, made a short call
-- and is a passenger on the earliest flight out of Fiftyville on July 29, 2025.
SELECT name
FROM people
WHERE id IN(
    SELECT person_id
    FROM bank_accounts
    WHERE account_number IN(
        SELECT account_number
        FROM atm_transactions
        WHERE year = 2025 AND month = 7 AND day = 28
            AND atm_location = 'Leggett Street'
            AND transaction_type = 'withdraw'
    )
)
AND license_plate IN(
    SELECT license_plate
    FROM bakery_security_logs
    WHERE year = 2025 AND month = 7 AND day = 28
        AND hour = 10 AND minute BETWEEN 15 AND 25
        AND activity = 'exit'
)
AND phone_number IN(
    SELECT caller
    FROM phone_calls
    WHERE year = 2025 AND month = 7 AND day = 28
        AND duration < 60
)
AND passport_number IN(
    SELECT passport_number
    FROM passengers
    WHERE flight_id = (
        SELECT id
        FROM flights
        WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
            AND year = 2025 AND month = 7 AND day = 29
        ORDER BY hour, minute
        LIMIT 1
    )
);
-- Find the city the thief escaped to: destination of the earliest flight on July 29
SELECT city
FROM airports
WHERE id = (
    SELECT destination_airport_id
    FROM flights
    WHERE origin_airport_id = (SELECT id FROM airports WHERE city = 'Fiftyville')
        AND year = 2025 AND month = 7 AND day = 29
    ORDER BY hour, minute
    LIMIT 1
);
-- Find the accomplice: the person the thief called for less than a minute
SELECT name
FROM people
WHERE phone_number IN(
    SELECT receiver
    FROM phone_calls
    WHERE year = 2025 AND month = 7 AND day = 28
        AND duration < 60
        AND caller = (SELECT phone_number FROM people WHERE name = 'Bruce') 
);-- Replace THIEF_NAME with the actual name of the thief found in the first query