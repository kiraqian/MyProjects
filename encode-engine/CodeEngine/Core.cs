using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CodeEngine
{
    public class Core
    {
        #region Private Member
        private string _originalText;
        private string _customEncodeText;
        #endregion

        #region Constructor
        public Core()
        {
            _originalText = "";
            _customEncodeText = "";
        }

        public Core(string orgText, string cusText)
        {
            _originalText = orgText;
            _customEncodeText = cusText;
        }
        #endregion

        #region Property
        public string OriginalText
        {
            get
            {
                return _originalText;
            }
            set
            {
                _originalText = value;
            }
        }

        public string CustomEncodeText
        {
            get
            {
                return _customEncodeText;
            }
            set
            {
                _customEncodeText = value;
            }
        }
        #endregion

        #region Public Method
        public string Encode()
        {
            int encodeInt = GetEncodeInt32(_customEncodeText);
            string retText = "";
            char splitChar = ',';

            int[] int32Array = Ascii.GetMappingInt32(_originalText.ToCharArray());
            // Result Array
            int[] retInt32Array = new int[int32Array.Length];

            for (int i = 0; i < int32Array.Length; i++)
            {
                retInt32Array[i] = int32Array[i] + encodeInt;
                retText += retInt32Array[i].ToString();
                if (i < int32Array.Length - 1)
                {
                    retText += splitChar.ToString();
                }
            }

            return MappingString(retText, Direction.Positive);
        }

        public string Decode()
        {
            int encodeInt = GetEncodeInt32(_customEncodeText);
            string orgTextMapping = MappingString(_originalText, Direction.Minus);
            string retText = "";
            char splitChar = ',';

            string[] tempString = orgTextMapping.Split(splitChar);
            int[] tempIntArray = new int[tempString.Length];

            for (int i = 0; i < tempString.Length; i++)
            {
                tempIntArray[i] = Convert.ToInt32(tempString[i]) - encodeInt;
            }

            char[] retIntArray = Ascii.AsciiToCharArray(tempIntArray);

            for (int i = 0; i < retIntArray.Length; i++)
            {
                retText += retIntArray[i].ToString();
            }

            return retText;
        }
        #endregion

        #region Private Method
        private int[] GetInt32StringByText(string text)
        {
            return Ascii.GetMappingInt32(text.ToCharArray());
        }
        
        private int GetEncodeInt32(string encodeString)
        {
            int encodeInt32 = 0;
            int[] encodeIntArray = Ascii.GetMappingInt32(encodeString.ToCharArray());
            for (int i = 0; i < encodeIntArray.Length; i++)
            {
                encodeInt32 += encodeIntArray[i];
            }
            return encodeInt32;
        }

        private char MappingAlphabet(char character)
        {
            switch (character)
            {
                case '0': return 'A';
                case '1': return 'B';
                case '2': return 'C';
                case '3': return 'D';
                case '4': return 'E';
                case '5': return 'F';
                case '6': return 'G';
                case '7': return 'H';
                case '8': return 'I';
                case '9': return 'J';
                case ',': return 'K';
                default: return '?';
            }
        }

        private char MappingAlphabet2(char int32Char)
        {
            switch (int32Char)
            {
                case 'A': return '0';
                case 'B': return '1';
                case 'C': return '2';
                case 'D': return '3';
                case 'E': return '4';
                case 'F': return '5';
                case 'G': return '6';
                case 'H': return '7';
                case 'I': return '8';
                case 'J': return '9';
                case 'K': return ',';
                default: return '?';
            }
        }

        private string MappingString(string orgString, Direction direction)
        {
            char[] orgCharArray = orgString.ToCharArray();
            string retText = "";

            if (direction == Direction.Positive)
            {
                for (int i = 0; i < orgCharArray.Length; i++)
                {
                    retText += MappingAlphabet(orgCharArray[i]).ToString();
                }
            }
            else if (direction == Direction.Minus)
            {
                for (int i = 0; i < orgCharArray.Length; i++)
                {
                    retText += MappingAlphabet2(orgCharArray[i]).ToString();
                }
            }

            return retText;
        }

        private enum Direction
        {
            Positive = 1,
            Minus = 2,
        }
        #endregion
    }
}
