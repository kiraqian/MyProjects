using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace VPing {
    public partial class FrmErrors : Form {
        public FrmErrors() {
            InitializeComponent();
        }

        public FrmErrors(List<string > lstErrors) {
            InitializeComponent();
            foreach (string error in lstErrors) {
                lbxErrors.Items.Add(error);
            }
        }
    }
}
