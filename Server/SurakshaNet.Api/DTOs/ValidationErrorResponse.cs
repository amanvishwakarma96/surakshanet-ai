namespace SurakshaNet.Api.DTOs;

public sealed record ValidationErrorResponse(
    string Code,
    string Message,
    IReadOnlyDictionary<string, string[]> Errors);
