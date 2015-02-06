-module(dm_app).
-behaviour(application).

-export([start/0]).
-export([start/2]).
-export([stop/1]).

-define(APP, dm).

start() ->
    application:ensure_all_started(?APP).

start(_Type, _Args) ->
    dm_http:start(9898),
    dm_riak:start(),
	dm_sup:start_link().

stop(_State) ->
	ok.
