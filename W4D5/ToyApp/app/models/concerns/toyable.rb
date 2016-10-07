module Toyable
  extend ActiveSupport::Concern

  included do
    has_many :toys, as: :toyable

  end

  def receive_toy(name)
    Toy.create(name: name, toyable_id: self.id, toyable_type: self.class)
  end

end
