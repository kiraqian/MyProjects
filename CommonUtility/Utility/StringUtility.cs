using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utility.StringUtil
{
    public class StringUtility
    {
        #region LinesStringToText
        public static string LinesStringToText(string[] linesString)
        {
            string text = "";

            foreach (string s in linesString)
            {
                text += s;
                text += "\r\n";
            }

            return text;
        }
        #endregion

        #region TextToLinesString
        public static string[] TextToLinesString(string text)
        {
            string[] sLines = text.Split(new string[] { "\n", "\r\n" }, StringSplitOptions.None);
            return sLines;
        }
        #endregion

        #region LinesStringToStringList
        public static List<string> LinesStringToStringList(string[] linesString)
        {
            List<string> sList = new List<string>();

            foreach (string s in linesString)
            {
                sList.Add(s);
            }

            return sList;
        }
        #endregion

        #region StringListToText
        public static string StringListToText(List<string> listString)
        {
            string text = "";

            foreach (string s in listString)
            {
                text += s;
                text += "\r\n";
            }

            return text;
        }
        #endregion

        #region RemoveTextEmptyLines
        public static string RemoveTextEmptyLines(string text)
        {
            List<string> listString = new List<string>();
            string[] textInLines = text.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
            foreach (string s in textInLines)
            {
                if (s.Trim() != string.Empty)
                {
                    listString.Add(s.TrimEnd());
                }
            }

            return StringListToText(listString);
        }
        #endregion        

        #region StringReplace
        public static bool StringReplace(string contentToReplace, string oldValue, string newValue,
                                         out string replacedContent, bool caseSensitive, bool matchWholeWord)
        {
            replacedContent = " " + contentToReplace + " ";

            StringComparison compareMode;
            if (caseSensitive)
            {
                compareMode = StringComparison.CurrentCulture;
            }
            else
            {
                compareMode = StringComparison.CurrentCultureIgnoreCase;
            }

            int startIndex = 0;
            while (true)
            {
                startIndex = replacedContent.IndexOf(oldValue, startIndex, compareMode);
                if (startIndex == -1)
                    break;

                if (startIndex > 0)
                {
                    if (matchWholeWord)
                    {
                        string charbefore = replacedContent.Substring(startIndex - 1, 1);
                        string charAfter = replacedContent.Substring(startIndex + oldValue.Length, 1);

                        if (!char.IsLetterOrDigit(charbefore, 0) && !char.IsLetterOrDigit(charAfter, 0)
                            && charbefore != "_" && charAfter != "_")
                        {
                            replacedContent = replacedContent.Substring(0, startIndex) + newValue + replacedContent.Substring(startIndex + oldValue.Length);
                            startIndex += newValue.Length;
                        }
                        else
                        {
                            startIndex += oldValue.Length;
                        }
                    }
                    else
                    {
                        replacedContent = replacedContent.Substring(0, startIndex) + newValue + replacedContent.Substring(startIndex + oldValue.Length);
                        startIndex += newValue.Length;
                    }
                }
            }

            replacedContent = replacedContent.Remove(0, 1);
            replacedContent = replacedContent.Remove(replacedContent.Length - 1, 1);

            if (replacedContent.Equals(contentToReplace))
            {
                return false; // Unchanged
            }
            else
            {
                return true; // Modified
            }
        }
        #endregion
    }
}
