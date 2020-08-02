function dibuja_tour(tour, coordenadas)
// Dibuja en pantalla un tour
// Entrada:
//  tour = vector con los vértices a ser recoridos por el tour
//  coordenadas = vector de 2 filas con las coordenadas en el plano de cada vértice

nodos = max(tour);

for v=1:nodos
    TSPTownList(v,1) = v;
    TSPTownList(v,2) = coordenadas(1,v);
    TSPTownList(v,3) = coordenadas(2,v);
end
plot_tsp(TSPTownList, tour, 'Tour')

endfunction


// Lo que sigue es parte del toolbox tsp-2.0 de:
// http://scilab-mip.googlecode.com/files/tsp-2.0.zip

function plot_tsp(TSPTownList, TSPVar, TSPComment)
if (size(TSPVar,1)==1) then
  TSPVar = TSPVar';
end
maxX = max(TSPTownList(:,2));
minX = min(TSPTownList(:,2));
maxY = max(TSPTownList(:,3));
minY = min(TSPTownList(:,3));
scf();
a = gca();
a.data_bounds = [minX minY;maxX maxY];
drawlater;
for i=1:size(TSPVar,1)-1
  plot([TSPTownList(TSPVar(i),2);TSPTownList(TSPVar(i+1),2)],[TSPTownList(TSPVar(i),3);TSPTownList(TSPVar(i+1),3)], 'k+-');
end
plot([TSPTownList(TSPVar(1),2);TSPTownList(TSPVar($),2)],[TSPTownList(TSPVar(1),3);TSPTownList(TSPVar($),3)], 'k+-');
xtitle(TSPComment,'X','Y');
drawnow;
endfunction
