/// @description Insert description here
// You can write your code in this editor

/*if !collision_point(obj_mario.x,obj_mario.y+32,obj_ground,true,false) {
	current_fall_length += obj_settings.grav/2;
	obj_mario.y += current_fall_length
}*/

if keyboard_check_released(vk_space) {
	hasReleased = true;
}

if keyboard_check(vk_left) obj_mario.x -= 5;
if keyboard_check(vk_right) obj_mario.x += 5;
if keyboard_check(vk_space) {
	current_jump_length += obj_settings.grav;
	jumpSpeed = 10-current_jump_length+(obj_settings.grav/2);
	obj_mario.y -= jumpSpeed;
} else if (hasReleased && jumpSpeed > 0) {
	current_fall_length += obj_settings.grav;
	obj_mario.y += current_fall_length
} else if (hasReleased && jumpSpeed <= 0) {
	current_jump_length += obj_settings.grav;
	jumpSpeed = 10-current_jump_length+(obj_settings.grav/2);
	obj_mario.y -= jumpSpeed;
}
if collision_point(obj_mario.x,obj_mario.y+32,obj_ground,true,false) {
	obj_mario.y -= obj_settings.grav;
	current_jump_length = 0.0;
	current_fall_length = 0.0;
	hasReleased = false;
};