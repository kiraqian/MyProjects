using PickupUtil;
using System;
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
            InitTextBox();
            _pickup = new Pickup();
            _text = new Text();
            wordsPoolFilesTable = _text.ListFiles(AppDomain.CurrentDomain.BaseDirectory);
            dgChoosePool.ItemsSource = wordsPoolFilesTable.DefaultView;
        }

        private void btnPickup_Click(object sender, RoutedEventArgs e)
        {
            string wordsPool = string.Empty;
            foreach (DataRow dr in wordsPoolFilesTable.Rows)
            {
                if (Convert.ToBoolean(dr["Select"]))
                {
                    wordsPool += _text.ReadFileContent(dr["FullName"].ToString());
                }
            }

            _pickup.SetWordsPool(_text.TextToList(wordsPool));

            txtWordsToPickup.Text = _text.ListToText(_text.TextToList(txtWordsToPickup.Text));
            _pickup.DoPickup(_text.TextToList(txtWordsToPickup.Text));
            txtWordsInPool.Text = _text.ListToText(_pickup.InPoolWords);
            txtWordsOutPool.Text = _text.ListToText(_pickup.OutPoolWords);

            InitTextBox();
        }

        private void txtWordsToPickup_GotFocus(object sender, RoutedEventArgs e)
        {
            InitTextBox();
        }

        private void txtWordsToPickup_LostFocus(object sender, RoutedEventArgs e)
        {
            InitTextBox();
        }

        private void InitTextBox()
        {
            if (txtWordsToPickup.IsFocused)
            {
                if (txtWordsToPickup.Text.Trim() == "Words to pickup")
                {
                    txtWordsToPickup.Text = string.Empty;
                }
            }
            else
            {
                if (txtWordsToPickup.Text.Trim() == string.Empty)
                {
                    txtWordsToPickup.Text = "Words to pickup";
                }
            }

            if (txtWordsInPool.Text.Trim() == string.Empty)
            {
                txtWordsInPool.Text = "Words in the pool";
            }

            if (txtWordsOutPool.Text.Trim() == string.Empty)
            {
                txtWordsOutPool.Text = "Words outside the pool";
            }
        }
    }
}
