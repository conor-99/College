import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

class CompetitionDijkstra {

    private WeightedGraph graph;
    private int sA, sB, sC;
    private int slowest, fastest;

    CompetitionDijkstra(String filename, int sA, int sB, int sC) {

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
        double maxDistance = graph.maxDistanceDijkstra();

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

        // Get the max distance using Dijkstra's algorithm
        double maxDistanceDijkstra() {

            double maxDist = 0;

            for (int i = 0; i < N; i++) {
                double dist = dijkstra(i);
                if (dist > maxDist) maxDist = dist;
            }

            return maxDist;

        }

        // Implementation of Dijkstra's algorithm using a map
        private double dijkstra(int src) {

            // Initialise a map to store IDs of vertices and their corresponding Vertex object
            Map<Integer, Vertex> vertices = new HashMap<>();

            // Populate the map with vertices and set every distance to infinity
            for  (int i = 0; i < N; i++)
                vertices.put(i, new Vertex(i, Double.POSITIVE_INFINITY, null));

            // Set the source distance to zero
            vertices.get(src).dist = 0;

            // Initialise it here so we can return its distance at the end
            Vertex u = null;

            // While there are still unvisited vertices
            while (!vertices.isEmpty()) {

                // Remove the vertex with the smallest distance from the map
                u = vertices.remove(getMin(vertices));

                // For each of the vertex's neighbours
                for (Edge e : adjList[u.id]) {

                    Vertex v = vertices.get(e.dst);

                    // If the neighbour is no longer present in the map then skip it
                    if (v == null) continue;

                    // Update the distance if it's smaller than the current one
                    double n = u.dist + e.weight;

                    if (n < v.dist) {
                        v.dist = n;
                        v.prev = u;
                    }

                }

            }

            return u.dist;

        }

        // Get the ID of the vertex with smallest distance
        private int getMin(Map<Integer, Vertex> vertices) {

            int id = 0;
            double dist = Double.POSITIVE_INFINITY;

            // Iterate over every vertex in the map
            for (Vertex v : vertices.values()) {

                // If the vertex's distance is the smallest so far
                if (v.dist < dist) {
                    id = v.id;
                    dist = v.dist;
                }

            }

            return id;

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

        // For storing vertices in the map for Dijkstra's algorithm
        private class Vertex {

            int id;
            double dist;
            Vertex prev;

            Vertex(int id, double dist, Vertex prev) {
                this.id = id;
                this.dist = dist;
                this.prev = prev;
            }

        }

    }

}
