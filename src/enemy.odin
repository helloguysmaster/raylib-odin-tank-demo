package main

import rl "vendor:raylib"
import "core:c"
import "core:fmt"

enemy_init :: proc(using enemy: ^Entity) {
	using rl

	active = true
    type = .ENEMY
    scale = 0.3

    _x: c.float
    left_or_right := GetRandomValue(0, 1)
    if left_or_right == 0 {
    	_x = 0
    	speed = Vector2{3, 0}
    	rotation = 90
    }
    else if left_or_right == 1 {
    	_x = SCREEN_WIDTH
    	speed = Vector2{-3, 0}
    	rotation = 270
    }
    else do fmt.println("oops")
    _y := c.float(GetRandomValue(100, 300))
    position = Vector2{_x, _y}

    sprite_info := get_sprite_info("plane")
	hitbox.width = c.float(sprite_info.source_width) * scale
	hitbox.height = c.float(sprite_info.source_height) * scale
}

enemy_update :: proc(using enemy: ^Entity) {
	position += speed
}

enemy_draw :: proc(using enemy: ^Entity) {
	draw("plane", position, scale, rotation)
}