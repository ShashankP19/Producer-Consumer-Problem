%%%-------------------------------------------------------------------
%%% @author shashankp
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jul 2017 11:14 PM
%%%-------------------------------------------------------------------
-module(buffer).
-author("shashankp").

%% API
-export([init/0, listen/3, output/1, getItemId/1]).

init() ->
  io:format("Buffer created~n"),
  MaxSize = 10,
  BufferArray = [],
  ItemId_Prod = 1,
  listen(MaxSize, BufferArray, ItemId_Prod).

listen(MaxSize, BufferArray, ItemId_Prod) ->
  receive

    {available, From, Item, Prod_Id} ->
      if length(BufferArray) < MaxSize ->
          Item ! {assignId, ItemId_Prod},
          NewBufferArray = lists:append(BufferArray, [Item]),
          From ! putItem,
          io:format("Producer ~w inserted item ~w. There are ~w items in buffer.~n", [Prod_Id,  ItemId_Prod, length(NewBufferArray)]),
          output(NewBufferArray),
          listen(MaxSize, NewBufferArray, ItemId_Prod + 1);
        true ->
          From ! full,
          listen(MaxSize, BufferArray, ItemId_Prod)
      end;

    {occupied, From, Cons_Id} ->
      if length(BufferArray) > 0 ->
          [Item | NewBufferArray] = BufferArray,
          ItemId_Cons = getItemId(Item),
          From ! removeItem,
          io:format("Consumer ~w removed item ~w. There are ~w items in buffer.~n", [Cons_Id, ItemId_Cons, length(NewBufferArray)]),
          output(NewBufferArray),
          listen(MaxSize, NewBufferArray, ItemId_Prod);
        true ->
          From ! empty,
          listen(MaxSize, BufferArray, ItemId_Prod)
      end

  end.



output(Buffer) ->
  io:format("Buffer: ["),
  fnl(Buffer).


fnl([H]) ->
  io:format("~w]~n", [getItemId(H)]);
fnl([H|T]) ->
  io:format("~w, ", [getItemId(H)]),
  fnl(T);
fnl([]) ->
  io:format("]~n").

getItemId(Item) ->
  Item ! {self(), getId},
  receive
    {itemid, Id} ->
      Id
  end.