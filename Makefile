.PHONY: clean test repl

clean:
	rm -f *~
	rm -f features/*~
	sudo rm -rf trygherkin/.cpcache

test:
	docker run -i -w="/var/app" -v `pwd`/trygherkin:/var/app clojure:tools-deps sh -c "clj -m trygherkin"

repl:
	docker run -i -w="/var/app" -v `pwd`/trygherkin:/var/app clojure:tools-deps clj
