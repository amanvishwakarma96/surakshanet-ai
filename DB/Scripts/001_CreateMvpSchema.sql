/*
    SurakshaNet AI MVP schema for SQL Server.

    Privacy defaults:
    - Approximate location fields are intended for routine matching and public output.
    - Exact coordinates are nullable and should only be populated or shared when the user has consented.
    - Sensitive actions and visibility decisions should create AuditLogs records.
*/

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'dbo.PetitionSupporters', N'U') IS NOT NULL DROP TABLE dbo.PetitionSupporters;
IF OBJECT_ID(N'dbo.Petitions', N'U') IS NOT NULL DROP TABLE dbo.Petitions;
IF OBJECT_ID(N'dbo.HelperRequests', N'U') IS NOT NULL DROP TABLE dbo.HelperRequests;
IF OBJECT_ID(N'dbo.Solutions', N'U') IS NOT NULL DROP TABLE dbo.Solutions;
IF OBJECT_ID(N'dbo.PublicIssues', N'U') IS NOT NULL DROP TABLE dbo.PublicIssues;
IF OBJECT_ID(N'dbo.Alerts', N'U') IS NOT NULL DROP TABLE dbo.Alerts;
IF OBJECT_ID(N'dbo.GeoFences', N'U') IS NOT NULL DROP TABLE dbo.GeoFences;
IF OBJECT_ID(N'dbo.IncidentVerificationLogs', N'U') IS NOT NULL DROP TABLE dbo.IncidentVerificationLogs;
IF OBJECT_ID(N'dbo.IncidentMedia', N'U') IS NOT NULL DROP TABLE dbo.IncidentMedia;
IF OBJECT_ID(N'dbo.Incidents', N'U') IS NOT NULL DROP TABLE dbo.Incidents;
IF OBJECT_ID(N'dbo.AuditLogs', N'U') IS NOT NULL DROP TABLE dbo.AuditLogs;
IF OBJECT_ID(N'dbo.UserRoles', N'U') IS NOT NULL DROP TABLE dbo.UserRoles;
IF OBJECT_ID(N'dbo.Roles', N'U') IS NOT NULL DROP TABLE dbo.Roles;
IF OBJECT_ID(N'dbo.Users', N'U') IS NOT NULL DROP TABLE dbo.Users;
IF OBJECT_ID(N'dbo.Departments', N'U') IS NOT NULL DROP TABLE dbo.Departments;
GO

CREATE TABLE dbo.Roles
(
    RoleId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Roles_RoleId DEFAULT NEWID(),
    RoleName NVARCHAR(64) NOT NULL,
    Description NVARCHAR(256) NULL,
    IsSystemRole BIT NOT NULL CONSTRAINT DF_Roles_IsSystemRole DEFAULT (0),
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_Roles_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIMEOFFSET(0) NULL,
    CONSTRAINT PK_Roles PRIMARY KEY (RoleId),
    CONSTRAINT UQ_Roles_RoleName UNIQUE (RoleName)
);
GO

CREATE TABLE dbo.Users
(
    UserId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Users_UserId DEFAULT NEWID(),
    DisplayName NVARCHAR(120) NOT NULL,
    Email NVARCHAR(256) NULL,
    PhoneNumberMasked NVARCHAR(32) NULL,
    PasswordHash NVARCHAR(512) NULL,
    IsAnonymous BIT NOT NULL CONSTRAINT DF_Users_IsAnonymous DEFAULT (0),
    IsProtectedIdentity BIT NOT NULL CONSTRAINT DF_Users_IsProtectedIdentity DEFAULT (0),
    IsActive BIT NOT NULL CONSTRAINT DF_Users_IsActive DEFAULT (1),
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_Users_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIMEOFFSET(0) NULL,
    CONSTRAINT PK_Users PRIMARY KEY (UserId),
    CONSTRAINT CK_Users_EmailOrAnonymous CHECK (Email IS NOT NULL OR IsAnonymous = 1)
);
GO

