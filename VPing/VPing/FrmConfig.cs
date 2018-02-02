using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using VPing.Properties;

namespace VPing {
    public partial class FrmConfig : Form {
        public FrmConfig() {
            InitializeComponent();
            VPing.Properties.Settings settings = new Settings();
            txtConfigFilePath.Text = settings.ConfigFileName;
        }

        private void btnOk_Click(object sender, EventArgs e) {
            VPing.Properties.Settings settings = new Settings();
            settings.ConfigFileName = txtConfigFilePath.Text;
            settings.Save();
            this.Close();
        }

        private void btnCancel_Click(object sender, EventArgs e) {
            this.Close();
        }

        private void btnSelectFile_Click(object sender, EventArgs e) {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.InitialDirectory = Application.StartupPath;
            if(openFileDialog.ShowDialog() == DialogResult.OK) {
                txtConfigFilePath.Text = openFileDialog.SafeFileName;
            }
        }
    }
}
