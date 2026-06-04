using Microsoft.EntityFrameworkCore;
using SurakshaNet.Api.Models;

namespace SurakshaNet.Api.Data;

public sealed class SurakshaNetDbContext(DbContextOptions<SurakshaNetDbContext> options) : DbContext(options)
{
    public DbSet<User> Users => Set<User>();

    public DbSet<Incident> Incidents => Set<Incident>();

    public DbSet<GeoFence> GeoFences => Set<GeoFence>();

    public DbSet<Alert> Alerts => Set<Alert>();

    public DbSet<PublicBoardRecord> PublicBoardRecords => Set<PublicBoardRecord>();

    public DbSet<SolutionSuggestion> SolutionSuggestions => Set<SolutionSuggestion>();

    public DbSet<HelperRequest> HelperRequests => Set<HelperRequest>();

    public DbSet<AuditLog> AuditLogs => Set<AuditLog>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<User>(entity =>
        {
            entity.Property(user => user.DisplayName).HasMaxLength(120).IsRequired();
            entity.Property(user => user.Email).HasMaxLength(256).IsRequired();
            entity.Property(user => user.Role).HasMaxLength(50).IsRequired();
            entity.HasIndex(user => user.Email).IsUnique();
        });

        modelBuilder.Entity<Incident>(entity =>
        {
            entity.Property(incident => incident.Title).HasMaxLength(160).IsRequired();
            entity.Property(incident => incident.Description).HasMaxLength(2000).IsRequired();
            entity.Property(incident => incident.Category).HasMaxLength(80).IsRequired();
            entity.Property(incident => incident.Status).HasMaxLength(50).IsRequired();
            entity.Property(incident => incident.ApproximateLatitude).HasPrecision(9, 6);
            entity.Property(incident => incident.ApproximateLongitude).HasPrecision(9, 6);
        });

        modelBuilder.Entity<GeoFence>(entity =>
        {
            entity.Property(geoFence => geoFence.Name).HasMaxLength(160).IsRequired();
            entity.Property(geoFence => geoFence.HazardType).HasMaxLength(80).IsRequired();
            entity.Property(geoFence => geoFence.CenterLatitude).HasPrecision(9, 6);
            entity.Property(geoFence => geoFence.CenterLongitude).HasPrecision(9, 6);
            entity.HasMany<Alert>()
                .WithOne(alert => alert.GeoFence)
                .HasForeignKey(alert => alert.GeoFenceId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<Alert>(entity =>
        {
            entity.Property(alert => alert.Title).HasMaxLength(160).IsRequired();
            entity.Property(alert => alert.Message).HasMaxLength(1000).IsRequired();
            entity.Property(alert => alert.Severity).HasMaxLength(32).IsRequired();
            entity.Property(alert => alert.Status).HasMaxLength(32).IsRequired();
            entity.HasOne(alert => alert.Incident)
                .WithMany()
                .HasForeignKey(alert => alert.IncidentId)
                .OnDelete(DeleteBehavior.Restrict);
            entity.HasOne(alert => alert.PublishedBy)
                .WithMany()
                .HasForeignKey(alert => alert.PublishedByUserId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<PublicBoardRecord>(entity =>
        {
            entity.Property(record => record.PublicSummary).HasMaxLength(2000).IsRequired();
            entity.Property(record => record.VisibilityStatus).HasMaxLength(50).IsRequired();
        });

        modelBuilder.Entity<SolutionSuggestion>(entity =>
        {
            entity.Property(solution => solution.SuggestedAction).HasMaxLength(2000).IsRequired();
            entity.Property(solution => solution.SuggestedBy).HasMaxLength(120).IsRequired();
            entity.Property(solution => solution.Status).HasMaxLength(50).IsRequired();
        });

        modelBuilder.Entity<HelperRequest>(entity =>
        {
            entity.Property(request => request.NeedType).HasMaxLength(100).IsRequired();
            entity.Property(request => request.Status).HasMaxLength(50).IsRequired();
            entity.Property(request => request.ApproximateLocationLabel).HasMaxLength(240).IsRequired();
        });

        modelBuilder.Entity<AuditLog>(entity =>
        {
            entity.Property(log => log.Actor).HasMaxLength(120).IsRequired();
            entity.Property(log => log.Action).HasMaxLength(120).IsRequired();
            entity.Property(log => log.EntityName).HasMaxLength(120).IsRequired();
            entity.Property(log => log.Summary).HasMaxLength(1000).IsRequired();
        });
    }
}
