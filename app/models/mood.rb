class Mood
  include Mongoid::Document
  include SimpleEnum::Mongoid

  as_enum :mood, %i[very_bad bad neutral good very_good]

  embedded_in :post
end
