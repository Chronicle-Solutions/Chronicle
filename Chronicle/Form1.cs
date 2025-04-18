using MySqlConnector;

namespace Chronicle
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            populateMenu(menuStrip2.Items, "/");

        }

        public static void populateMenu(ToolStripItemCollection parent, string path)
        {

            using (MySqlConnection conn = new(Globals.ConnectionString))
            {
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT * FROM MENU_ITEMS WHERE parentItemID is NULL ORDER BY sortOrder DESC";
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ToolStripDropDownItem item = new NavElement(reader.GetString("menuText"), reader["pluginID"] is DBNull ? null : reader.GetString("pluginID"));
                    parent.Add(item);
                    populateMenu(item.DropDownItems, reader.GetInt32("menuItemID"), $"{path}/{reader.GetString("menuText")}");
                }
                reader.Close();
            }
        }

        public static void populateMenu(ToolStripItemCollection parent, int parentID, string path)
        {
            using (MySqlConnection conn = new(Globals.ConnectionString))
            {
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT * FROM MENU_ITEMS WHERE parentItemID = @pID ORDER BY sortOrder DESC";
                cmd.Parameters.AddWithValue("@pID", parentID);
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ToolStripDropDownItem item = new NavElement(reader.GetString("menuText"), reader["pluginID"] is DBNull ? null : reader.GetString("pluginID"));
                    parent.Add(item);
                    populateMenu(item.DropDownItems, reader.GetInt32("menuItemID"), $"{path}/{reader.GetString("menuText")}");
                }
                reader.Close();
            }
        }
    }
}
