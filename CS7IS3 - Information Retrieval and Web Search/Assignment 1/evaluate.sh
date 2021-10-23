# index with standard analyzer
java -jar target/cranfield-1.0.jar --mode 0 --analyzer 0

# evaluate for combinations of scoring/parsing
echo "=== standard analyzer, BM25 scoring, standard parser ==="
java -jar target/cranfield-1.0.jar --mode 2 --analyzer 0 --scoring 0 --parser 0
./trec_eval-9.0.7/trec_eval -m map -m set_recall cranfield_collection/cranqrel_corrected results/scores
echo "=== standard analyzer, BM25 scoring, multi-field parser ==="
java -jar target/cranfield-1.0.jar --mode 2 --analyzer 0 --scoring 0 --parser 1
./trec_eval-9.0.7/trec_eval -m map -m set_recall cranfield_collection/cranqrel_corrected results/scores
echo "=== standard analyzer, VSM scoring, standard parser ==="
java -jar target/cranfield-1.0.jar --mode 2 --analyzer 0 --scoring 1 --parser 0
./trec_eval-9.0.7/trec_eval -m map -m set_recall cranfield_collection/cranqrel_corrected results/scores
echo "=== standard analyzer, VSM scoring, multi-field parser ==="
java -jar target/cranfield-1.0.jar --mode 2 --analyzer 0 --scoring 1 --parser 1
./trec_eval-9.0.7/trec_eval -m map -m set_recall cranfield_collection/cranqrel_corrected results/scores

# index with custom analyzer
java -jar target/cranfield-1.0.jar --mode 0 --analyzer 1

# evaluate for combinations of scoring/parsing
echo "=== custom analyzer, BM25 scoring, standard parser ==="
java -jar target/cranfield-1.0.jar --mode 2 --analyzer 1 --scoring 0 --parser 0
./trec_eval-9.0.7/trec_eval -m map -m set_recall cranfield_collection/cranqrel_corrected results/scores
echo "=== custom analyzer, BM25 scoring, multi-field parser ==="
java -jar target/cranfield-1.0.jar --mode 2 --analyzer 1 --scoring 0 --parser 1
./trec_eval-9.0.7/trec_eval -m map -m set_recall cranfield_collection/cranqrel_corrected results/scores
echo "=== custom analyzer, VSM scoring, standard parser ==="
java -jar target/cranfield-1.0.jar --mode 2 --analyzer 1 --scoring 1 --parser 0
./trec_eval-9.0.7/trec_eval -m map -m set_recall cranfield_collection/cranqrel_corrected results/scores
echo "=== custom analyzer, VSM scoring, multi-field parser ==="
java -jar target/cranfield-1.0.jar --mode 2 --analyzer 1 --scoring 1 --parser 1
./trec_eval-9.0.7/trec_eval -m map -m set_recall cranfield_collection/cranqrel_corrected results/scores
