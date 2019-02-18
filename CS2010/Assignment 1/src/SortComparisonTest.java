/**
 *
 * @author Conor McCauey
 *
 * /// Results Table ///
 * | INPUT    | INSERT | QUICK  | MRG R  | MRG I  | SELECT |
 * |   10 r.  |        |        |        |        |        |
 * |  100 r.  |        |        |        |        |        |
 * | 1000 r.  |        |        |        |        |        |
 * | 1000 fu. |        |        |        |        |        |
 * | 1000 no. |        |        |        |        |        |
 * | 1000 ro. |        |        |        |        |        |
 * | 1000 s.  |        |        |        |        |        |
 *
 * /// Questions ///
 * a. ...
 * b. ...
 * c. ...
 * d. ...
 * e. ...
 *
*/

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import static org.junit.Assert.assertTrue;

import java.awt.desktop.ScreenSleepEvent;
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

        for (int i = 0; i < runs; i++) {

            System.arraycopy(a, 0, b, 0, a.length);
            start = System.nanoTime();
            SortComparison.insertionSort(b);
            end = System.nanoTime();
            time = (end - start) / 1000000;
            results[0] += time;

            System.arraycopy(a, 0, b, 0, a.length);
            start = System.nanoTime();
            SortComparison.selectionSort(b);
            end = System.nanoTime();
            time = (end - start) / 1000000;
            results[0] += time;

            System.arraycopy(a, 0, b, 0, a.length);
            start = System.nanoTime();
            SortComparison.insertionSort(b);
            end = System.nanoTime();
            time = (end - start) / 1000000;
            results[0] += time;

            System.arraycopy(a, 0, b, 0, a.length);
            start = System.nanoTime();
            SortComparison.insertionSort(b);
            end = System.nanoTime();
            time = (end - start) / 1000000;
            results[0] += time;

            System.arraycopy(a, 0, b, 0, a.length);
            start = System.nanoTime();
            SortComparison.insertionSort(b);
            end = System.nanoTime();
            time = (end - start) / 1000000;
            results[0] += time;

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
