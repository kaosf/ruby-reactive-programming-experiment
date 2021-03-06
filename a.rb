require 'frappuccino'

class Button
  def push
    emit(:pushed) # emit sends a value into the stream
  end
end

button = Button.new
stream = Frappuccino::Stream.new(button)

counter = stream
            .map {|event| event == :pushed ? 1 : 0 } # convert events to ints
            .inject(0) {|sum, n| sum + n } # add them up

puts counter.now # => 0

button.push
button.push
button.push

puts counter.now # => 3

button.push

puts counter.now # => 4
