/// @description Movement code

// When the space button is released, will set a variable to hasReleased;
if keyboard_check_released(vk_space) { hasReleased = true } 

// General movement direction taking right - left, -1 for left, 1 for right, 0 for both.
moveDirection = keyboard_check(vk_right) - keyboard_check(vk_left); 

/*
 * If only one button is pressed, then it sets the sprite to marioMoving, and which direction with image_xscale.
 * Then if the side Mario is going to move in isn't colliding with obj_ground, it will add 5 in the direction intended to x.
 * If no buttons or both buttons are pressed, it will just set the sprite to a default one.
*/
if moveDirection != 0 {
	if !collision_point(obj_mario.x+(9*moveDirection), obj_mario.y, obj_ground, false, false) &&
	!collision_point(obj_mario.x+(9*moveDirection), obj_mario.y-32, obj_ground, false, false) {
		obj_mario.x += 5 * moveDirection;
	}
	sprite_index = spr_marioMoving;
	image_xscale = moveDirection;
} else {
	sprite_index = spr_mario;
}

/*
 * If the space key is pressed, then the currentJumpLength will be added to every frame by obj_settings.grav. Then
 * the jumpSpeed value is set with the starting speed - the currentJumpLength, then that value is added to by half of
 * obj_settings.grav (I have no clue why that's there, but I don't want to remove it). The sprite of Mario Jumping is then
 * set, and hasPressed is set to true. Then if Mario's top has collided with obj_ground (Usually the bottom) then it sets a
 * variable of hasCollied to true. If hasCollided is still false, then the y will be updated with jumpSpeed. 
 * If it hasCollided, then instead currentFallLengt0h will has .grav added to it every frame, then y is
 * updated by currentFallLength. That prevent's Mario from jumping through the bottom of blocks.
 * If descending, then sprite is set to spr_marioDescent.
 * If space is not pressed, then it checks if hasReleased is true and if jumpSpeed is more than or less than 0.
 * If jumpSpeed is more than 0, it will then start increasing currentFallLength by grav, and use that to set
 * Mario's y axis, and change the sprite to marioDescent. If jumpSpeed is less than 0, then it will maintain the
 * value Mario had before, continuing currentJumpLength, and jumpSpeed, then set the y axis for Mario, and the
 * sprite to marioDescent. The reason for this is that if jumpSpeed is less than 0, then Mario is already going
 * down, as that value is used to subtract Mario's y-axis, so a positive value makes it goes down. Otherwise, if
 * it is a negative value, using that value would instead make Mario go up. We don't want that since Mario isn't
 * in space, so we instead use currentFallLength, starting at 0 and adding grav to that until it hits the ground.
 * Then that value is added to Mario, so it goes down. Makes sense? Hopefully, I'm not going over that again.
*/
if keyboard_check(vk_space) { 
	currentJumpLength += obj_settings.grav; 
	jumpSpeed = 10-currentJumpLength+(obj_settings.grav/2); 
	if collision_point(obj_mario.x, obj_mario.y-33, obj_ground, true, false) { 
		hasCollided = true; 
	}
	if !hasCollided { 
		obj_mario.y -= jumpSpeed; 
	} else {
		currentFallLength += obj_settings.grav;
		obj_mario.y += currentFallLength;
	}
	sprite_index = spr_marioJump;
	hasPressed = true;
	if jumpSpeed < 0 { sprite_index = spr_marioDescent }
} else if (hasReleased && jumpSpeed > 0) {
	currentFallLength += obj_settings.grav;
	obj_mario.y += currentFallLength;
	sprite_index = spr_marioDescent;
} else if (hasReleased && jumpSpeed <= 0) {
	currentJumpLength += obj_settings.grav;
	jumpSpeed = 10-currentJumpLength+(obj_settings.grav/2);
	obj_mario.y -= jumpSpeed;
	sprite_index = spr_marioDescent;
}


/*
 * If the point collides with obj_ground, then Mario's Y is raised to the average of currentFallLength and
 * currentJumpLength so that he will be over the ground instantly instead of being slowly raising, then
 * all values are set to default so they can be reused.
*/
if collision_point(obj_mario.x, obj_mario.y+1, obj_ground, true, false) {
	obj_mario.y -= ((currentFallLength + currentJumpLength)/2)+(obj_settings.grav);
	currentJumpLength = 0;
	currentFallLength = 0;
	hasReleased = false;
	hasPressed = false;
	hasCollided = false;
	jumpSpeed = 0;
}

/*
 * IF the point doesn't collide with obj_ground, meaning it's above the ground, and hasReleased and
 * hasPressed is false, meaning this isn't because of an intended jump, then the currentFallLength
 * is added to for every frame it isnt on the ground, then Mario's Y is added to, and the sprite is
 * changed to spr_marioDescent.
*/
if !collision_point(obj_mario.x, obj_mario.y+2, obj_ground, true, false) && !hasReleased && !hasPressed { 
	currentFallLength += obj_settings.grav; 
	obj_mario.y += currentFallLength; 
	sprite_index = spr_marioDescent;
}