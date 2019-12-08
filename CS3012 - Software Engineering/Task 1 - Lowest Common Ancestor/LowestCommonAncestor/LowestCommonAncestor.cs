using System.Collections.Generic;

namespace LowestCommonAncestor
{

    public class BinaryTree
    {

        public const int NONE = int.MaxValue;

        public BinaryTreeNode root;
        private List<int> pathA, pathB;

        public int FindLCA(int a, int b)
        {

            pathA = new List<int>();
            pathB = new List<int>();

            if (!FindPath(root, a, pathA) || !FindPath(root, b, pathB))
                return NONE;

            int i;
            for (i = 0; i < pathA.Count && i < pathB.Count; i++)
            {
                if (!pathA[i].Equals(pathB[i])) break;
            }

            return pathA[i - 1];

        }

        private bool FindPath(BinaryTreeNode root, int n, List<int> path)
        {

            if (root == null)
                return false;

            path.Add(root.value);

            if (root.value.Equals(n))
                return true;
            if (root.left != null && FindPath(root.left, n, path))
                return true;
            if (root.right != null && FindPath(root.right, n, path))
                return true;

            path.RemoveAt(path.Count - 1);
            return false;

        }

    }

    public class BinaryTreeNode
    {

        public BinaryTreeNode left, right;
        public int value;

        public BinaryTreeNode(int value)
        {
            this.value = value;
        }

    }

}
