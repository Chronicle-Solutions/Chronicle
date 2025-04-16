using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Chronicle
{
    public partial class Auth : Form
    {

        public string userid { get => txtuserID.Text; }
        public string password { get => txtUserPass.Text; }

        public string environment { get => environmentBox.Text; }
        public Auth(List<string> Environments)
        {
            InitializeComponent();
            if(Environments.Count == 0)
            {
                NewEnv e = new NewEnv();
                Environments.Add(e.getEnvironment());
            }
            environmentBox.Items.AddRange(Environments.ToArray());
            environmentBox.SelectedIndex = 0;
            if(Environments.Count == 1)
            {
                environmentBox.Hide();
                label4.Hide();
            }
        }

    }
}
