(local fennel (require :lib.fennel))

;; test Bloke classes/subclasses
(local blokes (require :Bloke))

(fn pp [x] (print (fennel.view x)))

(local (w h _flags) (love.window.getMode))

(local blokes (let [seed (math.randomseed (os.time))
                    blokes [(. blokes :Bloke1)
                            (. blokes :Bloke2)
                            (. blokes :Bloke3)]]
                (icollect [i v (ipairs [:xander
                                        :buffy
                                        :giles
                                        :willow
                                        :angel
                                        :tara])]
                  (let [rand (math.random 3)
                        Bloke (. blokes rand)]
                    (Bloke v (* i 96) 100)))))

(fn activate [])

(fn draw [_message]
  (each [i bloke (ipairs blokes)]
    (bloke:draw)))

(fn update [dt set-mode]
  (each [i bloke (ipairs blokes)]
    (bloke:update dt)))

(fn keypressed [key set-mode]
  (let [valid-keys [:left :right :up :down]
        key-valid? (icollect [i k (ipairs valid-keys)] (= k key))]
    (when key-valid?
      (each [i bloke (ipairs blokes)]
        (bloke:set-dir key)))))

{: activate : draw : update : keypressed}
