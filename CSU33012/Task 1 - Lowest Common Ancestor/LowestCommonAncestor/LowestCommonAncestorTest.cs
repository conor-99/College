using LowestCommonAncestor;
using NUnit.Framework;

namespace Tests
{

    public class Tests
    {

        [SetUp]
        public void Setup() {}

        [Test]
        public void Test1()
        {

            BinaryTree<int> tree = new BinaryTree<int>();

            tree.root = new BinaryTreeNode<int>(0);
            tree.root.left = new BinaryTreeNode<int>(1);
            tree.root.right = new BinaryTreeNode<int>(2);

            int lca = LowestCommonAncestor<int>.Find(tree, 1, 2);

            Assert.AreEqual(0, lca, "");

        }

    }

}
