package main

import rl "vendor:raylib"
import "core:c"

player: Entity

player_init :: proc(using player: ^Entity) {
	speed.x = 20
	shoot_delay = 20
	x = 100
	y = 500
	scale = 0.2

	sprite_info := get_sprite_info("tank")
	hitbox.width = c.float(sprite_info.source_width) * scale
	hitbox.height = c.float(sprite_info.source_height) * scale
}

player_update :: proc(using player: ^Entity) {
	using rl
	player.x += GetGamepadAxisMovement(0, .LEFT_X)
	if shoot_delay_timer > 0 do shoot_delay_timer -= 1
	if shoot_delay_timer == 0 && GetGamepadAxisMovement(0, .RIGHT_Y) < 0 {
		shoot_delay_timer = shoot_delay
		bullet: Entity
		bullet_init(&bullet)
		entity_create(&bullet)
	}

}

player_draw :: proc(using player: ^Entity) {
	using rl
	draw("tank", position, scale, rotation)
}