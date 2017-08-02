%%%-------------------------------------------------------------------
%%% @author shashankp
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jul 2017 11:43 PM
%%%-------------------------------------------------------------------
-module(consumer).
-author("shashankp").

%% API
-export([init/2]).

init(Buffer, Cons_Id) ->
  io:format("Consumer number ~w created~n",[Cons_Id]),
  listen(Buffer, Cons_Id).

listen(Buffer, Cons_Id) ->
  timer:sleep(rand:uniform(7)*100),
  Buffer ! {occupied, self(), Cons_Id},
  receive
    empty ->
      io:format("Consumer ~w tried to remove item. But buffer is empty. ~n", [Cons_Id]),
      listen(Buffer, Cons_Id);
    removeItem  ->
      listen(Buffer, Cons_Id)
  end.
