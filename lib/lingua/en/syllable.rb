require 'lingua/en/syllable/guess'

module Lingua
  module EN
    # The module Lingua::EN::Syllable contains a single class method,
    # +syllable+, which will use the most accurate technique available to
    # determine the number syllables in a string containing a word passed to it.
    #
    ########## REMOVED BY dbalatero:
    # The exact definition of the function depends on the availability of the
    # Carnegie Mellon Pronouncing Dictionary on the system. If it is available,
    # the number of syllables as determined by the dictionary will be returned.
    # If the dictionary is not available, or if a word not contained in the
    # dictionary is passed, it will return the number of syllables as determined
    # by the module Lingua::EN::Syllable::Guess. For more details, see there and
    # Lingua::EN::Syllable::Dictionary.
    module Syllable
      def self.syllables(word)
        Guess::syllables word
      end
    end
  end
end
