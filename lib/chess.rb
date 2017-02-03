class Game
	
	class Board
		attr_accessor :board, :firgures_white, :figures_black, :pawns_white, :pawns_black, :empty

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
			num = 8
			num1 = 0
			num2 = 7
			letters = "	 a 		b 	   c 	  d 	 e 		f 	   g 	  h"
			puts letters

			8.times do
				puts
				print "#{num}  "
				p @board[num1..num2]
				num -= 1
				num1 += 8
				num2 += 8
			end
			puts
			puts letters
		end


	end

end
