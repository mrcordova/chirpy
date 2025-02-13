-- name: CreateUser :one
INSERT INTO users (id, created_at, updated_at, email)
VALUES (
    gen_random_uuid(), NOW(), NOw(), $1
)
RETURNING *;

-- name: DeleteUsers :exec
DELETE FROM users;


-- name: CreateChirp :one
INSERT INTO chirps(id, created_at, updated_at, body, user_id)
VALUES(
    gen_random_uuid(), NOW(), NOW(), $1, $2
)
RETURNING *;


-- name: GetChirps :many
SELECT * FROM chirps
ORDER BY created_at ASC;


-- name: GetChirp :one
SELECT * FROM chirps
WHERE id = $1 LIMIT 1;