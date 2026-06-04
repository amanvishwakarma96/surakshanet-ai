namespace SurakshaNet.Api.DTOs;

public sealed record IncidentResponse(
    Guid Id,
    string Title,
    string Description,
    string Category,
    string Status,
    decimal ApproximateLatitude,
    decimal ApproximateLongitude,
    bool ExactLocationConsent,
    DateTimeOffset CreatedAt);
