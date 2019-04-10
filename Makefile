.PHONY: clean echo test repl

TEST_SRC := $(wildcard features/support/*.sibilant)
TEST_FILES := $(TEST_SRC:%.sibilant=%.js)

build: ${TEST_FILES}

%.js: %.sibilant
	npx sibilant $< > $@

clean:
	rm -f *~
	rm -f features/*~
	rm -f features/support/*~

echo:
	@ echo "TEST_SRC: ${TEST_SRC}"
	@ echo "TEST_FILES: ${TEST_FILES}"

test:
	docker run -it \
	-w="/var/app" \
	--network=host \
	-v `pwd`/features:/var/app/features \
	sleepyfox/cucumber-js sh -c "npx cucumber-js -t '@mvp and not @skip'"

repl:
	docker run -it \
	-w="/var/app" \
	-v `pwd`/features:/var/app/features \
	sleepyfox/cucumber-js sh

run-mock:
	docker run -it \
	-p "8080:8080" \
	-v `pwd`/mock-account-docker/server.coffee:/var/app/server.coffee:ro \
	sleepyfox/mock-account sh -c './node_modules/.bin/coffee ./server.coffee'

run-shell:
	docker run -it \
	-p "8080:8080" \
	-v `pwd`/mock-account-docker/server.coffee:/var/app/server.coffee:ro \
	sleepyfox/mock-account sh
