using Microsoft.EntityFrameworkCore;

namespace ECommerceApp.Infrastructure;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) { }
}