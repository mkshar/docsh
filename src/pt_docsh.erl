-module(pt_docsh).
-export([parse_transform/2]).

parse_transform(AST, _Options) ->
    File = file(AST),
    print("file: ~s~n", [File]),
    %print("AST: ~p~n", [AST]),
    %print("xmerl doc: ~p~n", [edoc(AST)]),
    %print("xml doc: ~s~n", [xml(AST)]),
    print("internal (from edoc): ~p~n", [edoc_xmerl(AST)]),
    AST.

print(Fmt, Args) ->
    io:format(Fmt, Args).

file(AST) ->
    {_,_,file,{File,_}} = lists:keyfind(file, 3, AST),
    File.

edoc(AST) ->
    {_Mod, EDoc} = edoc:get_doc(file(AST), []),
    EDoc.

xml(AST) ->
    iolist_to_binary(xmerl:export_simple([edoc(AST)], xmerl_xml)).

edoc_xmerl(AST) ->
    xmerl:export_simple([edoc(AST)], docsh_xmerl).