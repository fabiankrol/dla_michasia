-module(dm_http).

-behaviour(cowboy_http_handler).

-export([start/1]).
-export([init/3, terminate/3, handle/2]).

start(Port) ->
    Dispatch = cowboy_router:compile([ {'_', [ {'_', ?MODULE, []} ]} ]),
    cowboy:start_http(?MODULE, 2, [{port, Port}], [{env, [{dispatch, Dispatch}]}]).

init(_, Req, _Opts) ->
    {ok, Req, []}.

terminate(_Reason, _Req, _State) ->
    ok.

handle(Req, State) ->
    {ok, Buckets} = dm_riak:buckets(),
    {ok, Req2} = cowboy_req:reply(200, [], Buckets, Req),
    {ok, Req2, State}.
