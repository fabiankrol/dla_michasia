
.PHONY: all compile deps

all: deps compile run

compile: deps
	@./rebar compile

deps:
	@./rebar get-deps

run: compile
	erl -pa ebin -pz deps/*/ebin -s dm_app
