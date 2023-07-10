//CREATE VARIABLES
rkey = keyboard_check(ord("D"));
lkey = keyboard_check(ord("A"));
dkey = keyboard_check(ord("S"));
ukey = keyboard_check(ord("w"));
fkey = keyboard_check(ord("F"));
Rkey = keyboard_check(ord("R"));
ekey = keyboard_check(ord("E"));
qkey = keyboard_check(ord("Q"));


//CHARACTER MOVEMENT 
if (keyboard_check(vk_right) || rkey) {
    x += 3;
    sprite_index = Character1_Run;
    image_xscale = 1;
}
else if (keyboard_check(vk_left) || lkey) {
    x -= 3;
    sprite_index = Character1_Run;
    image_xscale = -1;
}
else if (keyboard_check(vk_down) || dkey) {    
    sprite_index = Character1_Down;    
}
else if (keyboard_check(vk_alt)) {    
	if (image_xscale = 1){
		x += 6;
		sprite_index = Character1_Dash;    
	}else {
		x -= 6;
		sprite_index = Character1_Dash;    
	}
}
else if (fkey) {
	sprite_index = Character1_Attack1;
}
else if (Rkey) {
	sprite_index = Character1_Attack2;
}
else if (ekey) {	
	if (image_xscale = 1) {
		x += 2;
		sprite_index = Character1_Attack3;
		image_speed = 3;	
	}else {
		x -= 2;
		sprite_index = Character1_Attack3;
		image_speed = 3;	
	}
}
else if (qkey) {
	sprite_index = Character1_Attack4;
	image_speed = 2;
}
else {
	sprite_index = Character1;
	image_speed = 1;	
}

