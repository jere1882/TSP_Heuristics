// Input
// circuito: Una lista de vértices formando un circuito
// unused: Una lista de aristas disponibles para expandir el circuito
//
// Output
// circuito: El mismo circuito input expandido
// unused: Las aristas que no se llegaron a usar
function [circuito,unused] = expandir_circuito(circuito,unused)
    
    // Elegir el vértice inicial desde donde apliaremos el circuito.
    circuit_size = length(circuito);
    [zz,n_aristas_no_usadas] = size(unused);
    
    if circuit_size==0 then
        initial_v = 1;    // Si el circuito inicial está vacío, elegimos cualquiera
    else
        // Si ya hay un circuito previo, necesitamos un vertice inicial que tenga alguna arista 
        // incidiente no usada aún
        for (c_vert_idx=1:circuit_size)
            c1 = circuito(c_vert_idx)
            
            found = %F 
            
            for (a_idx = 1:n_aristas_no_usadas)
                
                a = unused(:,a_idx)
                v1 = a(1)
                v2 = a(2)
                
                if (c1==v1 | c1==v2)
                    found = %T
                    initial_v = c1;
                    break;
                end
            end
            
            if (found)
               break; 
            end       
                      
        end
        
        assert_checktrue(found); 
    end
    
    // En este punto, tenemos un vertice en el circuito existente a partir del cuál podemos insertar un segundo
    // circuito, hecho a partir de las aristas no usadas aún
    
    last_v = initial_v;
    tmp_circuit = [initial_v];
    
    while (%T)
       [zz,n_aristas_no_usadas] = size(unused);
        // Buscar un arista NO USADA que sea incidente en last_v, y agregarla al ciruito
        for a_idx=1:n_aristas_no_usadas
            a = unused(:,a_idx);
            
            if (a(1)==last_v)
                tmp_circuit = [tmp_circuit, a(2)];
                last_v = a(2);
                unused(:,a_idx)=[]
                break;
            end
            
            if (a(2)==last_v)
                tmp_circuit = [tmp_circuit, a(1)];
                last_v = a(1);
                unused(:,a_idx)=[]
                break;
            end
            
        end
        
        if (last_v == initial_v) // Una vez que cerramos el circuito, paramos.
            break;       
        end
        
    end
    
    // En este punto, tenemos un nuevo circuito en tmp_circuit que puede ser insetado 
    //en el circuito provisto como argumento
    if circuit_size==0 
        circuito = tmp_circuit;  // No hay nada que combinar si el circuito anterior estaba vacio
    else
        // Si el circuito anterior tenía elementos, entonces debemos combinarlos:
        circuito_copia = circuito;
        circuito = [];
       
       // Primero copiamos el primer tramo del circuito original 
        appended = %F;
        
        for (v = circuito_copia)
            if (v==initial_v & appended~=%T)
               circuito = [circuito,tmp_circuit];
               appended = %T;
            else
               circuito = [circuito,v]
            end
        end
        
        
    end
    
endfunction

function [circuito] = generar_circuito_euleriano(edges)

    unused = edges;
    circuito = [];
    
    while(unused ~= [])
        [circuito,unused] = expandir_circuito(circuito,unused);
    end
    
endfunction


function [tour, valor] = alg2aprox(A)
    // Ejecuta el algoritmo 2-aproximado
    // Entrada:
    //  A = matríz de distancias de la instancia TSP
    // Salida:
    //  tour = vector con los vértices a ser recoridos por el tour
    //  valor = valor del tour generado
    
    [nodos, zzz] = size(A); // en "nodos" se guarda la cantidad de vértices de la instancia
    
    
    // 1- Obtener un arbol de expansion mimimo
    [G, costos] = genera_grafo_costos(A);
    [F, valor]  = kruskal(G, costos);
    
    // 2 - Generar un circuito euleriano en (G, F++F)
    aristas = [F,F]
    circuito = generar_circuito_euleriano(aristas);
    
    // 3- Simplificarlo tomando atajos
    circuito_simplificado = []
    
    for v=circuito
        
        was_already_visited = %f;
        
        for (a=circuito_simplificado)
            if a==v
                was_already_visited = %t;
                break;
            end
        end
        
        if (~was_already_visited)
            circuito_simplificado = [circuito_simplificado,v]
        end
        
    end
    
    
    tour = circuito_simplificado;
    
    // 4 - Calculamos el valor
    valor = 0
    
    for (i = 1:(length(circuito_simplificado)-1))
        vi  = circuito_simplificado(i);
        vin = circuito_simplificado(i+1);
        cost = A(vi,vin);
        valor = valor + cost;    
    end
    
    valor = valor + A(circuito_simplificado(length(circuito_simplificado)),circuito_simplificado(1))
    
     
endfunction
