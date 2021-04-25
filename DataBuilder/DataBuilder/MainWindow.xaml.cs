using System;
using System.Data.SqlClient;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Data;
using System.Xml;

namespace DataBuilder
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private string connString;
        private DataTable tableData;
        private DataTable tableEdit;

        public MainWindow()
        {
            InitializeComponent();
            tableData = new DataTable();
            tableEdit = new DataTable();
            tableEdit.Columns.Add("Column");
            tableEdit.Columns.Add("Value");
            dgEditColumns.ItemsSource = tableEdit.DefaultView;

            string server;
            string dbName;
            string userId;
            string password;
            bool trustedConnection;
            GetConfig(out server, out dbName, out userId, out password, out trustedConnection);
            connString = GetConnectionString(server, dbName, userId, password, trustedConnection);
        }

        private void btnQuery_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(connString))
                {
                    sqlConn.Open();
                    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(txtSelection.Text, sqlConn);
                    tableData.Rows.Clear();
                    tableData.Columns.Clear();
                    sqlDataAdapter.Fill(tableData);
                    sqlConn.Close();
                }

                dgTableData.ItemsSource = null;
                dgTableData.ItemsSource = tableData.DefaultView;
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void dgTableData_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            tableEdit.Rows.Clear();
            int selectedIndex = dgTableData.SelectedIndex;

            for(int i = 0; selectedIndex >= 0 && i < tableData.Columns.Count; i++)
            {
                Type dataType = tableData.Columns[i].DataType;
                string columnName = tableData.Columns[i].ColumnName;
                object value = tableData.Rows[selectedIndex][i];
                
                DataRow dr = tableEdit.NewRow();
                dr[0] = columnName;
                dr[1] = GetValueByDataType(dataType, value);
                tableEdit.Rows.Add(dr);
            }
        }

        private void btnGenCode_Click(object sender, RoutedEventArgs e)
        {
            string insertColumnList = "";
            string insertValueList = "";

            for (int i = 0; i < tableEdit.Rows.Count; i++)
            {
                DataRow dr = tableEdit.Rows[i];
                string columnName = dr[0].ToString();
                string valueStr = dr[1].ToString();
                if (ckExcludeSystemColumns.IsChecked == true && IsSystemColumns(columnName))
                {
                    continue;
                }
                insertColumnList += columnName;
                insertValueList += valueStr;

                insertColumnList += ", ";
                insertColumnList += (bool)ckColumnPerLine.IsChecked ? "\r\n" : "";
                insertValueList += ", ";
                insertValueList += (bool)ckColumnPerLine.IsChecked ? "\r\n" : "";
            }

            string tableName = GetTableFromQuery(txtSelection.Text);
            insertColumnList = insertColumnList.TrimEnd(' ', ',', '\r', '\n');
            insertValueList = insertValueList.TrimEnd(' ', ',', '\r', '\n');
            string codeBlock = $"INSERT INTO {tableName} ({insertColumnList})\r\nVALUES({insertValueList})";
            txtCode.Text = codeBlock;
        }

        private bool IsSystemColumns(string columnName)
        {
            string[] systemColumnList = new string[] { "NoteExistsFlag", "InWorkflow", "RowPointer", "RecordDate", "CreateDate", "CreatedBy", "UpdatedBy" };
            return systemColumnList.Contains(columnName);
        }

        private string GetTableFromQuery(string queryCmd)
        {
            string[] itemList = queryCmd.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            for(int i = 0; i < itemList.Length; i++)
            {
                if(itemList[i].Trim().ToUpper() == "FROM")
                {
                    return itemList[i + 1];
                }
            }
            return "";
        }

        private string GetValueByDataType(Type dataType, object value)
        {
            string valueStr;
            if(Convert.IsDBNull(value))
            {
                valueStr = "NULL";
                return valueStr;
            }

            if (dataType == typeof(string) || dataType == typeof(DateTime) || dataType == typeof(Guid))
            {
                valueStr = $"'{value}'";
            }
            else if(dataType == typeof(byte[]))
            {
                valueStr = $"'{Convert.ToBase64String((byte[])value)}'";
            }
            else
            {
                valueStr = $"{value}";
            }

            return valueStr;
        }

        private string GetConnectionString(string server, string dbName, string userId, string password, bool trustedConnection = false)
        {
            string connString;
            if (trustedConnection)
            {
                connString = $"Server = {server}; Database = {dbName}; Trusted_Connection = True;";
            }
            else
            {
                connString = $"Server = {server};Database = {dbName}; User Id = {userId}; Password = {password};";
            }

            return connString;
        }

        private void GetConfig(out string server, out string dbName, out string userId, out string password, out bool trustedConnection)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(AppDomain.CurrentDomain.BaseDirectory + "\\Config.xml");
            server = xmlDoc.SelectSingleNode("/Config/Server").InnerText;
            dbName = xmlDoc.SelectSingleNode("/Config/DBName").InnerText;
            userId = xmlDoc.SelectSingleNode("/Config/UserId").InnerText;
            password = xmlDoc.SelectSingleNode("/Config/Password").InnerText;
            trustedConnection = Convert.ToBoolean(xmlDoc.SelectSingleNode("/Config/TrustedConnection").InnerText);
        }
    }
}
