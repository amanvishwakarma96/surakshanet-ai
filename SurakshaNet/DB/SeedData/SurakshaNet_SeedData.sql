-- MVP seed data. PasswordHash values are placeholders; create real hashes during local setup.
INSERT INTO Roles (Name) VALUES ('Admin'), ('Citizen'), ('Verifier');
INSERT INTO Users (FullName, Mobile, Email, PasswordHash, PreferredLanguage, VerificationLevel) VALUES
('Admin User', '+910000000001', 'admin@suraksha.local', 'PLACEHOLDER_HASH_CHANGE_ME', 'en', 'GovernmentVerified'),
('Citizen User', '+910000000002', 'citizen@suraksha.local', 'PLACEHOLDER_HASH_CHANGE_ME', 'en', 'Basic');
INSERT INTO UserRoles (UserId, RoleId) VALUES (1, 1), (2, 2);
INSERT INTO Departments (Name, DepartmentType, ContactEmail, ContactMobile) VALUES
('Police', 'Emergency', 'police@example.local', '+910000001001'),
('Ambulance', 'Medical', 'ambulance@example.local', '+910000001002'),
('Fire Department', 'Fire', 'fire@example.local', '+910000001003'),
('Municipal Roads', 'Roads', 'roads@example.local', '+910000001004'),
('Drainage Department', 'Drainage', 'drainage@example.local', '+910000001005'),
('Electricity Board', 'Electricity', 'electricity@example.local', '+910000001006'),
('Women Safety Cell', 'Safety', 'women-safety@example.local', '+910000001007'),
('Vigilance Department', 'Vigilance', 'vigilance@example.local', '+910000001008');
