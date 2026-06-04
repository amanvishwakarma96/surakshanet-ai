using System.ComponentModel.DataAnnotations;

namespace SurakshaNet.Api.DTOs;

public sealed record CreateIncidentRequest(
    [property: Required]
    [property: StringLength(160, MinimumLength = 3)]
    string Title,

    [property: Required]
    [property: StringLength(2000, MinimumLength = 10)]
    string Description,

    [property: Required]
    [property: StringLength(80, MinimumLength = 3)]
    string Category,

    [property: Range(-90, 90)]
    decimal ApproximateLatitude,

    [property: Range(-180, 180)]
    decimal ApproximateLongitude,

    bool ExactLocationConsent);
