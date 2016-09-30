class Person < ActiveRecord::Base
  validates :name, :house_id, presence: true

  belongs_to :lives_in,
    primary_key: :id,
    foreign_key: :house_id,
    class_name: :House
end
