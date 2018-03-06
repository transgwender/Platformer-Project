/*
 * Movement Code
 *
 * If only one button is pressed, then it sets the sprite to marioMoving, and which direction with image_xscale.
 * Then if the side Mario is going to move in isn't colliding with obj_solid, it will add 5 in the direction intended to x.
 * If no buttons or both buttons are pressed, it will just set the sprite to a default one.
*/
obj_settings.moveDirection = keyboard_check(vk_right) - keyboard_check(vk_left); 

if obj_settings.moveDirection != 0 {
	if !collision_point(obj_player.x+(9*obj_settings.moveDirection), obj_player.y, obj_solid, false, false) &&
	!collision_point(obj_player.x+(9*obj_settings.moveDirection), obj_player.y-32, obj_solid, false, false) {
		obj_player.x += obj_settings.moveSpeed * obj_settings.moveDirection;
	}
	sprite_index = spr_playerMoving;
	image_xscale = obj_settings.moveDirection;
} else {
	sprite_index = spr_player;
}

/*
 * Jump Code
 *
 * Just read it over slowly... but the just of it is that when space is pressed, it sets a modifier, and total
 * for triple jumps, and prevents it from running again with hasJumped.
 * It will also set hasPressed to true, and reset currentGroundLength, and that allows the jump code to run/
 * It takes currentJumpLength, constantly adds grav to that value, and using simple methods, sets current jumpSpeed
 * Then the sprite is changed to a jumping one, and it detects the collision above. If it has collided above, it will
 * immediately begin to go down, else it will update y with jumpSpeed. If it's going down, it sets the sprite
 * to the descent one.
*/

if keyboard_check_pressed(vk_space) && obj_settings.jumpTotal < 3 && !obj_settings.hasJumped {
	obj_settings.jumpModifier += 2.5;
	obj_settings.jumpTotal += 1;
	obj_settings.hasJumped = true;
}

if keyboard_check_pressed(vk_space) {
	obj_settings.hasPressed = true;
	obj_settings.currentGroundLength = 0;
}

if obj_settings.hasPressed {
	obj_settings.currentJumpLength += obj_settings.grav; 
	obj_settings.jumpSpeed = (obj_settings.jumpStart+obj_settings.jumpModifier)-obj_settings.currentJumpLength+(obj_settings.grav/2);
	sprite_index = spr_playerJump;
	if collision_point(obj_player.x, obj_player.y-33, obj_solid, true, false) { 
		obj_settings.hasCollided = true;
	}
	if !obj_settings.hasCollided { 
		obj_player.y -= obj_settings.jumpSpeed; 
	} else {
		obj_settings.currentFallLength += obj_settings.grav;
		obj_player.y += obj_settings.currentFallLength;
	}
	if obj_settings.jumpSpeed < 0 { sprite_index = spr_playerDescent }
}

/*
 * Landing Code
 *
 * If the point collides with obj_solid, then Mario's Y is raised to currentJumpLength/2
 * so that he will be over the ground instantly instead of being slowly raising, then
 * all values are set to default so they can be reused.
*/
if collision_point(obj_player.x, obj_player.y, obj_solid, true, false) {
	obj_player.y -= obj_settings.currentJumpLength/2;
	obj_settings.currentJumpLength = 0;
	obj_settings.currentFallLength = 0;
	obj_settings.hasPressed = false;
	obj_settings.hasCollided = false;
	obj_settings.jumpSpeed = 0;
	obj_settings.hasJumped = false;
}

/*
 * Triple Jump Detection Code
 *
 * If Mario is coliding with the ground, it will set a currentGroundLength variable to increase. If it's
 * greater than the allocated time amount, or Mario has already jumped 3 times, it will reset the modifier
 * total.
*/

if collision_point(obj_player.x, obj_player.y+3, obj_solid, true, false) {
	obj_settings.currentGroundLength += 0.1;
}

if (obj_settings.currentGroundLength > obj_settings.tJumpGracePeriod || (obj_settings.jumpTotal = 3 && obj_settings.hasJumped = false)) {
	obj_settings.jumpModifier = 1;
	obj_settings.jumpTotal = 0;
}

/*
 * Gravity Code (Non Jumping)
 *
 * If the point doesn't collide with obj_solid, meaning it's above the ground, and
 * hasPressed is false, meaning this isn't because of an intended jump, then the currentFallLength
 * is added to for every frame it isnt on the ground, then Mario's Y is added to, and the sprite is
 * changed to spr_playerDescent.
*/

if !collision_point(obj_player.x, obj_player.y+2, obj_solid, true, false) && !obj_settings.hasPressed { 
	obj_settings.currentFallLength += obj_settings.grav; 
	obj_player.y += obj_settings.currentFallLength; 
	sprite_index = spr_playerDescent;
}