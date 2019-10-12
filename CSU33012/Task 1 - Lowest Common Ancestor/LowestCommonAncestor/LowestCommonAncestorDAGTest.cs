using NUnit.Framework;
using System.Collections.Generic;
using Vertex = LowestCommonAncestor.DirectedAcyclicGraphVertex; // makes the code a lot easier to read

namespace LowestCommonAncestor
{

    public class TestsDAG
    {

        [SetUp]
        public void Setup() {}

        [Test]
        public void TestStandardDAG()
        {

            Vertex v1, v2, v3, v4, v5, v6;
            v1 = new Vertex(1);
            v2 = new Vertex(2);
            v3 = new Vertex(3);
            v4 = new Vertex(4);
            v5 = new Vertex(5);
            v6 = new Vertex(6);

            v1.predecessors = null;
            v1.successors   = new List<Vertex>() { v2, v4, v6 };
            v2.predecessors = new List<Vertex>() { v1, v6 };
            v2.successors   = new List<Vertex>() { v3, v5 };
            v3.predecessors = new List<Vertex>() { v2, v5 };
            v3.successors   = new List<Vertex>() { v4 };
            v4.predecessors = new List<Vertex>() { v1, v3 };
            v4.successors   = null;
            v5.predecessors = new List<Vertex>() { v2 };
            v5.successors   = new List<Vertex>() { v3 };
            v6.predecessors = new List<Vertex>() { v1 };
            v6.successors   = new List<Vertex>() { v2 };


            List<Vertex> vertices = new List<Vertex>() { v1, v2, v3, v4, v5, v6 };
            DirectedAcyclicGraph graph = new DirectedAcyclicGraph(v1, vertices);

            int result = graph.FindLCA(4, 5);
            
            Assert.AreEqual(5, result, $"{result} != 5");

        }

        [Test]
        public void TestEmptyGraph()
        {

            DirectedAcyclicGraph graph = new DirectedAcyclicGraph(null, null);

            int result = graph.FindLCA(1, 2);

            Assert.AreEqual(DirectedAcyclicGraph.NONE, result, $"{result} != Infinity");

        }

        [Test]
        public void TestValueMissing()
        {

            Vertex v1, v2, v3, v4, v5, v6;
            v1 = new Vertex(1);
            v2 = new Vertex(2);
            v3 = new Vertex(3);
            v4 = new Vertex(4);
            v5 = new Vertex(5);
            v6 = new Vertex(6);

            v1.predecessors = null;
            v1.successors = new List<Vertex>() { v2, v4, v6 };
            v2.predecessors = new List<Vertex>() { v1, v6 };
            v2.successors = new List<Vertex>() { v3, v5 };
            v3.predecessors = new List<Vertex>() { v2, v5 };
            v3.successors = new List<Vertex>() { v4 };
            v4.predecessors = new List<Vertex>() { v1, v3 };
            v4.successors = null;
            v5.predecessors = new List<Vertex>() { v2 };
            v5.successors = new List<Vertex>() { v3 };
            v6.predecessors = new List<Vertex>() { v1 };
            v6.successors = new List<Vertex>() { v2 };


            List<Vertex> vertices = new List<Vertex>() { v1, v2, v3, v4, v5, v6 };
            DirectedAcyclicGraph graph = new DirectedAcyclicGraph(v1, vertices);

            int result = graph.FindLCA(4, 7);

            Assert.AreEqual(DirectedAcyclicGraph.NONE, result, $"{result} != Infinity");

        }

    }

}
