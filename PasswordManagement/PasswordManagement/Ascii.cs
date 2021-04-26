using System;

namespace PasswordManagement
{
    public class Ascii
    {
        #region Constructor
        public Ascii()
        {
        }
        #endregion

        #region Public Static Method
        public static int GetAsciiCode(char character)
        {
            return Convert.ToInt32(character);
        }

        public static int[] GetMappingInt32(char[] charArray)
        {
            int[] retInt = new int[charArray.Length];
            for (int i = 0; i < charArray.Length; i++)
            {
                retInt[i] = Ascii.GetAsciiCode(charArray[i]);
            }
            return retInt;
        }

        public static char AsciiToChar(int int32Value)
        {
            return Convert.ToChar(int32Value);
        }

        public static char[] AsciiToCharArray(int[] int32Array)
        {
            char[] retCharArray = new char[int32Array.Length];
            for (int i = 0; i < int32Array.Length; i++)
            {
                retCharArray[i] = Ascii.AsciiToChar(int32Array[i]);
            }
            return retCharArray;
        }
        #endregion
    }
}
