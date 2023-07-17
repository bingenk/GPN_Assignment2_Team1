//CREATE VARIABLES
var rkey = keyboard_check(ord("D"));
var lkey = keyboard_check(ord("A"));
var dkey = keyboard_check(ord("S"));
var ukey = keyboard_check(ord("w"));
var fkey = keyboard_check(ord("F"));
var Rkey = keyboard_check(ord("R"));
var ekey = keyboard_check(ord("E"));
var qkey = keyboard_check(ord("Q"));


if (keyboard_check(vk_right) || rkey) {
    x += 3;
    // Only change sprite if on the ground
    if (onGround) {
        sprite_index = Character1_Run;
    }
    image_xscale = 1;
}
else if (keyboard_check(vk_left) || lkey) {
    x -= 3;
    // Only change sprite if on the ground
    if (onGround) {
        sprite_index = Character1_Run;
    }
    image_xscale = -1;
}
else if (keyboard_check(vk_down) || dkey) {
    sprite_index = Character1_Down;
}
else if (keyboard_check(vk_alt)) {
    if (image_xscale == 1) {  
        x += 6;
        sprite_index = Character1_Dash;
    }
    else {
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
    if (image_xscale == 1) {  
        x += 2;
        sprite_index = Character1_Attack3;
        image_speed = 3;
    }
    else {
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

if (Attack2_Cooldown > 0) {
    Attack2_Cooldown -= 1;
}

// Check if character is on the ground
if (place_meeting(x, y + 1, obj_ground)) {
    onGround = true;
} else {
    onGround = false;
}

// Handle jumping
if (keyboard_check(vk_space) || ukey) {
	sprite_index = Character1_Jump; 
    if (onGround) {
        vSpeed = -jumpSpeed; // Jump upwards		
    }
}

// Apply gravity
if (!onGround) {
    vSpeed += grav;
}

// Apply vertical speed
y += vSpeed;

// Prevent character from going into the ground
if (place_meeting(x, y + vSpeed, obj_ground) && vSpeed > 0) {
    while (!place_meeting(x, y + sign(vSpeed), obj_ground)) {
        y += sign(vSpeed); // Move to the ground
    }
    vSpeed = 0; // Stop moving downwards
}