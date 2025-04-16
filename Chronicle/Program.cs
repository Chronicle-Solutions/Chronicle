using System.Diagnostics;
using MySqlConnector;

namespace Chronicle
{
    public static class Globals
    {
        public static PluginManager PluginManager = new();
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
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            List<string> envs = new List<string>();
            //envs.Add("ES1DEV");
            //envs.Add("ES1TST");
            Auth a = new Auth(envs);
            DialogResult result = a.ShowDialog();
            if (result != DialogResult.OK) return;


            Form1 main = new Form1();
            main.FormClosed += FormClosed;
            main.Show();
            Application.Run();
        }

        static void FormClosed(object sender, FormClosedEventArgs e)
        {
            ((Form)sender).FormClosed -= FormClosed;
            if (Application.OpenForms.Count == 0) Application.ExitThread();
            else Application.OpenForms[0].FormClosed += FormClosed;
        }
    }
}