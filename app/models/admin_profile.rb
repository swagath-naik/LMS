class AdminProfile < ApplicationRecord
has_one :user, as: :profile, dependent: :destroy
def admin?
true
end
def role
"admin"
end
end
