DB_PATH = $(HOME)/Documents/codeql-result/argus-test-repo-db
QUERY_PATH = $(HOME)/Documents/codeql-repo/actions/ql/src/custom/DoGS_RepoFileExecutionDetection.ql
SEARCH_PATH = $(HOME)/Documents/codeql-repo
BQRS_OUTPUT = $(HOME)/Documents/codeql-result/results.bqrs
CSV_OUTPUT = $(HOME)/Documents/codeql-result/results.csv

.PHONY: clean create analyze extract run

run: extract
	@cat $(CSV_OUTPUT)

extract: analyze
	codeql bqrs decode $(BQRS_OUTPUT) --format=csv --output=$(CSV_OUTPUT)

analyze: create
	codeql query run $(QUERY_PATH) --database=$(DB_PATH) --search-path=$(SEARCH_PATH) --output=$(BQRS_OUTPUT)

create:
	codeql database create $(DB_PATH) --language=actions --overwrite

clean:
	rm -rf $(DB_PATH) $(BQRS_OUTPUT) $(CSV_OUTPUT)