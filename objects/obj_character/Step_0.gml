//CREATE VARIABLES
var rkey = keyboard_check(ord("D"));
var lkey = keyboard_check(ord("A"));
var dkey = keyboard_check(ord("S"));
var ukey = keyboard_check(ord("w"));
var fkey = keyboard_check(ord("F"));
var Rkey = keyboard_check(ord("R"));
var ekey = keyboard_check(ord("E"));
var qkey = keyboard_check(ord("Q"));

var isAttacking = false;


// Check if character is on the ground
if (place_meeting(x, y + 1, obj_ground)) {
    onGround = true;
} else {
    onGround = false;
}

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
	isAttacking = true;
    sprite_index = Character1_Attack1;
	audio_play_sound(attack1_sound, 1, false);
}

//Attack 2
else if (Rkey) {
	isAttacking = true;
    sprite_index = Character1_Attack2;		
	audio_play_sound(attack2_sound, 1, false);
}

//Attack 3
else if (ekey) {
	isAttacking = true;
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
	audio_play_sound(attack3_sound, 1, false);
}

//Attack 4 
else if (qkey) {
	isAttacking = true;
    sprite_index = Character1_Attack4;
    image_speed = 2;	
	audio_play_sound(attack4_sound, 1, false);
}

//Default movement
else {
    sprite_index = Character1;
    image_speed = 1;		
}

//Down movement (Reset)
if (keyboard_check_released(vk_down) || keyboard_check_released(ord("S"))) {
    isDownPressed = false;
    image_speed = 1; // reset to default speed    
}

//Jumping movement 
if ((keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"))) && (onGround || remainingJumps > 0)) {
    vSpeed = -jumpSpeed; // Jump upwards
    remainingJumps -= 1; // Reduce remaining jumps
    
    if (remainingJumps == maxJumps - 1) { // First jump
        sprite_index = Character1_Jump; 
    }
    else if (remainingJumps == maxJumps - 2) { // Second jump
        sprite_index = Character1_Jump;         
    }
	audio_play_sound(Jump_sound, 1, false);
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

//Character Decrease HP
if ((place_meeting(x, y, obj_danger) || place_meeting(x, y, obj_enemy1) || place_meeting(x, y, obj_enemy2) || place_meeting(x, y, obj_enemy3)) && !isAttacking && (damageCooldown <= 0)) {
    // Apply knockback
    if (x < obj_danger.x) {
        x -= 50; //knockback distance
    } else {
        x += 50;
    }

    // Decrease health
    hp -= 1;

    // Check health and respawn if needed
    if (hp == 0) {
        x = spawn_x;
        y = spawn_y;				
        hp = 3; // Reset health
    }
	
	isFlashing = true;
    flashAmount = 1.0;
	
    // Set the cooldown time
    damageCooldown = damageCooldownTime;
}



// Handle Attack State
if (isAttacking) {
    if (sprite_index != Character1_Attack1 && sprite_index != Character1_Attack2 && sprite_index != Character1_Attack3 && sprite_index != Character1_Attack4) {
        // Attack animation is complete
        isAttacking = false;
    } else {
        // Check for hit
        if (image_index >= 1 && image_index <= 3) {
            with (instance_create_depth(x, y, 0, obj_hitbox)) {
                var enemy = instance_place(x, y, obj_enemy1);
                if (enemy != noone && enemy.hit == 0) {
                    enemy.hit = 1;
                    enemy.vsp = -3;
                    enemy.hsp = sign(x - enemy.x) * 4;                   
                }
            }
        }
    }
}


if (damageCooldown > 0) {
    damageCooldown--;
}

// Hitflash animation
if (isFlashing && flashAmount > 0) {
    flashAmount -= 0.1; // Adjust the decrement value to control the flash speed
} else if (isFlashing && flashAmount <= 0) {
    isFlashing = false; // Reset isFlashing when the hitflash is complete
}






