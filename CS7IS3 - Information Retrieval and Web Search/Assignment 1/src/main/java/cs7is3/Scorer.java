package cs7is3;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.apache.lucene.analysis.Analyzer;

public class Scorer
{
    public static void score(Analyzer analyzer, String scoringType, String parserType) throws Exception
    {
        ArrayList<String> queries = getQueries();
        Searcher searcher = new Searcher(analyzer, scoringType, parserType);

        FileWriter file = new FileWriter(Constants.RESULTS_PATH, false);
        BufferedWriter buffer = new BufferedWriter(file);

        for (int i = 0; i < queries.size(); i++)
        {
            searcher.search(queries.get(i), i + 1, buffer);
        }

        buffer.close();
        file.close();
    }

    private static ArrayList<String> getQueries() throws IOException
    {
        // Read all lines from the queries file
        List<String> lines = Files.readAllLines(Paths.get(Constants.QUERIES_PATH));

        // Initialise list of query texts
        ArrayList<String> queries = new ArrayList<String>();

        // Each query has an index number and some text
        // Note: we can ignore the index number since it just counts up from 1
        String currentText = null;

        for (int i = 0; i < lines.size(); i++)
        {
            String line = lines.get(i);

            if (line.startsWith(".I"))
            {
                // If this isn't the initial empty query
                if (currentText != null)
                {
                    // Construct the query as a pair and add it to the list, increment the index too
                    queries.add(currentText);
                }
                
                // Reset the text
                currentText = "";

                // Skip over the next line which is always ".W"
                i++;
            }
            else
            {
                // Add the current line to the query text
                currentText = currentText + line + " ";
            }

            // If this is the last line then construct and add the final query
            if (i == lines.size() - 1)
            {
                queries.add(currentText);
            }
        }

        return queries;
    }
}
