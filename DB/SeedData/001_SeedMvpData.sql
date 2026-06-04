/*
    Safe non-production seed data for SurakshaNet AI MVP.
    Run after DB/Scripts/001_CreateMvpSchema.sql.

    The users below are placeholders only. PasswordHash intentionally uses NULL;
    credentials must be provisioned by the application or secure identity workflow.
*/

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

DECLARE @AdminRoleId UNIQUEIDENTIFIER = '11111111-1111-1111-1111-111111111111';
DECLARE @ModeratorRoleId UNIQUEIDENTIFIER = '22222222-2222-2222-2222-222222222222';
DECLARE @ReviewerRoleId UNIQUEIDENTIFIER = '33333333-3333-3333-3333-333333333333';
DECLARE @HelperRoleId UNIQUEIDENTIFIER = '44444444-4444-4444-4444-444444444444';
DECLARE @ResidentRoleId UNIQUEIDENTIFIER = '55555555-5555-5555-5555-555555555555';

MERGE dbo.Roles AS target
USING (VALUES
    (@AdminRoleId, N'Admin', N'Platform administration and restricted audit access.', 1),
    (@ModeratorRoleId, N'Moderator', N'Public-board moderation and safety visibility decisions.', 1),
    (@ReviewerRoleId, N'Reviewer', N'Human verification reviewer for sensitive and public workflows.', 1),
    (@HelperRoleId, N'VerifiedHelper', N'Verified helper allowed to respond to approximate-first helper requests.', 1),
    (@ResidentRoleId, N'Resident', N'Default citizen reporter role.', 1)
) AS source (RoleId, RoleName, Description, IsSystemRole)
ON target.RoleId = source.RoleId
WHEN MATCHED THEN
    UPDATE SET RoleName = source.RoleName, Description = source.Description, IsSystemRole = source.IsSystemRole, UpdatedAt = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (RoleId, RoleName, Description, IsSystemRole)
    VALUES (source.RoleId, source.RoleName, source.Description, source.IsSystemRole);
GO

DECLARE @MunicipalWorksId UNIQUEIDENTIFIER = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1';
DECLARE @ElectricityDeptId UNIQUEIDENTIFIER = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2';
DECLARE @DisasterResponseId UNIQUEIDENTIFIER = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3';
DECLARE @TrafficPoliceId UNIQUEIDENTIFIER = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4';
DECLARE @PublicSafetyId UNIQUEIDENTIFIER = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa5';
DECLARE @AntiCorruptionCellId UNIQUEIDENTIFIER = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa6';

MERGE dbo.Departments AS target
USING (VALUES
    (@MunicipalWorksId, N'Municipal Roads and Works', N'Potholes, road hazards, drainage, and civic repair routing.', N'municipal-works-placeholder'),
    (@ElectricityDeptId, N'Electricity Safety Department', N'Downed wires, exposed electrical hazards, and power safety.', N'electricity-safety-placeholder'),
    (@DisasterResponseId, N'Disaster Response Cell', N'Flood, evacuation, rescue, and critical emergency coordination.', N'disaster-response-placeholder'),
    (@TrafficPoliceId, N'Traffic Police', N'Unsafe traffic conditions, road blockage, and diversion support.', N'traffic-police-placeholder'),
    (@PublicSafetyId, N'Public Safety and Women Helpline', N'Unsafe areas and public safety escalation.', N'public-safety-placeholder'),
    (@AntiCorruptionCellId, N'Anti-Corruption Review Cell', N'Sensitive complaints that require protected identity and human review.', N'anti-corruption-placeholder')
) AS source (DepartmentId, DepartmentName, ServiceArea, ContactChannel)
ON target.DepartmentId = source.DepartmentId
WHEN MATCHED THEN
    UPDATE SET DepartmentName = source.DepartmentName, ServiceArea = source.ServiceArea, ContactChannel = source.ContactChannel, UpdatedAt = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (DepartmentId, DepartmentName, ServiceArea, ContactChannel)
    VALUES (source.DepartmentId, source.DepartmentName, source.ServiceArea, source.ContactChannel);
