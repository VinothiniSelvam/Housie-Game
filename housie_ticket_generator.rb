# Program for housie ticket generation

def generate_ticket
  # Initialize two dimensional array to hold ticket numbers
  ticket = Array.new(3) { Array.new(9) }

  # iteration to generate each column of a ticket
  9.times do |column_index|
    # Find min number of current column by using column_index
    min_num = if column_index == 1 
                10
              else
                column_index == 0 ? 1 : column_index * 10
              end
    # Find increment value in order to find max number of a column
    increments = {
      0 => 8,
      8 => 10
    }
    increment = increments[column_index] || 9

    # Find max value of current column by using increment and minimum value
    max_num = min_num + increment

    # Generate and store ordered random numbers for current column
    column = (min_num..max_num).to_a.sample(3).sort
    ticket.map { |row| row[column_index] = column.shift }
  end

  # Add blanks to tickets
  #
  # Possible positions to set nil
  values = (0..8).to_a

  # Get 4 random positions for 1st row
  sample1 = values.sample(4)

  # Get 4 random positions without repeatation of sample1 positions for 2nd row
  rem_values = values - sample1
  sample2 = rem_values.sample(4)

  # Get 3rd set of 4 random positions for 3rd row
  sample3 = values.sample(4)

  # Stored 3 set of random positions in an array
  pos_to_be_nil = [sample1, sample2, sample3] 

  # Set nil to random set of positions in each row
  ticket.each_with_index do |array, index|
    pos_to_be_nil[index].each do |position|
      array[position] = nil
    end
  end

  # Print the ticket
  puts "Generated Housie Ticket :\n\n"
  ticket.each do |row|
    puts row.map { |num| num.nil? ? 'X' : num.to_s }.join("\t")
  end
end

# Generate housie ticket
generate_ticket
