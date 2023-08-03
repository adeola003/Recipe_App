class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, :description, :cooking_time, :prep_time, presence: true

  def toggle_public
    update(public: !public)
end

def add_to_shopping_list
  update(add_to_shopping_list: !add_to_shopping_list)
end
end
