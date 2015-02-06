-module(dm_riak).

-export([start/0]).
-export([buckets/0]).

start() ->
    Size = [{size,2},{max_overflow,0}],
    Worker = [
              {hostname,"localhost"},
              {port,8087},
              {options,[{auto_reconnect,true}]},
              {ping_every,50000},
              {sync_connect,true}
             ],
    {ok, _} = riakc_poolboy:start_pool(?MODULE, Size, Worker).

buckets() ->
    riakc_poolboy:list_buckets(?MODULE).
