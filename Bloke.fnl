(local fennel (require :lib.fennel))
(local class (require :lib.30log))
(local anim8 (require :lib.anim8))

(local Bloke (class :Bloke))

(fn Bloke.init [self name x y]
  (set (self.name self.x self.y) (values name x y))
  (set self.sprite-width 48)
  (set self.scale 5)
  (set self.images
       {:down (love.graphics.newImage :assets/unit_1/D_Idle.png)
        :up (love.graphics.newImage :assets/unit_1/U_Idle.png)
        :left (love.graphics.newImage :assets/unit_1/S_Idle.png)
        :right (love.graphics.newImage :assets/unit_1/S_Idle.png)})
  (set self.image (. self.images :down))
  (set self.flippedX false)
  (self:reset-animation))

(fn Bloke.reset-animation [self]
  (let [g (anim8.newGrid self.sprite-width self.sprite-width
                         (self.image:getWidth) (self.image:getHeight))
        anim (anim8.newAnimation (g :1-4 1) 0.15)]
    (set self.animation anim)))

(fn Bloke.set-dir [self dir]
  (match dir
    :left (do
            (set self.flippedX true)
            (set self.image (. self.images :left))
            (self:reset-animation))
    :right (do
             (set self.flippedX false)
             (set self.image (. self.images :right))
             (self:reset-animation))
    :up (do
          (set self.image (. self.images :up))
          (self:reset-animation))
    :down (do
            (set self.image (. self.images :down))
            (self:reset-animation))))

(fn Bloke.draw [self]
  (self.animation:draw self.image (+ self.x (* self.scale self.sprite-width))
                       self.y 0 (if self.flippedX self.scale (* -1 self.scale))
                       self.scale (if self.flippedX self.sprite-width 0) 0))

(fn Bloke.update [self dt]
  (self.animation:update dt))

Bloke
