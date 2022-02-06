package main

import rl "vendor:raylib"
import "core:c"

Entity :: struct {
    id: uint,
    using position: rl.Vector2,
    sprite: string,
    scale: c.float,
    speed: rl.Vector2,
    shoot_delay: uint,
    shoot_delay_timer: uint,
    type: Entity_Type,
    rotation: c.float,
    hitbox: rl.Rectangle,
    active: bool,
}

Entity_Type :: enum {
	PLAYER,
	ENEMY,
	PLAYER_BULLET,
	ENEMY_BULLET,
}

entities: [dynamic]Entity

next_id: uint

entity_create :: proc(using e: ^Entity) {
	e.id = next_id
	e.active = true

	for entity, entity_index in entities {
		if !entity.active {
			entities[entity_index] = e^
			next_id += 1
			return
		}
	}

	append(&entities, e^)
	next_id += 1
}

entities_touching :: proc(entity1, entity2: ^Entity) -> bool {
	using rl

	entity1_position_hitbox: rl.Rectangle
	entity1_position_hitbox.x = entity1.x + entity1.hitbox.x
	entity1_position_hitbox.y = entity1.y + entity1.hitbox.y
	entity1_position_hitbox.width = entity1.hitbox.width
	entity1_position_hitbox.height = entity1.hitbox.height

	entity2_position_hitbox: rl.Rectangle
	entity2_position_hitbox.x = entity2.x + entity2.hitbox.x
	entity2_position_hitbox.y = entity2.y + entity2.hitbox.y
	entity2_position_hitbox.width = entity2.hitbox.width
	entity2_position_hitbox.height = entity2.hitbox.height

	return CheckCollisionRecs(entity1_position_hitbox, entity2_position_hitbox)
}