namespace SurakshaNet.Api.DTOs;

public sealed record ModuleStatusResponse(
    string Name,
    string Status,
    string Note);
