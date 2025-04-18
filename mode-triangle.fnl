(local fennel (require :lib.fennel))
(local shaders (require :shaders))

(fn pp [x] (print (fennel.view x)))

(fn shallow-copy [t]
  (let [t2 {}]
    (each [k v (pairs t)] (tset t2 k v))
    t2))

(local (w h _flags) (love.window.getMode))

(local margin 10)

(local corner-points [[(/ w 2) margin]
                      ;;
                      [margin (- h margin)]
                      ;;
                      [(- w margin) (- h margin)]])

(local points (shallow-copy corner-points))

(fn activate [])

(fn draw [_message]
  (let [my-shader (. shaders :wave-shader)]
    (love.graphics.setShader my-shader)
    (my-shader:send :screenWidth w)
    (my-shader:send :screenHeight h)
    (my-shader:send :points (-> points length))
    (love.graphics.setColor 1 1 1)
    (love.graphics.points points)
    (love.graphics.setShader)))

(fn update [dt set-mode]
  (let [next-target (->> (math.random 3) (. corner-points))
        cur-point (->> points length (. points))
        x1 (. cur-point 1)
        y1 (. cur-point 2)
        x2 (. next-target 1)
        y2 (. next-target 2)
        ;; half way between current point and next corner point
        next-point [(/ (+ x1 x2) 2) (/ (+ y1 y2) 2)]]
    (table.insert points next-point)))

(fn keypressed [key set-mode])

{: activate : draw : update : keypressed}
