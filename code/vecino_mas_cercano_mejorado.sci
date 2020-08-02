function [tour, valor] = vecino_mas_cercano_mejorado(A)
// Ejecuta el algoritmo ''mejorado'' del Vecino más cercano sobre la instancia TSP dada
// Entrada:
//  A = matríz de distancias de la instancia TSP
// Salida:
//  tour = vector con los vértices a ser recoridos por el tour
//  valor = valor del tour generado

[nodos, zzz] = size(A); // en "nodos" se guarda la cantidad de vértices de la instancia

valor = %inf
best_idx  = -1

for n=1:nodos
  [tmp_tour,tmp_valor] = vecino_mas_cercano(A,n);
  //disp("iter ",n, " value ",tmp_valor);
  if (tmp_valor < valor)
      valor = tmp_valor;
      best_idx = n;
      tour = tmp_tour;
  end
end


endfunction
