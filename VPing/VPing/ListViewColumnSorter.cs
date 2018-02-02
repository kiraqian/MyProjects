using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Collections;

namespace VPing {
    public class ListViewColumnSorter : IComparer {
        public int Compare(object x, object y) {
            ListViewItem listViewItem1 = x as ListViewItem;
            ListViewItem listViewItem2 = y as ListViewItem;

            if (listViewItem1 != null && listViewItem2 != null) {
                return SortListViewItem(listViewItem1, listViewItem2);
            }

            return 0;
        }

        private int SortListViewItem(ListViewItem listViewItem1, ListViewItem listViewItem2) {
            Decimal dValue1, dValue2;
            if (IsAsc) {
                if (Decimal.TryParse(listViewItem1.SubItems[SortColumnIndex].Text, out dValue1) &&
                Decimal.TryParse(listViewItem2.SubItems[SortColumnIndex].Text, out dValue2)) {
                    return Decimal.Compare(dValue1, dValue2);
                } else {
                    return String.Compare(listViewItem1.SubItems[SortColumnIndex].Text,
                                          listViewItem2.SubItems[SortColumnIndex].Text);
                }
            } else {
                if (Decimal.TryParse(listViewItem1.SubItems[SortColumnIndex].Text, out dValue1) &&
                Decimal.TryParse(listViewItem2.SubItems[SortColumnIndex].Text, out dValue2)) {
                    return Decimal.Compare(dValue2, dValue1);
                } else {
                    return String.Compare(listViewItem2.SubItems[SortColumnIndex].Text,
                                          listViewItem1.SubItems[SortColumnIndex].Text);
                }
            }
        }

        public int SortColumnIndex { get; set; }

        public bool IsAsc { get; set; }
    }
}
