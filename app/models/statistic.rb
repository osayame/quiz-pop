class Statistic < ActiveRecord::Base
	has_one :user

	def self.insert(user, game, question, correct)
		@stat = Statistic.new
		@stat.user_id = user.id
		@stat.category = Category.find(game.current_category).title
		@stat.correct = correct
		@stat.question = question.id
		@stat.game_id = game.id
		@stat.save
	end

	def self.all_time
		stats_by_period("none")
	end

	def self.week
		stats_by_period("week")
	end

	def self.month
		stats_by_period("month")
	end

	def self.user_stats(user, category)
		@correct = Statistic.where(["user_id = ? and correct = ? and category = ?", user.id, true, category]).count

		if @correct != 0 
			@total = Statistic.where({user_id: user.id, category: category}).count
			@accuracy = @correct.to_f/@total.to_f * 100
		else
			@accuracy = 0
		end
		@accuracy.round(2)
	end

	def self.user_total_count(user)
		Statistic.where(["user_id = ?", user.id]).count
	end

	def self.user_correct_count(user)
		Statistic.where(["user_id = ? and correct = ?", user.id, true]).count
	end

	def self.stats_by_period(period)
		time = {"week" => 1.week.ago.utc, "month" => 1.month.ago.utc, "none" => 5000.month.ago.utc}
		@stats = Hash.new
		User.all.each do |user|
			id = user.id
			@correct = Statistic.where(["user_id = ? and correct = ? and updated_at >= ?", user.id, true, time[period]]).count

			if @correct != 0
				@total = Statistic.where({user_id: user.id}).count
				@accuracy = @correct.to_f/@total.to_f * 100
			else
				@accuracy = 0
			end

			if @correct > 0
				@stats[id] = {correct: @correct, accuracy: @accuracy.round(2), total: @total}
			end
		end
		@stats.sort_by { |k,v| v[:accuracy] }.reverse
	end




end
