.PHONY: build
build:
	docker build -t gobox .
	docker images | grep gobox | sed -E 's/[ ]+/,/g' | rev | cut -d',' -f1 | rev
