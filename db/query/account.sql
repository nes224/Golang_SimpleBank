INSERT INTO accounts (
    owner,
    balance,
    currency
) VALUES (
    $1, $2, $3
) RETURNING *;

SELECT * FROM accounts
WHERE id = $1 LIMIT 1;

SELECT * FROM accounts
ORDER BY id
LIMIT $1
OFFSET $2;

UPDATE accounts
SET balance = $2
WHERE id = $1
RETURNING *;

DELETE FROM accounts
WHERE id = $1;