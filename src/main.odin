package main

import rl "vendor:raylib"
import "core:fmt"
import "core:c"

SCREEN_WIDTH :: 1280
SCREEN_HEIGHT :: 720

Game_State :: enum {
    TITLE,
    GAME,
    WON,
    LOST,
}

main :: proc()
{
    using rl
    // Initialization
    //--------------------------------------------------------------------------------------
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "controller test")

    load_sprites()
    player_init(&player)

    enemy_spawn_delay: uint

    SetTargetFPS(60)               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    for !WindowShouldClose()    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        if IsGamepadAvailable(0) {
            DrawText(GetGamepadName(0), 50, 50, 20, BLACK)
            DrawText(TextFormat("left x: %f", GetGamepadAxisMovement(0, .LEFT_X)), 50, 200, 20, BLACK)
            DrawText(TextFormat("left y: %f", GetGamepadAxisMovement(0, .LEFT_Y)), 50, 225, 20, BLACK)
            DrawText(TextFormat("right x: %f", GetGamepadAxisMovement(0, .RIGHT_X)), 50, 250, 20, BLACK)
            DrawText(TextFormat("right y: %f", GetGamepadAxisMovement(0, .RIGHT_Y)), 50, 275, 20, BLACK)

            if enemy_spawn_delay == 0 {
                enemy_spawn_delay = 180
                enemy: Entity
                enemy_init(&enemy)
                entity_create(&enemy)
            }
            else do enemy_spawn_delay -= 1

            player_update(&player)

            for entity, entity_index in entities {
                if entity.active {
                    #partial switch entity.type {
                        case .PLAYER_BULLET: {
                            bullet_update(&entities[entity_index])
                        }
                        case .ENEMY:
                            enemy_update(&entities[entity_index])
                    }
                }
            }
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing()

            ClearBackground(RAYWHITE)
            player_draw(&player)

            for entity, entity_index in entities {
                if entity.active {
                    #partial switch entity.type {
                        case .PLAYER_BULLET:
                            bullet_draw(&entities[entity_index])

                        case .ENEMY:
                            enemy_draw(&entities[entity_index])
                    }
                }
            }

        EndDrawing()
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow()        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}