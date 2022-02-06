package main

import rl "vendor:raylib"
import "rtpa"
import "core:c"

atlas: rl.Texture2D

atlas_info: rtpa.Atlas_Info
sprite_info: [dynamic]rtpa.Sprite_Info

load_sprites :: proc() {
	using rl
	atlas = LoadTexture("resources/atlas.png")
    atlas_info, sprite_info = rtpa.load("resources/atlas.rtpa")
}

draw :: proc(s: string, position: rl.Vector2, scale: c.float, rotation: c.float) {
    using rl
    rtpa.draw(atlas, &sprite_info, s, position, scale, rotation)
}

get_sprite_info :: proc(sprite_name: string) -> rtpa.Sprite_Info {
	return rtpa.get_sprite_info(&sprite_info, sprite_name)
}