INSERT INTO roles(name) VALUES('ROLE_EDITOR') ON CONFLICT DO NOTHING;
INSERT INTO roles(name) VALUES('ROLE_VIEWER') ON CONFLICT DO NOTHING;

-- Passwords for 'admin' and 'user' are 'root' encoded with BCrypt
-- This is just for initial testing. Change them via API later.
INSERT INTO users(username, password) VALUES('admin', '$2a$10$fV3.vA5oTXZhH4wF6.128eyI5U2Q5hG7tZ3iZ9mZ6u2Q8wY4pT5yG') ON CONFLICT DO NOTHING;
INSERT INTO users(username, password) VALUES('user', '$2a$10$fV3.vA5oTXZhH4wF6.128eyI5U2Q5hG7tZ3iZ9mZ6u2Q8wY4pT5yG') ON CONFLICT DO NOTHING;

INSERT INTO user_roles(user_id, role_id) 
SELECT u.id, r.id FROM users u, roles r 
WHERE u.username = 'admin' AND r.name = 'ROLE_EDITOR'
ON CONFLICT DO NOTHING;

INSERT INTO user_roles(user_id, role_id) 
SELECT u.id, r.id FROM users u, roles r 
WHERE u.username = 'user' AND r.name = 'ROLE_VIEWER'
ON CONFLICT DO NOTHING;