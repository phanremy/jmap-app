# frozen_string_literal: true

class AddUnaccentExtension < ActiveRecord::Migration[7.1]
  def up
    execute 'CREATE EXTENSION IF NOT EXISTS unaccent;'
  end

  def down
    execute 'DROP EXTENSION IF EXISTS unaccent CASCADE;'
  end
end
