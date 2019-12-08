using NUnit.Framework;

namespace LowestCommonAncestor
{

    public class Tests
    {

        [SetUp]
        public void Setup() {}

        [Test]
        public void TestStandardTree()
        {

            BinaryTree tree = new BinaryTree();

            tree.root = new BinaryTreeNode(1);
            tree.root.left = new BinaryTreeNode(2);
            tree.root.right = new BinaryTreeNode(3);
            tree.root.left.left = new BinaryTreeNode(4);
            tree.root.left.right = new BinaryTreeNode(5);
            tree.root.right.left = new BinaryTreeNode(6);
            tree.root.right.right = new BinaryTreeNode(7);

            int result = tree.FindLCA(6, 2);
            
            Assert.AreEqual(1, result, $"{result} != 1");

        }

        [Test]
        public void TestEmptyTree()
        {

            BinaryTree tree = new BinaryTree();

            int result = tree.FindLCA(6, 2);

            Assert.AreEqual(BinaryTree.NONE, result, $"{result} != Infinity");

        }

        [Test]
        public void TestValueMissing()
        {

            BinaryTree tree = new BinaryTree();

            tree.root = new BinaryTreeNode(1);
            tree.root.left = new BinaryTreeNode(2);
            tree.root.right = new BinaryTreeNode(3);
            tree.root.left.left = new BinaryTreeNode(4);
            tree.root.left.right = new BinaryTreeNode(5);
            tree.root.right.left = new BinaryTreeNode(6);
            tree.root.right.right = new BinaryTreeNode(7);

            int result = tree.FindLCA(6, 10);

            Assert.AreEqual(BinaryTree.NONE, result, $"{result} != Infinity");

        }

    }

}
