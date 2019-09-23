namespace LowestCommonAncestor
{

    class BinaryTree<T>
    {
        public BinaryTreeNode<T> root;
    }

    class BinaryTreeNode<T>
    {

        public BinaryTreeNode<T> left, right;
        public T value;

        public BinaryTreeNode(T value)
        {
            this.value = value;
        }

    }

}
