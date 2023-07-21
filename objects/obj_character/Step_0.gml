//CREATE VARIABLES
var rkey = keyboard_check(ord("D"));
var lkey = keyboard_check(ord("A"));
var dkey = keyboard_check(ord("S"));
var ukey = keyboard_check(ord("w"));
var fkey = keyboard_check(ord("F"));
var Rkey = keyboard_check(ord("R"));
var ekey = keyboard_check(ord("E"));
var qkey = keyboard_check(ord("Q"));



//Right movement
if (keyboard_check(vk_right) || rkey) {
    x += 3;
    // Only change sprite if on the ground
    if (onGround && !(keyboard_check(vk_down) || dkey)) {
        sprite_index = Character1_Run;
    }
    image_xscale = 1;
}
//Left movement
else if (keyboard_check(vk_left) || lkey) {
    x -= 3;
    // Only change sprite if on the ground
    if (onGround && !(keyboard_check(vk_down) || dkey)) {
        sprite_index = Character1_Run;
    }
    image_xscale = -1;
}
//Down movement
else if ((keyboard_check(vk_down) || dkey) && !isDownPressed && onGround) {
    sprite_index = Character1_Down;
    image_speed = 1; // adjust this to the speed you want
    isDownPressed = true;
} else if ((keyboard_check(vk_down) || dkey) && isDownPressed) {
    if (image_index >= image_number - 1) {
        image_speed = 0;
        image_index = image_number - 1; // last frame
    }
}
//Dash movement
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
//Attack 1
else if (fkey) {
    sprite_index = Character1_Attack1;
}
//Attack 2
else if (Rkey) {
    sprite_index = Character1_Attack2;	
}
//Attack 3
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
//Attack 4 
else if (qkey) {
    sprite_index = Character1_Attack4;
    image_speed = 2;
}
//Default movement
else {
    sprite_index = Character1;
    image_speed = 1;		
}


if (keyboard_check_released(vk_down) || keyboard_check_released(ord("S"))) {
    isDownPressed = false;
    image_speed = 1; // reset to default speed    
}



// Check if character is on the ground
if (place_meeting(x, y + 1, obj_ground)) {
    onGround = true;
} else {
    onGround = false;
}

// Handle jumping
if ((keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"))) && (onGround || remainingJumps > 0)) {
    vSpeed = -jumpSpeed; // Jump upwards
    remainingJumps -= 1; // Reduce remaining jumps
    sprite_index = Character1_Jump; // Change sprite to jumping animation
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
	
	// Reset remaining jumps if character lands on the ground
    if (place_meeting(x, y + 1, obj_ground)) {
        remainingJumps = maxJumps;
    }
	
}

