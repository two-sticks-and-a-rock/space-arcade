extends Node

signal get_starting_weapon
signal start_tutorial

signal level_up
signal finish_level_up

class GameOverData:
    var kills: int = 0
    var kills_display: String = "0"

    var time: float = 0.0
    var time_display: String = "00:00"

    func _init(
        kills_value: int,
        kills_text: String,
        run_time: float,
        time_text: String,
    ):
        kills = kills_value
        kills_display = kills_text

        time = run_time
        time_display = time_text


signal game_over(game_over_data: GameOverData)
signal restart_game

enum SceneType { MENU, LEVEL }
signal switch_scenes(scene: int)

signal enemy_death
