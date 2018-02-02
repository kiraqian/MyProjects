using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace VPing {
    public partial class FrmAddUrl : Form {
        private DataTable _dtURL;

        public FrmAddUrl() {
            InitializeComponent();
        }

        public FrmAddUrl(DataTable dataTable) {
            _dtURL = dataTable;
            InitializeComponent();
            dgvURL.DataSource = _dtURL;
            dgvURL.Columns[0].AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
        }

        private void btnOK_Click(object sender, EventArgs e) {
            this.Close();
        }
    }
}
