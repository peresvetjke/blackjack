# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'auto_casino'
require_relative 'player'
require_relative 'live_player'
require_relative 'dealer'
require_relative 'cardgame'
require_relative 'blackjackgame'
require_relative 'round'
require 'pry'

casino1 = AutoCasino.new('JQ21-Casino')
casino1.main_menu
