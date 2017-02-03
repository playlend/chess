class Game
	
	class Board
		attr_accessor :board
		def initialize
			@board = []
			num1 = 0
			num2 = 0
			64.times do |num|
				
				if num <= 7
					case num 
						when 0
							@board.push("wr1")
						when 1
							@board.push("wk1")
						when 2
							@board.push("wb1")
						when 3
							@board.push("W Q")
						when 4
							@board.push("W K")
						when 5
							@board.push("wb2")
						when 6
							@board.push("wk2")
						when 7
							@board.push("wr2")
					end
				elsif num > 7 && num <= 15 
					num1 += 1	
					@board.push("wp" + num1.to_s)
				elsif num >= 48 && num < 56
					num2 += 1	
					@board.push("bp" + num2.to_s)

				elsif num >= 56
					case num 
						when 56
							@board.push("br1")
						when 57
							@board.push("bk1")
						when 58
							@board.push("bb1")
						when 59
							@board.push("B Q")
						when 60
							@board.push("B K")
						when 61
							@board.push("bb2")
						when 62
							@board.push("bk2")
						when 63
							@board.push("br2")
					end
				else
					@board.push("xxx")
				end
			end
		end

		def show_board
			num1 = 0
			num2 = 7
			8.times do 
				p @board[num1..num2]
				num1 += 8
				num2 += 8
			end
		end


	end

end

