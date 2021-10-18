# frozen_string_literal: true

require './sinatra_app'

File.new('db', 'w') unless File.file?('db')

run Sinatra::Application
