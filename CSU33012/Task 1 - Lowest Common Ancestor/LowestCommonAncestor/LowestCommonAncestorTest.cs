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

            tree.root = new BinaryTreeNode<int>(1);
            tree.root.left = new BinaryTreeNode<int>(2);
            tree.root.right = new BinaryTreeNode<int>(3);
            tree.root.left.left = new BinaryTreeNode<int>(4);
            tree.root.left.right = new BinaryTreeNode<int>(5);
            tree.root.right.left = new BinaryTreeNode<int>(6);
            tree.root.right.right = new BinaryTreeNode<int>(7);

            LowestCommonAncestor<int> LCA = new LowestCommonAncestor<int>(tree);
            int result = LCA.Find(6, 7);

            Assert.AreEqual(3, result, "");

        }

    }

}
