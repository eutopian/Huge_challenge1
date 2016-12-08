class Canvas
  attr_accessor :canvas
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    @canvas = make_canvas(@width, @height)
  end

	def draw_canvas
		row = []
		(@width + 2).times { row.push('-') }
		puts row.join
		i = 0
		while i < @height
			puts "|" + @canvas[i].join + "|"
			i += 1
		end
    puts row.join
	end
	
	def make_line(x1, y1, x2, y2)
	  if y1 == y2
	    min = x1 < x2 ? x1 : x2
		  max = x1 > x2 ? x1 : x2
		  counter = 0
	    while (min + counter) < (max + 1)
		    @canvas[(y1 - 1)][(min - 1) + counter] = "X"
		    counter += 1
	    end
	  elsif x1 == x2
	    min = y1 < y2 ? y1 : y2
		  max = y1 > y2 ? y1 : y2
		  counter = 0
		  while (min + counter) < (max + 1)
		    @canvas[(min - 1) + counter][(x1 - 1)] = "X"
		    counter += 1
		  end
	  end
	end

	def create_line(x1, y1, x2, y2)
	  make_line(x1, y1, x2, y2)
	  draw_canvas
	end
		
	def create_rectange(x1, y1, x2, y2)
	  make_line(x1, y1, x2, y1)
	  make_line(x1, y2, x2, y2)
	  make_line(x1, y1, x1, y2)
	  make_line(x2, y1, x2, y2)
	  draw_canvas
	end

	/ second attempt at making bucket_fill /
  def trial(x, y, c)
    color = @canvas[y-1][x-1]
    pixel_stack = [[x, y]]
    while pixel_stack.length > 0
      new_position = pixel_stack.pop
      x = new_position[0]
      y = new_position[1]
      while !off_canvas(x, y) && match_color(x, y, color)
        @canvas[y-1][x-1] = c
        y -= 1
        while @canvas[y][x-1] == color && !off_canvas(x, y)
          pixel_stack << [x-1, y]
          x -= 1
        end
        if @canvas[y][x] == color
          pixel_stack << [x+1, y]
          puts "hi"
        end
      end
    end
  end

  / not full working yet /
	def bucket_fill(x, y, c)
	  counter1 = 0
	  counter2 = 0
	  counter3 = 0
	  counter4 = 0
	  if @canvas[y-1][x-1] != "X"
	    while !off_canvas(x, y-counter1) && @canvas[(y-1)-counter1][x-1] != "X"
	      east_fill(x, y-counter1, c)
	      west_fill(x, y-counter1, c)
	      north_fill(x, y-counter1, c)
	      south_fill(x, y-counter1, c)
	      counter1 += 1
	    end
	    
	    while !off_canvas(x+counter2, y) && @canvas[y-1][(x-1)+counter2] != "X"
	      east_fill(x+counter2, y, c)
	      west_fill(x+counter2, y, c)
	      north_fill(x+counter2, y, c)
	      south_fill(x+counter2, y, c)
	      counter2 += 1
	    end
	    
	    while !off_canvas(x, y+counter3) && @canvas[(y-1)+counter3][x-1] != "X"
	      east_fill(x, y+counter3, c)
	      west_fill(x, y+counter3, c)
	      north_fill(x, y+counter3, c)
	      south_fill(x, y+counter3, c)
	      counter3 += 1
	    end
	    
	    while !off_canvas(x-counter4, y) && @canvas[y-1][(x-1)-counter4] != "X"
	      east_fill(x-counter4, y, c)
	      west_fill(x-counter4, y, c)
	      north_fill(x-counter4, y, c)
	      south_fill(x-counter4, y, c)
	      counter4 += 1
	    end
	  end

	  @canvas.each_with_index do |sub_array, i|
	  	sub_array.each_with_index do |color, ind|
	  		if @canvas[i][ind] == c
		  		east_fill(i, ind, c)
		  		west_fill(i, ind, c)
		  		north_fill(i, ind, c)
		  		south_fill(i, ind, c)
	  		end
	  	end
		end
	end

	def east_fill(x, y, c)
	  counter = 0
	  while !off_canvas(x+counter, y) && @canvas[y-1][(x-1)+counter] != "X"
	    @canvas[y-1][(x-1)+counter] = c
	    counter += 1
	  end
	end

	def west_fill(x, y, c)
	  counter = 0
	  while !off_canvas(x-counter, y) && @canvas[y-1][(x-1)-counter] != "X"
	    @canvas[y-1][(x-1)-counter] = c
	    counter += 1
	  end
	end

	def north_fill(x, y, c)
	  counter = 0
	  while !off_canvas(x, y-counter) && @canvas[(y-1)-counter][x-1] != "X"
	    @canvas[(y-1)-counter][x-1] = c
	    counter += 1
	  end
	end

	def south_fill(x, y, c)
	  counter = 0
	  while !off_canvas(x, y+counter) && @canvas[(y-1)+counter][x-1] != "X"
	    @canvas[(y-1)+counter][x-1] = c
	    counter += 1
	  end
	end

	def off_canvas(x, y)
		(x < 1 || x > @width || y < 1 || y > @height) ? true : false
	end
	
	def match_color(x, y, c)
    @canvas[(y-1)][(x-1)] == c ? true : false 
  end

private
	def make_canvas(x, y)
		@canvas = Array.new(y, ".")
		@canvas.map! { Array.new(x, ".")}
	end
end

a = Canvas.new(20, 4)
a.create_line(1, 2, 6, 2)
a.create_line(6, 3, 6, 4)
a.create_rectange(16, 1, 20, 3)