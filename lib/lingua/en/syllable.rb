module Lingua
module EN
# The module Lingua::EN::Syllable contains a single class method, +syllable+,
# which will use the most accurate technique available to determine the number
# syllables in a string containing a word passed to it.
# The exact definition of the function depends on the availability of the
# Carnegie Mellon Pronouncing Dictionary on the system. If it is available, 
# the number of syllables as determined by the dictionary will be returned. If
# the dictionary is not available, or if a word not contained in the dictionary
# is passed, it will return the number of syllables as determined by the 
# module Lingua::EN::Syllable::Guess. For more details, see there and
# Lingua::EN::Syllable::Dictionary.
module Syllable
	# use dictionary if possible
	begin
		require 'lingua/en/syllable/dictionary.rb'
		require 'lingua/en/syllable/guess.rb'
		
		def Syllable.syllables(word)
			begin
				return Dictionary::syllables(word)
			rescue Dictionary::LookUpError
				return Guess::syllables(word)
			end
		end
	rescue LoadError # dictionary not available?
		require 'lingua/en/syllable/guess.rb'
		def Syllable.syllables(word)
			Guess::syllables word
		end
	end
end
end
end

if __FILE__ == $0
	ARGV.each { | word |  puts "'#{word}' : " + 
		Lingua::EN::Syllable::syllables(word).to_s }
end