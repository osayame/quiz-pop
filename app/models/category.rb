class Category < ActiveRecord::Base
	has_many :questions
	validates :title, presence: true,
	length: { minimum: 3 }

end
