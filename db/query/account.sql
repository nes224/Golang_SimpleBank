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
WHERE id = $1 LIMIT 1
FOR NO KEY UPDATE;

SELECT * FROM accounts 
WHERE owner = $1
ORDER BY id 
LIMIT $2
OFFSET $3;

UPDATE accounts
SET balance = $2
WHERE id = $1
RETURNING *;

DELETE FROM accounts
WHERE id = $1;