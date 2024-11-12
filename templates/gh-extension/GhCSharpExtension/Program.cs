using System.Diagnostics;
using System.Reflection;
using Cocona;
using Microsoft.Extensions.DependencyInjection;

public class Program
{
    public class GhExtensionApplicationMetadataProvider : Cocona.Application.ICoconaApplicationMetadataProvider
    {
        public string GetExecutableName()
        {
            return Process.GetCurrentProcess().ProcessName.Replace("gh-", "gh ");
        }

        public string GetDescription()
        {
            var entryAssembly = Assembly.GetEntryAssembly();

            return entryAssembly?.GetCustomAttribute<AssemblyTitleAttribute>()?.Title
                   ?? string.Empty;
        }

        public string GetProductName()
        {
            var entryAssembly = Assembly.GetEntryAssembly();

            return entryAssembly?.GetCustomAttribute<AssemblyProductAttribute>()?.Product
                   ?? entryAssembly?.FullName
                   ?? string.Empty;
        }

        public string GetVersion()
        {
            var entryAssembly = Assembly.GetEntryAssembly();

            return entryAssembly?.GetCustomAttribute<AssemblyInformationalVersionAttribute>()?.InformationalVersion
                   ?? entryAssembly?.GetCustomAttribute<AssemblyVersionAttribute>()?.Version
                   ?? "1.0.0.0";
        }
    }
    
    static void Main(string[] args)
    {
        var builder = CoconaApp.CreateBuilder(args, options =>
        {
            // NOTE: Not supported because it is not possible to generate a completion that corresponds to gh completion
            // options.EnableShellCompletionSupport = true;
        });
        builder.Services.AddSingleton<Cocona.Application.ICoconaApplicationMetadataProvider,
            GhExtensionApplicationMetadataProvider>();
        var app = builder.Build();
        app.AddSubCommand("say", x =>
        {
            x.AddCommand("hello", (string name="world") => Console.WriteLine($"Hello {name}"));
            x.AddCommand("goodbye", (string name="world") => Console.WriteLine($"Goodbye {name}"));
        });
        app.Run();
    }
}
