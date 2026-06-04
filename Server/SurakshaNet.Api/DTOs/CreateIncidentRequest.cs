namespace SurakshaNet.Api.DTOs;

public sealed record CreateIncidentRequest(
    string Title,
    string Description,
    string Category,
    decimal ApproximateLatitude,
    decimal ApproximateLongitude,
    bool ExactLocationConsent);
