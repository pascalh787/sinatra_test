# frozen_string_literal: true

workers ENV['PUMA_WORKERS'] || 2
port ENV['PUMA_PORT'] || 9292
preload_app!
