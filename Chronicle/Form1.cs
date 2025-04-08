using MySqlConnector;

namespace Chronicle
{
    public partial class Form1 : Form
    {
        MySqlConnectionStringBuilder cSb;
        public Form1()
        {
            cSb = new MySqlConnectionStringBuilder();
            cSb.UserID = "es1dev";
            cSb.Password = "Password";
            cSb.Database = "ES1DEV";
            cSb.Server = "db.maria.adasneves.info";
            InitializeComponent();
            populateMenu(menuStrip2.Items);

        }

        public void populateMenu(ToolStripItemCollection parent)
        {
            
            using (MySqlConnection conn = new(cSb.ConnectionString))
            {
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT * FROM MENU_ITEMS WHERE parentItemID is NULL ORDER BY sortOrder DESC";
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ToolStripDropDownItem item = new ToolStripMenuItem(reader.GetString("menuText"));
                    parent.Add(item);
                    populateMenu(item.DropDownItems, reader.GetInt32("menuItemID"));
                }
                reader.Close();
            }
        }

        public void populateMenu(ToolStripItemCollection parent, int parentID)
        {
            using (MySqlConnection conn = new(cSb.ConnectionString))
            {
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT * FROM MENU_ITEMS WHERE parentItemID = @pID ORDER BY sortOrder DESC";
                cmd.Parameters.AddWithValue("@pID", parentID);
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ToolStripDropDownItem item = new ToolStripMenuItem(reader.GetString("menuText"));
                    parent.Add(item);
                    populateMenu(item.DropDownItems, reader.GetInt32("menuItemID"));
                }
                reader.Close();
            }
        }


        private void fileToolStripMenuItem_Click(object sender, EventArgs e)
        {
            
        }
    }
}
