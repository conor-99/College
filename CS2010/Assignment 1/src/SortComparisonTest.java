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

import java.io.BufferedReader;
import java.io.File;
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

    public static void main(String[] args) {
        
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

        } catch (Exception e) { }

        return a;

    }

}
