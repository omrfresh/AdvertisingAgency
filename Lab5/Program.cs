//using Lab4.Data;
//using Lab4.Infrastructure;
//using Lab4.Middleware;
//using Lab4.Services;
//using Microsoft.AspNetCore.Builder;
//using Microsoft.EntityFrameworkCore;
//using Microsoft.Extensions.DependencyInjection;
//using Microsoft.Extensions.Hosting;
//using Microsoft.Extensions.Logging;
//using Microsoft.AspNetCore.Identity;

//namespace Lab4
//{
//    public class Program
//    {
//        public static void Main(string[] args)
//        {
//            var builder = WebApplication.CreateBuilder(args);
//            var services = builder.Services;

//            // ��������� ����������� ��� ������� � �� � �������������� EF
//            string connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
//            services.AddDbContext<AdvertisingDbContext>(options => options.UseSqlServer(connectionString));

//            // ���������� �����������
//            services.AddMemoryCache();

//            // ���������� ��������� ������
//            services.AddDistributedMemoryCache();
//            services.AddSession(options =>
//            {
//                options.IdleTimeout = TimeSpan.FromMinutes(30);
//                options.Cookie.HttpOnly = true;
//                options.Cookie.IsEssential = true;
//            });

//            // ��������� ASP.NET Core Identity
//            services.AddIdentity<IdentityUser, IdentityRole>()
//                .AddEntityFrameworkStores<AdvertisingDbContext>()
//                .AddDefaultTokenProviders();

//            // ����������� ��������
//            services.AddTransient<IOperationService, OperationService>();

//            // ������������� MVC
//            services.AddControllersWithViews();

//            var app = builder.Build();

//            if (app.Environment.IsDevelopment())
//            {
//                app.UseDeveloperExceptionPage();
//            }
//            else
//            {
//                app.UseExceptionHandler("/Home/Error");
//                app.UseHsts();
//            }

//            // ��������� ��������� ����������� ������
//            app.UseStaticFiles();

//            // ��������� ��������� ������
//            app.UseSession();

//            // ��������� ��������� middleware �� ������������� ���� ������ � ���������� ������������� ����
//            app.UseDbInitializer();

//            // ��������� ��������� middleware ��� ���������� ����������� � ��������� ������ � ���
//            app.UseOperatinCache("Operations 10");

//            // �������������
//            app.UseRouting();

//            // ������������� ������������� ��������� � �������������
//            app.UseAuthorization();

//            app.MapControllerRoute(
//                name: "default",
//                pattern: "{controller=Home}/{action=Index}/{id?}");

//            app.MapControllerRoute(
//                name: "privacy",
//                pattern: "{controller=Home}/{action=Privacy}/{id?}");

//            // ��������� �������� ��� ���������� ������
//            app.MapControllerRoute(
//                name: "additionalServices",
//                pattern: "AdditionalServices/{action=Index}/{id?}",
//                defaults: new { controller = "AdditionalServices" });

//            app.MapControllerRoute(
//                name: "adTypes",
//                pattern: "AdTypes/{action=Index}/{id?}",
//                defaults: new { controller = "AdTypes" });

//            app.MapControllerRoute(
//                name: "clients",
//                pattern: "Clients/{action=Index}/{id?}",
//                defaults: new { controller = "Clients" });

//            app.MapControllerRoute(
//                name: "employees",
//                pattern: "Employees/{action=Index}/{id?}",
//                defaults: new { controller = "Employees" });

//            app.MapControllerRoute(
//                name: "locations",
//                pattern: "Locations/{action=Index}/{id?}",
//                defaults: new { controller = "Locations" });

//            app.MapControllerRoute(
//                name: "orders",
//                pattern: "Orders/{action=Index}/{id?}",
//                defaults: new { controller = "Orders" });

//            app.MapControllerRoute(
//                name: "orderServices",
//                pattern: "OrderServices/{action=Index}/{id?}",
//                defaults: new { controller = "OrderServices" });

