using System.Collections.Generic;

namespace LowestCommonAncestor
{

    public class DirectedAcyclicGraph
    {

        public const int NONE = int.MaxValue;

        private Dictionary<int, HashSet<int>> vertices = new Dictionary<int, HashSet<int>>();

        public void AddVertex(int value, HashSet<int> successors)
        {

            if (!vertices.ContainsKey(value))
                vertices.Add(value, new HashSet<int>());

            vertices[value].UnionWith(successors);
            
        }

        public int FindLCA(int a, int b)
        {
            return NONE;
        }
        
    }

}
