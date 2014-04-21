=begin
author: Saskya Irena
last modified: Apr 21, 2014
description: The SumOfSquares class can accept user's input, then perform sum of squares calculation.
			 First the user inputs how many sequences they would like to do, then the program prompts
			 again how many integers the users want in that sequence. If the user is asking for more
			 than a sequence, then the program will proceed accordingly. 
			 When user has finished with his or her inputs, then the program will show the 
			 sum of squares result chronologically. 
			 The program validates along the way, whether the user is inputting the correct form
			 of input for the program or not, such as is it integer or not, is it positive or not. 
=end

class SumOfSquares
	
	#constructor method
	#accepts an integer (i) and make an array with size i
	def initialize(i)
		#result is the an array that keeps the result of the sum of squares operation
		@result = Array.new(i, 0)
		
		#put is just a reference to later put the summation into the result array
		@put = i
	end
	
	#method to ask user to put how many sequences he or she would like to make. 
	def makeSequence(n)
		if n == 0 
			#base case. does nothing
		else 
			#start to ask input from users on how many sequences
			puts "Insert how many integers you want in this sequence. Must be a positive integer."
			a = gets.chomp
			
			#checking whether the input is an integer
			if isInt(a)
				numOfInt = a.to_i
				#checking if the number is negative or not
				#sending error message if it is negative and repeat the process
				if isNegative(numOfInt)
					puts "Negative number. Must be positive. Try again."
					makeSequence(n)
				#otherwise, proceed with the process
				else
					stageTwo(numOfInt)
					makeSequence(n-1) #repeating the code using recursion
				end
			else 
				#if the input is not an integer (i.e. String) then the process is repeated.
				puts "Not an integer. Try again"
				makeSequence(n)
			end
		end
	end
	
	#method to let users input the sequence of numbers 
	#each sequence will be calculated for its sum of squares. 
	def stageTwo(x)
		
		#user prompt
		if x == 0
			@put = @put -1
		else
			puts "Enter #{x} integers"
			b = gets.chomp
			
			#splitting the input into an array, by using space as the delimiter
			arrayFirst = b.split(" ")
		
			#converting the members of the array into integer (initially it was String)
			arrayOfInt = arrayFirst.map{|a| a.to_i}
		
			#if the number of integers do not match the initial input, machine gives warning
			#process is repeated
			if arrayOfInt.length != x
				puts "Do not match! Please input #{x} integers. Try again."
				stageTwo(x)
			
			#checking whether the arrays are consisted of integers only (no Strings)
			#process is repeated if not all integer
			elsif !consistedOfInt(arrayFirst, arrayOfInt)
				puts "The members of the array are not all integer. Try again."
				stageTwo(x)
		
			#passes the above conditions, and start to do the sum of squares calculation
			else
				squareArray = arrayOfInt.map{|a| a*a}
				theResult = squareArray.inject{|sum, x| sum + x}
			
				#putting in the array of result
				@put = @put - 1
				@result[@put] = theResult
			
				#sends good message
				puts "Good, proceed."
			end
		end
	end
	
	#method to print the array of result in reverse. 
	#it is reversed because we keep the first summation result in the last index of the array
	def print()
		puts @result.reverse
	end
	
	#method to check whether a variable is an integer or not by using regular expression
	def isInt(input)
		regex_num = /^[-+]?[\d]+$/
		match = input.match(regex_num)
	end
	
	#method to check whether the number is negative or not
	#returns true if the number is negative
	def isNegative(number)
		return number < 0
	end
	
	#method to check the member of an array is all integer or not
	#returns true if the members are all integer
	def consistedOfInt(arrayStr, arrayInt)
		temp = arrayInt.map{|a| a.to_s}
		return arrayStr == temp
	end
end 

#the main routine of this class
puts "Welcome! Insert the number of sequence to begin with"

input = gets.chomp

number = input.to_i

#validation whether the input is an integer or not
if number.to_s != input
	puts "Not an integer. Unable to process."
	
#if the number is negative
elsif number < 0
	puts "Negative number. Unable to process."

#checks whether the number is zero or not. If it is, the program ends.
elsif number == 0
	puts "Bye!"
	
#proceed to execute the main routine
else
	puts "Please put #{number} sequence(s) of numbers.\n"
	ss = SumOfSquares.new(number)
	ss.makeSequence(number)
	
	#printing out the results of the operation 
	puts "\nResult for each operation in chronological order:"
	ss.print()
end