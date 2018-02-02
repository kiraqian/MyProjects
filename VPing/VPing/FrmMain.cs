using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Windows.Forms;

namespace VPing {
    public partial class FrmMain : Form, IPingView {
        #region Member
        private ListViewColumnSorter _lstColumnSorter;
        private List<string> _errorMsg;
        private MainController _mainController;
        #endregion

        #region Constructor
        public FrmMain() {
            InitializeComponent();
            _mainController = new MainController(this);

            lstResult.View = View.Details;
            lstResult.GridLines = true;
            lstResult.FullRowSelect = true;

            _lstColumnSorter = new ListViewColumnSorter();
            lstResult.ListViewItemSorter = _lstColumnSorter;
            lstResult.ColumnClick += new ColumnClickEventHandler(lstResult_ColumnClick);
            Closing += new CancelEventHandler(FrmMain_Closing);
            tslErrorMsg.Click += new EventHandler(tslErrorMsg_Click);
            label1.Visible = false;
        }
        #endregion

        #region Event handled method
        private void tslErrorMsg_Click(object sender, EventArgs e) {
            FrmErrors frmErrors = new FrmErrors(_errorMsg);
            frmErrors.ShowDialog(this);
        }

        private void lstResult_ColumnClick(object sender, ColumnClickEventArgs e) {
            _lstColumnSorter.SortColumnIndex = e.Column;
            _lstColumnSorter.IsAsc = !_lstColumnSorter.IsAsc;
            lstResult.Sort();
        }

        private void FrmMain_Closing(object sender, CancelEventArgs e) {
            _mainController.SaveSettingsAction();
        }

        private void btnPing_Click(object sender, EventArgs e) {
            _mainController.StartPing();
        }

        private void btnAddUrl_Click(object sender, EventArgs e) {
            _mainController.AddUrlAction();
        }

        private void configFileToolStripMenuItem_Click(object sender, EventArgs e) {
            _mainController.ChangeConfigFileAction();
        }

        private void copyToolStripMenuItem_Click(object sender, EventArgs e) {
            if (lstResult.SelectedItems.Count > 0) {
                Clipboard.SetText(lstResult.SelectedItems[0].Text);
            }
        }
        #endregion

        #region method
        public void UpdateResult(DataTable dataTable) {
            lstResult.Clear();
            
            foreach (DataColumn column in dataTable.Columns) {
                lstResult.Columns.Add(column.Caption);
            }

            foreach (DataRow row in dataTable.Rows) {
                ListViewItem listViewItem = new ListViewItem();
                listViewItem.Text = row["URL"].ToString();
                listViewItem.SubItems.Add(row["PingResponseTime"].ToString());
                lstResult.Items.Add(listViewItem);
            }
            lstResult.AutoResizeColumns(ColumnHeaderAutoResizeStyle.ColumnContent);
        }

        public void UpdateProgress(int value) {
            this.Invoke(new SetProValueDlg(SetProValue), value);
        }

        public void SetMaxProgress(int value) {
            tsPingProgress.Maximum = value;
        }

        private delegate void SetProValueDlg(int i);

        private void SetProValue(int value) {
            tsPingProgress.Value = value;
        }
        
        #endregion

        public void UpdateSettings() {
            throw new NotImplementedException();
        }
    }
}
