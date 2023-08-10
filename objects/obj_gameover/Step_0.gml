if (showGameOver)
{
    if (keyboard_check_pressed(ord("Y")))
	{	    
	    obj_character.hp = 3; 	    
	    // Hide the game over screen
	    showGameOver = false;

	    // Go to Level 1
	    room_goto(Level1);
	}
    else if (keyboard_check_pressed(ord("N")))
    {
        game_end();
    }
}
