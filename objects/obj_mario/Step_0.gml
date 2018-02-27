/// @description Insert description here
// You can write your code in this editor

/*if !collision_point(obj_mario.x,obj_mario.y+32,obj_ground,true,false) {
	current_fall_length += obj_settings.grav/2;
	obj_mario.y += current_fall_length
}*/

if keyboard_check_released(vk_space) {
	hasReleased = true;
}

moveDirection = keyboard_check(vk_right) - keyboard_check(vk_left)

if (moveDirection != 0) {
	obj_mario.x += 5 * moveDirection;
	sprite_index = spr_marioMoving;
	image_xscale = moveDirection;
} else {
	sprite_index = spr_mario;
}

if keyboard_check(vk_space) {
	currentJumpLength += obj_settings.grav;
	jumpSpeed = 10-currentJumpLength+(obj_settings.grav/2);
	obj_mario.y -= jumpSpeed;
	sprite_index = spr_marioJump;
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

if jumpSpeed < 0 {
	sprite_index = spr_marioDescent;
}

if collision_point(obj_mario.x, obj_mario.y+32, obj_ground, true, false) {
	obj_mario.y -= obj_settings.grav;
	currentJumpLength = 0.0;
	currentFallLength = 0.0;
	hasReleased = false;
	jumpSpeed = 0;
};

if !collision_point(obj_mario.x, obj_mario.y+33, obj_ground, true, false) {	
}