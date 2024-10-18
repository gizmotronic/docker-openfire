all: build

build:
	@docker build --tag=gizmotronic/openfire .

release: build
	@docker build --tag=gizmotronic/openfire:$(shell cat VERSION) .
