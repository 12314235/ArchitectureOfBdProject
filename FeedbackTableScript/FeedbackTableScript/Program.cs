using Npgsql;

class Program
{
    static string DB_HOST = Environment.GetEnvironmentVariable("DB_HOST") ?? "localhost";
    static string DB_PORT = Environment.GetEnvironmentVariable("DB_PORT") ?? "5432";
    static string DB_NAME = Environment.GetEnvironmentVariable("DB_NAME") ?? "database";
    static string DB_USER = Environment.GetEnvironmentVariable("DB_USER") ?? "postgres";
    static string DB_PASSWORD = Environment.GetEnvironmentVariable("DB_PASSWORD") ?? "postgres";

    private static Dictionary<int, string> quarterName = new Dictionary<int, string>()
    {
        { 1, "first_quarter" },
        { 2, "second_quarter" },
        { 3, "third_quarter" },
        { 4, "fourth_quarter" },
    };
    
    struct QuarterBounds
    {
        private DateTime start;
        private DateTime end;

        public QuarterBounds(DateTime start, DateTime end)
        {
            this.start = start;
            this.end = end;
        }

        public DateTime Start => start;
        public DateTime End => end;
    }

    static async Task Main(string[] args)
    {
        if (DateTime.Now.Day == 1)
        {
            string connectionString =
                $"Host={DB_HOST};Port={DB_PORT};Username={DB_USER};Password={DB_PASSWORD};Database={DB_NAME}";
            
            int currentQuarter = (DateTime.Now.Month - 1) / 3 + 1;
            int currentYear = DateTime.Now.Year;
            
            DateTime quarterStart = new DateTime(currentYear, (currentQuarter - 1) * 3 + 1, 1);
            DateTime quarterEnd = quarterStart.AddMonths(3);

            string participantName = $"feedback_y{currentYear}_{quarterName[currentQuarter]}";

            string existsQuery =
                $"SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = '{participantName}')";

            string createQuery = $"CREATE TABLE IF NOT EXISTS {participantName} PARTITION OF feedback FOR VALUES ('{{quarterStart:yyyy-MM-dd}}') TO ('{{quarterEnd:yyyy-MM-dd}}');";

            string oldestPartitionQuery = "SELECT table_name FROM information_schema.partitions WHERE partition_name = (SELECT MIN(partition_name) FROM information_schema.partitions WHERE table_name = 'feedback');";
            
            try
            {
                using (var connection = new NpgsqlConnection(connectionString))
                {
                    connection.Open();

                    using (var cmd = new NpgsqlCommand(existsQuery, connection))
                    {
                        bool exists = (bool)cmd.ExecuteScalar();

                        if (exists)
                        {
                            Console.WriteLine($"{participantName} already exists");
                            return;
                        }
                    }

                    using (var cmd = new NpgsqlCommand(createQuery, connection))
                    {
                        var result = cmd.ExecuteNonQuery();
                        Console.WriteLine($"{participantName} created.");
                    }

                    using (var cmd = new NpgsqlCommand($"CREATE INDEX ON {participantName}(feedback_date);"))
                    {
                        cmd.ExecuteNonQuery();
                    }

                    using (var cmd = new NpgsqlCommand(oldestPartitionQuery, connection))
                    {
                        string oldestPartitionName = (string)cmd.ExecuteScalar();

                        using (var command = new NpgsqlCommand($"DROP TABLE {oldestPartitionName};", connection))
                        {
                            command.ExecuteNonQuery();
                            Console.WriteLine($"{oldestPartitionName} deleted.");
                        }
                    }
                    
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
    }
}