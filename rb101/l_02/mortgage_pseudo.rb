Get Loan Information from user
:Loan Amount
:APR (~5.5%)
:Loan Duration (years)

Must Calculate
:Monthly Interest Rate = APR / 12
:Loan Duration in Months = Duration / 12
:Monthly Payment = formula

Formula: m = p * (j / (1 - (1 + j)**(-n)))

    m = monthly payment
    p = loan amount
    j = monthly interest rate
    n = loan duration in months

Get all pieces of info from the user
	Validate each input
Calculate the pieces of the formula individually
Plug pieces into formula into resulting monthly payment
Print out monthly payment

START
	SET loan_amount = user input
	SET apr = user input
	SET loan_duration = user input
		Validate all of these inputs individually

	monthly_rate = apr / 12 / 100
	monthly_duration = duration / 12

	monthly_payment = loan_amount * (monthly_rate / (1 - (1 + monthly_rate)**(-monthly_duration)))
	PRINT monthly_paymentdef some_method
  a = 1
  5.times do
    puts a
    b = 2
  end

  puts a
  puts b
end

some_method     # => NameError: undefined local variable or method `b' for main:Object
END