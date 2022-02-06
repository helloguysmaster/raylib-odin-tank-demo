package main

import rl "vendor:raylib"
import "core:c"
import "core:fmt"

bullet_init :: proc(using bullet: ^Entity) {
	using rl
	position = Vector2{player.x + 55, player.y - 30}
	sprite = "bullet"
	scale = 0.5
	speed = Vector2{GetGamepadAxisMovement(0, .RIGHT_X) * 10, -10}
	rotation = GetGamepadAxisMovement(0, .RIGHT_X) * 50
	type = .PLAYER_BULLET

	sprite_info := get_sprite_info("bullet")
	hitbox.width = c.float(sprite_info.source_width) * scale
	hitbox.height = c.float(sprite_info.source_height) * scale
}

bullet_update :: proc(using bullet: ^Entity) {
	position += speed
	if x <= 0 || x > SCREEN_WIDTH || y <= 0 do active = false

	for entity, entity_index in entities {
		if entity.active && entity.type == .ENEMY {
			if entities_touching(bullet, &entities[entity_index]) {
				entities[entity_index].active = false
			}
		}
	}
}

bullet_draw :: proc(using bullet: ^Entity) {
	draw("bullet", position, scale, rotation)
}