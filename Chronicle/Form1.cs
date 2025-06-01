using MySqlConnector;
using Chronicle.Utils;

namespace Chronicle
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            menuStrip2.populate(false);
            this.Text += $" [{Globals.Database}]";
            menuStrip2.addHandler("File/Exit", onExitClick);
            menuStrip2.addHandler("File/Change Database", changeDatabase);
        }

        private void onExitClick(object? sender, EventArgs e)
        {
            Application.Exit();
        }

        private void changeDatabase(object? sender, EventArgs e)
        {
            // Alert the user that this will close other windows.
            DialogResult res = MessageBox.Show("This will close all other windows. Are you sure you want to continue?", "Close all windows?",
                MessageBoxButtons.YesNo, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1);
            if (res == DialogResult.Yes)
            {
                Application.OpenForms
                    .OfType<Form>()
                    .Where(f => f != this)
                    .ToList()
                    .ForEach(f => f.Close());
            } else
            {
                return;
            }
                Auth a = new Auth();
            a.ShowDialog();
        }
    }
}
