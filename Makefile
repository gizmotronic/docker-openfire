all: build

build:
	@docker build --tag=miguelwill/openfire .

release: build
	@docker build --tag=miguelwill/openfire:$(shell cat VERSION) .
