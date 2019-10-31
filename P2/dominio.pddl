(
    define (domain mantenimiento-carreteras)

    (:requirements :durative-actions :typing :fluents)

    (:types
        cuadrilla maquina tramo - object
        cisterna pavimentadora compactadora - maquina 
    )

    (:predicates 
        (se-debe-compactar ?t - tramo)
        (pavimentado ?t - tramo)
        (aplastado ?t - tramo)
        (pintado ?t - tramo)
        (vallado ?t - tramo)
        (se-debe-senalizar ?t - tramo)
        (cuadrilla-disponible ?c - cuadrilla)
        (maquina-disponible ?m - maquina)
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
        (tiempo-pintar)
        (tiempo-vallar)
        (tiempo-senalizar)
        (coste-maquina ?m - maquina)
        (coste-total)
    )

    (:durative-action desplazar-cuadrilla
        :parameters (?c - cuadrilla ?t1 - tramo ?t2 - tramo)
        :duration (= ?duration (tiempo-desplazar-cuadrilla ?t1 ?t2))
        :condition (and 
            (at start (and
                (at ?c ?t1)
                (conectados ?t1 ?t2)
                (cuadrilla-disponible ?c)
                (tramo-disponible ?t1)
                (tramo-disponible ?t2)
            ))
            (over all (and
                (tramo-disponible ?t1)
                (tramo-disponible ?t2)
            ))
            (at end (and 
            ))
        )
        :effect (and 
            (at start (and
                (not (at ?c ?t1))
                (not (cuadrilla-disponible ?c))
            ))
            (at end (and
                (at ?c ?t2)
                (cuadrilla-disponible ?c)
            ))
        )
    )

    (:durative-action desplazar-maquina
        :parameters (?m - maquina ?t1 - tramo ?t2 - tramo)
        :duration (= ?duration (tiempo-desplazar-maquina ?t1 ?t2))
        :condition (and 
            (at start (and
                (at ?m ?t1)
                (conectados ?t1 ?t2)
                (maquina-disponible ?m)
                (tramo-disponible ?t1)
                (tramo-disponible ?t2)
            ))
            (over all (and
                (tramo-disponible ?t1)
                (tramo-disponible ?t2)
            ))
            (at end (and 
            ))
        )
        :effect (and 
            (at start (and
                (not (at ?m ?t1))
                (not (maquina-disponible ?m))
            ))
            (at end (and
                (at ?m ?t2)
                (maquina-disponible ?m)
            ))
        )
    )

    (:durative-action compactar
        :parameters (?c - compactadora ?t - tramo)
        :duration (= ?duration (tiempo-compactar))
        :condition (and 
            (at start (and 
                (at ?c ?t)
                (se-debe-compactar ?t)
                (maquina-disponible ?c)
                (tramo-disponible ?t)
            ))
            (over all (and
                (at ?c ?t)
            ))
            (at end (and 
            ))
        )
        :effect (and 
            (at start (and
                (not (maquina-disponible ?c)) 
                (not (tramo-disponible ?t)) 
            ))
            (at end (and
                (maquina-disponible ?c)
                (tramo-disponible ?t)
                (not (se-debe-compactar ?t))
                (increase (coste-total) (coste-maquina ?c))
            ))
        )
    )

    (:durative-action pavimentar
        :parameters (?c - cisterna ?p - pavimentadora ?t - tramo)
        :duration (= ?duration (tiempo-pavimentar))
        :condition (and 
            (at start (and
                (at ?c ?t)
                (at ?p ?t)
                (not (se-debe-compactar ?t))
                (not (pavimentado ?t))
                (maquina-disponible ?c)
                (maquina-disponible ?p)
                (tramo-disponible ?t)
            ))
            (over all (and
                (at ?c ?t)
                (at ?p ?t)
            ))
            (at end (and 
            ))
        )
        :effect (and 
            (at start (and
                (not (tramo-disponible ?t))
                (not (maquina-disponible ?C))
                (not (maquina-disponible ?p))
            ))
            (at end (and
                (maquina-disponible ?c)
                (maquina-disponible ?p)
                (tramo-disponible ?t)
                (pavimentado ?t)
                (increase (coste-total) (+ (coste-maquina ?c) (coste-maquina ?p)))
            ))
        )
    )

    (:durative-action aplastar
        :parameters (?c - compactadora ?t - tramo)
        :duration (= ?duration (tiempo-aplastar))
        :condition (and 
            (at start (and
                (at ?c ?t)
                (pavimentado ?t)
                (not (aplastado ?t))
                (maquina-disponible ?c)
                (tramo-disponible ?t)
            ))
            (over all (and
                (at ?c ?t)
            ))
            (at end (and
            ))
        )
        :effect (and 
            (at start (and
                (not (maquina-disponible ?c))
                (not (tramo-disponible ?t))
            ))
            (at end (and
                (maquina-disponible ?c)
                (tramo-disponible ?t)
                (aplastado ?t)
                (increase (coste-total) (coste-maquina ?m))
            ))
        )
    )

    (:durative-action pintado
        :parameters (?c - cuadrilla ?t - tramo)
        :duration (= ?duration (tiempo-pintar))
        :condition (and 
            (at start (and
                (at ?c ?t)
                (cuadrilla-disponible ?c)
                (tramo-disponible ?t)
                (not (aplastado ?t))
                (not (pintado ?t))
            ))
            (over all (and
                (at ?c ?t)
            ))
            (at end (and 
            ))
        )
        :effect (and 
            (at start (and
                (not (cuadrilla-disponible ?c))
                (not (tramo-disponible ?t))
            ))
            (at end (and
                (cuadrilla-disponible ?c)
                (tramo-disponible ?t)
                (pintado ?t)
            ))
        )
    )

    (:durative-action vallado
        :parameters (?c - cuadrilla ?t - tramo)
        :duration (= ?duration (tiempo-vallar))
        :condition (and 
            (at start (and 
                (at ?c ?t)
                (cuadrilla-disponible ?c)
                (tramo-disponible ?t)
                (not (vallado ?t))
                (aplastado ?t)
            ))
            (over all (and
                (at ?c ?t)
            ))
            (at end (and 
            ))
        )
        :effect (and 
            (at start (and
                (not (cuadrilla-disponible ?c))
                (not (tramo-disponible ?t))
            ))
            (at end (and 
                (cuadrilla-disponible ?c)
                (tramo-disponible ?t)
                (vallado ?t)
            ))
        )
    )

    (:durative-action senalizado
        :parameters (?c - cuadrilla ?t - tramo)
        :duration (= ?duration (tiempo-senalizar))
        :condition (and 
            (at start (and
                (at ?c ?t)
                (cuadrilla-disponible ?c)
                (tramo-disponible ?t)
                (se-debe-senalizar ?t)
                (aplastado ?t)
            ))
            (over all (and
                (at ?c ?t)
            ))
            (at end (and 
            ))
        )
        :effect (and 
            (at start (and
                (not (cuadrilla-disponible ?c))
                (not (tramo-disponible ?t))
            ))
            (at end (and
                (cuadrilla-disponible ?c)
                (tramo-disponible ?t)
                (not (se-debe-senalizar ?t))
            ))
        )
    )
)