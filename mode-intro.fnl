(import-macros {: incf} :sample-macros)

(local countdown-time 30)
(var counter 0)
(var time 0)

(love.graphics.setNewFont 30)

(local (major minor revision) (love.getVersion))
(local fennel (require :lib.fennel))
(fn pp [x] (print (fennel.view x)))

(fn activate [])

(fn draw [_message]
         (local (w h _flags) (love.window.getMode))
         (let [version-str (: "Love Version: %s.%s.%s" :format  major minor revision)
               message-str (: "This window should close in %0.1f seconds" :format (math.max 0 (- countdown-time time)))
               counter-str (: "Counter %d" :format counter)]
           (love.graphics.printf version-str 0 10 w :center)
           (love.graphics.printf message-str 0 (- (/ h 2) 15) w :center)
           (love.graphics.printf counter-str 0 (+ (/ h 2) 15) w :center)))

(fn update [dt set-mode]
             (if (< counter 65535)
                 (set counter (+ counter 1))
                 (set counter 0))
             (incf time dt)
             (when (> time countdown-time)
               (set time 0)
               (love.event.quit)))

(fn keypressed [key set-mode])

{ : activate : draw : update : keypressed }
