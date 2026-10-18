extends Node


signal level_up
signal finish_level_up

class GameOverData:
    var kills: int = 0

    func _init(kills_value: int):
        kills = kills_value


signal game_over(game_over_data: GameOverData)
signal restart_game

enum SceneType { MENU, LEVEL }
signal switch_scenes(scene: int)

signal enemy_death