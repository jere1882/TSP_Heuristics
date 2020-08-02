function [F, valor] = kruskal(G, costos)
// Ejecuta el algoritmo de Kruskal (practica 2) usando la estructura disjoint set union
// Entradas:
//  G = vector de 2 filas con los extremos de las aristas del grafo
//  costos = vector de costos (cada componente es para una arista)
// Salidas:
//  F = vector de 2 filas con los extremos de las aristas del árbol de expansión
//  valor = costo del arbol de expansión

nodos = max(G);
[zzz, aristas] = size(G);

// En "orden" se almacenan los índices de las aristas ordenadas de menor a mayor por costo
// Esta operación es O(aristas log(aristas))
[zzz, orden] = gsort([costos;1:aristas],'lc','i');

// Ahora inicializamos la matríz A y el grafo H=(V,F)
// Complejidad O(nodos)
aristas_F = 0
F = [];
valor = 0;
A = [];
for v=1:nodos
    A(1,v) = v
    A(2,v) = 1
    A(3,v) = 0
end

// Corazón del algoritmo, complejidad O(aristas log(nodos))
for i=1:aristas
    // Toma la arista según el orden
    u = G(1,orden(i));
    v = G(2,orden(i));
    costo = costos(orden(i));
    // Comentar la siguiente linea para no ver evolución
    // mprintf('Se procesa arista (%1.0f, %1.0f) con costo = %f\n', u, v, costo)
    if A(1,u) ~= A(1,v) then
        // Si u y v pertenecen a diferentes componentes, unirlas (ver explicación en práctica 2)
        if A(2,A(1,u)) < A(2,A(1,v)) then
            v1 = A(1,u);
            v2 = A(1,v);
        else
            v1 = A(1,v);
            v2 = A(1,u);
        end
        A(2,v2) = A(2,v1) + A(2,v2);
        r = A(3,v2);
        A(3,v2) = v1;
        w = v2;
        for i=1:A(2,v1)
            w = A(3,w);
            A(1,w) = v2;
        end
        A(3,w) = r;
        // Agregar la arista a F
        aristas_F = aristas_F + 1;
        F(1,aristas_F) = u;
        F(2,aristas_F) = v;
        valor = valor + costo;
        // Comentar la siguiente linea para no ver evolución
        // mprintf('Se incorpora arista (%1.0f, %1.0f) a F\n', u, v)
    end
end

endfunction
