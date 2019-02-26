class Order < ApplicationRecord
    belongs_to :product, touch: true
    belongs_to :user
end