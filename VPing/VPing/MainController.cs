using System;
using System.Data;
using System.Net.NetworkInformation;
using System.Threading;
using System.Windows.Forms;
using VPing.Properties;
using System.IO;

namespace VPing {
    public class MainController {
        private IPingView _mainForm;
        private DataTable _dtURL;
        private DataTable _dtView;
        private int _globalCount;
        private int _urlCount;
        private object _syncRoot = new object();

        public MainController(IPingView mainForm) {
            _mainForm = mainForm;
            _dtURL = new DataTable("tblURL");
            _dtURL.Columns.Add("URL");
            try {
                Settings settings = new Settings();
                LoadData(settings.ConfigFileName, _dtURL);
            } catch (Exception exp) {
                MessageBox.Show("Load data failed. " + exp.Message);
            }

            _dtView = new DataTable("dtView");
            _dtView.Columns.Add("URL");
            _dtView.Columns["URL"].Caption = "URL";
            _dtView.Columns.Add("PingResponseTime");
            _dtView.Columns["PingResponseTime"].Caption = "Response Time";
        }

        public void StartPing() {
            int i = 0;
            _globalCount = _dtURL.Rows.Count;
            _urlCount = _globalCount;
            _mainForm.SetMaxProgress(_urlCount);
            foreach (DataRow row in _dtURL.Rows) {
                string url = row["URL"].ToString();
                try {
                    Thread thPing = new Thread(RunPing);
                    thPing.Start(url);
                } catch (Exception exp) {
                    
                }
            }
            while (_globalCount > 0) {
                
            }
            _mainForm.UpdateResult(_dtView);
        }

        public void RunPing(Object Url) {
            long pingResTime = GetPingResponseTime(Url.ToString());
            string pingResTimeText = pingResTime == 0 ? "Timeout" : pingResTime.ToString();
            _dtView.Rows.Add(Url.ToString(), pingResTimeText);
            lock (_syncRoot) {
                _globalCount--;
            }
            _mainForm.UpdateProgress(_urlCount - _globalCount);
        }

        private long GetPingResponseTime(string URL) {
            try {
                Ping ping = new Ping();
                PingReply pingReply = ping.Send(URL);
                if (pingReply != null) {
                    int tryCount = 0;
                    while (pingReply.RoundtripTime == 0 && tryCount < 4) {
                        ping.Send(URL);
                        tryCount++;
                    }
                    return pingReply.RoundtripTime;
                } else {
                    return 0;
                }
            } catch (Exception) {
                return 0;
            }
        }

        private void LoadData(string dataFileName, DataTable dataTable) {
            if (dataFileName != string.Empty && File.Exists(Application.StartupPath + "\\" + dataFileName)) {
                dataTable.Rows.Clear();
                dataTable.ReadXml(Application.StartupPath + "\\" + dataFileName);
            }
        }

        public void AddUrlAction() {
            FrmAddUrl frmAddUrl = new FrmAddUrl(_dtURL);
            frmAddUrl.ShowDialog();
        }

        public void ChangeConfigFileAction() {
            FrmConfig frmConfig = new FrmConfig();
            frmConfig.ShowDialog();
            Settings settings = new Settings();
            LoadData(settings.ConfigFileName, _dtURL);
        }

        public void SaveSettingsAction() {
            Settings settings = new Settings();
            try {
                _dtURL.WriteXml(Application.StartupPath + "\\" + settings.ConfigFileName);
            } catch (Exception exp) {
                MessageBox.Show("Save config failed. " + exp.Message);
            }
        }
    }
}
