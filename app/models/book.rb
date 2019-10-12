class Book < ApplicationRecord
	validates :bookId, uniqueness: true, presence: true
	validates :title, presence: true
	validates :bookId, presence: true
end
