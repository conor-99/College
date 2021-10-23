# CS7IS3: Assignment 1

## Building the Program

You can build the program from within the `cd cs7is3-assign1` directory in two ways:

### Using Provided Script

```
./build.sh
```

### Manually

```
mvn compile
mvn package
```

## Running the Program

The command to execute the program should be in the following form:

```
java -jar target/cranfield-1.0.jar --mode <MODE>
```

### Modes of Operation

The program has three modes of operation:

1. **Indexing** (`--mode 0`): creates an index out of the documents in the corpus.
2. **Searching** (`--mode 1`): allows the user to interactively query the search engine.
3. **Scoring** (`--mode 2`): stores the engines scores against the Cranfield queries in a results file.

### Optional Parameters

By default, the program will use Lucene's `StandardAnalyzer` for content processing, `BM25` for scoring results and `QueryParser` for querying the engine.

Other options can be selected via the following parameters:

- `--analyzer 0` = `StandardAnalyzer`
- `--analyzer 1` = `CustomAnalyzer`
- `--scoring 0` = `BM25`
- `--scoring 1` = `VSM`
- `--parser 0` = `QueryParser`
- `--parser 1` = `MultiFieldQueryParser`

For example, to score the engine using the `CustomAnalyzer`, `BM25` scoring and the `MultiFieldQueryParser` you would execute the following command:

```
java -jar target/cranfield-1.0.jar --mode 2 --analyzer 1 --scoring 0 --parser 1
```

## Evaluating the Program

### Manually

To evaluate the program you will need to first build, index and score the engine via the above commands. You can then run `trec_eval` like so:

```
./trec_eval-9.0.7/trec_eval cranfield_collection/cranqrel_corrected results/scores
```

### Using Provided Script

The provided `evaluate.sh` script will, assuming the program has been built, evaluate and output the *MAP* and *recall* values for all combinations of analyzers, scoring methods and query parsers. It can be run like so:

```
./evaluate.sh
```