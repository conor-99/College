using System;
using System.Collections.Generic;

namespace LowestCommonAncestor
{

    class LowestCommonAncestor<T>
    {

        private BinaryTree<T> tree;
        private List<T> pathA, pathB;

        public LowestCommonAncestor(BinaryTree<T> tree)
        {
            this.tree = tree;
            pathA = new List<T>();
            pathB = new List<T>();
        }

        public T Find(T a, T b)
        {

            pathA.Clear();
            pathB.Clear();

            if (!FindPath(tree.root, a, pathA) || !FindPath(tree.root, b, pathB))
                return a; // TO-DO

            int i;
            for (i = 0; i < pathA.Count && i < pathB.Count; i++)
            {
                if (!pathA[i].Equals(pathB[i])) break;
            }

            return pathA[i - 1];

        }

        private bool FindPath(BinaryTreeNode<T> root, T n, List<T> path)
        {
            return false;
        }

    }

}
