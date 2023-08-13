// In a Draw GUI Event
//draw_text(32, 32, "HP: " + string(hp)); // Draw the HP at the position (32, 32)


// Get the width of the Heart sprite
var Heart_width = sprite_get_width(Heart);

// Draw the heart sprite
draw_sprite(Heart, 0, 30, 55);

draw_sprite_stretched(sHealthBar,0, healthbar_x, healthbar_y, (hp/hp_max) * healthbar_width, healthbar_height);



draw_set_font(spr_menu_font); 
draw_set_color(c_white);
var x_position = 37; 
var y_position = 80; 
draw_sprite(Coin, 0, 30, 97); 
draw_text(x_position + sprite_get_width(Coin), y_position, "x " + string(coins));

if (room == Level2)
{
	instance_destroy(Coin);
	draw_set_font(spr_menu_font); 
	draw_set_color(c_white);
	var x_position = 57; 
	var y_position = 120; 
	
	var xscale = 3; 
    var yscale = 3; 
	
	draw_sprite_ext(Gem_1, 0, 30, 137, xscale, yscale, 0, c_white, 1);
	draw_text(x_position + sprite_get_width(Gem_1), y_position, "x " + string(gems));
}


