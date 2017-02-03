class Game
	attr_accessor :location, :figure, :grid, :figure_index, :location_index, :player1, :player2, :player1_taken, :player2_taken

	def initialize
		@grid = Board.new()
		@player1 = 1
		@player2 = 2
		@player1_taken = []
		@player2_taken = []
	end

	def prompt_figure
		@figure = []
		print "Please, enter the row of the figure: "
		@figure[0] = gets.chomp.to_i
		print "Please, enter the column of the figure: "
		@figure[1] = gets.chomp.to_i
		@figure
	end

	def prompt_location
		@location = []
		print "Please, enter the row to move: "
		@location[0] = gets.chomp.to_i
		print "Please, enter the column to move: "
		@location[1] = gets.chomp.to_i
		@location
	end

	# checks if the figure is available to move
	def get_figure_index
		#get index of the figure
		if (@figure[0] >= 0 && @figure[0] <= 7) &&
			(@figure[1] >= 0 && @figure[1] <= 7)
			case @figure[0]
				when 0
					@figure_index = @figure[1]
				when 1
					@figure_index = 8 + @figure[1]
				when 2
					@figure_index = 16 + @figure[1]
				when 3
					@figure_index = 24 + @figure[1]
				when 4
					@figure_index = 32 + @figure[1]
				when 5
					@figure_index = 40 + @figure[1]
				when 6
					@figure_index = 48 + @figure[1]
				when 7
					@figure_index = 56 + @figure[1]
			end
		else
			return "Wrong figure"
		end
		return @figure_index
	end

	# check if the place if vacant, or if there is a figure to take
	def get_location_index
		#get index of the figure
		if (@location[0] >= 0 && @location[0] <= 7) &&
			(@location[1] >= 0 && @location[1] <= 7)
			case @location[0]
				when 0
					@location_index = @location[1]
				when 1
					@location_index = 8 + @location[1]
				when 2
					@location_index = 16 + @location[1]
				when 3
					@location_index = 24 + @location[1]
				when 4
					@location_index = 32 + @location[1]
				when 5
					@location_index = 40 + @location[1]
				when 6
					@location_index = 48 + @location[1]
				when 7
					@location_index = 56 + @location[1]
			end
		else
			return "Wrong location"
		end
		return @location_index
	end

	# check if the selected figure is good to go, returns true or false
	def check_figure(player)
		condition = false
		if player == @player1
			#check if it's among white figures
			@grid.figures_white.each do |element|
				if @grid.board[@figure_index] == element
					condition = true
					return condition
				end
			end
			@grid.pawns_white.each do |element|
				if @grid.board[@figure_index] == element
					condition = true
					return condition
				end
			end
		elsif player == @player2
			@grid.figures_black.each do |element|
				if @grid.board[@figure_index] == element
					condition = true
					return condition
				end
			end
			@grid.pawns_black.each do |element|
				if @grid.board[@figure_index] == element
					condition = true
					return condition
				end
			end
		end
		return condition
	end

	# game is over
	def game_over
		false
	end	


	# game is started
	def game_on
		counter = 1
		while !game_over
			if counter == @player1
				@grid.show_board
				puts "Player № #{@player1}"
				prompt_figure
				prompt_location
				get_figure_index
				get_location_index
				check_figure(@player1)

				counter += 1
			elsif counter == @player2
				@grid.show_board
				puts "Player № #{@player2}"
				prompt_figure
				prompt_location
				get_figure_index
				get_location_index
				check_figure(@player2)

				counter -= 1
			end
				
		end
	end

	# CLASS BOARD
	class Board
		attr_accessor :board, :figures_white, :figures_black, :pawns_white, :pawns_black, :empty

		def initialize
			@board = []
			@empty = "xxx"
			@figures_white = ["wr1","wk1","wb1","W Q","W K","wb2","wk2","wr2"]
			@figures_black = ["br1","bk1","bb1","B Q","B K","bb2","bk2","br2"]
			@pawns_white = ["wp1","wp2","wp3","wp4","wp5","wp6","wp7","wp8"]
			@pawns_black = ["bp1","bp2","bp3","bp4","bp5","bp6","bp7","bp8"]
			num1 = 0
			num2 = 0
			64.times do |num|
				
				if num <= 7
					case num 
						when 0
							@board.push(@figures_white[0])
						when 1
							@board.push(@figures_white[1])
						when 2
							@board.push(@figures_white[2])
						when 3
							@board.push(@figures_white[3])
						when 4
							@board.push(@figures_white[4])
						when 5
							@board.push(@figures_white[5])
						when 6
							@board.push(@figures_white[6])
						when 7
							@board.push(@figures_white[7])
					end
				elsif num > 7 && num <= 15 
					@board.push(@pawns_white[num1])
					num1 += 1
				elsif num >= 48 && num < 56
					@board.push(@pawns_black[num2])
					num2 += 1	
				elsif num >= 56
					case num 
						when 56
							@board.push(@figures_black[0])
						when 57
							@board.push(@figures_black[1])
						when 58
							@board.push(@figures_black[2])
						when 59
							@board.push(@figures_black[3])
						when 60
							@board.push(@figures_black[4])
						when 61
							@board.push(@figures_black[5])
						when 62
							@board.push(@figures_black[6])
						when 63
							@board.push(@figures_black[7])
					end
				else
					@board.push(@empty)
				end
			end
		end

		def show_board
			num1 = 0
			num2 = 7
			columns = "      0      1       2      3      4      5      6      7"
			puts columns

			8.times do |num|
				puts
				print "#{num}  "
				p @board[num1..num2]
				num1 += 8
				num2 += 8
			end
			puts
			puts columns
		end
	end
	# CLASS BOARD
	
end
