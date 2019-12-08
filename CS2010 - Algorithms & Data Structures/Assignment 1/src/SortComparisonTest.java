/**
 *
 * @author Conor McCauley
 *
 * /// Results Table (milliseconds) ///
 * | INPUT    | INSERT | QUICK  | MRG R  | MRG I  | SELECT |
 * |   10 r.  | 0.006  | 0.396  | 0.011  | 0.012  | 0.004  |
 * |  100 r.  | 0.361  | 0.236  | 0.072  | 0.052  | 0.183  |
 * | 1000 r.  | 5.300  | 0.792  | 0.208  | 0.297  | 4.877  |
 * | 1000 fu. | 0.997  | 0.235  | 0.133  | 0.297  | 0.759  |
 * | 1000 no. | 0.741  | 0.237  | 0.386  | 0.439  | 0.619  |
 * | 1000 ro. | 2.010  | 0.203  | 0.088  | 0.146  | 1.103  |
 * | 1000 s.  | 1.445  | 0.200  | 0.083  | 0.162  | 0.725  |
 *
 * /// Questions ///
 * a.
 *      Insertion sort:
 *          Since we iterate through the list, ordering each element as we go, then the more ordered the list already
 *          is the less swaps we'll need to carry out because we can ignore the ordered sections of the list.
 *      Selection sort:
 *          When the list is already sorted we won't need to make as many comparisons to find the next largest element
 *          in the list -- we can add items from the unsorted list to the sorted list quicker.
 *
 * b.
 *      Selection sort (nearly ordered is 7.9x faster than random order):
 *          The reason for this is given in question (a) -- we don't need to make as many comparisons and can move items
 *          from the unsorted list to the sorted list quicker.
 *
 * c.
 *      Worst: selection sort -- 100x increase in input size -> 1219x increase in time.
 *      Best: quick sort -- 100x increase in input size -> 2x increase in time.
 *
 * d.
 *      Yes, the recursive version seems to be faster in all cases except '100 random'.
 *
 * e.
 *      10 random:          selection sort.
 *      100 random:         merge sort (iter).
 *      1000 random:        merge sort (rec).
 *      1000 few unique:    merge sort (rec).
 *      1000 near order:    quick sort.
 *      1000 rev order:     merge sort (rec).
 *      1000 sorted:        merge sort (rec).
 *
*/

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import static org.junit.Assert.assertTrue;

import java.io.BufferedReader;
import java.io.FileReader;

@RunWith(JUnit4.class)
public class SortComparisonTest {

    @Test
    public void testConstructor() {
        new SortComparison();
    }

    @Test
    public void testEmptyInsert() {
        double[] unsorted   = new double[] {};
        double[] sorted     = new double[] {};
        double[] result     = SortComparison.insertionSort(unsorted);
        assertTrue(arrayEquals(result, sorted));
    }

    @Test
    public void testEmptySelect() {
        double[] unsorted   = new double[] {};
        double[] sorted     = new double[] {};
        double[] result     = SortComparison.selectionSort(unsorted);
        assertTrue(arrayEquals(result, sorted));
    }

    @Test
    public void testEmptyMergeRec() {
        double[] unsorted   = new double[] {};
        double[] sorted     = new double[] {};
        double[] result     = SortComparison.mergeSortRecursive(unsorted);
        assertTrue(arrayEquals(result, sorted));
    }

    @Test
    public void testEmptyMergeIter() {
        double[] unsorted   = new double[] {};
        double[] sorted     = new double[] {};
        double[] result     = SortComparison.mergeSortIterative(unsorted);
        assertTrue(arrayEquals(result, sorted));
    }

    @Test
    public void testEmptyQuick() {
        double[] unsorted   = new double[] {};
        double[] sorted     = new double[] {};
        double[] result     = SortComparison.quickSort(unsorted);
        assertTrue(arrayEquals(result, sorted));
    }

    @Test
    public void testUnsortedInsert() {
        double[] unsorted   = new double[] { 1.0, 3.0, 2.0, 3.0, 1.0, 4.0, -1.0 };
        double[] sorted     = new double[] { -1.0, 1.0, 1.0, 2.0, 3.0, 3.0, 4.0 };
        double[] result     = SortComparison.insertionSort(unsorted);
        assertTrue(arrayEquals(result, sorted));
    }

    @Test
    public void testUnsortedSelect() {
        double[] unsorted   = new double[] { 1.0, 3.0, 2.0, 3.0, 1.0, 4.0, -1.0 };
        double[] sorted     = new double[] { -1.0, 1.0, 1.0, 2.0, 3.0, 3.0, 4.0 };
        double[] result     = SortComparison.selectionSort(unsorted);
        assertTrue(arrayEquals(result, sorted));
    }

