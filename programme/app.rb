require 'colorize'
require 'pry'
require 'rubocop'
require_relative 'boardcase'
require_relative 'board'
require_relative 'player'
require_relative 'game'

Game.new.launch_game