CREATE TABLE dbo.UserRoles
(
    UserId UNIQUEIDENTIFIER NOT NULL,
    RoleId UNIQUEIDENTIFIER NOT NULL,
    AssignedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_UserRoles_AssignedAt DEFAULT SYSUTCDATETIME(),
    AssignedByUserId UNIQUEIDENTIFIER NULL,
    CONSTRAINT PK_UserRoles PRIMARY KEY (UserId, RoleId),
    CONSTRAINT FK_UserRoles_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT FK_UserRoles_Roles FOREIGN KEY (RoleId) REFERENCES dbo.Roles(RoleId),
    CONSTRAINT FK_UserRoles_AssignedByUsers FOREIGN KEY (AssignedByUserId) REFERENCES dbo.Users(UserId)
);
GO

CREATE TABLE dbo.Departments
(
    DepartmentId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Departments_DepartmentId DEFAULT NEWID(),
    DepartmentName NVARCHAR(160) NOT NULL,
    ServiceArea NVARCHAR(120) NOT NULL,
    ContactChannel NVARCHAR(256) NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Departments_IsActive DEFAULT (1),
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_Departments_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIMEOFFSET(0) NULL,
    CONSTRAINT PK_Departments PRIMARY KEY (DepartmentId),
    CONSTRAINT UQ_Departments_DepartmentName UNIQUE (DepartmentName)
);
GO

