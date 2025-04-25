(local fennel (require :lib.fennel))
(local repl (require :lib.stdio))
(local class (require :lib.30log))
(local canvas (let [(w h) (love.window.getMode)]
                (love.graphics.newCanvas w h)))

(var scale 1)

;; set the first mode
(var (mode mode-name) nil)

(fn set-mode [new-mode-name ...]
  (set (mode mode-name) (values (require new-mode-name) new-mode-name))
  (when mode.activate
    (match (pcall mode.activate ...)
      (false msg) (print mode-name "activate error" msg))))

(fn love.load [args]
  (set-mode :mode-intro)
  ;; nearest-neighbor pixel precision
  (canvas:setFilter :nearest :nearest)
  (when (not= :web (. args 1)) (repl.start)))

(fn safely [f]
  (xpcall f #(set-mode :error-mode mode-name $ (fennel.traceback))))

(fn love.draw []
  ;; the canvas allows you to get sharp pixel-art style scaling; if you
  ;; don't want that, just skip that and call mode.draw directly.
  (love.graphics.setDefaultFilter :nearest)
  (love.graphics.setCanvas canvas)
  (love.graphics.clear)
  (love.graphics.setColor 1 1 1)
  (safely mode.draw)
  (love.graphics.setCanvas)
  (love.graphics.setColor 1 1 1)
  (love.graphics.draw canvas 0 0 0 scale scale))

(fn love.resize [x y])

(fn love.update [dt]
  (when mode.update
    (safely #(mode.update dt set-mode))))

(fn love.keypressed [key code isrepeat]
  (match key
    :escape (love.event.quit)
    :backspace (set-mode :mode-intro)
    :space (set-mode :mode-game)))

(fn love.keyreleased [key code isrepeat]
  (if (and (love.keyboard.isDown :lctrl :rctrl :capslock) (= key :q))
      (love.event.quit)
      ;; add what each keypress should do in each mode
      (not isrepeat)
      (safely #(mode.keypressed key set-mode))))
