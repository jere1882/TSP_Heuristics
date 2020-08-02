function [G, costos] = genera_grafo_costos(A)
// Genera un grafo con costos en sus aristas a partir de una instancia TSP
// Entrada:
//  A = matríz de distancias de una instancia TSP
// Salida:
//  G = vector de 2 filas con los extremos de las aristas del grafo
//  costos = vector de costos (cada componente es para una arista)

[nodos, zzz] = size(A);

e = 1;
for u=1:(nodos-1)
    for v=(u+1):nodos
        G(1,e) = u;
        G(2,e) = v;
        costos(e) = A(u,v);
        e = e + 1;
    end
end
costos = costos';
endfunction
