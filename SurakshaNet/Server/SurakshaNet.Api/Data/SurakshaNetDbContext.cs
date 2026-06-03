using Microsoft.EntityFrameworkCore;
using SurakshaNet.Api.Entities;

namespace SurakshaNet.Api.Data;

public class SurakshaNetDbContext(DbContextOptions<SurakshaNetDbContext> options) : DbContext(options)
{
    public DbSet<User> Users => Set<User>();
    public DbSet<Role> Roles => Set<Role>();
    public DbSet<UserRole> UserRoles => Set<UserRole>();
    public DbSet<Incident> Incidents => Set<Incident>();
    public DbSet<IncidentMedia> IncidentMedia => Set<IncidentMedia>();
    public DbSet<IncidentVerificationLog> IncidentVerificationLogs => Set<IncidentVerificationLog>();
    public DbSet<Department> Departments => Set<Department>();
    public DbSet<GeoFence> GeoFences => Set<GeoFence>();
    public DbSet<Alert> Alerts => Set<Alert>();
    public DbSet<PublicIssue> PublicIssues => Set<PublicIssue>();
    public DbSet<Solution> Solutions => Set<Solution>();
    public DbSet<Petition> Petitions => Set<Petition>();
    public DbSet<PetitionSupporter> PetitionSupporters => Set<PetitionSupporter>();
    public DbSet<HelperRequest> HelperRequests => Set<HelperRequest>();
    public DbSet<AuditLog> AuditLogs => Set<AuditLog>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<User>().HasIndex(u => u.Email).IsUnique();
        modelBuilder.Entity<Role>().HasIndex(r => r.Name).IsUnique();
        modelBuilder.Entity<UserRole>().HasKey(ur => new { ur.UserId, ur.RoleId });
        modelBuilder.Entity<Incident>().Property(i => i.Latitude).HasPrecision(9, 6);
        modelBuilder.Entity<Incident>().Property(i => i.Longitude).HasPrecision(9, 6);
        modelBuilder.Entity<GeoFence>().Property(g => g.Latitude).HasPrecision(9, 6);
        modelBuilder.Entity<GeoFence>().Property(g => g.Longitude).HasPrecision(9, 6);
        modelBuilder.Entity<HelperRequest>().Property(h => h.ApproxLatitude).HasPrecision(9, 6);
        modelBuilder.Entity<HelperRequest>().Property(h => h.ApproxLongitude).HasPrecision(9, 6);

        modelBuilder.Entity<Role>().HasData(new Role { Id = 1, Name = "Admin" }, new Role { Id = 2, Name = "Citizen" }, new Role { Id = 3, Name = "Verifier" });
        modelBuilder.Entity<Department>().HasData(
            new Department { Id = 1, Name = "Police", DepartmentType = "Emergency", ContactEmail = "police@example.local" },
            new Department { Id = 2, Name = "Ambulance", DepartmentType = "Medical", ContactEmail = "ambulance@example.local" },
            new Department { Id = 3, Name = "Fire Department", DepartmentType = "Fire", ContactEmail = "fire@example.local" },
            new Department { Id = 4, Name = "Municipal Roads", DepartmentType = "Roads", ContactEmail = "roads@example.local" },
            new Department { Id = 5, Name = "Drainage Department", DepartmentType = "Drainage", ContactEmail = "drainage@example.local" },
            new Department { Id = 6, Name = "Electricity Board", DepartmentType = "Electricity", ContactEmail = "electricity@example.local" },
            new Department { Id = 7, Name = "Women Safety Cell", DepartmentType = "Safety", ContactEmail = "women-safety@example.local" },
            new Department { Id = 8, Name = "Vigilance Department", DepartmentType = "Vigilance", ContactEmail = "vigilance@example.local" });
    }
}
