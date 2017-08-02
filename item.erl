%%%-------------------------------------------------------------------
%%% @author shashankp
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jul 2017 11:40 PM
%%%-------------------------------------------------------------------
-module(item).
-author("shashankp").

%% API
-export([init/0]).

init() ->
  listen(0).

listen(Id) ->
  receive

    {assignId, ItemId} ->
      listen(ItemId);

    {From, getId} ->
      From ! {itemid, Id},
      listen(Id)

  end.