GO

DECLARE @AdminUserId UNIQUEIDENTIFIER = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1';
DECLARE @ReviewerUserId UNIQUEIDENTIFIER = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2';
DECLARE @HelperUserId UNIQUEIDENTIFIER = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb3';
DECLARE @ResidentUserId UNIQUEIDENTIFIER = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb4';
DECLARE @AnonymousUserId UNIQUEIDENTIFIER = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb5';

MERGE dbo.Users AS target
USING (VALUES
    (@AdminUserId, N'MVP Admin', N'admin.placeholder@surakshanet.local', N'***0001', 0, 0),
    (@ReviewerUserId, N'MVP Reviewer', N'reviewer.placeholder@surakshanet.local', N'***0002', 0, 0),
    (@HelperUserId, N'Verified Helper Placeholder', N'helper.placeholder@surakshanet.local', N'***0003', 0, 0),
    (@ResidentUserId, N'Resident Reporter Placeholder', N'resident.placeholder@surakshanet.local', N'***0004', 0, 0),
    (@AnonymousUserId, N'Anonymous Protected Reporter', NULL, NULL, 1, 1)
) AS source (UserId, DisplayName, Email, PhoneNumberMasked, IsAnonymous, IsProtectedIdentity)
ON target.UserId = source.UserId
WHEN MATCHED THEN
    UPDATE SET DisplayName = source.DisplayName, Email = source.Email, PhoneNumberMasked = source.PhoneNumberMasked,
        IsAnonymous = source.IsAnonymous, IsProtectedIdentity = source.IsProtectedIdentity, UpdatedAt = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (UserId, DisplayName, Email, PhoneNumberMasked, PasswordHash, IsAnonymous, IsProtectedIdentity)
    VALUES (source.UserId, source.DisplayName, source.Email, source.PhoneNumberMasked, NULL, source.IsAnonymous, source.IsProtectedIdentity);
GO

