import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

class CompetitionFloydWarshall {

    private WeightedGraph graph;
    private int sA, sB, sC;
    private int slowest, fastest;

    CompetitionFloydWarshall(String filename, int sA, int sB, int sC) {

        // Construct a graph using data from the file
        try {
            graph = new WeightedGraph(filename);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            System.exit(1);
        }

        // Initialise the speeds
        this.sA = sA;
        this.sB = sB;
        this.sC = sC;

        // Find the slowest and fastest speeds
        int speeds[] = new int[] { sA, sB, sC };
        Arrays.sort(speeds);
        slowest = speeds[0];
        fastest = speeds[2];

    }

    // Calculate the time taken for the slowest person to travel from intersections A to B where |AB| is maximised
    int timeRequiredForCompetition() {

        // If the graph hasn't been initialised or the speeds are invalid
        if (graph == null || slowest < 50 || fastest > 100) return -1;

        // Calculate the maximum distance between two intersections
        double maxDistance = graph.maxDistanceFloydWarshall();

        // If the graph isn't connected
        if (maxDistance == Double.POSITIVE_INFINITY) return -1;

        // Calculate the minimum time needed
        return (int) Math.ceil((maxDistance * 1000) / slowest);

    }

    // Creates a weighted graph with vertices and edges using data from a text file
    private class WeightedGraph {

        int N, S;
        LinkedList<Edge> adjList[];

        WeightedGraph(String filename) throws FileNotFoundException {

            File file = new File(filename);
            Scanner scanner = new Scanner(file);

            N = scanner.nextInt();
            adjList = new LinkedList[N];

            for (int i = 0; i < N; i++)
                adjList[i] = new LinkedList<>();

            S = scanner.nextInt();

            for (int i = 0; i < S; i++) {

                int a = scanner.nextInt();
                int b = scanner.nextInt();
                double l = scanner.nextDouble();

                addEdge(a, b, l);

            }

        }

        // Add an edge to the graph
        private void addEdge(int src, int dst, double weight) {
            adjList[src].addFirst(new Edge(src, dst, weight));
        }

        // Get the max distance using the Floyd-Warshall algorithm
        double maxDistanceFloydWarshall() {
            return getMax(floydWarshall());
        }

        // Implementation of the Floyd-Warshall algorithm
        private double[][] floydWarshall() {

            double[][] minDistances = new double[N][N];

            for (int u = 0; u < N; u++)
                for (int v = 0; v < N; v++)
                    if (u == v) minDistances[u][v] = 0;
                    else minDistances[u][v] = Double.POSITIVE_INFINITY;

            for (int u = 0; u < N; u++)
                for (Edge e : adjList[u])
                    minDistances[u][e.dst] = e.weight;

            for (int k = 0; k < N; k++) {
                for (int i = 0; i < N; i++) {
                    for (int j = 0; j < N; j++) {
                        double d = minDistances[i][k] + minDistances[k][j];
                        if (minDistances[i][j] > d) minDistances[i][j] = d;
                    }
                }
            }

            return minDistances;

        }

        // Get the max value from a 2D array of doubles
        private double getMax(double[][] minDistances) {

            double max = 0;

            for (int i = 0; i < N; i++)
                for (int j = 0; j < N; j++)
                    if (minDistances[i][j] > max) max = minDistances[i][j];

            return max;

        }

        // For storing edge data
        private class Edge {

            int src, dst;
            double weight;

            Edge(int src, int dst, double weight) {
                this.src = src;
                this.dst = dst;
                this.weight = weight;
            }

        }

    }

}
