require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  integer?(num) || float?(num)
end

def integer?(num)
  num.to_i.to_s == num  
end

def float?(num)
  num.to_f.to_s == num
end

def operation_to_message(op)
  word = case op
         when '1' then 'Adding'
         when '2' then 'Subtracting'
         when '3' then 'Multiplying'
         when '4' then 'Dividing'
         end

  word
end

prompt(MESSAGES['welcome'])
name = ''
loop do
  name = Kernel.gets.chomp()

  if name.empty?()
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt("#{MESSAGES['hello']} #{name}!")

loop do # main loop
  num1 = ''
  loop do
    prompt(MESSAGES['first_num'])
    num1 = Kernel.gets().chomp()

    if valid_number?(num1)
      break
    else
      prompt(MESSAGES['valid_num'])
    end
  end

  num2 = ''
  loop do
    prompt(MESSAGES['second_num'])
    num2 = Kernel.gets().chomp()

    if valid_number?(num2)
      break
    else
      prompt(MESSAGES['valid_num'])
    end
  end

  num1 = num1.to_i()
  num2 = num2.to_i()

  prompt(MESSAGES['operator_menu'])

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['valid_operator'])
    end
  end

  result = case operator
           when '1' then num1 + num2
           when '2' then num1 - num2
           when '3' then num1 * num2
           when '4' then num1.to_f / num2.to_f
           end

  prompt("#{operation_to_message(operator)} #{MESSAGES['calculating']}")

  prompt("#{MESSAGES['result']} #{result}")
  prompt(MESSAGES['continue'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
prompt(MESSAGES['bye'])
