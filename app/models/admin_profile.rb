class AdminProfile < ApplicationRecord
has_one :user, as: :profile, dependent: :destroy
end
