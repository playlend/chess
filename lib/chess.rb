class Game
	attr_accessor :location, :figure, :grid, :figure_index, :location_index, :player1, :player2, :player1_taken, :player2_taken, :black, :white

	def initialize
		@grid = Board.new()
		@player1 = 1
		@player2 = 2
		@player1_taken = []
		@player2_taken = []
		@black = "b"
		@white = "w"
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

	# show figures that are taken
	def taken_figures(player)
		if player == @player1
			p @player1_taken
		elsif player == @player2
			p @player2_taken
		end	
	end

	# figure takes 
	def figure_takes(player_takes, figure, location)
		player_takes.push(@grid.board[location])
		@grid.board[location] = @grid.board[figure]
		@grid.board[figure] = @grid.empty
	end
	# figure moves 
	def figure_moves(figure, location)
		@grid.board[location] = @grid.board[figure]
		@grid.board[figure] = @grid.empty
	end

	# define which figure to invoke appropriate method
	def define_figure(color,figure_index,location_index)
		# define color
		if color == @white
			case @grid.board[figure_index][1]
				when "p"
					if pawn_moves(color,figure_index,location_index)
						return true
					else
						return false
					end
				when "r"
					if rook_moves(color,figure_index,location_index)
						return true
					else
						return false
					end
				when "k"
					if knight_moves(color,figure_index,location_index)
						return true
					else
						return false
					end	
				when "b"
					if bishop_moves(color,figure_index,location_index)
						return true
					else
						return false
					end		
				else
				puts "error"
				return false
			end
		elsif color == @black
			case @grid.board[figure_index][1]
				when "p"
					if pawn_moves(color,figure_index,location_index)
						return true
					else
						return false
					end
				when "r"
					if rook_moves(color,figure_index,location_index)
						return true
					else
						return false
					end	
				when "k"
					if knight_moves(color,figure_index,location_index)
						return true
					else
						return false
					end
				when "b"
					if bishop_moves(color,figure_index,location_index)
						return true
					else
						return false
					end					
				else
				puts "error"
				return false
			end
		end		
		false			
	end


	# defining the way pawn moves, if true we will call another method to perform move, if false we will ask for a different figure and location
	def pawn_moves(color,figure_index,location_index)
		#checking what color of the pawn
		if color == @white
			if ((figure_index + 8) == location_index) && (@grid.board[location_index] == @grid.empty)
				figure_moves(figure_index, location_index)
				return true
			elsif (figure_index+7) == location_index
				if (figure_index != 0) && ((figure_index % 8) != 0)
					if @grid.board[location_index][0] == @black
						figure_takes(@player1_taken, figure_index, location_index)
						return true
					end
				end
			elsif (figure_index+9) == location_index
				if (figure_index != 7) && (figure_index != 15) && (figure_index != 23) && (figure_index != 31) && (figure_index != 47) && (figure_index != 55) 
					if @grid.board[location_index][0] == @black
						figure_takes(@player1_taken, figure_index, location_index)
						return true
					end
				end
			elsif ((figure_index + 16) == location_index) && (@grid.board[location_index] == @grid.empty)
				if (@grid.board[figure_index+8]) == @grid.empty
					num = 8
					8.times do 
						if figure_index == num
							figure_moves(figure_index, location_index)
							return true
						end	
						num += 1 
					end
				end
			else
				return false
			end
		elsif color == @black
		# black pawn moves
			if ((figure_index - 8) == location_index) && (@grid.board[location_index] == @grid.empty)
				figure_moves(figure_index, location_index)
				return true
			elsif (figure_index-7) == location_index
				if (figure_index != 63) && (figure_index != 55) && (figure_index != 47) && (figure_index != 39) && (figure_index != 31) && (figure_index != 23) && (figure_index != 15) && (figure_index != 7)
					if @grid.board[location_index][0] == @white
						figure_takes(@player2_taken, figure_index, location_index)
						return true
					end
				end
			elsif (figure_index-9) == location_index
				if (figure_index != 56) && ((figure_index % 8) != 0)
					if @grid.board[location_index][0] == @white
						figure_takes(@player2_taken, figure_index, location_index)
						return true
					end
				end
			elsif ((figure_index - 16) == location_index) && (@grid.board[location_index] == @grid.empty)
				if (@grid.board[figure_index - 8]) == @grid.empty
					num = 48
					8.times do
						if figure_index == num
							figure_moves(figure_index, location_index)
							return true
						end
						num += 1
					end
				end
			else
				return false
			end
		end
		false
	end

	#defining the way rook moves
	def rook_moves(color,figure_index,location_index)	
		condition = false
		forward = false
		back = false
		left = false
		right = false
		if color == @white
			# check if the location is reachable one side at a time
			# determine which way user wants to go
			if @figure[0] == @location[0]
				# it's either right or left
				if @figure[1] == @location[1]
					condition = false
				# check for left and right
				elsif @figure[1] > @location[1]
					condition = false
					left = true
				elsif @figure[1] < @location[1]
					condition = false
					right = true
				end
			elsif @figure[1] == @location[1]
				# it's either forward or back
				if @figure[0] == @location[0]
					condition = false
				# check for forward	and back
				elsif @figure[0] > @location[0]
					condition = false
					back = true
				elsif @figure[0] < @location[0]
					condition = false
					forward = true				
				end
			else
				# it's a wrong location
				condition = false		
			end

			# if location is reachable we have to check if the way is clear
			if forward == true
				if (@grid.board[location_index] == @grid.empty) || (@grid.board[location_index][0] == @black)
					# check if the way is clear
					check = false
					counter = @location[0] - @figure[0] - 1
					num = 8
					counter.times do
						if @grid.board[figure_index+num] != @grid.empty
							check == true						
						end	
						num += 8 
					end

					# if the way is clear, perform the move or take opponets figure
					if check == false
						if @grid.board[location_index] == @grid.empty
							figure_moves(figure_index,location_index)
							condition = true
						elsif @grid.board[location_index][0] == @black
							figure_takes(@player1_taken, figure_index, location_index)
							condition = true
						end
					end
				end
			elsif back == true
				if (@grid.board[location_index] == @grid.empty) || (@grid.board[location_index][0] == @black)
					check = false
					counter = @figure[0] - @location[0] - 1
					num = -8
					counter.times do
						if @grid.board[figure_index+num] != @grid.empty
							check == true
						end
						num -= 8
					end

					# if the way clear perform move
					if check == false
						if @grid.board[location_index] == @grid.empty
							figure_moves(figure_index,location_index)
							condition = true
						elsif @grid.board[location_index][0] == @black
							figure_takes(@player1_taken, figure_index, location_index)
							condition = true
						end
					end
				end			
			elsif left == true
				if (@grid.board[location_index] == @grid.empty) || (@grid.board[location_index][0] == @black)
					check = false
					counter = figure_index - location_index - 1
					num = -1
					counter.times do
						if @grid.board[figure_index+num] != @grid.empty
							check = true
						end
						num -= 1
					end

					if check == false
						if @grid.board[location_index] == @grid.empty
							figure_moves(figure_index, location_index)
							condition = true
						elsif @grid.board[location_index][0] == @black
							figure_takes(@player1_taken, figure_index, location_index)
							condition = true
						end
					end				
				end
			elsif right == true
				if (@grid.board[location_index] == @grid.empty) || (@grid.board[location_index][0] == @black)
					check = false
					counter = location_index - figure_index - 1
					num = 1
					counter.times do 
						if @grid.board[figure_index+num] != @grid.empty
							check = true
						end
						num += 1
					end

					if check == false
						if @grid.board[location_index] == @grid.empty
							figure_moves(figure_index,location_index)
							condition = true
						elsif @grid.board[location_index][0] == @black
							figure_takes(@player1_taken, figure_index, location_index)
							condition = true
						end
					end
				end	

			end				
			
		elsif color == @black
			# check if the location is reachable one side at a time
			# determine which way user wants to go
			if @figure[0] == @location[0]
				# it's either right or left
				if @figure[1] == @location[1]
					condition = false
				# check for left and right
				elsif @figure[1] > @location[1]
					condition = false
					right = true
				elsif @figure[1] < @location[1]
					condition = false
					left = true
				end
			elsif @figure[1] == @location[1]
				# it's either forward or back
				if @figure[0] == @location[0]
					condition = false
				# check for forward	and back
				elsif @figure[0] > @location[0]
					condition = false
					forward = true
				elsif @figure[0] < @location[0]
					condition = false
					back = true				
				end
			else
				# it's a wrong location
				condition = false		
			end

			# if location is reachable we have to check if the way is clear
			if forward == true
				if (@grid.board[location_index] == @grid.empty) || (@grid.board[location_index][0] == @white)
					# check if the way is clear
					check = false
					counter = @figure[0] - @location[0] - 1
					num = -8
					counter.times do
						if @grid.board[figure_index+num] != @grid.empty
							check == true						
						end	
						num -= 8 
					end

					# if the way is clear, perform the move or take opponets figure
					if check == false
						if @grid.board[location_index] == @grid.empty
							figure_moves(figure_index,location_index)
							condition = true
						elsif @grid.board[location_index][0] == @white
							figure_takes(@player2_taken, figure_index, location_index)
							condition = true
						end
					end
				end
			elsif back == true
				if (@grid.board[location_index] == @grid.empty) || (@grid.board[location_index][0] == @white)
					check = false
					counter = @location[0] - @figure[0] - 1
					num = 8
					counter.times do
						if @grid.board[figure_index+num] != @grid.empty
							check == true
						end
						num += 8
					end

					# if the way clear perform move
					if check == false
						if @grid.board[location_index] == @grid.empty
							figure_moves(figure_index,location_index)
							condition = true
						elsif @grid.board[location_index][0] == @white
							figure_takes(@player2_taken, figure_index, location_index)
							condition = true
						end
					end
				end			
			elsif left == true
				if (@grid.board[location_index] == @grid.empty) || (@grid.board[location_index][0] == @white)
					check = false
					counter = figure_index - location_index - 1
					num = -1
					counter.times do
						if @grid.board[figure_index+num] != @grid.empty
							check = true
						end
						num -= 1
					end

					if check == false
						if @grid.board[location_index] == @grid.empty
							figure_moves(figure_index, location_index)
							condition = true
						elsif @grid.board[location_index][0] == @white
							figure_takes(@player2_taken, figure_index, location_index)
							condition = true
						end
					end				
				end
			elsif right == true
				if (@grid.board[location_index] == @grid.empty) || (@grid.board[location_index][0] == @white)
					check = false
					counter = location_index - figure_index - 1
					num = 1
					counter.times do 
						if @grid.board[figure_index+num] != @grid.empty
							check = true
						end
						num += 1
					end

					if check == false
						if @grid.board[location_index] == @grid.empty
							figure_moves(figure_index,location_index)
							condition = true
						elsif @grid.board[location_index][0] == @white
							figure_takes(@player2_taken, figure_index, location_index)
							condition = true
						end
					end
				end	

			end


		end
		condition	
	end

	# defining the way knight moves
	def knight_moves(color,figure_index,location_index)
		condition = false
		if color == @white
			if (@grid.board[location_index] == @grid.empty) 
				if complement_knight_moves(figure_index,location_index)
					figure_moves(figure_index,location_index)
					condition = true
					return condition
				end
			elsif (@grid.board[location_index][0] == @black)
				if complement_knight_moves(figure_index,location_index)
					figure_takes(@player1_taken, figure_index, location_index)
					condition = true
					return condition
				end	
			end	
		elsif color == @black
			if (@grid.board[location_index] == @grid.empty) 
				if complement_knight_moves(figure_index,location_index)
					figure_moves(figure_index,location_index)
					condition = true
					return condition
				end
			elsif (@grid.board[location_index][0] == @white)
				if complement_knight_moves(figure_index,location_index)
					figure_takes(@player2_taken, figure_index, location_index)
					condition = true
					return condition
				end	
			end
		end
		condition
	end	

	# will define another method which will complement knight_moves method
	# methods will return true or false based on ability to reach the location
	def complement_knight_moves(figure_index,location_index)
		# figuring out if the location is reachable
		# we can go forward, back, left, right
		# 1 [x+1][y+2]
		# 2 [x+1][y-2]
		# 3	[x+2][y+1] 
		# 4	[x+2][y-1]
		# 5	[x-1][y+2]
		# 6	[x-1][y-2]
		# 7	[x-2][y+1]
		# 8	[x-2][y-1]
		condition = false
		
			if @location[0] == (@figure[0] + 1)
				if @location[1] == (@figure[1] + 2)
					condition = true
					return condition
				elsif @location[1] == (@figure[1] -2)
					condition = true
					return condition
				end	
			elsif @location[0] == (@figure[0] - 1)
				if @location[1] == (@figure[1] + 2)
					condition = true
					return condition
				elsif @location[1] == (@figure[1] -2)
					condition = true
					return condition
				end
			elsif @location[0] == (@figure[0] + 2)
				if @location[1] == (@figure[1] + 1)
					condition = true
					return condition
				elsif @location[1] == (@figure[1] - 1)
					condition = true
					return condition
				end
			elsif @location[0] == (@figure[0] - 2)
				if @location[1] == (@figure[1] + 1)
					condition = true
					return condition
				elsif @location[1] == (@figure[1] - 1)
					condition = true
					return condition
				end
			end						
		
		condition	
	end	

	# defining the way bishop moves
	# bishop moves diagonally
	def bishop_moves(color,figure_index,location_index)
		condition = false
		if color == @white
			if (@grid.board[location_index] == @grid.empty) 
				if complement_bishop_moves(figure_index,location_index)
					figure_moves(figure_index,location_index)
					condition = true
					return condition
				end
			elsif (@grid.board[location_index][0] == @black)
				if complement_bishop_moves(figure_index,location_index)
					figure_takes(@player1_taken, figure_index, location_index)
					condition = true
					return condition
				end	
			end	
		elsif color == @black
			if (@grid.board[location_index] == @grid.empty) 
				if complement_bishop_moves(figure_index,location_index)
					figure_moves(figure_index,location_index)
					condition = true
					return condition
				end
			elsif (@grid.board[location_index][0] == @white)
				if complement_bishop_moves(figure_index,location_index)
					figure_takes(@player2_taken, figure_index, location_index)
					condition = true
					return condition
				end	
			end
		end
		condition
	end

	# this method will return true if the location is reachable, and false if not
	def complement_bishop_moves(figure_index,location_index)
		# bishop can move four different directions
		# first, we need to check if the location is reachable
		# then, we have to check if the way is clear
		condition = false
		top_left = false
		top_right = false
		bottom_left = false
		bottom_right = false

		# determinning which way user wants to move
		if @figure == @location
			condition = false
			return condition
		elsif (@figure[0] - @location[0]) == (@figure[1] - @location[1])
			top_left = true
		elsif (@figure[0] - @location[0]) == (@location[1] - @figure[1])
			top_right = true
		elsif (@location[0] - @figure[0]) == (@figure[1]-@location[1])
			bottom_left = true
		elsif (@figure[0] + @location[0]) == (@figure[1] + location[1])
			bottom_right = true
		end

		condition
	end

	def game_over
		false
	end

	def game_on
		counter = 1
		while !game_over
			if counter == @player1
				@grid.show_board
				puts "Player 1 WHITE"
				prompt_figure
				prompt_location
				get_figure_index
				get_location_index
				if define_figure(@white, @figure_index, @location_index)
					taken_figures(@player1)
					counter += 1
				else
					puts "Please, try one more time"
					counter = 1
				end
			elsif counter == @player2
				@grid.show_board
				puts "Player 2 BLACK"
				prompt_figure
				prompt_location
				get_figure_index
				get_location_index
				if define_figure(@black, @figure_index, @location_index)
					taken_figures(@player2)
					counter -= 1
				else
					puts "Please, try one more time"
					counter = 2
				end
			end
		end
	end



	# CLASS BOARD
	class Board
		attr_accessor :board, :figures_white, :figures_black, :pawns_white, :pawns_black, :empty

		def initialize
			@board = []
			@empty = "xxx"
			@figures_white = ["wr1","wk1","wb1","wQQ","wKK","wb2","wk2","wr2"]
			@figures_black = ["br1","bk1","bb1","bQQ","bKK","bb2","bk2","br2"]
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
game = Game.new
game.game_on