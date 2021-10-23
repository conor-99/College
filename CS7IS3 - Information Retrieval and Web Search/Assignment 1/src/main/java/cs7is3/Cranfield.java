package cs7is3;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.ParseException;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;

public class Cranfield
{
    private Analyzer analyzer;

    private Cranfield(String analyzerType)
    {
        if (analyzerType.equals("0")) this.analyzer = new StandardAnalyzer();
        else this.analyzer = new CustomAnalyzer();
    }

    public static void main(String[] args) throws Exception
    {
        Options options = new Options();
        Option optionMode = new Option("m", "mode", true, "mode of operation (0=index, 1=search, 2=score)");
        optionMode.setRequired(true);
        options.addOption(optionMode);
        Option optionAnalyzer = new Option("a", "analyzer", true, "type of analyzer (0=standard, 1=custom)");
        options.addOption(optionAnalyzer);
        Option optionScore = new Option("s", "scoring", true, "type of scoring (0=BM25, 1=VSM)");
        options.addOption(optionScore);
        Option optionWeights = new Option("p", "parser", true, "type of query parser (0=standard, 1=multifield)");
        options.addOption(optionWeights);
        
        CommandLineParser parser = new DefaultParser();
        HelpFormatter help = new HelpFormatter();
        
        try
        {
            CommandLine cmd = parser.parse(options, args);
            
            String mode = cmd.getOptionValue("mode");
            String analyzer = cmd.getOptionValue("analyzer");
            analyzer = (analyzer == null) ? "0" : analyzer;
            String scoringType = cmd.getOptionValue("scoring");
            scoringType = (scoringType == null) ? "0" : scoringType;
            String parserType = cmd.getOptionValue("parser");
            parserType = (parserType == null) ? "0" : parserType;

            Cranfield cranfield = new Cranfield(analyzer);

            if (mode.equals("0"))
            {
                Indexer.index(cranfield.analyzer);
            }
            else if (mode.equals("1"))
            {
                Searcher searcher = new Searcher(cranfield.analyzer, scoringType, parserType);
                searcher.interactive();
                searcher.close();
            }
            else if (mode.equals("2"))
            {
                Scorer.score(cranfield.analyzer, scoringType, parserType);
            }
        }
        catch (ParseException e)
        {
            System.out.println(e.getMessage());
            help.printHelp("java -jar target/cranfield-1.0.jar", options);
            System.exit(1);
        }
    }
}
