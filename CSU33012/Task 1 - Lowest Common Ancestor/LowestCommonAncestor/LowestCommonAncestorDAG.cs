using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Vertex = LowestCommonAncestor.DirectedAcyclicGraphVertex;

namespace LowestCommonAncestor
{

    public class DirectedAcyclicGraph
    {

        public const int NONE = int.MaxValue;

        public Vertex root;
        public Dictionary<int, Vertex> vertexMap;

        public DirectedAcyclicGraph(Vertex root, List<Vertex> vertices)
        {

            this.root = root;

            foreach (Vertex vertex in vertices)
                vertexMap.Add(vertex.value, vertex);

        }

        public int FindLCA(int a, int b)
        {

            if (!vertexMap.ContainsKey(a) || !vertexMap.ContainsKey(b))
                return NONE;

            Vertex vA = vertexMap[a];
            Vertex vB = vertexMap[b];

            MarkPredecessors(vA, StatusLCA.A, StatusLCA.Default);
            MarkPredecessors(vB, StatusLCA.AB, StatusLCA.A);

            List<int> solutions = GetSolutions();
            return (solutions.Count == 0) ? NONE : solutions.Max();

        }

        private void MarkPredecessors(Vertex root, StatusLCA mark, StatusLCA markIf)
        {

            if (root.status == markIf)
                root.status = mark;

            if (root.predecessors == null)
                return;

            foreach (Vertex predecessor in root.predecessors)
                MarkPredecessors(predecessor, mark, markIf);

        }

        private List<int> GetSolutions()
        {
            return new List<int>() { 1, 2, 3 };
        }
        
    }

    public class DirectedAcyclicGraphVertex
    {

        public List<Vertex> predecessors, successors;
        public int value;

        public StatusLCA status = StatusLCA.Default;
        public int count = 0;

        public DirectedAcyclicGraphVertex(int value)
        {
            this.value = value;
        }

    }

    public enum StatusLCA { Default, A, AB };

}
