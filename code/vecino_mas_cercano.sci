function [tour, valor] = vecino_mas_cercano(A, v1)
// Ejecuta el algoritmo del Vecino más cercano sobre la instancia TSP dada
// Entrada:
//  A = matríz de distancias de la instancia TSP
//  v1 = vértice inicial
// Salida:
//  tour = vector con los vértices a ser recoridos por el tour
//  valor = valor del tour generado

[nodos, zzz] = size(A); // en "nodos" se guarda la cantidad de vértices de la instancia

vertices_permitidos = 1:nodos; // al principio todos los vertices son permitidos

// Cargamos el primer vértice del tour y lo borramos de los vértices permitidos
valor = 0;
tour(1) = v1;
vertices_permitidos(find(vertices_permitidos==v1)) = [];

v = v1;
for i=2:nodos
    // buscamos el siguiente vecino más cercano de enrte los permitidos
    valor_minimo = %inf;
    vert_minimo = -1;
    for j=vertices_permitidos
        if (valor_minimo > A(v,j)) then
            vert_minimo = j;
            valor_minimo = A(v,j);
        end
    end
    // lo incorporamos al tour y lo borramos del los permitidos
    valor = valor + valor_minimo;
    tour(i) = vert_minimo;
    vertices_permitidos(find(vertices_permitidos==vert_minimo)) = [];
    // pasamos al siguiente vértice
    v = vert_minimo;
end

// agregamos el valor desde ir del último al primer nodo
valor = valor + A(v,v1);

endfunction
