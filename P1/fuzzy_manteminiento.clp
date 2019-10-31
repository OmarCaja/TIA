; Funcion fuzzify:

(deffunction fuzzify (?fztemplate ?value ?delta)

    (bind ?low (get-u-from ?fztemplate))
    (bind ?hi  (get-u-to   ?fztemplate))

    (if (<= ?value ?low)
        then
            (assert-string (format nil "(%s (%g 1.0) (%g 0.0))" ?fztemplate ?low ?delta))
        else
            (if (>= ?value ?hi)
                then
                    (assert-string (format nil "(%s (%g 0.0) (%g 1.0))" ?fztemplate (- ?hi ?delta) ?hi))
            else
                (assert-string (format nil "(%s (%g 0.0) (%g 1.0) (%g 0.0))" ?fztemplate (max ?low (- ?value ?delta)) ?value (min ?hi (+ ?value ?delta))))
            )
    )
)

; Clase carretera

(deftemplate carretera
    (slot id (type SYMBOL))
    (slot porcentaje-agrietamiento (type INTEGER))
    (slot temperatura-min (type INTEGER))
    (slot temperatura-max (type INTEGER))
    (slot densidad-trafico (type INTEGER))
    (slot prioridad-reasfaltado (type FLOAT) (default 0.0))
)

; Funcion inicial, para la entrada de datos

(deffunction init()

    (reset)

    (printout t "Introduzca el id de la carretera" crlf)
    (bind ?id (read))
    (printout t "Introduzca el porcentaje agrietamiento" crlf)
    (bind ?agr (read))
    (printout t "Introduzca la temperatura extrema minima" crlf)
    (bind ?tmin (read))
    (printout t "Introduzca la temperatura extrema maxima" crlf)
    (bind ?tmax (read))
    (printout t "Introduzca la densidad de vehiculos por hora" crlf)
    (bind ?dt (read))
    (assert (carretera (id ?id) (porcentaje-agrietamiento ?agr) (temperatura-min ?tmin) (temperatura-max ?tmax) (densidad-trafico ?dt)))
)

; Variables difusas:

(deftemplate agrietamiento
    0 100 %
    (
        (ligero (10 1) (20 0))
        (medio (5 0) (25 1) (45 1) (55 0))
        (fuerte (50 0) (60 1))
    )
)

(deftemplate temperatura
    -10 90 grados
    (
        (fria (5 1) (10 0))
        (moderada (-5 0) (15 1) (40 1) (50 0))
        (calida (35 0) (45 1))
    )
)

(deftemplate prioridad-reasfaltado
    0 100 %
    (
        (baja (z 10 25))
        (media (pi 15 60))
        (urgente (s 55 90))
    )
)

(deftemplate densidad-trafico
    0 300 vehiculos/hora
    (
        (baja (z 20 80))
        (alta (s 120 250))
    )
)

; Reglas

(defrule urgencia-media
    (agrietamiento ligero)
    (or (temperatura fria) (temperatura calida))
=>
    (assert (prioridad-reasfaltado media))
)

(defrule urgencia-very-baja
    (agrietamiento ligero)
    (temperatura moderada)
=>
    (assert (prioridad-reasfaltado very baja))
)

(defrule urgencia-urgente
    (agrietamiento medio)
    (temperatura fria)
=>
    (assert (prioridad-reasfaltado urgente))
)

(defrule urgencia-baja
    (agrietamiento medio)
    (temperatura moderada)
=>
    (assert (prioridad-reasfaltado baja))
)

(defrule urgencia-very-urgente
    (agrietamiento medio)
    (temperatura calida)
=>
    (assert (prioridad-reasfaltado very urgente))
)

(defrule urgencia-extremely-urgente
    (agrietamiento fuerte)
    (or (temperatura fria) (temperatura calida))
=>
    (assert (prioridad-reasfaltado extremely urgente))
)

(defrule urgencia-somewhat-media
    (agrietamiento fuerte)
    (temperatura moderada)
=>
    (assert (prioridad-reasfaltado somewhat media))
)

(defrule densidad-alta
    (densidad-trafico alta)
=>
    (assert (prioridad-reasfaltado very urgente))
)

(defrule densidad-baja
    (densidad-trafico baja)
=>
    (assert (prioridad-reasfaltado more-or-less baja))
)

(defrule fusificar-carretera
    (carretera (porcentaje-agrietamiento ?agr) (temperatura-min ?tmin) (temperatura-max ?tmax) (densidad-trafico ?dt))
=>
    (fuzzify agrietamiento ?agr 0.1)
    (fuzzify temperatura ?tmin 0.1)
    (fuzzify temperatura ?tmax 0.1)
    (fuzzify densidad-trafico ?dt 0.1)
)

(defrule defusificar-carretera
    (declare (salience -1))
    (prioridad-reasfaltado ?p)
    (carretera (id ?id))
=>
    (printout t "Prioridad de mantenimiento carretera " ?id " moment " (moment-defuzzify ?p) crlf)
    (printout t "Prioridad de mantenimiento carretera " ?id " maximum " (maximum-defuzzify ?p) crlf)
    (halt)
)
