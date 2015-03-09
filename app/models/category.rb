class Category < ActiveRecord::Base
	has_many :questions, dependent: :destroy
	validates :title, presence: true,
	length: { minimum: 3 }

end
