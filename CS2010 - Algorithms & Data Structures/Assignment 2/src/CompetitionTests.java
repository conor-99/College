/*
    @author Conor McCauley
*/

import org.junit.Test;
import org.junit.Assert;

public class CompetitionTests {

    @Test
    public void testDijkstraTiny() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("tiny.txt", 50, 70, 80);

        int expected = 38;
        int actual   = dijkstra.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }

    /*@Test
    public void testDijkstraBig() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("big.txt", 60, 70, 80);

        int expected = 24;
        int actual   = dijkstra.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }*/

    @Test
    public void testDijkstraNoFile() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("nofile", 60, 70, 80);

        int expected = -1;
        int actual   = dijkstra.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testDijkstraInvalidSpeed1() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("tiny.txt", 40, 40, 40);

        int expected = -1;
        int actual   = dijkstra.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testDijkstraInvalidSpeed2() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("tiny.txt", 140, 140, 140);

        int expected = -1;
        int actual   = dijkstra.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testDijkstraEmpty() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("empty.txt", 50, 60, 70);

        int expected = -1;
        int actual   = dijkstra.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testDijkstraImpossible() {

        CompetitionDijkstra dijkstra = new CompetitionDijkstra("impossible.txt", 50, 70, 80);

        int expected = -1;
        int actual   = dijkstra.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWTiny() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("tiny.txt", 50, 70, 80);

        int expected = 38;
        int actual   = floydWarshall.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }

    /*@Test
    public void testFWBig() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("big.txt", 60, 70, 80);

        int expected = 24;
        int actual   = floydWarshall.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }*/

    @Test
    public void testFWNoFile() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("nofile", 60, 70, 80);

        int expected = -1;
        int actual   = floydWarshall.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWInvalidSpeed1() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("tiny.txt", 40, 40, 40);

        int expected = -1;
        int actual   = floydWarshall.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWInvalidSpeed2() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("tiny.txt", 140, 140, 140);

        int expected = -1;
        int actual   = floydWarshall.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWEmpty() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("empty.txt", 50, 60, 70);

        int expected = -1;
        int actual   = floydWarshall.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }

    @Test
    public void testFWImpossible() {

        CompetitionFloydWarshall floydWarshall = new CompetitionFloydWarshall("impossible.txt", 50, 70, 80);

        int expected = -1;
        int actual   = floydWarshall.timeRequiredforCompetition();

        Assert.assertEquals(expected, actual);

    }
    
}