CREATE TABLE dbo.Incidents
(
    IncidentId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Incidents_IncidentId DEFAULT NEWID(),
    ReporterUserId UNIQUEIDENTIFIER NULL,
    AssignedDepartmentId UNIQUEIDENTIFIER NULL,
    Title NVARCHAR(160) NOT NULL,
    Description NVARCHAR(2000) NOT NULL,
    Category NVARCHAR(64) NOT NULL,
    Severity NVARCHAR(32) NOT NULL CONSTRAINT DF_Incidents_Severity DEFAULT (N'Medium'),
    Status NVARCHAR(32) NOT NULL CONSTRAINT DF_Incidents_Status DEFAULT (N'Submitted'),
    VerificationStatus NVARCHAR(32) NOT NULL CONSTRAINT DF_Incidents_VerificationStatus DEFAULT (N'Pending'),
    IsSensitive BIT NOT NULL CONSTRAINT DF_Incidents_IsSensitive DEFAULT (0),
    IsPublicCandidate BIT NOT NULL CONSTRAINT DF_Incidents_IsPublicCandidate DEFAULT (0),
    ApproximateLatitude DECIMAL(9,6) NOT NULL,
    ApproximateLongitude DECIMAL(9,6) NOT NULL,
    ApproximateLocationLabel NVARCHAR(160) NOT NULL,
    ExactLatitude DECIMAL(9,6) NULL,
    ExactLongitude DECIMAL(9,6) NULL,
    ExactLocationConsent BIT NOT NULL CONSTRAINT DF_Incidents_ExactLocationConsent DEFAULT (0),
    ExactLocationConsentAt DATETIMEOFFSET(0) NULL,
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_Incidents_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIMEOFFSET(0) NULL,
    CONSTRAINT PK_Incidents PRIMARY KEY (IncidentId),
    CONSTRAINT FK_Incidents_ReporterUsers FOREIGN KEY (ReporterUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT FK_Incidents_Departments FOREIGN KEY (AssignedDepartmentId) REFERENCES dbo.Departments(DepartmentId),
    CONSTRAINT CK_Incidents_Category CHECK (Category IN (N'Flood', N'ElectricHazard', N'Pothole', N'RoadHazard', N'UnsafeArea', N'HelperRequest', N'CorruptionComplaint', N'Other')),
    CONSTRAINT CK_Incidents_Severity CHECK (Severity IN (N'Low', N'Medium', N'High', N'Critical')),
    CONSTRAINT CK_Incidents_Status CHECK (Status IN (N'Submitted', N'UnderReview', N'Verified', N'Rejected', N'Escalated', N'Resolved', N'Closed')),
    CONSTRAINT CK_Incidents_VerificationStatus CHECK (VerificationStatus IN (N'Pending', N'AutoScored', N'NeedsHumanReview', N'HumanVerified', N'Rejected')),
    CONSTRAINT CK_Incidents_ApproxLatitude CHECK (ApproximateLatitude BETWEEN -90 AND 90),
    CONSTRAINT CK_Incidents_ApproxLongitude CHECK (ApproximateLongitude BETWEEN -180 AND 180),
    CONSTRAINT CK_Incidents_ExactLatitude CHECK (ExactLatitude IS NULL OR ExactLatitude BETWEEN -90 AND 90),
    CONSTRAINT CK_Incidents_ExactLongitude CHECK (ExactLongitude IS NULL OR ExactLongitude BETWEEN -180 AND 180),
    CONSTRAINT CK_Incidents_ExactLocationConsent CHECK
    (
        (ExactLatitude IS NULL AND ExactLongitude IS NULL AND ExactLocationConsent = 0 AND ExactLocationConsentAt IS NULL)
        OR
        (ExactLatitude IS NOT NULL AND ExactLongitude IS NOT NULL AND ExactLocationConsent = 1 AND ExactLocationConsentAt IS NOT NULL)
    )
);
GO

CREATE TABLE dbo.IncidentMedia
(
    IncidentMediaId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_IncidentMedia_IncidentMediaId DEFAULT NEWID(),
    IncidentId UNIQUEIDENTIFIER NOT NULL,
    MediaType NVARCHAR(32) NOT NULL,
    StorageUri NVARCHAR(512) NOT NULL,
    PublicSafeUri NVARCHAR(512) NULL,
    Sha256Hash CHAR(64) NULL,
    IsSensitiveEvidence BIT NOT NULL CONSTRAINT DF_IncidentMedia_IsSensitiveEvidence DEFAULT (1),
    UploadedByUserId UNIQUEIDENTIFIER NULL,
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_IncidentMedia_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_IncidentMedia PRIMARY KEY (IncidentMediaId),
    CONSTRAINT FK_IncidentMedia_Incidents FOREIGN KEY (IncidentId) REFERENCES dbo.Incidents(IncidentId),
    CONSTRAINT FK_IncidentMedia_UploadedByUsers FOREIGN KEY (UploadedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_IncidentMedia_MediaType CHECK (MediaType IN (N'Image', N'Video', N'Audio', N'Document'))
);
GO

CREATE TABLE dbo.IncidentVerificationLogs
(
    VerificationLogId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_IncidentVerificationLogs_VerificationLogId DEFAULT NEWID(),
    IncidentId UNIQUEIDENTIFIER NOT NULL,
    ReviewerUserId UNIQUEIDENTIFIER NULL,
    VerificationType NVARCHAR(32) NOT NULL,
    Score DECIMAL(5,2) NULL,
    Status NVARCHAR(32) NOT NULL,
    Reason NVARCHAR(1000) NOT NULL,
    RequiresHumanReview BIT NOT NULL CONSTRAINT DF_IncidentVerificationLogs_RequiresHumanReview DEFAULT (1),
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_IncidentVerificationLogs_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_IncidentVerificationLogs PRIMARY KEY (VerificationLogId),
    CONSTRAINT FK_IncidentVerificationLogs_Incidents FOREIGN KEY (IncidentId) REFERENCES dbo.Incidents(IncidentId),
    CONSTRAINT FK_IncidentVerificationLogs_ReviewerUsers FOREIGN KEY (ReviewerUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_IncidentVerificationLogs_VerificationType CHECK (VerificationType IN (N'MockAI', N'HumanReview', N'DepartmentFeedback', N'ClosureProof')),
    CONSTRAINT CK_IncidentVerificationLogs_Status CHECK (Status IN (N'Pending', N'AutoScored', N'NeedsHumanReview', N'HumanVerified', N'Rejected', N'Closed')),
    CONSTRAINT CK_IncidentVerificationLogs_Score CHECK (Score IS NULL OR Score BETWEEN 0 AND 100)
);
GO

CREATE TABLE dbo.GeoFences
(
    GeoFenceId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_GeoFences_GeoFenceId DEFAULT NEWID(),
    Name NVARCHAR(160) NOT NULL,
    HazardType NVARCHAR(64) NOT NULL,
    CenterLatitude DECIMAL(9,6) NOT NULL,
    CenterLongitude DECIMAL(9,6) NOT NULL,
    RadiusMeters INT NOT NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_GeoFences_IsActive DEFAULT (1),
    CreatedByUserId UNIQUEIDENTIFIER NULL,
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_GeoFences_CreatedAt DEFAULT SYSUTCDATETIME(),
    ExpiresAt DATETIMEOFFSET(0) NULL,
    UpdatedAt DATETIMEOFFSET(0) NULL,
    CONSTRAINT PK_GeoFences PRIMARY KEY (GeoFenceId),
    CONSTRAINT FK_GeoFences_CreatedByUsers FOREIGN KEY (CreatedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_GeoFences_CenterLatitude CHECK (CenterLatitude BETWEEN -90 AND 90),
    CONSTRAINT CK_GeoFences_CenterLongitude CHECK (CenterLongitude BETWEEN -180 AND 180),
    CONSTRAINT CK_GeoFences_RadiusMeters CHECK (RadiusMeters BETWEEN 50 AND 10000)
);
GO

CREATE TABLE dbo.Alerts
(
    AlertId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Alerts_AlertId DEFAULT NEWID(),
    IncidentId UNIQUEIDENTIFIER NULL,
    GeoFenceId UNIQUEIDENTIFIER NOT NULL,
    Title NVARCHAR(160) NOT NULL,
    Message NVARCHAR(1000) NOT NULL,
    Severity NVARCHAR(32) NOT NULL,
    Status NVARCHAR(32) NOT NULL CONSTRAINT DF_Alerts_Status DEFAULT (N'Draft'),
    PublishedByUserId UNIQUEIDENTIFIER NULL,
    PublishedAt DATETIMEOFFSET(0) NULL,
    ExpiresAt DATETIMEOFFSET(0) NULL,
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_Alerts_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIMEOFFSET(0) NULL,
    CONSTRAINT PK_Alerts PRIMARY KEY (AlertId),
    CONSTRAINT FK_Alerts_Incidents FOREIGN KEY (IncidentId) REFERENCES dbo.Incidents(IncidentId),
    CONSTRAINT FK_Alerts_GeoFences FOREIGN KEY (GeoFenceId) REFERENCES dbo.GeoFences(GeoFenceId),
    CONSTRAINT FK_Alerts_PublishedByUsers FOREIGN KEY (PublishedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_Alerts_Severity CHECK (Severity IN (N'Low', N'Medium', N'High', N'Critical')),
    CONSTRAINT CK_Alerts_Status CHECK (Status IN (N'Draft', N'Published', N'Expired', N'Cancelled')),
    CONSTRAINT CK_Alerts_PublishedState CHECK ((Status <> N'Published') OR (PublishedAt IS NOT NULL AND PublishedByUserId IS NOT NULL))
);
GO

CREATE TABLE dbo.PublicIssues
(
    PublicIssueId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_PublicIssues_PublicIssueId DEFAULT NEWID(),
    IncidentId UNIQUEIDENTIFIER NOT NULL,
    AssignedDepartmentId UNIQUEIDENTIFIER NULL,
    PublicTitle NVARCHAR(160) NOT NULL,
    PublicSummary NVARCHAR(2000) NOT NULL,
    ApproximateLocationLabel NVARCHAR(160) NOT NULL,
    VisibilityStatus NVARCHAR(32) NOT NULL CONSTRAINT DF_PublicIssues_VisibilityStatus DEFAULT (N'Draft'),
    ResolutionStatus NVARCHAR(32) NOT NULL CONSTRAINT DF_PublicIssues_ResolutionStatus DEFAULT (N'Open'),
    IsArchived BIT NOT NULL CONSTRAINT DF_PublicIssues_IsArchived DEFAULT (0),
    PublishedByUserId UNIQUEIDENTIFIER NULL,
    PublishedAt DATETIMEOFFSET(0) NULL,
    ResolvedAt DATETIMEOFFSET(0) NULL,
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_PublicIssues_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIMEOFFSET(0) NULL,
    CONSTRAINT PK_PublicIssues PRIMARY KEY (PublicIssueId),
    CONSTRAINT UQ_PublicIssues_IncidentId UNIQUE (IncidentId),
    CONSTRAINT FK_PublicIssues_Incidents FOREIGN KEY (IncidentId) REFERENCES dbo.Incidents(IncidentId),
    CONSTRAINT FK_PublicIssues_Departments FOREIGN KEY (AssignedDepartmentId) REFERENCES dbo.Departments(DepartmentId),
    CONSTRAINT FK_PublicIssues_PublishedByUsers FOREIGN KEY (PublishedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_PublicIssues_VisibilityStatus CHECK (VisibilityStatus IN (N'Draft', N'Published', N'HiddenForSafety', N'Archived')),
    CONSTRAINT CK_PublicIssues_ResolutionStatus CHECK (ResolutionStatus IN (N'Open', N'InProgress', N'Resolved', N'Closed')),
    CONSTRAINT CK_PublicIssues_PublishedState CHECK ((VisibilityStatus <> N'Published') OR (PublishedAt IS NOT NULL AND PublishedByUserId IS NOT NULL))
);
GO

CREATE TABLE dbo.Solutions
(
    SolutionId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Solutions_SolutionId DEFAULT NEWID(),
    IncidentId UNIQUEIDENTIFIER NULL,
    DepartmentId UNIQUEIDENTIFIER NULL,
    Title NVARCHAR(160) NOT NULL,
    SuggestedAction NVARCHAR(2000) NOT NULL,
    SuggestedBy NVARCHAR(64) NOT NULL CONSTRAINT DF_Solutions_SuggestedBy DEFAULT (N'System'),
    Status NVARCHAR(32) NOT NULL CONSTRAINT DF_Solutions_Status DEFAULT (N'Proposed'),
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_Solutions_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIMEOFFSET(0) NULL,
    CONSTRAINT PK_Solutions PRIMARY KEY (SolutionId),
    CONSTRAINT FK_Solutions_Incidents FOREIGN KEY (IncidentId) REFERENCES dbo.Incidents(IncidentId),
    CONSTRAINT FK_Solutions_Departments FOREIGN KEY (DepartmentId) REFERENCES dbo.Departments(DepartmentId),
    CONSTRAINT CK_Solutions_Status CHECK (Status IN (N'Proposed', N'Accepted', N'Rejected', N'Completed'))
);
GO

CREATE TABLE dbo.Petitions
(
    PetitionId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Petitions_PetitionId DEFAULT NEWID(),
    PublicIssueId UNIQUEIDENTIFIER NOT NULL,
    Title NVARCHAR(160) NOT NULL,
    Summary NVARCHAR(2000) NOT NULL,
    Status NVARCHAR(32) NOT NULL CONSTRAINT DF_Petitions_Status DEFAULT (N'Draft'),
    RequiresLegalReview BIT NOT NULL CONSTRAINT DF_Petitions_RequiresLegalReview DEFAULT (1),
    CreatedByUserId UNIQUEIDENTIFIER NULL,
    PublishedAt DATETIMEOFFSET(0) NULL,
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_Petitions_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIMEOFFSET(0) NULL,
    CONSTRAINT PK_Petitions PRIMARY KEY (PetitionId),
    CONSTRAINT FK_Petitions_PublicIssues FOREIGN KEY (PublicIssueId) REFERENCES dbo.PublicIssues(PublicIssueId),
    CONSTRAINT FK_Petitions_CreatedByUsers FOREIGN KEY (CreatedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_Petitions_Status CHECK (Status IN (N'Draft', N'LegalReview', N'Published', N'Closed', N'Rejected')),
    CONSTRAINT CK_Petitions_PublishedState CHECK ((Status <> N'Published') OR (PublishedAt IS NOT NULL))
);
GO

CREATE TABLE dbo.PetitionSupporters
(
    PetitionSupporterId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_PetitionSupporters_PetitionSupporterId DEFAULT NEWID(),
    PetitionId UNIQUEIDENTIFIER NOT NULL,
    UserId UNIQUEIDENTIFIER NULL,
    DisplayNamePublic NVARCHAR(120) NULL,
    SupporterHash CHAR(64) NOT NULL,
    IsAnonymousPublicly BIT NOT NULL CONSTRAINT DF_PetitionSupporters_IsAnonymousPublicly DEFAULT (1),
    SupportedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_PetitionSupporters_SupportedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_PetitionSupporters PRIMARY KEY (PetitionSupporterId),
    CONSTRAINT FK_PetitionSupporters_Petitions FOREIGN KEY (PetitionId) REFERENCES dbo.Petitions(PetitionId),
    CONSTRAINT FK_PetitionSupporters_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT UQ_PetitionSupporters_PetitionHash UNIQUE (PetitionId, SupporterHash)
);
GO

CREATE TABLE dbo.HelperRequests
(
    HelperRequestId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_HelperRequests_HelperRequestId DEFAULT NEWID(),
    IncidentId UNIQUEIDENTIFIER NULL,
    RequesterUserId UNIQUEIDENTIFIER NULL,
    NeedType NVARCHAR(64) NOT NULL,
    Status NVARCHAR(32) NOT NULL CONSTRAINT DF_HelperRequests_Status DEFAULT (N'Open'),
    ApproximateLocationLabel NVARCHAR(160) NOT NULL,
    ApproximateLatitude DECIMAL(9,6) NOT NULL,
    ApproximateLongitude DECIMAL(9,6) NOT NULL,
    ExactLatitude DECIMAL(9,6) NULL,
    ExactLongitude DECIMAL(9,6) NULL,
    ExactLocationSharedWithConsent BIT NOT NULL CONSTRAINT DF_HelperRequests_ExactLocationSharedWithConsent DEFAULT (0),
    ExactLocationConsentAt DATETIMEOFFSET(0) NULL,
    MatchedHelperUserId UNIQUEIDENTIFIER NULL,
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_HelperRequests_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIMEOFFSET(0) NULL,
    ClosedAt DATETIMEOFFSET(0) NULL,
    CONSTRAINT PK_HelperRequests PRIMARY KEY (HelperRequestId),
    CONSTRAINT FK_HelperRequests_Incidents FOREIGN KEY (IncidentId) REFERENCES dbo.Incidents(IncidentId),
    CONSTRAINT FK_HelperRequests_RequesterUsers FOREIGN KEY (RequesterUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT FK_HelperRequests_MatchedHelperUsers FOREIGN KEY (MatchedHelperUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_HelperRequests_NeedType CHECK (NeedType IN (N'Rescue', N'Medical', N'Transport', N'FoodWater', N'Power', N'Other')),
    CONSTRAINT CK_HelperRequests_Status CHECK (Status IN (N'Open', N'Matching', N'Matched', N'ConsentShared', N'Closed', N'Cancelled')),
    CONSTRAINT CK_HelperRequests_ApproxLatitude CHECK (ApproximateLatitude BETWEEN -90 AND 90),
    CONSTRAINT CK_HelperRequests_ApproxLongitude CHECK (ApproximateLongitude BETWEEN -180 AND 180),
    CONSTRAINT CK_HelperRequests_ExactLatitude CHECK (ExactLatitude IS NULL OR ExactLatitude BETWEEN -90 AND 90),
    CONSTRAINT CK_HelperRequests_ExactLongitude CHECK (ExactLongitude IS NULL OR ExactLongitude BETWEEN -180 AND 180),
    CONSTRAINT CK_HelperRequests_ExactLocationConsent CHECK
    (
        (ExactLatitude IS NULL AND ExactLongitude IS NULL AND ExactLocationSharedWithConsent = 0 AND ExactLocationConsentAt IS NULL)
        OR
        (ExactLatitude IS NOT NULL AND ExactLongitude IS NOT NULL AND ExactLocationSharedWithConsent = 1 AND ExactLocationConsentAt IS NOT NULL AND MatchedHelperUserId IS NOT NULL)
    )
);
GO

CREATE TABLE dbo.AuditLogs
(
    AuditLogId UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_AuditLogs_AuditLogId DEFAULT NEWID(),
    ActorUserId UNIQUEIDENTIFIER NULL,
    ActorRole NVARCHAR(64) NULL,
    Action NVARCHAR(120) NOT NULL,
    ModuleName NVARCHAR(64) NOT NULL,
    EntityName NVARCHAR(120) NOT NULL,
    EntityId UNIQUEIDENTIFIER NULL,
    Reason NVARCHAR(1000) NOT NULL,
    MetadataJson NVARCHAR(MAX) NULL,
    IpAddressMasked NVARCHAR(64) NULL,
    CreatedAt DATETIMEOFFSET(0) NOT NULL CONSTRAINT DF_AuditLogs_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_AuditLogs PRIMARY KEY (AuditLogId),
    CONSTRAINT FK_AuditLogs_ActorUsers FOREIGN KEY (ActorUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_AuditLogs_MetadataJson CHECK (MetadataJson IS NULL OR ISJSON(MetadataJson) = 1)
);
GO

CREATE UNIQUE INDEX UX_Users_Email_NotNull ON dbo.Users(Email) WHERE Email IS NOT NULL;
CREATE INDEX IX_Users_IsActive ON dbo.Users(IsActive);
CREATE INDEX IX_UserRoles_RoleId ON dbo.UserRoles(RoleId);
CREATE INDEX IX_Incidents_Status_CreatedAt ON dbo.Incidents(Status, CreatedAt DESC);
CREATE INDEX IX_Incidents_Category_Status ON dbo.Incidents(Category, Status);
CREATE INDEX IX_Incidents_VerificationStatus ON dbo.Incidents(VerificationStatus);
CREATE INDEX IX_Incidents_ApproxLocation ON dbo.Incidents(ApproximateLatitude, ApproximateLongitude);
CREATE INDEX IX_IncidentMedia_IncidentId ON dbo.IncidentMedia(IncidentId);
CREATE INDEX IX_IncidentVerificationLogs_IncidentId_CreatedAt ON dbo.IncidentVerificationLogs(IncidentId, CreatedAt DESC);
CREATE INDEX IX_GeoFences_Active_Hazard ON dbo.GeoFences(IsActive, HazardType);
CREATE INDEX IX_Alerts_Status_PublishedAt ON dbo.Alerts(Status, PublishedAt DESC);
CREATE INDEX IX_PublicIssues_Visibility_Resolution ON dbo.PublicIssues(VisibilityStatus, ResolutionStatus);
CREATE INDEX IX_Solutions_IncidentId ON dbo.Solutions(IncidentId);
CREATE INDEX IX_Petitions_Status ON dbo.Petitions(Status);
CREATE INDEX IX_HelperRequests_Status_NeedType ON dbo.HelperRequests(Status, NeedType);
CREATE INDEX IX_HelperRequests_ApproxLocation ON dbo.HelperRequests(ApproximateLatitude, ApproximateLongitude);
CREATE INDEX IX_AuditLogs_Module_CreatedAt ON dbo.AuditLogs(ModuleName, CreatedAt DESC);
CREATE INDEX IX_AuditLogs_Entity ON dbo.AuditLogs(EntityName, EntityId);
GO
