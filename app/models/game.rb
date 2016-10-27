class Game < ActiveRecord::Base
  has_many :pieces
  has_many :players

def as_json(options={})
  super(:include =>[:pieces])
end
end
