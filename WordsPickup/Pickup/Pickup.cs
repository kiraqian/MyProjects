using System.Collections.Generic;

namespace PickupUtil
{
    public class Pickup : IPickup
    {
        private List<string> _wordsPool;

        public List<string> InPoolWords { get; }

        public List<string> OutPoolWords { get; }

        public Pickup()
        {
            InPoolWords = new List<string>();
            OutPoolWords = new List<string>();
        }

        public void DoPickup(List<string> wordsToPickup, bool distinct = true)
        {
            InPoolWords.Clear();
            OutPoolWords.Clear();

            foreach (string word in wordsToPickup)
            {
                if (_wordsPool.Contains(word.Trim()))
                {
                    if (distinct)
                    {
                        if (!InPoolWords.Contains(word.Trim()))
                        {
                            InPoolWords.Add(word.Trim());
                        }
                    }
                    else
                    {
                        InPoolWords.Add(word.Trim());
                    }
                }
                else
                {
                    if (distinct)
                    {
                        if (!OutPoolWords.Contains(word.Trim()))
                        {
                            OutPoolWords.Add(word.Trim());
                        }
                    }
                    else
                    {
                        OutPoolWords.Add(word.Trim());
                    }
                }
            }
        }

        public void SetWordsPool(List<string> words)
        {
            _wordsPool = words;
        }
    }
}
