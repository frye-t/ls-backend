require 'yaml'
MSGS = YAML.load_file('mortgage_messages.yml')

# puts(MESSAGES['key']) (send through a message formatter)
def prompt_config(key)
  puts "=> #{MSGS[key]}"
end

def prompt(msg)
  puts "=> #{msg}"
end

def valid_num?(num)
  integer?(num) || float?(num)
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

prompt_config('welcome')
prompt_config('name')

name = ''
loop do
  name = gets.chomp
  break unless name.empty?
  prompt_config('invalid_name')
end

prompt_config('begin_calc')

prompt_config('get_amount')
loan_amount = ''
loop do
  loan_amount = gets.chomp
  break if valid_num?(loan_amount)
  prompt_config('invalid_num')
end

prompt_config('get_apr')
apr = ''
loop do
  apr = gets.chomp
  break if valid_num?(apr)
  prompt_config('invalid_num')
end

prompt_config('get_duration')
duration_years = ''
loop do
  duration_years = gets.chomp
  break if valid_num?(duration_years)
  prompt_config('invalid_num')
end

monthly_rate = apr.to_f / 12 / 100
duration_months = duration_years.to_f * 12
monthly_payment = (loan_amount.to_f *
                  (monthly_rate /
                  (1 - (1 + monthly_rate)**(-duration_months)))).round(2)

prompt("Your monthly payment is #{monthly_payment}")
