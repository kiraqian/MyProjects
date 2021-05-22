using PickupUtil;
using System;
using System.Collections.Generic;
using System.Data;
using System.Windows;

namespace WordsPickup
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private IPickup _pickup;
        private IText _text;
        private DataTable wordsPoolFilesTable;

        public MainWindow()
        {
            InitializeComponent();
            _pickup = new Pickup();
            _text = new Text();
            wordsPoolFilesTable = ListWordsPoolFiles(AppDomain.CurrentDomain.BaseDirectory);
            dgChoosePool.ItemsSource = wordsPoolFilesTable.DefaultView;
        }

        private void btnPickup_Click(object sender, RoutedEventArgs e)
        {
            string wordsPool = string.Empty;
            foreach(DataRow dr in wordsPoolFilesTable.Rows)
            {
                if(Convert.ToBoolean(dr["Select"]))
                {
                    wordsPool += _text.ReadFileContent(dr["FullName"].ToString());
                }
            }
            
            _pickup.SetWordsPool(_text.TextToList(wordsPool));

            txtWordsToPickup.Text = _text.ListToText(_text.TextToList(txtWordsToPickup.Text));
            _pickup.DoPickup(_text.TextToList(txtWordsToPickup.Text));
            txtWordsInPool.Text = _text.ListToText(_pickup.InPoolWords);
            txtWordsOutPool.Text = _text.ListToText(_pickup.OutPoolWords);
        }

        private DataTable ListWordsPoolFiles(string path)
        {
            DataTable dt = _text.ListFiles(path);
            return dt;
        }
    }
}
