extends Node


signal level_up
signal finish_level_up

signal game_over
signal restart_game

enum SceneType { MENU, LEVEL }
signal switch_scenes(scene: int)