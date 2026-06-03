using Microsoft.EntityFrameworkCore;
using SurakshaNet.Api.Data;

namespace SurakshaNet.Api.Repositories;

public interface IRepository<T> where T : class
{
    IQueryable<T> Query();
    Task<T?> GetByIdAsync(int id);
    Task<T> AddAsync(T entity);
    Task SaveChangesAsync();
}

public class EfRepository<T>(SurakshaNetDbContext db) : IRepository<T> where T : class
{
    public IQueryable<T> Query() => db.Set<T>().AsQueryable();
    public async Task<T?> GetByIdAsync(int id) => await db.Set<T>().FindAsync(id);
    public async Task<T> AddAsync(T entity) { db.Set<T>().Add(entity); await db.SaveChangesAsync(); return entity; }
    public Task SaveChangesAsync() => db.SaveChangesAsync();
}
