using NUnit.Framework;
using System.Collections.Generic;

namespace LowestCommonAncestor
{

    public class TestsDAG
    {

        [SetUp]
        public void Setup() {}

        [Test]
        public void TestStandardDAG()
        {

            DirectedAcyclicGraph graph = new DirectedAcyclicGraph();

            graph.AddVertex(1, new HashSet<int>() { 2, 4, 6 });
            graph.AddVertex(2, new HashSet<int>() { 3, 5 });
            graph.AddVertex(3, new HashSet<int>() { 4 });
            graph.AddVertex(4, null);
            graph.AddVertex(5, new HashSet<int>() { 3 });
            graph.AddVertex(6, new HashSet<int>() { 2 });

            int result = graph.FindLCA(4, 5);

            Assert.AreEqual(2, result, $"{result} != 2");

        }

    }

}
