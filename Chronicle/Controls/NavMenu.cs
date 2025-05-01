using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySqlConnector;

namespace Chronicle.Controls
{
    public class NavMenu : MenuStrip
    {
        public NavMenu()
        {
            
        }

        public void populate(bool populateInChildMenu)
        {
            if (populateInChildMenu)
            {
                ToolStripMenuItem itm = new ToolStripMenuItem("Menu");
                populateMenu(itm.DropDownItems);
                this.Items.Add(itm);
            } else
            {
                populateMenu(this.Items);
            }
        }

        private NavElement? findItem(ToolStripItemCollection root, string path)
        {
            if (root == null || string.IsNullOrEmpty(path))
                return null;

            string[] parts = path.Split('/');
            ToolStripItemCollection currentCollection = root;
            ToolStripItem currentItem = null;

            foreach (string part in parts)
            {
                currentItem = null;

                foreach (ToolStripItem item in currentCollection)
                {
                    if (item.Text == part)
                    {
                        currentItem = item;
                        break;
                    }
                }

                if (currentItem == null)
                    return null;

                if (currentItem is ToolStripMenuItem menuItem)
                {
                    currentCollection = menuItem.DropDownItems;
                }
                else
                {
                    // If it's not a menu with children and we're not at the last part, fail
                    if (part != parts[^1])
                        return null;
                }
            }

            return currentItem as NavElement;
        }

        public void addHandler(string path, EventHandler e)
        {
            if (e is null) return;
            
            NavElement? n = findItem(this.Items, path);
            if (n is null) return;

            n.Click += e;
            
        }

        public static void populateMenu(ToolStripItemCollection parent)
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
                    populateMenu(item.DropDownItems, reader.GetInt32("menuItemID"));
                }
                reader.Close();
            }
        }

        public static void populateMenu(ToolStripItemCollection parent, int parentID)
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
                    populateMenu(item.DropDownItems, reader.GetInt32("menuItemID"));
                }
                reader.Close();
            }
        }
    }
}
