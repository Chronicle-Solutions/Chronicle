using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chronicle.Controls
{
    public class TabbedComboBox : UserControl
    {
        private TextBox displayBox;
        private Button dropButton;
        public Form dropDownForm;
        private TabControl tabControl;
        public event EventHandler SelectedValueChanged;

        public TabbedComboBox()
        {
            // Setup display box
            displayBox = new TextBox
            {
                Dock = DockStyle.Fill,
                ReadOnly = true
            };

            // Setup dropdown button
            dropButton = new Button
            {
                Dock = DockStyle.Right,
                Width = 20,
                Text = "▼",
                FlatStyle = FlatStyle.Flat
            };
            dropButton.FlatAppearance.BorderSize = 0;
            
            dropButton.Click += DropButton_Click;

            // Add controls to this UserControl
            this.Controls.Add(displayBox);
            this.Controls.Add(dropButton);

            // Setup dropdown form
            dropDownForm = new Form
            {
                FormBorderStyle = FormBorderStyle.None,
                StartPosition = FormStartPosition.Manual,
                ShowInTaskbar = false,
                TopMost = true,
                Width = 200,
                Height = 150
            };

            // Setup TabControl
            tabControl = new TabControl
            {
                Dock = DockStyle.Fill
            };

            
            dropDownForm.Controls.Add(tabControl);
        }

        public void AddTab(string title, string colHeader, string[] items)
        {
            var listBox = new ListView { Dock = DockStyle.Fill, MultiSelect = false, View = View.Details, FullRowSelect = true };
            ColumnHeader hdr = new ColumnHeader();
            hdr.Text = colHeader;
            hdr.Width = listBox.Width * 2;
            listBox.Columns.Add(hdr);
            listBox.Items.AddRange(items.ToList<string>().ConvertAll<ListViewItem>(item => new ListViewItem(item)).ToArray());
            
            listBox.DoubleClick += (s, e) =>
            {
                if (listBox.SelectedItems.Count != 0)
                {
                    displayBox.Text = listBox.SelectedItems[0].Text;
                    dropDownForm.Hide();
                }
            };
            listBox.KeyDown += (s, e) =>
            {
                if(e.KeyCode == Keys.Enter)
                {
                    displayBox.Text = listBox.SelectedItems[0].Text;
                    dropDownForm.Hide();
                }
                if (e.KeyCode == Keys.Escape)
                {
                    dropDownForm.Hide();
                }
            };
            var tabPage = new TabPage(title);
            tabPage.Controls.Add(listBox);
            tabControl.TabPages.Add(tabPage);
            listBox.SelectedIndexChanged += new EventHandler(selectionChanged);
        }

        public void AddTab(string title, string colHeader, ListViewItem[] items)
        {
            var listBox = new ListView {Dock = DockStyle.Fill, MultiSelect=false, View=View.Details, FullRowSelect = true};
            ColumnHeader hdr = new ColumnHeader();
            hdr.Text = colHeader;
            hdr.Width = listBox.Width * 2;
            listBox.Columns.Add(hdr);

            listBox.Items.AddRange(items);
            listBox.DoubleClick += (s, e) =>
            {
                if (listBox.SelectedItems.Count != 0)
                {
                    displayBox.Text = listBox.SelectedItems[0].Text;
                    dropDownForm.Hide();
                }
            };

            var tabPage = new TabPage(title);
            tabPage.Controls.Add(listBox);
            tabControl.TabPages.Add(tabPage);
            displayBox.TextChanged += new EventHandler(selectionChanged);
        }

        private void selectionChanged(object? sender, EventArgs e)
        {
            SelectedValueChanged.Invoke(sender, e);

        }


        private void DropButton_Click(object sender, EventArgs e)
        {
            var location = this.PointToScreen(new Point(0, this.Height));
            dropDownForm.Location = location;
            dropDownForm.Width = this.Width;
            dropDownForm.Show();
            dropDownForm.BringToFront();
        }

        // Optional: Expose selected item
        public string SelectedItem => displayBox.Text;
    }
}
