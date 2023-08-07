// Step Event of obj_enemy3
// Check for collision with character hitbox (assuming the hitbox is called obj_hitbox)
if (place_meeting(x, y, obj_hitbox)) {
    if (!isFlashing) {
        // Play hitflash animation
        isFlashing = true;
        flashAmount = 1.0; // Set flash amount to 1 for a white hitflash
        // Decrease HP by 1
        hp -= 1;
        // Check if HP is zero or below
        if (hp <= 0) {
            // Destroy the enemy if HP is zero or below
            instance_destroy();
        }
    }
}

// Hitflash animation
if (isFlashing && flashAmount > 0) {
    flashAmount -= 0.1; // Adjust the decrement value to control the flash speed
} else if (isFlashing && flashAmount <= 0) {
    isFlashing = false; // Reset isFlashing when the hitflash is complete
}










