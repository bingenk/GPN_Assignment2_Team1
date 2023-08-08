// Define sound resources
sound_button_select = MenuSwitch_Select; // Change to the actual sound resource name
sound_confirm = MenuSwitch_Confirm; // Change to the actual confirm sound resource name

// Oscillate the cursor using sin function
cursorLevitate = dsin(cursorTime);

// Use this as an "angle" to use in the sin function
// to oscillate cursor
cursorTime += leviRate;

// Vertical input is determined by the press of up
// and down buttons
var downPressed = keyboard_check_pressed(downButt) || keyboard_check_pressed(ord("S"));
var upPressed = keyboard_check_pressed(upButt) || keyboard_check_pressed(ord("W")); // You can also add more keys here if needed

var vert = downPressed - upPressed;

// Move cursor up or down depending on inputs
selected += vert;
selectLerp = lerp(selectLerp, selected, lerpAmt); // Smooth cursor movement

// Don't let cursor move past where it should be
selected = clamp(selected, 0, array_length_1d(menu) - 1);

// Play sound effect when navigating through options
if (downPressed || upPressed) {
    audio_play_sound(sound_button_select, 1, false);
}

// Whenever you press the confirm button, do whatever
// it should do depending on what menu element is selected
if (keyboard_check_pressed(confirmButt))
{
    audio_play_sound(sound_confirm, 1, false);

    if (selected == 0) // Play by default
    {
        room_goto(Level1); // Go to room "Level1"
    }

    if (selected == 1) // Options by default
    {
        // Go to options room
    }

    if (selected == 2) // Stats by default
    {
        // Go to stats room
    }

    if (selected == 3) // Exit by default
    {
        game_end();
    }
}
