using SurakshaNet.Api.DTOs;
using SurakshaNet.Api.Models;
using SurakshaNet.Api.Repositories;

namespace SurakshaNet.Api.Services;

public sealed class IncidentService(
    IIncidentRepository incidentRepository,
    IAuditLogService auditLogService) : IIncidentService
{
    public async Task<IReadOnlyList<IncidentResponse>> GetRecentAsync(CancellationToken cancellationToken)
    {
        var incidents = await incidentRepository.GetRecentAsync(cancellationToken);
        return incidents.Select(ToResponse).ToList();
    }

    public async Task<IncidentResponse?> GetByIdAsync(Guid id, CancellationToken cancellationToken)
    {
        var incident = await incidentRepository.GetByIdAsync(id, cancellationToken);
        return incident is null ? null : ToResponse(incident);
    }

    public async Task<IncidentResponse> CreateAsync(CreateIncidentRequest request, CancellationToken cancellationToken)
    {
        var incident = new Incident
        {
            Title = request.Title.Trim(),
            Description = request.Description.Trim(),
            Category = request.Category.Trim(),
            ApproximateLatitude = request.ApproximateLatitude,
            ApproximateLongitude = request.ApproximateLongitude,
            ExactLocationConsent = request.ExactLocationConsent
        };

        var created = await incidentRepository.AddAsync(incident, cancellationToken);
        await auditLogService.RecordAsync(
            actor: "Api",
            action: "IncidentCreated",
            entityName: nameof(Incident),
            entityId: created.Id,
            summary: "Incident submitted with approximate location only by default.",
            cancellationToken);

        return ToResponse(created);
    }

    private static IncidentResponse ToResponse(Incident incident)
    {
        return new IncidentResponse(
            incident.Id,
            incident.Title,
            incident.Description,
            incident.Category,
            incident.Status,
            incident.ApproximateLatitude,
            incident.ApproximateLongitude,
            incident.ExactLocationConsent,
            incident.CreatedAt);
    }
}
