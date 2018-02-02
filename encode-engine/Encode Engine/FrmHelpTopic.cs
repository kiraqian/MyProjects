using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Utility;

namespace Encode_Engine
{
    public partial class FrmHelpTopic : Form
    {
        public FrmHelpTopic()
        {
            InitializeComponent();
            Utility.File.TextFile textFile = new Utility.File.TextFile(Application.StartupPath + "\\HelpTopic.txt");
            try
            {
                rchHelpTopic.Text = textFile.ReadAllText();
            }
            catch
            {
                MessageBox.Show("Read help topic failed", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnOk_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
