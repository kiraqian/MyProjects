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

            foreach(string word in wordsToPickup)
            {
                if(_wordsPool.Contains(word))
                {
                    if(distinct && !InPoolWords.Contains(word))
                    {
                        InPoolWords.Add(word);
                    }
                    else
                    {
                        InPoolWords.Add(word);
                    }
                }
                else
                {
                    if (distinct && !OutPoolWords.Contains(word))
                    {
                        OutPoolWords.Add(word);
                    }
                    else
                    {
                        OutPoolWords.Add(word);
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