    @Test
    public void testUnsortedMergeRec() {
        double[] unsorted   = new double[] { 1.0, 3.0, 2.0, 3.0, 1.0, 4.0, -1.0 };
        double[] sorted     = new double[] { -1.0, 1.0, 1.0, 2.0, 3.0, 3.0, 4.0 };
        double[] result     = SortComparison.mergeSortRecursive(unsorted);
        assertTrue(arrayEquals(result, sorted));
    }

    @Test
    public void testUnsortedMergeIter() {
        double[] unsorted   = new double[] { 1.0, 3.0, 2.0, 3.0, 1.0, 4.0, -1.0 };
        double[] sorted     = new double[] { -1.0, 1.0, 1.0, 2.0, 3.0, 3.0, 4.0 };
        double[] result     = SortComparison.mergeSortIterative(unsorted);
        assertTrue(arrayEquals(result, sorted));
    }

    @Test
    public void testUnsortedQuick() {
        double[] unsorted   = new double[] { 1.0, 3.0, 2.0, 3.0, 1.0, 4.0, -1.0 };
        double[] sorted     = new double[] { -1.0, 1.0, 1.0, 2.0, 3.0, 3.0, 4.0 };
        double[] result     = SortComparison.quickSort(unsorted);
        assertTrue(arrayEquals(result, sorted));
    }

    @Test
    public void testMainMethod() {
        main(null); // runs the main method -- which allows us to time our sorting algorithms
    }

    public static void main(String[] args) {

        double[] rTen       = importArray("inputs/numbers10.txt", 10);
        double[] rHundred   = importArray("inputs/numbers100.txt", 100);
        double[] rThou      = importArray("inputs/numbers1000.txt", 1000);
        double[] fuThou     = importArray("inputs/numbers1000Duplicates.txt", 1000);
        double[] noThou     = importArray("inputs/numbersNearlyOrdered1000.txt", 1000);
        double[] roThou     = importArray("inputs/numbersReverse1000.txt", 1000);
        double[] sThou      = importArray("inputs/numbersSorted1000.txt", 1000);

        System.out.println("10 r");
        print(getAverageTimes(rTen, 3));

        System.out.println("100 r");
        print(getAverageTimes(rHundred, 3));

        System.out.println("1000 r");
        print(getAverageTimes(rThou, 3));

        System.out.println("1000 fu");
        print(getAverageTimes(fuThou, 3));

        System.out.println("1000 no");
        print(getAverageTimes(noThou, 3));

        System.out.println("1000 ro");
        print(getAverageTimes(roThou, 3));

        System.out.println("1000 s");
        print(getAverageTimes(sThou, 3));

    }

    private static long[] getAverageTimes(double[] a, int runs) {

        long[] results = new long[5];
        long start, end, time;
        double[] b = new double[a.length];

        // Time each sorting method
        for (int i = 0; i < runs; i++) {

            System.arraycopy(a, 0, b, 0, a.length);

            start = System.nanoTime();
            SortComparison.insertionSort(b);
            end = System.nanoTime();
            //time = (end - start) / 1000000;
            time = (end - start) / 1000;

            results[0] += time;

            System.arraycopy(a, 0, b, 0, a.length);

            start = System.nanoTime();
            SortComparison.quickSort(b);
            end = System.nanoTime();
            //time = (end - start) / 1000000;
            time = (end - start) / 1000;

            results[1] += time;

            System.arraycopy(a, 0, b, 0, a.length);

            start = System.nanoTime();
            SortComparison.mergeSortRecursive(b);
            end = System.nanoTime();
            //time = (end - start) / 1000000;
            time = (end - start) / 1000;

            results[2] += time;

            System.arraycopy(a, 0, b, 0, a.length);

            start = System.nanoTime();
            SortComparison.mergeSortIterative(b);
            end = System.nanoTime();
            //time = (end - start) / 1000000;
            time = (end - start) / 1000;

            results[3] += time;

            System.arraycopy(a, 0, b, 0, a.length);

            start = System.nanoTime();
            SortComparison.selectionSort(b);
            end = System.nanoTime();
            //time = (end - start) / 1000000;
            time = (end - start) / 1000;

            results[4] += time;

        }

        // Calculate averages
        for (int i = 0; i < 5; i++) { results[i] /= runs; }

        return results;

    }

    private static void print(long[] a) {
        for (long l : a) { System.out.print(l + " "); }
        System.out.println();
    }

    private static boolean arrayEquals(double[] a, double[] b) {

        if (a.length != b.length) return false;

        for (int i = 0; i < a.length; i++) {
            if (a[i] != b[i]) return false;
        }

        return true;

    }

    private static double[] importArray(String file, int size) {

        double[] a = new double[size];

        try {

            FileReader fr = new FileReader(file);
            BufferedReader br = new BufferedReader(fr);

            int i = 0;
            String l = null;

            while ((l = br.readLine()) != null && i < size) {
                a[i] = Double.parseDouble(l);
                i++;
            }

            br.close();

        } catch (Exception e) {
            System.out.println("Error importing array");
            e.printStackTrace();
        }

        return a;

    }

}
