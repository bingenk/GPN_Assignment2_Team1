//Record Character spawn place 
spawn_x = x;
spawn_y = y;

grav = 0.4; // The strength of gravity
vSpeed = 0; // The character's current vertical speed
jumpSpeed = 7; // The initial speed of jumps
onGround = false; // Whether the character is currently on the ground
maxJumps = 2; // Maximum number of jumps
remainingJumps = maxJumps; // Number of jumps remaining
isDownPressed = false;

//Initialize HP for character
hp = 3;

damageCooldown = 0;
damageCooldownTime = 120; // 120 steps, or 2 second at 60fps

isFlashing = false;
flashAmount = 0.0;

// Load sound effects
attack1_sound = Snd_attack1;
attack2_sound = Snd_attack2;
attack3_sound = Snd_attack3;
attack4_sound = Snd_attack4;
Jump_sound = Snd_Jump;

