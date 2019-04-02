.PHONY: clean echo test

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
	-v `pwd`/features:/var/app/features \
	sleepyfox/cucumber-js
