// Step Event of obj_enemy1
// Check for collision with character hitbox (assuming the hitbox is called obj_hitbox)
if (place_meeting(x, y, obj_hitbox)) {
    if (!isFlashing) {
        // Play hitflash animation
        isFlashing = true;
        image_alpha = 0.5; // Set the alpha value to 0.5 during the hitflash
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
if (isFlashing && image_alpha < 1) {
    image_alpha += 0.1; // Adjust the increment value to control the flash speed
} else if (isFlashing && image_alpha >= 1) {
    isFlashing = false; // Reset isFlashing when the hitflash is complete
    image_alpha = 1; // Set the alpha value back to 1 to make the enemy visible again
}
