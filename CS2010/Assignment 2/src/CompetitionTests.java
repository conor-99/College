/*
    @author Conor McCauley
*/

import org.junit.Test;
import org.junit.Assert;

public class CompetitionTests {

    @Test
    public void testDijkstraTiny() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("inputs/tiny.txt", 50, 70, 80);

        int expected = 38;
        int actual   = dijkstra.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testDijkstraBig() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("inputs/big.txt", 60, 70, 80);

        int expected = 24;
        int actual   = dijkstra.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testDijkstraNoFile() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("nofile", 60, 70, 80);

        int expected = -1;
        int actual   = dijkstra.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testDijkstraInvalidSpeed() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("nofile", 40, 70, 80);

        int expected = -1;
        int actual   = dijkstra.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testDijkstraImpossible() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("inputs/impossible.txt", 50, 70, 80);

        int expected = -1;
        int actual   = dijkstra.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWTiny() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("inputs/tiny.txt", 50, 70, 80);

        int expected = 38;
        int actual   = floydWarshall.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWBig() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("inputs/big.txt", 60, 70, 80);

        int expected = 24;
        int actual   = floydWarshall.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWNoFile() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("nofile", 60, 70, 80);

        int expected = -1;
        int actual   = floydWarshall.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWInvalidSpeed() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("nofile", 40, 70, 80);

        int expected = -1;
        int actual   = floydWarshall.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWImpossible() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("inputs/impossible.txt", 50, 70, 80);

        int expected = -1;
        int actual   = floydWarshall.timeRequiredForCompetition();

        Assert.assertEquals(expected, actual);

    }
    
}
