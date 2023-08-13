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
if(!visible) return 0;

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
if ((keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W")) || keyboard_check(vk_up)) && (onGround || remainingJumps > 0)) {
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
if ((place_meeting(x, y, obj_danger) || place_meeting(x, y, obj_enemy1) || place_meeting(x, y, obj_enemy2) || place_meeting(x, y, obj_enemy3) || place_meeting(x, y, obj_enemy4) || place_meeting(x, y, obj_enemy5)) && !isAttacking && (damageCooldown <= 0)) {
    // Apply knockback
    if (x < obj_danger.x) {
        x -= 50; //knockback distance
    } else {
        x += 50;
    }

    // Decrease health
    hp -= 1;

	
	audio_play_sound(Snd_Damage, 1, false);
	
    // Check health and respawn if needed
    if (hp == 0) {
        x = spawn_x;
        y = spawn_y;				
        hp = 6; // Reset health
		coins = 0;
		gems = 0;
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
            // Determine hitbox offset based on character's direction
            var hitbox_offset;
            if (image_xscale == 1) {
                hitbox_offset = 0; 
            } else if (image_xscale == -1) {
                hitbox_offset = -70; 
            }
            
            with (instance_create_depth(x + hitbox_offset, y, 0, obj_hitbox)) {
                var enemy = instance_place(x, y, obj_enemy1);
                if (enemy != noone && enemy.hit == 0) {
                    enemy.hit = 1;
                    enemy.vsp = -3;
                    enemy.hsp = sign(x - enemy.x) * 4;                   
					
					if (enemy.hit == 1) {
						instance_destroy(obj_hitbox);
					}
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

// Check if the character collides with a coin
if (place_meeting(x, y, obj_coin)) {
    // If so, collect the coin and destroy it
    var coin = instance_place(x, y, obj_coin);
    if (coin != noone) {
        instance_destroy(coin);
        coins += 1;
        
        // Check if the character has collected 15 coins
        if (coins % 15 == 0) {
            hp += 1;
        }
    }
	audio_play_sound(Snd_Coin, 1, false);
}

// Check if the character collides with a gem
if (place_meeting(x, y, obj_Gem1)) {
    // If so, collect the coin and destroy it
    var gem1 = instance_place(x, y, obj_Gem1);
    if (gem1 != noone) {
        instance_destroy(gem1);
        gems += 1;
        
        // Check if the character has collected 15 coins
        if (gems % 15 == 0) {
            hp += 1;
        }
    }
	audio_play_sound(Snd_Gem1, 1, false);
}

// Check if the character collides with a gem(bigger)
if (place_meeting(x, y, obj_Gem)) {
    // If so, collect the coin and destroy it
    var gem = instance_place(x, y, obj_Gem);
    if (gem != noone) {
        instance_destroy(gem);
        gems += 3;
        
        // Check if the character has collected 15 coins
        if (gems % 15 == 0) {
            hp += 1;
        }
    }
	audio_play_sound(Snd_Gem1, 1, false);
}



// Check if the character collides with obj_ultradamage
if (place_meeting(x, y, obj_ultradamage) || place_meeting(x, y, obj_danger) || hp == 0) {
    if (room == Level2){
		obj_character.x = 156;    
		obj_character.y = 238;	
		hp = 6; // Reset health
		coins = 0;
		gems = 0;
	}
}

// Check if the character collides with obj_FlagWin
if (place_meeting(x, y, obj_FlagWin)) {
    // End the game or trigger a win state
    show_message("You won!"); // Display a message
    game_end(); // End the game
}