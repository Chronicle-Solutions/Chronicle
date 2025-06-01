using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using MySqlConnector;

namespace Chronicle.Controls
{
    public class NavMenu : MenuStrip
    {
        private System.Windows.Forms.Timer _timer;
        private ToolStripMenuItem openWindows;
        public NavMenu()
        {
            _timer = new System.Windows.Forms.Timer();
            openWindows = new ToolStripMenuItem("Open Windows");
            _timer.Interval = 1000;
            _timer.Enabled = true;
            _timer.Tick += updateForms;
            this.MenuActivate += openMenuActions;
            this.MenuDeactivate += closeMenuActions;
        }

        private void openMenuActions(object? sender, EventArgs e)
        {
            _timer.Enabled = false;
        }

        private void closeMenuActions(object? sender, EventArgs e)
        {
            _timer.Enabled = true;
        }

        private void updateForms(object? sender, EventArgs e)
        {
            openWindows.DropDownItems.Clear();
            foreach (Form f in Application.OpenForms)
            {
                ToolStripMenuItem itm = new ToolStripMenuItem(f.Text);    
                openWindows.DropDownItems.Add(itm);

                if (this.TopLevelControl is not Form frm) continue;
                itm.Checked = frm == f;
                itm.Click += openForm;
            }
        }

        private void openForm(object? sender, EventArgs e)
        {
            if (sender is not ToolStripMenuItem itm) return;
            foreach (Form f in Application.OpenForms)
            {
                if(f.Text == itm.Text)
                {
                    f.Show();
                    f.Focus();
                    if(f.WindowState == FormWindowState.Minimized)
                        f.WindowState = FormWindowState.Normal;
                    SetForegroundWindow(f.Handle);
                }
            }
        }

        public void populate(bool populateInChildMenu)
        {
            if (populateInChildMenu)
            {
                ToolStripMenuItem itm = new ToolStripMenuItem("Menu");
                this.Items.Add(itm);
                populateMenu(itm.DropDownItems, true);
                
            } else
            {
                populateMenu(this.Items, false);
            }
            this.Items.Add(openWindows);
        }

        private static NavElement? findItem(ToolStripItemCollection root, string path)
        {
            if (root == null || string.IsNullOrEmpty(path))
                return null;

            string[] parts = path.Split('/');
            ToolStripItemCollection currentCollection = root;
            ToolStripItem? currentItem = null;

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

        public static void populateMenu(ToolStripItemCollection parent, bool isSubmenu)
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
                    bool populateInSubmenu = reader.GetBoolean("showInSubmenu");
                    if (isSubmenu && !populateInSubmenu) continue;
                    ToolStripDropDownItem item = new NavElement(reader.GetString("menuText"), reader["pluginID"] is DBNull ? null : reader.GetString("pluginID"));
                    parent.Add(item);
                    populateMenu(item.DropDownItems, reader.GetInt32("menuItemID"), isSubmenu);
                }
                reader.Close();
            }
        }

        public static void populateMenu(ToolStripItemCollection parent, int parentID, bool isSubmenu)
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
                    bool populateInSubmenu = reader.GetBoolean("showInSubmenu");
                    if (isSubmenu && !populateInSubmenu) continue;
                    ToolStripDropDownItem item = new NavElement(reader.GetString("menuText"), reader["pluginID"] is DBNull ? null : reader.GetString("pluginID"));
                    parent.Add(item);
                    populateMenu(item.DropDownItems, reader.GetInt32("menuItemID"), isSubmenu);
                }
                reader.Close();
            }
        }
        [DllImport("user32.dll")]
        static extern bool SetForegroundWindow(IntPtr hWnd);
    }
}
