function [A, coordenadas] = lee_TSP(archivo)
// Lee un archivo TSP con puntos en el plano euclídeo
// Entrada:
//  archivo = nombre del archivo TSP
// Salida:
//  A = matríz de distancias de la instancia TSP
//  coordenadas = vector de 2 filas con las coordenadas en el plano de cada vértice

[TSP_Town_List, TSPSize, TSPComment] = read_tsp(archivo);
A = compute_tsp_dist(TSP_Town_List, 0);
for v=1:TSPSize
    coordenadas(1,v) = TSP_Town_List(v,2);
    coordenadas(2,v) = TSP_Town_List(v,3);
end

endfunction


// Lo que sigue es parte del toolbox tsp-2.0 de:
// http://scilab-mip.googlecode.com/files/tsp-2.0.zip

function [TSP_Town_List, TSPSize, TSPComment] = read_tsp(Filename)
[fd, err] = mopen(Filename,'r');
if (err) then
  printf('error while reading file %s\n',Filename);
  abort;
end

Line = mgetl(fd,1);
Line = stripblanks(tokens(Line,':'));

while(Line(1)~='EOF')
  select(Line(1))
  case 'NAME' then
    TSPName = Line(2);
  case 'COMMENT' then
    TSPComment = Line(2);
  case 'TYPE' then
    if (Line(2)~='TSP') then
      error('the instance to read must be of ''TSP'' type');
    end
  case 'EDGE_WEIGHT_TYPE' then
    if (Line(2)~='EUC_2D') then
      error('the edges of this instance to read must be of ''EUC_2D'' type');
    end
  case 'NODE_COORD_SECTION' then
    TspDataType = Line(1);
    if (TspDataType~='NODE_COORD_SECTION') then
      error('this function is only able to read data of the type NODE_COORD_SECTION');
    end
  case 'DIMENSION' then
    TSPSize = eval(Line(2));
  else
    Line = stripblanks(tokens(Line,' '));
    Index = 0;
    while(Line(1)~='EOF')
      Index = Index + 1;
      for i=1:size(Line,1)
        TSP_Town_List(Index,i) = eval(Line(i));
      end
      Line = mgetl(fd,1);
      Line = stripblanks(tokens(Line,' '));
    end // While
  end
  if (Line(1)~='EOF') then
    Line = mgetl(fd,1);
    Line = stripblanks(tokens(Line,':'));
  end
end
mclose(fd);
endfunction

function TSP_Matrix_Dist = compute_tsp_dist(TSP_List_Town, Log)
if (~isdef('Log','local')) then
  Log = %F;
end
n = size(TSP_List_Town,1);
TSP_Matrix_Dist = zeros(n,n);
Index = 0;
for i=1:n
  for j=1:n
    Index = Index + 1;
    if (modulo(Index,10)) then
      if (Log) then
        printf('compute_tsp_dist: step %d / %d\n', Index, n*n);
      end
    end
    if (i==j) then
      TSP_Matrix_Dist(i,j) = %inf;
    else
      TSP_Matrix_Dist(i,j) = sqrt((TSP_List_Town(i,2) - TSP_List_Town(j,2))^2 + (TSP_List_Town(i,3) - TSP_List_Town(j,3))^2);
    end
  end
end
endfunction
