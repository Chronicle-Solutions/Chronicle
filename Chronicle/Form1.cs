using MySqlConnector;

namespace Chronicle
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            populateMenu(menuStrip2.Items, "/");
            this.Text += $" [{Globals.Database}]";

        }

        public static void populateMenu(ToolStripItemCollection parent, string path)
        {

            using (MySqlConnection conn = new(Globals.ConnectionString))
            {
                conn.Open();
                MySqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT DISTINCT A.* FROM MENU_ITEMS A, MENU_ITEM_ACCESS B, OPERATOR_CLASS_LINK C WHERE parentItemID is NULL AND A.menuItemID = B.menuItemID AND B.operatorClassID = C.operatorClassID AND C.operatorID = @operatorID ORDER BY sortOrder DESC";
                cmd.Parameters.AddWithValue("@operatorID", Globals.OperatorID);
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
                cmd.CommandText = "SELECT DISTINCT A.* FROM MENU_ITEMS A, MENU_ITEM_ACCESS B, OPERATOR_CLASS_LINK C WHERE parentItemID = @pID AND A.menuItemID = B.menuItemID AND B.operatorClassID = C.operatorClassID AND C.operatorID = @operatorID ORDER BY sortOrder DESC";
                cmd.Parameters.AddWithValue("@pID", parentID);
                cmd.Parameters.AddWithValue("@operatorID", Globals.OperatorID);
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