//            app.Run();
//        }
//    }
//}
using Lab4.Data;
using Lab4.Middleware;
using Lab4.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Lab4
{
    public class Program
    {
        public static async Task Main(string[] args) // �������� �� async Task
        {
            var builder = WebApplication.CreateBuilder(args);
            var services = builder.Services;

            // ��������� ����������� ��� ������� � �� � �������������� EF
            string connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
            services.AddDbContext<AdvertisingDbContext>(options => options.UseSqlServer(connectionString));

            // ���������� �����������
            services.AddMemoryCache();

            // ���������� ��������� ������
            services.AddDistributedMemoryCache();
            services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(30);
                options.Cookie.HttpOnly = true;
                options.Cookie.IsEssential = true;
            });

            // ��������� ASP.NET Core Identity
            services.AddIdentity<IdentityUser, IdentityRole>(options =>
            {
                options.Password.RequireDigit = true;
                options.Password.RequireLowercase = true;
                options.Password.RequireNonAlphanumeric = false;
                options.Password.RequireUppercase = true;
                options.Password.RequiredLength = 6;
                options.Lockout.AllowedForNewUsers = true;
                options.Lockout.MaxFailedAccessAttempts = 5;
                options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
                options.SignIn.RequireConfirmedAccount = false; // ����� ��� ������������
            })
            .AddEntityFrameworkStores<AdvertisingDbContext>()
            .AddDefaultTokenProviders();

            // ����������� ��������
            services.AddTransient<IOperationService, OperationService>();

            // ������������� MVC
            services.AddControllersWithViews();

            var app = builder.Build();

            // ������������� ����� � ��������������
            using (var scope = app.Services.CreateScope())
            {
                var scopedServices = scope.ServiceProvider; // ����������� ����������
                try
                {
                    await SeedData.Initialize(scopedServices);
                }
                catch (Exception ex)
                {
                    var logger = scopedServices.GetRequiredService<ILogger<Program>>();
                    logger.LogError(ex, "������ ������������� ���� ������");
                }
            }

            if (app.Environment.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }

            // ��������� ��������� ����������� ������
            app.UseStaticFiles();

            // ��������� ��������� ������
            app.UseSession();

            // ��������� ��������� middleware �� ������������� ���� ������
            app.UseDbInitializer();

            // ��������� ��������� middleware ��� ���������� �����������
            app.UseOperatinCache("Operations 10");

            // �������������
            app.UseRouting();

            // ��������� �������������� � �����������
            app.UseAuthentication();
            app.UseAuthorization();

            // ������������� ������������� ��������� � �������������
            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{id?}");


            app.MapControllerRoute(
                name: "additionalServices",
                pattern: "AdditionalServices/{action=Index}/{id?}",
                defaults: new { controller = "AdditionalServices" });

            app.MapControllerRoute(
                name: "adTypes",
                pattern: "AdTypes/{action=Index}/{id?}",
                defaults: new { controller = "AdTypes" });

            app.MapControllerRoute(
                name: "clients",
                pattern: "Clients/{action=Index}/{id?}",
                defaults: new { controller = "Clients" });

            app.MapControllerRoute(
                name: "employees",
                pattern: "Employees/{action=Index}/{id?}",
                defaults: new { controller = "Employees" });

            app.MapControllerRoute(
                name: "locations",
                pattern: "Locations/{action=Index}/{id?}",
                defaults: new { controller = "Locations" });

            app.MapControllerRoute(
                name: "orders",
                pattern: "Orders/{action=Index}/{id?}",
                defaults: new { controller = "Orders" });

            app.MapControllerRoute(
                name: "orderServices",
                pattern: "OrderServices/{action=Index}/{id?}",
                defaults: new { controller = "OrderServices" });

            app.MapControllerRoute(
                name: "admin",
                pattern: "Admin/{action=Index}/{id?}",
            defaults: new { controller = "Admin" });

            app.Run();
        }
    }
}