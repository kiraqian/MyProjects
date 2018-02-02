using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace VPing {
    public interface IPingView {
        void UpdateResult(DataTable dt);
        void UpdateProgress(int value);
        void UpdateSettings();
        void SetMaxProgress(int value);
    }
}
