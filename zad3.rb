class CommandParser

	def initialize(command_name)
		@command_name = command_name
		@command_runner = {}
		@args_ns = []
		@t = {}
	end

	def argument(named_opt_param)
		@args_ns << named_opt_param
		h = {}
		yield(@t,nil)
		# @t << h
		p @t
	end

	def option(named_opt_param)
	end

	def option_with_parameter(named_opt_param)

	end

	def parse(command_runner, argv)
		keys = @t.keys
		keys.each_with_index { |e, i| command_runner[e.to_sym] = argv[i] }
		# argv.each_with_index { |e, i| command_runner[keys[i]] = e  }
		# p "@command_runner #{@command_runner}"
		# yield(command_runner,argv) if block_given?
		# command_runner
	end

	def help
	<<~HELP
	"Usage: #{@command_name} #{@args_ns.map { |e| "[#{e}]"}.join(" ")}
	dadada"
	HELP
	end

	
end
def h(el)
		"[#{el}]"
	end
parser = CommandParser.new("rubocop")
# 10.times do |x|
# parser.argument("#{x}")
# end
# h = {}
# parser.argument('FIRST') do |runner, value|
#   runner[:first] = value
# end

parser.argument('SECOND') do |runner, value|
  runner[:second] = value
end
parser.argument("first") do |h, v|
	h[:larodi] = v
end

command_runner = {}

parser.parse(command_runner, ['foo', 'larodi'])
p command_runner

print parser.help