MERGE dbo.UserRoles AS target
USING (VALUES
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1', '11111111-1111-1111-1111-111111111111'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2', '33333333-3333-3333-3333-333333333333'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb3', '44444444-4444-4444-4444-444444444444'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb4', '55555555-5555-5555-5555-555555555555'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb5', '55555555-5555-5555-5555-555555555555')
) AS source (UserId, RoleId)
ON target.UserId = source.UserId AND target.RoleId = source.RoleId
WHEN NOT MATCHED THEN
    INSERT (UserId, RoleId, AssignedByUserId)
    VALUES (source.UserId, source.RoleId, 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1');
GO

DECLARE @FloodIncidentId UNIQUEIDENTIFIER = 'cccccccc-cccc-cccc-cccc-ccccccccccc1';
DECLARE @PotholeIncidentId UNIQUEIDENTIFIER = 'cccccccc-cccc-cccc-cccc-ccccccccccc2';
DECLARE @UnsafeIncidentId UNIQUEIDENTIFIER = 'cccccccc-cccc-cccc-cccc-ccccccccccc3';
DECLARE @HelperIncidentId UNIQUEIDENTIFIER = 'cccccccc-cccc-cccc-cccc-ccccccccccc4';

MERGE dbo.Incidents AS target
USING (VALUES
    (@FloodIncidentId, 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb4', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3', N'Water logging near main bus stop', N'Road is flooded and pedestrians are using the median.', N'Flood', N'High', N'Verified', N'HumanVerified', 0, 1, CAST(18.520400 AS DECIMAL(9,6)), CAST(73.856700 AS DECIMAL(9,6)), N'Central bus stop area, Ward 1'),
    (@PotholeIncidentId, 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb4', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1', N'Large pothole on market road', N'Two-wheelers are swerving around a deep pothole after rain.', N'Pothole', N'Medium', N'UnderReview', N'AutoScored', 0, 0, CAST(18.521000 AS DECIMAL(9,6)), CAST(73.858000 AS DECIMAL(9,6)), N'Market road area, Ward 1'),
    (@UnsafeIncidentId, 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb5', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa5', N'Poor lighting near walkway', N'Walkway has repeated unsafe activity reports after dark.', N'UnsafeArea', N'High', N'UnderReview', N'NeedsHumanReview', 1, 0, CAST(18.519200 AS DECIMAL(9,6)), CAST(73.855900 AS DECIMAL(9,6)), N'Riverside walkway area'),
    (@HelperIncidentId, 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb5', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3', N'Need drinking water assistance', N'Family near flooded lane needs water and safe transport guidance.', N'HelperRequest', N'High', N'Escalated', N'NeedsHumanReview', 1, 0, CAST(18.522200 AS DECIMAL(9,6)), CAST(73.854800 AS DECIMAL(9,6)), N'Flooded lane near Ward 1 community hall')
) AS source (IncidentId, ReporterUserId, AssignedDepartmentId, Title, Description, Category, Severity, Status, VerificationStatus, IsSensitive, IsPublicCandidate, ApproximateLatitude, ApproximateLongitude, ApproximateLocationLabel)
ON target.IncidentId = source.IncidentId
WHEN MATCHED THEN
    UPDATE SET Status = source.Status, VerificationStatus = source.VerificationStatus, UpdatedAt = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (IncidentId, ReporterUserId, AssignedDepartmentId, Title, Description, Category, Severity, Status, VerificationStatus,
        IsSensitive, IsPublicCandidate, ApproximateLatitude, ApproximateLongitude, ApproximateLocationLabel)
    VALUES (source.IncidentId, source.ReporterUserId, source.AssignedDepartmentId, source.Title, source.Description, source.Category,
        source.Severity, source.Status, source.VerificationStatus, source.IsSensitive, source.IsPublicCandidate,
        source.ApproximateLatitude, source.ApproximateLongitude, source.ApproximateLocationLabel);
GO

INSERT INTO dbo.IncidentVerificationLogs (IncidentId, ReviewerUserId, VerificationType, Score, Status, Reason, RequiresHumanReview)
SELECT source.IncidentId, source.ReviewerUserId, source.VerificationType, source.Score, source.Status, source.Reason, source.RequiresHumanReview
FROM (VALUES
    ('cccccccc-cccc-cccc-cccc-ccccccccccc1', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2', N'HumanReview', CAST(92.00 AS DECIMAL(5,2)), N'HumanVerified', N'Human reviewer confirmed public flood alert can use approximate area only.', 1),
    ('cccccccc-cccc-cccc-cccc-ccccccccccc2', NULL, N'MockAI', CAST(68.00 AS DECIMAL(5,2)), N'AutoScored', N'MVP scoring suggests municipal road review; no public publishing yet.', 0),
    ('cccccccc-cccc-cccc-cccc-ccccccccccc3', NULL, N'MockAI', CAST(81.00 AS DECIMAL(5,2)), N'NeedsHumanReview', N'Sensitive unsafe-area report requires human review before public visibility.', 1)
) AS source (IncidentId, ReviewerUserId, VerificationType, Score, Status, Reason, RequiresHumanReview)
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.IncidentVerificationLogs existing
    WHERE existing.IncidentId = source.IncidentId AND existing.VerificationType = source.VerificationType AND existing.Status = source.Status
);
GO

DECLARE @FloodGeoFenceId UNIQUEIDENTIFIER = 'dddddddd-dddd-dddd-dddd-dddddddddd01';
DECLARE @UnsafeGeoFenceId UNIQUEIDENTIFIER = 'dddddddd-dddd-dddd-dddd-dddddddddd02';

MERGE dbo.GeoFences AS target
USING (VALUES
    (@FloodGeoFenceId, N'Ward 1 flood caution radius', N'Flood', CAST(18.520400 AS DECIMAL(9,6)), CAST(73.856700 AS DECIMAL(9,6)), 750, 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2'),
    (@UnsafeGeoFenceId, N'Riverside walkway safety watch', N'UnsafeArea', CAST(18.519200 AS DECIMAL(9,6)), CAST(73.855900 AS DECIMAL(9,6)), 500, 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2')
) AS source (GeoFenceId, Name, HazardType, CenterLatitude, CenterLongitude, RadiusMeters, CreatedByUserId)
ON target.GeoFenceId = source.GeoFenceId
WHEN MATCHED THEN
    UPDATE SET Name = source.Name, HazardType = source.HazardType, RadiusMeters = source.RadiusMeters, UpdatedAt = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (GeoFenceId, Name, HazardType, CenterLatitude, CenterLongitude, RadiusMeters, CreatedByUserId)
    VALUES (source.GeoFenceId, source.Name, source.HazardType, source.CenterLatitude, source.CenterLongitude, source.RadiusMeters, source.CreatedByUserId);
GO

MERGE dbo.Alerts AS target
USING (VALUES
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee1', 'cccccccc-cccc-cccc-cccc-ccccccccccc1', 'dddddddd-dddd-dddd-dddd-dddddddddd01', N'Flood caution near Ward 1 bus stop', N'Avoid low-lying routes near the central bus stop. Use alternate roads and follow official guidance.', N'High', N'Published', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2')
) AS source (AlertId, IncidentId, GeoFenceId, Title, Message, Severity, Status, PublishedByUserId)
ON target.AlertId = source.AlertId
WHEN MATCHED THEN
    UPDATE SET Title = source.Title, Message = source.Message, Severity = source.Severity, Status = source.Status, UpdatedAt = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (AlertId, IncidentId, GeoFenceId, Title, Message, Severity, Status, PublishedByUserId, PublishedAt)
    VALUES (source.AlertId, source.IncidentId, source.GeoFenceId, source.Title, source.Message, source.Severity, source.Status, source.PublishedByUserId, SYSUTCDATETIME());
GO

MERGE dbo.PublicIssues AS target
USING (VALUES
    ('ffffffff-ffff-ffff-ffff-fffffffffff1', 'cccccccc-cccc-cccc-cccc-ccccccccccc1', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3', N'Flooded route near central bus stop', N'Verified flooding is affecting access near the central bus stop. Exact reporter identity and exact location are not public.', N'Central bus stop area, Ward 1', N'Published', N'Open', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2')
) AS source (PublicIssueId, IncidentId, AssignedDepartmentId, PublicTitle, PublicSummary, ApproximateLocationLabel, VisibilityStatus, ResolutionStatus, PublishedByUserId)
ON target.PublicIssueId = source.PublicIssueId
WHEN MATCHED THEN
    UPDATE SET VisibilityStatus = source.VisibilityStatus, ResolutionStatus = source.ResolutionStatus, UpdatedAt = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (PublicIssueId, IncidentId, AssignedDepartmentId, PublicTitle, PublicSummary, ApproximateLocationLabel, VisibilityStatus, ResolutionStatus, PublishedByUserId, PublishedAt)
    VALUES (source.PublicIssueId, source.IncidentId, source.AssignedDepartmentId, source.PublicTitle, source.PublicSummary, source.ApproximateLocationLabel, source.VisibilityStatus, source.ResolutionStatus, source.PublishedByUserId, SYSUTCDATETIME());
GO

INSERT INTO dbo.Solutions (IncidentId, DepartmentId, Title, SuggestedAction, SuggestedBy, Status)
SELECT source.IncidentId, source.DepartmentId, source.Title, source.SuggestedAction, source.SuggestedBy, source.Status
FROM (VALUES
    ('cccccccc-cccc-cccc-cccc-ccccccccccc1', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3', N'Flood route diversion', N'Post temporary route guidance and inspect drainage near the bus stop.', N'MockAI', N'Proposed'),
    ('cccccccc-cccc-cccc-cccc-ccccccccccc2', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1', N'Pothole repair triage', N'Mark the road hazard and schedule patch repair after site verification.', N'MockAI', N'Proposed'),
    ('cccccccc-cccc-cccc-cccc-ccccccccccc3', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa5', N'Lighting and patrol review', N'Review lighting coverage and coordinate a safety patrol without exposing reporter identity.', N'MockAI', N'Proposed')
) AS source (IncidentId, DepartmentId, Title, SuggestedAction, SuggestedBy, Status)
WHERE NOT EXISTS (SELECT 1 FROM dbo.Solutions existing WHERE existing.IncidentId = source.IncidentId AND existing.Title = source.Title);
GO

MERGE dbo.HelperRequests AS target
USING (VALUES
    ('99999999-9999-9999-9999-999999999991', 'cccccccc-cccc-cccc-cccc-ccccccccccc4', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb5', N'FoodWater', N'Matching', N'Flooded lane near Ward 1 community hall', CAST(18.522200 AS DECIMAL(9,6)), CAST(73.854800 AS DECIMAL(9,6)), 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb3')
) AS source (HelperRequestId, IncidentId, RequesterUserId, NeedType, Status, ApproximateLocationLabel, ApproximateLatitude, ApproximateLongitude, MatchedHelperUserId)
ON target.HelperRequestId = source.HelperRequestId
WHEN MATCHED THEN
    UPDATE SET Status = source.Status, UpdatedAt = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (HelperRequestId, IncidentId, RequesterUserId, NeedType, Status, ApproximateLocationLabel, ApproximateLatitude, ApproximateLongitude, MatchedHelperUserId)
    VALUES (source.HelperRequestId, source.IncidentId, source.RequesterUserId, source.NeedType, source.Status, source.ApproximateLocationLabel, source.ApproximateLatitude, source.ApproximateLongitude, source.MatchedHelperUserId);
GO

INSERT INTO dbo.AuditLogs (ActorUserId, ActorRole, Action, ModuleName, EntityName, EntityId, Reason, MetadataJson, IpAddressMasked)
SELECT source.ActorUserId, source.ActorRole, source.Action, source.ModuleName, source.EntityName, source.EntityId, source.Reason, source.MetadataJson, source.IpAddressMasked
FROM (VALUES
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2', N'Reviewer', N'HumanVerifiedIncident', N'Incidents', N'Incident', 'cccccccc-cccc-cccc-cccc-ccccccccccc1', N'Flood incident verified for approximate public alert.', N'{"locationPolicy":"approximate-only"}', N'10.0.0.xxx'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2', N'Moderator', N'PublishedPublicIssue', N'PublicBoard', N'PublicIssue', 'ffffffff-ffff-ffff-ffff-fffffffffff1', N'Public issue published without exact reporter location.', N'{"identityPublic":false}', N'10.0.0.xxx'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2', N'Reviewer', N'MarkedNeedsHumanReview', N'Incidents', N'Incident', 'cccccccc-cccc-cccc-cccc-ccccccccccc3', N'Sensitive unsafe-area report requires human review before public output.', N'{"sensitive":true}', N'10.0.0.xxx'),
    (NULL, N'System', N'SeedDataLoaded', N'Database', N'SeedData', NULL, N'MVP non-production seed data loaded.', N'{"script":"DB/SeedData/001_SeedMvpData.sql"}', NULL)
) AS source (ActorUserId, ActorRole, Action, ModuleName, EntityName, EntityId, Reason, MetadataJson, IpAddressMasked)
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.AuditLogs existing
    WHERE existing.Action = source.Action AND existing.EntityName = source.EntityName AND (existing.EntityId = source.EntityId OR (existing.EntityId IS NULL AND source.EntityId IS NULL))
);
GO
