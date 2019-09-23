using System;
using System.Collections.Generic;
using System.Text;

namespace LowestCommonAncestor
{

    class BinaryTree<T>
    {

        BinaryTreeNode<T> root;

        public BinaryTree(T value, BinaryTreeNode<T> left, BinaryTreeNode<T> right)
        {
            root = new BinaryTreeNode<T>(value, left, right);
        }

    }

    class BinaryTreeNode<T>
    {

        public BinaryTreeNode<T> left, right;
        public T value;

        public BinaryTreeNode(T value, BinaryTreeNode<T> left, BinaryTreeNode<T> right)
        {
            this.value = value;
            this.left = left;
            this.right = right;
        }

    }

}
