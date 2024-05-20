using System;
using Microsoft.Extensions.Configuration;
using Npgsql;

class Program
{
    static string DB_HOST = Environment.GetEnvironmentVariable("DB_HOST") ?? "localhost";
    static string DB_PORT = Environment.GetEnvironmentVariable("DB_PORT") ?? "5432";
    static string DB_NAME = Environment.GetEnvironmentVariable("DB_NAME") ?? "database";
    static string DB_USER = Environment.GetEnvironmentVariable("DB_USER") ?? "postgres";
    static string DB_PASSWORD = Environment.GetEnvironmentVariable("DB_PASSWORD") ?? "postgres";
    static int NUM_ATTEMPTS = int.Parse(Environment.GetEnvironmentVariable("NUM_ATTEMPTS") ?? "5");

    
    static async Task Main(string[] args)
    {
        List<string> queries = new List<string>
        {
            // Get marketplaces, managed by user
            "SELECT u.username, m.name FROM users AS u " +
            "JOIN user_marketplace AS um ON u.user_id=um.user_id " +
            "JOIN marketplace AS m ON um.marketplace_id=m.marketplace_id;",
            
            // Get products, managed by user
            "SELECT u.username, p.name FROM users AS u " +
            "JOIN user_product AS up ON u.user_id=up.user_id " +
            "JOIN product AS p ON up.product_id=p.product_id;",
            
            // Get product, managed by user and marketplace where product is selling
            "SELECT u.username, p.name, m.name FROM users AS u " +
            "JOIN user_product AS up ON u.user_id=up.user_id " +
            "JOIN product AS p ON up.product_id=p.product_id " +
            "JOIN product_marketplace AS pm ON p.product_id=pm.product_id " +
            "JOIN marketplace AS m ON m.marketplace_id=pm.marketplace_id;",
            
            // Get feedback on product and customer who write this.
            "SELECT p.name, c.name, f.description, f.rating FROM product AS p " +
            "JOIN feedback AS f ON f.product_id=p.product_id " +
            "JOIN customer AS c ON c.customer_id=f.customer_id;",
            
            // Get average marks of user`s products
            "SELECT u.username, sum(f.rating)/count(f.rating) FROM users AS u " +
            "JOIN user_product AS up ON u.user_id=up.user_id " +
            "JOIN product AS p ON p.product_id=up.product_id " +
            "JOIN feedback AS f ON f.product_id=p.product_id " +
            "GROUP BY u.username;"
        };

        if (!Directory.Exists("explain_analyze_files"))
        {
            Directory.CreateDirectory("explain_analyze_files");
        }

        var queryPerformanceFilename = "explain_analyze_files/query_performance_" + DateTime.Now.ToString("yyyy_MM_dd_HH_mm_ss") + ".txt";
        
        
        using (var writer = new StreamWriter(queryPerformanceFilename))
        {
            foreach (var query in queries)
            {
                double bestCase = double.PositiveInfinity;
                double worstCase = 0;
                double totalCost = 0;

                for (int i = 0; i < NUM_ATTEMPTS; i++)
                {
                    double cost = ExecuteQuery(query);
                    totalCost += cost;
                    bestCase = Math.Min(bestCase, cost);
                    worstCase = Math.Max(worstCase, cost);
                }

                double averageCase = totalCost / NUM_ATTEMPTS;

                writer.WriteLine($"Query: {query}");
                writer.WriteLine($"Best Case Cost: {bestCase}");
                writer.WriteLine($"Worst Case Cost: {worstCase}");
                writer.WriteLine($"Average Case Cost: {averageCase}");
                writer.WriteLine();
            }
        }

    }
    
    static double ExecuteQuery(string query)
    {
        string connString = $"Host={DB_HOST};Port={DB_PORT};Username={DB_USER};Password={DB_PASSWORD};Database={DB_NAME}";
        double cost = -1;

        try
        {
            using var conn = new NpgsqlConnection(connString);
            conn.Open();
            using var cmd = new NpgsqlCommand($"EXPLAIN ANALYZE {query}", conn);
            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                var line = reader.GetString(0);
                if (line.Contains("cost="))
                {
                    Console.WriteLine(query);
                    Console.WriteLine(line);
                    string costString = line.Split("cost=")[1].Split(" ")[0].Split(".")[0] + "." +
                                        line.Split("cost=")[1].Split(" ")[0].Split(".")[1].Substring(0, 2);
                    cost = double.Parse(costString);
                    Console.WriteLine(cost);
                    break;
                }
            }

            return cost;
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return -1;
        }
    }
}