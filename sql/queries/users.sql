-- name: CreateUser :one
INSERT INTO users (id, created_at, updated_at, email, hashed_password)
VALUES (
    gen_random_uuid(), NOW(), NOw(), $1, $2
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

-- name: GetUser :one
SELECT * FROM users
WHERE email = $1 LIMIT 1;

-- name: GetChirps :many
SELECT * FROM chirps
ORDER BY created_at ASC;


-- name: GetChirp :one
SELECT * FROM chirps
WHERE id = $1 LIMIT 1;


-- name: CreateRefreshToken :one
INSERT INTO refresh_tokens(token, created_at, updated_at, expires_at, revoked_at, user_id)
VALUES (
    $1, NOw(), NOw(), $2, $3, $4
)
RETURNING *;

-- name: GetRefreshToken :one
SELECT * FROM refresh_tokens
WHERE token = $1 LIMIT 1;

-- name: UpdateRefreshToken :exec
UPDATE refresh_tokens
SET updated_at = NOW(), revoked_at = NOw()
WHERE token = $1;

-- name: UpdateUser :one
UPDATE users
SET email = $1, hashed_password = $2, updated_at = NOW()
WHERE id = $3
RETURNING *;

-- name: DeleteChirp :one
DELETE FROM chirps
WHERE id = $1 AND user_id = $2
RETURNING *;

-- name: UpdateUserMembership :one
UPDATE users
SET is_chirpy_red = $1, updated_at = NOW()
WHERE id = $2
RETURNING *;