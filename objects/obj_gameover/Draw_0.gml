if (showGameOver)
{
    // Draw the black overlay with 50% opacity
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(0, 0, room_width, room_height, false);

    // Draw the game over text and restart options
    draw_set_font(spr_menu_font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(1); // Reset alpha to fully opaque
    draw_set_color(c_white);

    var _centerX = room_width / 2;
    var _centerY = room_height / 2;
    draw_text(_centerX, _centerY, "GAME OVER");
    draw_text(_centerX, _centerY + 40, "Restart? Yes or No");
}
