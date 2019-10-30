(
    define (domain asfaltado)

    (:requirements :durative-actions :typing :fluents)

    (:types
        cuadrilla maquina tramo - object
        cisterna pavimentadora compactadora - maquina 
    )

    (:predicates 
        (se-debe-compactar ?t - tramo)
        (compactado ?t - tramo)
        (pavimentado ?t - tramo)
        (aplastado ?t - tramo)
        (pintado ?t - tramo)
        (vallado ?t - tramo)
        (necesita-señales ?t - tramo)
        (señalizado ?t - tramo)
        (cuadrilla-disponible ?t - tramo)
        (maquina-disponible ?t - tramo)
        (tramo-disponible ?t - tramo)
        (conectados ?t1 - tramo ?t2 - tramo)
        (at ?x - (either cuadrilla maquina) ?t - tramo)
    )

    (:functions 
        (tiempo-desplazar-cuadrilla ?t1 - tramo ?t2 - tramo)
        (tiempo-desplazar-maquina ?t1 - tramo ?t2 - tramo)
        (tiempo-compactar)
        (tiempo-pavimentar)
        (tiempo-aplastar)
        (tiempo-pintado)
        (tiempo-vallado)
        (tiempo-señalizado)
        (coste-maquina ?m - maquina)
        (coste-total)
    )
)