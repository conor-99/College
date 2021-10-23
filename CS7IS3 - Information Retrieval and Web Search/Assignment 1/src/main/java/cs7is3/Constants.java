package cs7is3;

public class Constants
{
    // Paths/directories
    public static final String CORPUS_PATH = "./cranfield_collection/cran.all.1400";
    public static final String QUERIES_PATH = "./cranfield_collection/cran.qry";
    public static final String RESULTS_PATH = "./results/scores";
    public static final String INDEX_DIRECTORY = "./index";

    // Indexing
    public static final String FIELD_TITLE = "title";
    public static final String FIELD_AUTHORS = "authors";
    public static final String FIELD_DEPARTMENT = "department";
    public static final String FIELD_ABSTRACT = "abstract";

    // Searching: interactive
    public static final String EXIT_COMMAND = "\\q";
    public static final int MAX_RESULTS_INT = 5;

    // Searching: automatic
    public static final int MAX_RESULTS_AUTO = 1400;
}
