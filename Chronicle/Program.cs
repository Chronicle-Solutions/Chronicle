using System.Diagnostics;
using System.Text;
using System.Xml;
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

        public static string? AuthServer { get; set; }

        public static string? OperatorID { get; set; }

        public static Version BaseAppVersion => new Version("0.0.0.1");

        public static long sessionID;
    }
    public static class Program
    {

        public static void loadConfig()
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(Path.Join(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "Chronicle", "config.xml"));
            Globals.AuthServer = doc.DocumentElement?.SelectSingleNode("auth")?.InnerText ?? "";
        }
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            loadConfig();
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration.
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Auth a = new Auth();
            DialogResult result = a.ShowDialog();
            if (result != DialogResult.OK) return;
            // Log Session Start
            logSessionStart();
            Form1 main = new Form1();
            main.FormClosed += FormClosed;
            main.Show();
            Application.ApplicationExit += new EventHandler(logSessionEnd);
            Application.Run();
        }

        static void FormClosed(object? sender, FormClosedEventArgs e)
        {
            if (sender is not Form form) return;
            // Get the current form. Remove the handler.
            form.FormClosed -= FormClosed;

            // If there are no forms open, exit the program.
            if (Application.OpenForms.Count == 0)
            {
                Application.ExitThread();
            }
            else
            {
                // Check for "stuck forms". Forms that are open but not visible.
                bool formVisible = false;
                foreach (Form frm in Application.OpenForms)
                {
                    formVisible |= frm.Visible;
                }
                // If no forms are open but a form is "stuck", exit. Otherwise, add the event handler.
                if (formVisible)
                {
                    if (Application.OpenForms[0] is not Form frm) return;
                    frm.FormClosed += new FormClosedEventHandler(FormClosed);
                } else
                {
                    Application.ExitThread();
                }
            }
        }

        static void logSessionStart()
        {
            using(MySqlConnection conn = new MySqlConnection(Globals.ConnectionString))
            {
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                // Get IP Address
                HttpClient client = new HttpClient();
                var webRequest = new HttpRequestMessage(HttpMethod.Get, $"https://api.ipify.org/");

                var response = client.Send(webRequest);
                StreamReader reader = new StreamReader(response.Content.ReadAsStream());
                string IPAddr = reader.ReadToEnd();


                cmd.CommandText = "INSERT INTO SESSIONS (operatorID, ipAddress) VALUES (@oprID, @ip);";
                cmd.Parameters.AddWithValue("@oprID", Globals.OperatorID);
                cmd.Parameters.AddWithValue("@ip", IPAddr);
                cmd.ExecuteNonQuery();
                Globals.sessionID = cmd.LastInsertedId;
            }
        }

        static void logSessionEnd(object? sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection(Globals.ConnectionString))
            {
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "UPDATE SESSIONS SET sessionCloseTime=current_timestamp WHERE sessionID = @sessionID;";
                cmd.Parameters.AddWithValue("@sessionID", Globals.sessionID);
                cmd.ExecuteNonQuery();
            }
        }
    }
}