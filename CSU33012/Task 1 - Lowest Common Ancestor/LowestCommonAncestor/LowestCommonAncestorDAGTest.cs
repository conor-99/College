using NUnit.Framework;

namespace LowestCommonAncestor
{

    public class TestsDAG
    {

        [SetUp]
        public void Setup() {}

        [Test]
        public void TestStandardDAG()
        {

            int result = 1;

            Assert.AreEqual(1, result, $"{result} != 1");

        }

    }

}
