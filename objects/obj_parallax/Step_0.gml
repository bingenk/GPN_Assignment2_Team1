var near = layer_get_id("Backgrounds_4");
var nearer = layer_get_id("Backgrounds_3");
var distant = layer_get_id("Backgrounds_2");
var away = layer_get_id("Backgrounds_1");

layer_x(near,    lerp(0, camera_get_view_x(view_camera[0]), 0.5));
layer_x(nearer,  lerp(0, camera_get_view_x(view_camera[0]), 0.7));
layer_x(distant, lerp(0, camera_get_view_x(view_camera[0]), 0.85));
layer_x(away,    lerp(0, camera_get_view_x(view_camera[0]), 0.9));

