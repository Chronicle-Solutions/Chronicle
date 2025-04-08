using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySqlConnector;

namespace Chronicle
{
    public partial class BaseForm : Form
    {
        int formID;
        public BaseForm(int formID)
        {
            InitializeComponent();
            this.formID = formID;
            this.getFormControls();
        }



        public void getFormControls()
        {
            MySqlConnectionStringBuilder cSb = new MySqlConnectionStringBuilder();
            cSb.UserID = "es1dev";
            cSb.Password = "Password";
            cSb.Database = "ES1DEV";
            cSb.Server = "db.maria.adasneves.info";
            MySqlConnection conn = new(cSb.ConnectionString);
            conn.Open();
            this.SuspendLayout();
            MySqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT * FROM FORMS WHERE formID = @fID";
            cmd.Parameters.AddWithValue("@fID", formID);
            MySqlDataReader reader = cmd.ExecuteReader();
            if (!reader.Read())
            {
                throw new Exception("Could not load form data.");
            }

            this.Text = reader.GetString("formName");
            reader.Close();

            cmd.CommandText = "SELECT * FROM FORM_CONTROLS WHERE formID = @fID";
            reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                Control ctrl;
                switch (reader.GetInt32("controlType"))
                {
                    case 1:
                        ctrl = new Button();
                        break;

                    default:
                        throw new Exception("Element Type not valid.");
                }
                ctrl.Location = new Point(reader.GetInt32("posX"), reader.GetInt32("posY"));
                ctrl.Text = reader.GetString("ctrlText");
                ctrl.Name = reader.GetString("ctrlName");
                this.Controls.Add(ctrl);
            }

            this.ResumeLayout(false);
            conn.Close();
        }
    }
}
