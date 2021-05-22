using System.Collections.Generic;

namespace PickupUtil
{
    public interface IPickup
    {
        void SetWordsPool(List<string> words);
        void DoPickup(List<string> wordsToPickup, bool distinct = true);

        List<string> InPoolWords { get; }
        List<string> OutPoolWords { get; }
    }
}
