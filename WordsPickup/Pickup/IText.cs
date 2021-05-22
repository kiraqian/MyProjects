using System.Collections.Generic;
using System.Data;

namespace PickupUtil
{
    public interface IText
    {
        List<string> TextToList(string textInLine, bool removeDuplicate = true);
        string ListToText(List<string> textInList);
        string ReadFileContent(string fileName);
        DataTable ListFiles(string path);
    }
}
