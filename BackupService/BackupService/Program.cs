using System;
using System.Diagnostics;
using System.IO;
using System.Linq;

class Program
{
    static void Main(string[] args)
    {
        string dbHost = Environment.GetEnvironmentVariable("DB_HOST") ?? "localhost";
        string dbPort = Environment.GetEnvironmentVariable("DB_PORT") ?? "5432";
        string dbName = Environment.GetEnvironmentVariable("DB_NAME") ?? "mydatabase";
        string dbUser = Environment.GetEnvironmentVariable("DB_USER") ?? "myuser";
        string dbPassword = Environment.GetEnvironmentVariable("DB_PASSWORD") ?? "mypassword";
        string backupDir = Environment.GetEnvironmentVariable("BACKUP_DIR") ?? "/backups";
        int keepBackups = int.Parse(Environment.GetEnvironmentVariable("KEEP_BACKUPS") ?? "3");

        string currentDate = DateTime.Now.ToString("yyyyMMddHHmmss");
        string backupFile = Path.Combine(backupDir, $"backup_{currentDate}.sql");

        string pgDumpPath = "pg_dump";
        string backupCommand = $"-h {dbHost} -p {dbPort} -U {dbUser} -v -F c -f {backupFile} {dbName}";

        // From pg_dump documentation
        // -h <hostname>
        // -p <port>
        // -U <db_username>
        // -v verbose mode for more useful logs
        // -F c custom format for backup to be able to use pg_restore
        
        
        var startInfo = new ProcessStartInfo
        {
            FileName = pgDumpPath,
            Arguments = backupCommand,
            RedirectStandardOutput = true,
            RedirectStandardError = true,
            UseShellExecute = false,
            CreateNoWindow = true,
            Environment =
            {
                ["PGPASSWORD"] = dbPassword
            }
        };

        using (var process = new Process { StartInfo = startInfo })
        {
            process.Start();
            process.WaitForExit();

            string output = process.StandardOutput.ReadToEnd();
            string error = process.StandardError.ReadToEnd();

            if (process.ExitCode == 0)
            {
                Console.WriteLine($"Backup created successfully: {backupFile}");
            }
            else
            {
                Console.WriteLine($"Error creating backup: {error}");
            }
        }

        var backupFiles = Directory.GetFiles(backupDir, "backup_*.sql")
                                   .OrderByDescending(f => f)
                                   .ToList();

        if (backupFiles.Count > keepBackups)
        {
            foreach (var file in backupFiles.Skip(keepBackups))
            {
                File.Delete(file);
                Console.WriteLine($"Deleted old backup: {file}");
            }
        }
    }
}
