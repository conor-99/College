using System.Collections.Generic;

namespace LowestCommonAncestor
{

    public class DirectedAcyclicGraph
    {

        public const int NONE = int.MaxValue;

        private List<DirectedAcyclicGraphVertex> vertices;

        public void AddVertex(DirectedAcyclicGraphVertex vertex)
        {
            vertices.Add(vertex);
        }

        public int FindLCA(int a, int b)
        {
            return NONE;
        }

    }

    public class DirectedAcyclicGraphVertex
    {

        public List<DirectedAcyclicGraphVertex> vertices;
        public int value;

        public DirectedAcyclicGraphVertex(int value)
        {
            this.value = value;
        }

        public void AddVertex(DirectedAcyclicGraphVertex vertex)
        {
            vertices.Add(vertex);
        }

    }

}
