(local fennel (require :lib.fennel))

;; test Bloke class
(local Bloke (require :Bloke))

(fn pp [x] (print (fennel.view x)))

(local (w h _flags) (love.window.getMode))

(local bloke-1 (Bloke "dave" 100 100))

(fn activate [])

(fn draw [_message]
  (bloke-1:draw))

(fn update [dt set-mode]
  (bloke-1:update dt))

(fn keypressed [key set-mode]
  (match key
    :left (bloke-1:set-dir :left)
    :right (bloke-1:set-dir :right)
    :up (bloke-1:set-dir :up)
    :down (bloke-1:set-dir :down)))

{: activate : draw : update : keypressed}
