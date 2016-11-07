 module M
	def self.pars_args(arr)

	end

	def self.parse_opt(e)
		e.size == 1 ? (return "-#{e}") : (return "--#{e}")
	end
 end
class CommandParser
	 include M
	def initialize(command_name)
		@command_name = command_name
		@command_runner = {}
		@args_ns = []
		@a = {}
		@opt = []
		@d = {}
		@c = {}
	end

	def argument(named_opt_param)
		@args_ns << named_opt_param
		yield(@a,nil)
		# p @a
	end

	def option(s_name, f_name, desc)
		@opt << {s_name: s_name, f_name: f_name, desc: desc}
		
		p @opt
		 yield(@c,true) if block_given?
		 p "c = #{@c}"
	end

	def option_with_parameter(named_opt_param)

	end

	def parse(command_runner, argv)
		# keys = @a.keys
		@a.keys.each_with_index { |e, i| command_runner[e.to_sym] = argv[i] }
		if argv[0].include?("-") || argv[0].include?("--") 
			s = argv.join[1..-1]
			command_runner[@c.keys[0]] = @c.values[0]
			p "from_parse #{command_runner},   #{@opt[0].values}"
		end
		
		# argv.each_with_index { |e, i| command_runner[keys[i]] = e  }
		# p "@command_runner #{@command_runner}"
		# yield(command_runner,argv) if block_given?
		# command_runner
	end

	def help
	<<~HELP
	"Usage: #{@command_name} #{arg_help}
	#{opt_help}"
	HELP
	end

	def arg_help  
		@args_ns.map { |e| "[#{e}]"}.join(" ") if !@args_ns.empty?
	end

	def opt_help
		a = []
		@opt.each do |el|
			a << "    #{M.parse_opt(el[:s_name])}, #{M.parse_opt(el[:f_name])} #{el[:desc]}\n"
		end
		a.join()
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

# parser.argument('SECOND') do |runner, value|
#   runner[:second] = value
# end
# parser.argument("first") do |h, v|
# 	h[:larodi] = v
# end
command_runner = {}

parser.option('v', 'version', 'show version number') do |runner, value|
  runner[:version] = value
end
# parser.option('d', 'delete', 'del') do |runner, value|
#   runner[:version] = value
# end

parser.parse(command_runner, ['-v'])
p "command_runner  = #{command_runner}"
print parser.help
# puts
# p parser.opt_help
# print M.parse_opt("version")