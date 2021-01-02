# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  :standard, :system, :admin, :anonymous,
  :app, :verified, :moderator, :support
].each do |role|
  Role.find_or_create_by!(
    name: role
  )
end

# Helper method to get a list of seed data files from a dir.
#
# Takes a relative or absolute directory path.
def get_data_files_by_dir(dir_path)
  data_files = []
  Dir.entries(dir_path).select do | f |
    abs_path = dir_path + f

    # Only get .yml files.
    if !f.match(/^\./ ) && f.match(/\.yml$/i) && File.file?(abs_path)
      filename = f.match(/^(.*)\./)[1]

      data_files << [filename, abs_path]
    end
  end

  data_files
end

# Helper method to get a seed data object from all
# seed data files in a directory.
#
# Takes a relative or absolute directory path.
def get_data_by_dir(dir_path)
  dir_files = get_data_files_by_dir(dir_path)

  seed_data = {}
  dir_files.each do |df|
    seed_item = YAML::load(File.read(df[1]))
    k = seed_item.keys[0]
    seed_data[k] = seed_item[k]
  end

  seed_data
end

# Automatically seed data in the env data path.
#
# Can take an optional seed path.
def seed_by_yaml(yaml_seed_path="./db/seeds/#{Rails.env}/data/")
  seed_data = get_data_by_dir(yaml_seed_path)

  seed_data.each_pair do |k,seed_items|
    p "KEY: #{k}"
    klass = Object.const_get k
    seed_items.each do |seed_item|
      # We always require a slug for seeds.
      p "FIND/INIT BY #{seed_item['slug']}"
      obj = klass.where(slug: seed_item['slug']).first_or_initialize
      p "DESC #{seed_item['description']}"
      obj.update_attributes!(seed_item)
    end
  end
end

# seed_by_yaml

# Run any env-specific seeds.
require_relative "seeds/#{Rails.env}/seeds.rb"
