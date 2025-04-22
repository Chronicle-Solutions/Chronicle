using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chronicle
{
    public class NavElement : ToolStripMenuItem
    {
        private string? pluginID;
        public NavElement(string navText, string? pluginID)
        {
            this.Text = navText;
            this.Click += openElement;
            this.pluginID = pluginID;
        }

        private void openElement(object? sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(pluginID))
            {
                Globals.PluginManager.ExecutePlugin(pluginID);
            }
        }

    }
}
