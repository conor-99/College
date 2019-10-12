using System.Collections.Generic;

namespace LowestCommonAncestor
{

    public class DirectedAcyclicGraph
    {

        public const int NONE = int.MaxValue;

        public DirectedAcyclicGraphVertex root;

        public int FindLCA(int a, int b)
        {
            return NONE;
        }
        
    }

    public class DirectedAcyclicGraphVertex
    {

        public List<DirectedAcyclicGraphVertex> predecessors, successors;
        public int value;

        public DirectedAcyclicGraphVertex(int value)
        {
            this.value = value;
        }

    }

}
