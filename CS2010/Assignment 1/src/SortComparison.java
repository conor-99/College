/**
 @author Conor McCauey
*/

class SortComparison {

    static double[] insertionSort(double[] a){

        for (int i = 1; i < a.length; i++) {
            for (int j = i; j > 0; j--) {
                if (a[j] < a[j - 1]) swap(a, j, (j - 1));
            }
        }

        return a;

    }

    static double[] quickSort(double[] a) {

        if (a.length <= 1) return a;

        shuffle(a);
        quickRecSort(a, 0, (a.length - 1));

        return a;

    }

    private static void quickRecSort(double[] a, int lo, int hi) {

        if (hi <= lo) return;

        int v = quickPartition(a, lo, hi);
        quickRecSort(a, lo, (v - 1));
        quickRecSort(a, (v + 1), hi);

    }

    private static int quickPartition(double[] a, int lo, int hi) {

        int i = lo;
        int j = hi + 1;

        double v = a[lo];

        while (true) {

            while (a[++i] < v) { if (i == hi) break; }
            while (v < a[--j]) { if (j == lo) break; }
            if (i >= j) break;

            swap(a, i, j);

        }

        a[lo] = a[j];
        a[j] = v;

        return j;

    }

    static double[] mergeSortIterative(double[] a) {

        int n = a.length;
        double[] aux = new double[n];

        for (int sz = 1; sz < n; sz = (sz + sz)) {
            for (int lo = 0; lo < (n - sz); lo += (sz + sz)) {
                merge(a, aux, lo, (lo + sz - 1), Math.min((lo + sz + sz - 1), (n - 1)));
            }
        }

        return a;

    }

    static double[] mergeSortRecursive(double[] a) {

        double[] aux = new double[a.length];
        mergeRecSort(a, aux, 0, (a.length - 1));
        return a;

    }

    private static void mergeRecSort(double[] a, double[] aux, int lo, int hi) {

        if (hi <= lo) return;
        int mid = lo + ((hi - lo) / 2);

        mergeRecSort(a, aux, lo, mid); // bottom half
        mergeRecSort(a, aux, (mid + 1), hi); // top half
        merge(a, aux, lo, mid, hi); // merge

    }

    private static void merge(double[] a, double[] aux, int lo, int mid, int hi) {

        for (int k = lo; k <= hi; k++) aux[k] = a[k];

        int i = lo;
        int j = mid + 1;

        for (int k = lo; k <= hi; k++) {
            if      (i > mid)           a[k] = aux[j++];
            else if (j > hi)            a[k] = aux[i++];
            else if (aux[j] < aux[i])   a[k] = aux[j++];
            else                        a[k] = aux[i++];
        }

    }

    static double[] selectionSort(double[] a) {

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

    // Shuffle the elements in an array
    private static void shuffle(double[] a) {

        int i = a.length;
        int r;

        while (i > 0) {

            r = (int) Math.floor(Math.random() * i);
            i--;

            swap(a, i, r);

        }

    }

}
