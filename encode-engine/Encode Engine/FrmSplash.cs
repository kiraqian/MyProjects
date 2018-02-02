using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Encode_Engine
{
    public partial class FrmSplash : Form
    {
        private Timer timer;

        public FrmSplash()
        {
            InitializeComponent();
            timer = new Timer();
            timer.Interval = 2000;
            timer.Enabled = true;
            timer.Tick += new EventHandler(timer_Tick);
        }

        void timer_Tick(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
