/**
 @author Conor McCauey
*/

class SortComparison {

    static double[] insertionSort(double a[]){

        for (int i = 1; i < a.length; i++) {
            for (int j = i; j > 0; j--) {
                if (a[j] < a[j - 1]) swap(a, j, (j - 1));
            }
        }

        return a;

    }

    static double[] quickSort(double a[]) {
        return a;
    }

    static double[] mergeSortIterative(double a[]) {
        return a;
    }

    static double[] mergeSortRecursive(double a[]) {
        return a;
    }

    static double[] selectionSort(double a[]) {

        int l = a.length;

        for (int i = 0; i < (l - 1); i++) {

            int m = i;

            for (int j = (i + 1); j < l; j++) {
                m = (a[j] < a[m]) ? j : m;
            }

            swap(a, i, m);

        }

        return a;

    }

    public static void main(String[] args) { }

    // Swap two elements in an array of doubles
    private static void swap(double[] a, int i, int j) {
        double t = a[i];
        a[i] = a[j];
        a[j] = t;
    }

    // Print out an array of doubles
    public static void print(double[] a) {

        for (int i = 0; i < a.length; i++) {
            System.out.print(a[i] + " ");
        }

        System.out.println();

    }

}
