(
    define (problem problema_mantenimiento_carreteras) (:domain mantenimiento-carreteras)

    (:objects 
        cuadrilla1 - cuadrilla
        cuadrilla2 - cuadrilla
        cuadrilla3 - cuadrilla
        cuadrilla4 - cuadrilla
        cisterna1 - cisterna
        cisterna2 - cisterna
        pavimentadora1 - pavimentadora
        pavimentadora2 - pavimentadora
        compactadora - compactadora
        tramo1 - tramo
        tramo2 - tramo
        tramo3 - tramo
        tramo4 - tramo
        tramo5 - tramo
    )

    (:init
        (= (tiempo-desplazar-cuadrilla tramo1 tramo2) 5)
        (= (tiempo-desplazar-cuadrilla tramo2 tramo1) 5)
        (= (tiempo-desplazar-cuadrilla tramo2 tramo3) 6)
        (= (tiempo-desplazar-cuadrilla tramo3 tramo2) 6)
        (= (tiempo-desplazar-cuadrilla tramo3 tramo5) 7)
        (= (tiempo-desplazar-cuadrilla tramo5 tramo3) 7)
        (= (tiempo-desplazar-cuadrilla tramo5 tramo4) 6)
        (= (tiempo-desplazar-cuadrilla tramo4 tramo5) 6)
        (= (tiempo-desplazar-cuadrilla tramo4 tramo2) 4)
        (= (tiempo-desplazar-cuadrilla tramo2 tramo4) 4)
        (= (tiempo-desplazar-maquina tramo1 tramo2) 10)
        (= (tiempo-desplazar-maquina tramo2 tramo1) 10)
        (= (tiempo-desplazar-maquina tramo2 tramo3) 12)
        (= (tiempo-desplazar-maquina tramo3 tramo2) 12)
        (= (tiempo-desplazar-maquina tramo3 tramo5) 14)
        (= (tiempo-desplazar-maquina tramo5 tramo3) 14)
        (= (tiempo-desplazar-maquina tramo5 tramo4) 12)
        (= (tiempo-desplazar-maquina tramo4 tramo5) 12)
        (= (tiempo-desplazar-maquina tramo4 tramo2) 8)
        (= (tiempo-desplazar-maquina tramo2 tramo4) 8)

        (conectados tramo1 tramo2)
        (conectados tramo2 tramo1)
        (conectados tramo2 tramo3)
        (conectados tramo3 tramo2)
        (conectados tramo2 tramo4)
        (conectados tramo4 tramo2)
        (conectados tramo3 tramo5)
        (conectados tramo5 tramo3)
        (conectados tramo4 tramo5)
        (conectados tramo5 tramo4)

        (= (tiempo-compactar) 250)
        (= (tiempo-pavimentar) 190)
        (= (tiempo-aplastar) 150)
        (= (tiempo-pintar) 30)
        (= (tiempo-vallar) 120)
        (= (tiempo-señalizar) 70)

        (= (coste-total) 0)
        (= (coste-maquina cisterna1) 25)
        (= (coste-maquina cisterna2) 25)
        (= (coste-maquina pavimentadora1) 30)
        (= (coste-maquina pavimentadora2) 30)
        (= (coste-maquina compactadora) 35)

        (at cuadrilla1 tramo1)
        (at cuadrilla2 tramo1)
        (at cuadrilla3 tramo5)
        (at cuadrilla4 tramo5)
        (at cisterna1 tramo1)
        (at cisterna2 tramo1)
        (at pavimentadora1 tramo2)
        (at pavimentadora2 tramo2)
        (at compactadora tramo5)

        (se-debe-compactar tramo1)
        (se-debe-compactar tramo2)

        (se-debe-señalizar tramo3)
        (se-debe-señalizar tramo4)
        (se-debe-señalizar tramo5)

        (tramo-disponible tramo1)
        (tramo-disponible tramo2)
        (tramo-disponible tramo3)
        (tramo-disponible tramo4)
        (tramo-disponible tramo5)

        (cuadrilla-disponible cuadrilla1)
        (cuadrilla-disponible cuadrilla2)
        (cuadrilla-disponible cuadrilla3)
        (cuadrilla-disponible cuadrilla4)

        (maquina-disponible cisterna1)
        (maquina-disponible cisterna2)
        (maquina-disponible pavimentadora1)
        (maquina-disponible pavimentadora2)
        (maquina-disponible compactadora)
    )

    (:goal 
        (and
            (at cuadrilla1 tramo1)
            (at cuadrilla2 tramo5)
            (at cuadrilla4 tramo5)
            (at cisterna1 tramo1)
            (at cisterna2 tramo3)
            (at compactadora tramo5)

            (not (se-debe-compactar tramo1))
            (not (se-debe-compactar tramo2))

            (pavimentado tramo1)
            (pavimentado tramo2)
            (pavimentado tramo3)
            (pavimentado tramo4)
            (pavimentado tramo5)

            (aplastado tramo1)
            (aplastado tramo2)
            (aplastado tramo3)
            (aplastado tramo4)
            (aplastado tramo5)

            (pintado tramo1)
            (pintado tramo2)
            (pintado tramo3)
            (pintado tramo4)
            (pintado tramo5)

            (vallado tramo1)
            (vallado tramo2)
            (vallado tramo3)
            (vallado tramo4)
            (vallado tramo5)

            (not (se-debe-señalizar tramo3))
            (not (se-debe-señalizar tramo4))
            (not (se-debe-señalizar tramo5))
        )
    )

    (:metric minimize (+ (* 0.2 (total-time)) (* 0.5 (coste-total))))
)
