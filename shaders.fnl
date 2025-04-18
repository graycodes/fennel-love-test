(local wave-shader (love.graphics.newShader "
#define M_PI 3.1415926535897932384626433832795;
extern number screenWidth;
extern number screenHeight;
extern number points;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  float time = points / 200.0;
  float pos_scaled = (screen_coords.x / screenWidth) * M_PI;
  
  float r = sin(pos_scaled + time) + 1.0 / 2.0;
  float g = 0.7;
  float b = screen_coords.y / screenHeight;
  
  return vec4(r, g, b, 1.0);
}"))

{ : wave-shader }
