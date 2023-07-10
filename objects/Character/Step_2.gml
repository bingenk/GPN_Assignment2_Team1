gravity = 0.5; // The force that pulls the character down
jump_speed = 12; // The initial speed when the character jumps


if (place_meeting(x, y+1, obj_ground)) // Check if the character is on the ground
{
    vspeed = 0; // Reset vertical speed

    if (keyboard_check_pressed(vk_space)) // Check if the player is pressing the jump button
    {
        vspeed = -jump_speed; // Make the character jump
    }
}
else
{
    vspeed += gravity; // Apply gravity

    if (!keyboard_check(vk_space) && vspeed < 0) // Check if the player has released the jump button
    {
        vspeed = 0; // Stop the character from rising
    }
}
