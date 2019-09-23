using System;

namespace LowestCommonAncestor
{

    class LowestCommonAncestor<T>
    {

        public static T Find(BinaryTree<T> tree, T a, T b)
        {
            return tree.root.value;
        }

    }

}
