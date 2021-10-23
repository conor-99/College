package cs7is3;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Scanner;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.similarities.BM25Similarity;
import org.apache.lucene.search.similarities.ClassicSimilarity;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

public class Searcher
{
    Directory directory;
    DirectoryReader reader;
    IndexSearcher searcher;
    QueryParser parser;

    public Searcher(Analyzer analyzer, String scoringType, String parserType) throws IOException
    {
        directory = FSDirectory.open(Paths.get(Constants.INDEX_DIRECTORY));
        reader = DirectoryReader.open(directory);
        
        searcher = new IndexSearcher(reader);
        if (scoringType.equals("0"))
            searcher.setSimilarity(new BM25Similarity());
        else
            searcher.setSimilarity(new ClassicSimilarity());
        
        if (parserType.equals("0"))
        {
            parser = new QueryParser(Constants.FIELD_ABSTRACT, analyzer);
        }
        else
        {
            parser = new MultiFieldQueryParser(
                new String[] { Constants.FIELD_TITLE, Constants.FIELD_ABSTRACT, Constants.FIELD_DEPARTMENT },
                analyzer,
                new HashMap<String, Float>() {{
                    put(Constants.FIELD_TITLE, 0.3f);
                    put(Constants.FIELD_ABSTRACT, 0.7f);
                    put(Constants.FIELD_DEPARTMENT, 0.05f);
                }}
            );
        }
    }

    public void close() throws IOException
    {
        reader.close();
        directory.close();
    }

    public void search(String queryStr, int queryId, BufferedWriter buffer) throws Exception
    {
        // Some queries contain illegal wildcard characters that need to be removed
        String queryStrClean = QueryParser.escape(queryStr);
        Query query = parser.parse(queryStrClean);
        ScoreDoc[] results = searcher.search(query, Constants.MAX_RESULTS_AUTO).scoreDocs;
        
        for (int i = 0; i < results.length; i++)
        {
            String output = String.format(
                "%d 0 %d %d %f STANDARD",
                queryId, results[i].doc + 1, i + 1, results[i].score
            );
            buffer.write(output);
            buffer.newLine();
        }
    }

    public void interactive() throws Exception
    {
        // Querying loop is mostly based on the example provided to us
        String queryStr = "";
        try (Scanner scanner = new Scanner(System.in))
        {
            do
            {
                if (queryStr.length() > 0)
                {
                    Query query = parser.parse(queryStr);
                    ScoreDoc[] results = searcher.search(query, Constants.MAX_RESULTS_INT).scoreDocs;
                    displaySearchResults(searcher, results);
                }
                System.out.print(">>> ");
                queryStr = scanner.nextLine().trim();
            } while (!queryStr.equals(Constants.EXIT_COMMAND));
        }
    }

    private static void displaySearchResults(IndexSearcher searcher, ScoreDoc[] results) throws IOException
    {
        System.out.println(String.format("=== Showing %d results ===", results.length));
        for (int i = 0; i < results.length; i++)
        {
            Document document = searcher.doc(results[i].doc);
            System.out.println(String.format("[%d] \"%s\" (%.3f)", i + 1, document.get("title"), results[i].score));
        }
        System.out.println();
    }
}
