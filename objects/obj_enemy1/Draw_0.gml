// Draw Event 
if (isFlashing) {
    // Use the white flash shader if the enemy should flash
    shader_set(shd_white_flash);
    draw_self();
    shader_reset();
} else {
    // If the enemy shouldn't flash, draw it normally
    draw_self();
}

