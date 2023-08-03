// Set default font
draw_set_font(spr_menu_font);

// Loop through the array containing each menu element
for(i = 0; i < array_length_1d(menu); i++)
{
	// If you're looking at the currently selected element, 
	// then draw it with a certain color, if not, then with
	// another color
	if(selected == i)
	{
		draw_set_color(selectedCol);
	}
	else
	{
		draw_set_color(notSelectedCol);
	}
	
	// Draw the text
	draw_text(x,y+i*spacing, menu[i]);	
}
// Getting width of cursor to separate it a bit from the menu
var cursWidth = sprite_get_width(s_cursor);

// Draw cursor at where it should be, but half its width 
// to the left of the menu
draw_sprite(s_cursor, -1, x + cursorLevitate - cursWidth/1, y + selectLerp*spacing);

// Draw game title (at 10% of screen width and height, hence 0.1)
draw_set_color(titleCol);
draw_text_transformed(room_width*0.1, room_height*0.1 , gameTitle, titleSize, titleSize,0);