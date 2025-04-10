using MySqlConnector;

namespace Chronicle
{

    public static class Globals
    {
        public static PluginManager PluginManager;
        private static MySqlConnectionStringBuilder connStringBuilder = new();
        public static string Username { get => connStringBuilder.UserID; set => connStringBuilder.UserID = value; }
        public static string Password { get => connStringBuilder.Password; set => connStringBuilder.Password = value; }
        public static string Host { get => connStringBuilder.Server; set => connStringBuilder.Server = value; }
        public static string Database { get => connStringBuilder.Database; set => connStringBuilder.Database = value; }
        public static uint Port { get => connStringBuilder.Port; set => connStringBuilder.Port = value; }

        public static string ConnectionString { get => connStringBuilder.ConnectionString; }

        public static Version BaseAppVersion => new Version("0.0.0.1");
    }
    public static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration.
            ApplicationConfiguration.Initialize();
            Globals.PluginManager = new();
            Application.Run(new Form1());
        }
    }
}