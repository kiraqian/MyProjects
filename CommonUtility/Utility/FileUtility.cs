using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utility.FileUtil
{
    public class FileUtility
    {
        #region CreateFolder
        public static void CreateFolder(string path)
        {
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
        }
        #endregion

        #region GetFileList
        public static string [] GetFileList(string directory, string searchPattern, bool searchSubFolders)
        {
            SearchOption searchOption = searchSubFolders ? SearchOption.AllDirectories : SearchOption.TopDirectoryOnly;
            string[] fileName = Directory.GetFiles(directory, searchPattern, searchOption);

            return fileName;
        }
        #endregion
    }
}
