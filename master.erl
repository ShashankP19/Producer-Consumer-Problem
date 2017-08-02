%%%-------------------------------------------------------------------
%%% @author shashankp
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Jul 2017 12:36 AM
%%%-------------------------------------------------------------------
-module(master).
-author("shashankp").

%% API
-export([init/0]).

init() ->
  {ok, [Num_Prod]} = io:fread("Input number of producers : ", "~d"),
  {ok, [Num_Cons]} = io:fread("Input number of consumers : ", "~d"),
  Buffer = spawn(buffer, init, []),
  start_prod(1, Num_Prod, Buffer),
  start_cons(1, Num_Cons, Buffer).

start_prod(Prod_Id, Num_Prod, Buffer) when Prod_Id < Num_Prod ->
  spawn(producer, init, [Buffer, Prod_Id]),
  start_prod(Prod_Id + 1, Num_Prod, Buffer);

start_prod(Num_Prod, Num_Prod, Buffer) ->
  spawn(producer, init, [Buffer, Num_Prod]).

start_cons(Cons_Id, Num_Cons, Buffer) when Cons_Id < Num_Cons ->
  spawn(consumer, init, [Buffer, Cons_Id]),
  start_cons(Cons_Id + 1, Num_Cons, Buffer);

start_cons(Num_Prod, Num_Prod, Buffer) ->
  spawn(consumer, init, [Buffer, Num_Prod]).
