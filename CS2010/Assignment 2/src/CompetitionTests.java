import org.junit.Test;
import org.junit.Assert;

public class CompetitionTests {

    @Test
    public void testDijkstraTiny() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("inputs/tiny.txt", 50, 70, 80);

        int expected = 38;
        int actual = dijkstra.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testDijkstraBig() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("inputs/big.txt", 60, 70, 80);

        int expected = 24;
        int actual = dijkstra.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWTiny() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("inputs/tiny.txt", 60, 70, 80);

        int expected = -1;
        int actual = floydWarshall.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWBig() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("inputs/big.txt", 60, 70, 80);

        int expected = -1;
        int actual = floydWarshall.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }
    
}
