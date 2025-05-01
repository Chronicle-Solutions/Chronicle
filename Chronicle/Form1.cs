using MySqlConnector;
using Chronicle.Utils;

namespace Chronicle
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            // MenuUtils.populateMenu(menuStrip2.Items, "/");
            this.Text += $" [{Globals.Database}]";
            menuStrip2.addHandler("File/Exit", onExitClick);
        }

        private void onExitClick(object? sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
