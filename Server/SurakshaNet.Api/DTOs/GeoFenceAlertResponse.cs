namespace SurakshaNet.Api.DTOs;

public sealed record GeoFenceAlertResponse(
    Guid Id,
    string Title,
    string Message,
    string Severity,
    string HazardType,
    string ApproximateAreaName,
    int RadiusMeters,
    double? DistanceMeters,
    DateTimeOffset? PublishedAt,
    DateTimeOffset? ExpiresAt,
    string PrivacyNote);
