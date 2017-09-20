%Fatos sobre companhias áereas
%comp(sigla, nome)
comp('tap', 'air portugal').
comp('luf', 'lufthansa').
comp('ba',  'british airways').
comp('af',  'air france').
comp('jal', 'japan airlines').

%Fatos sobre voos
% voo(id, origem, destino, companhia)
voo('tap1', 'lisboa', 'frankfurt', 'tap').
voo('luf1', 'lisboa', 'frankfurt', 'luf').
voo('tap2', 'lisboa', 'londres', 'tap').
voo('ba1',  'lisboa', 'londres', 'ba').
voo('tap3', 'lisboa', 'paris', 'tap').
voo('af1',  'lisboa', 'paris', 'af').
voo('ba2', 'londres', 'frankfurt', 'ba').
voo('luf2','londres', 'frankfurt', 'luf').
voo('af2', 'paris', 'frankfurt', 'af').
voo('lu3', 'paris', 'frankfurt', 'luf').
voo('lu4', 'frankfurt', 'munique', 'luf').
voo('lu5', 'munique', 'osaka', 'luf').
voo('lu6', 'munique', 'tokio', 'luf').
voo('ja1', 'osaka', 'tokio', 'jal').
voo('ja2', 'osaka', 'sapporo', 'jal').
voo('ja3', 'osaka', 'yokohama', 'jal').
voo('ja4', 'tokio', 'sapporo', 'jal').
voo('ja5', 'tokio', 'yokohama', 'jal').

%regras
rota(ORIGEM,ORIGEM,[]).
rota(ORIGEM,DESTINO,L):-L=[A:B|R],voo(A,ORIGEM,MEIO,B),rota(MEIO,DESTINO,R).
rotaIG(ORIGEM,DESTINO):-findall(X,rota(ORIGEM,DESTINO,X),LISTA),writeln(LISTA).
compInfo(DESTINO):-findall([X:B],(voo(_,_,DESTINO,X),comp(X,B)),LISTA),writeln(LISTA).
compVoo(COMP):-findall([A:B:C],(comp(X,COMP),voo(A,B,C,X)),LISTA),writeln(LISTA).

%interface 
%vejo todas as rotas da origem ao destino
janela1:-new(D,dialog('BUSCAR ROTAS')),
        send(D, append(new(T,text_item(cidade_de_origem)))),
        send(D,append(new(T2,text_item(cidade_de_destino)))),
        new(B,button('Buscar',message(@prolog,rotaIG,T?selection,T2?selection))),
        new(B2,button('Sair',and(message(D,destroy)))),
        send(D,append(B)),
        send(D,append(B2)),
        send(D,default_button,B),
        send(D,open).
%informo a cidade e vejo as companhias com voos para aquela cidade
janela2:-new(D,dialog('Buscar companhias aereas')),
        send(D,append,new(C,text_item(cidade))),
        new(B,button('Buscar',message(@prolog,compInfo,C?selection))),
        new(B2,button('Sair',message(D,destroy))),
        send(D,append(B)),
        send(D,append(B2)),
        send(D,default_button,'Buscar'),
        send(D,open).
%informo a companhia e vejo os voo ofertados
janela3:-new(D,dialog('Buscar vôos por companhia')),
        send(D,append,new(C,text_item(companhia))),
        new(B,button('Buscar',message(@prolog,compVoo,C?selection))),
        new(B2,button('Sair',message(D,destroy))),
        send(D,append(B)),
        send(D,append(B2)),
        send(D,default_button,'Buscar'),
        send(D,open).