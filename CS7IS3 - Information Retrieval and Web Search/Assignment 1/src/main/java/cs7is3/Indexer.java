package cs7is3;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

public class Indexer
{
    // The name of the field that came before a given line separator
    // Example: the 'title' field is always followed by an '.A' separator (for authors)
    private static HashMap<String, String> prevFieldNames = new HashMap<String, String>()
    {{
        put(".A", Constants.FIELD_TITLE);
        put(".B", Constants.FIELD_AUTHORS);
        put(".W", Constants.FIELD_DEPARTMENT);
    }};
    
    public static void index(Analyzer analyzer) throws IOException
    {
        // Read all lines from the corpus
        List<String> lines = Files.readAllLines(Paths.get(Constants.CORPUS_PATH));

        // Initialise list of documents
        ArrayList<Document> documents = new ArrayList<Document>();

        // Each document in the corpus has an index number, an author, a department (?) and an abstract
        // We need to iterate over the lines in the corpus correctly in order to generate our documents
        Document currentDocument = null;
        String currentField = "";

        // A handful of documents have .A/.B/.W lines contained within the abstract field
        // These lines should be included in the abstract field rather than being treated as field separators
        boolean parsingAbstract = false;

        for (int i = 0; i < lines.size(); i++)
        {
            String line = lines.get(i);

            if (line.startsWith(".I"))
            {
                // If this isn't the initial empty document
                if (currentDocument != null)
                {
                    // Add the final field to the document and add the document to the list
                    currentDocument.add(new TextField(Constants.FIELD_ABSTRACT, currentField, Field.Store.YES));
                    documents.add(currentDocument);
                }
                
                // Reset the document and field
                currentDocument = new Document();
                currentField = "";
                
                // We're no longer in the abstract section
                parsingAbstract = false;

                // Skip over the next line which is always ".T"
                i++;
            }
            else if (line.matches("^\\.(A|B|W)$") && !parsingAbstract) // line matches .A, .B or .W
            {
                // Add the previous field to the document and reset the field
                currentDocument.add(new TextField(
                    Indexer.prevFieldNames.get(line), // if line is '.A' then previous field was 'title', etc.
                    currentField,
                    Field.Store.YES
                ));
                currentField = "";
                
                // Check if we've moved into the abstract section
                if (line.equals(".W"))
                {
                    parsingAbstract = true;
                }
            }
            else
            {
                // Add the current line to the field
                currentField = currentField + line + " ";
            }

            // If this is the last line then add the final field, ID and document
            if (i == lines.size() - 1)
            {
                currentDocument.add(new TextField(Constants.FIELD_ABSTRACT, currentField, Field.Store.YES));
                documents.add(currentDocument);
            }
        }

        // Set up config using the analyzer instantiated by the class
        IndexWriterConfig config = new IndexWriterConfig(analyzer);
        config.setOpenMode(IndexWriterConfig.OpenMode.CREATE);
        
        // Write the documents to the index within the specified directory
        try (Directory directory = FSDirectory.open(Paths.get(Constants.INDEX_DIRECTORY)))
        {
            try (IndexWriter writer = new IndexWriter(directory, config))
            {
                writer.addDocuments(documents);
            }
        }
    }
}
