using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Utility.SqlUtil;
using DBDependence.Properties;

namespace DBDependence
{
    public partial class FrmDBDep : Form
    {
        private string _connString = "";
        private string _sourcePath = "";
        private string _targetPath = "";
        private string _fileToProcess = "";
        private List<string> _dependences;
        private Settings _setting = new Settings();
        private DataTable _dtDep = new DataTable();

        public FrmDBDep()
        {
            InitializeComponent();
            _dependences = new List<string>();
            _dtDep.Columns.Add("Dependence");
            dgvDep.DataSource = _dtDep;
            txtConnString.Text = _setting.ConnString;
            txtSourcePath.Text = _setting.SourcePath;
            txtTargetPath.Text = _setting.TargetPath;
            txtFiletoProcess.Text = _setting.FileToProcess;
        }

        private void btnProcess_Click(object sender, EventArgs e)
        {
            string errMsg = "";
            List<string> funAndSPList = new List<string>();
            LoadInput();
            if(!ValidateInput(_connString, _sourcePath, _targetPath, _fileToProcess))
            {
                return;
            }
            _dtDep.Clear();
            _dependences.Clear();

            try
            {
                funAndSPList = SqlUtility.GetAllSPAndFunNameInDB(_connString, out errMsg);
                SqlUtility.ProcessDBDependence(funAndSPList, _fileToProcess, _sourcePath, _targetPath, _dependences);
                foreach(string dep in _dependences)
                {
                    _dtDep.Rows.Add(dep);
                }
                MessageBox.Show("Finished!");
            }
            catch (Exception exp)
            {
                MessageBox.Show(exp.Message);
            }
        }

        private void LoadInput()
        {
            _connString = txtConnString.Text;
            _sourcePath = txtSourcePath.Text;
            _targetPath = txtTargetPath.Text;
            _fileToProcess = txtFiletoProcess.Text;
        }

        private bool ValidateInput(string connString, string sourcePath, string targetPath, string fileToProcess)
        {
            if (string.IsNullOrEmpty(connString))
            {
                MessageBox.Show("Please input DB connection string!");
                return false;
            }

            if (string.IsNullOrEmpty(sourcePath))
            {
                MessageBox.Show("Please input source path!");
                return false;
            }

            if (string.IsNullOrEmpty(targetPath))
            {
                MessageBox.Show("Please input target path!");
                return false;
            }

            if (string.IsNullOrEmpty(fileToProcess))
            {
                MessageBox.Show("Please input the full name of the file to be process!");
                return false;
            }
            return true;
        }

        private void FrmDBDep_FormClosing(object sender, FormClosingEventArgs e)
        {
            _setting.ConnString = txtConnString.Text;
            _setting.SourcePath = txtSourcePath.Text;
            _setting.TargetPath = txtTargetPath.Text;
            _setting.FileToProcess = txtFiletoProcess.Text;
            _setting.Save();
        }
    }
}
