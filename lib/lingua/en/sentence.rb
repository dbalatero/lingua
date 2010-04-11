module Lingua
  module EN
    # The module Lingua::EN::Sentence takes English text, and attempts to
    # split it up into sentences, respecting abbreviations.

    module Sentence
      EOS = "\001" unless defined?(EOS) # temporary end of sentence marker

      Titles   = [ 'jr', 'mr', 'mrs', 'ms', 'dr', 'prof', 'sr', 'sen', 'rep',
        'rev', 'gov', 'atty', 'supt', 'det', 'rev', 'col','gen', 'lt',
        'cmdr', 'adm', 'capt', 'sgt', 'cpl', 'maj' ] unless defined?(Titles)

      Entities = [ 'dept', 'univ', 'uni', 'assn', 'bros', 'inc', 'ltd', 'co',
        'corp', 'plc' ] unless defined?(Entities)

      Months   = [ 'jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul',
        'aug', 'sep', 'oct', 'nov', 'dec', 'sept' ] unless defined?(Months)

      Days     = [ 'mon', 'tue', 'wed', 'thu',
                   'fri', 'sat', 'sun' ] unless defined?(Days)

      Misc     = [ 'vs', 'etc', 'no', 'esp', 'cf' ] unless defined?(Misc)

      Streets  = [ 'ave', 'bld', 'blvd', 'cl', 'ct',
                   'cres', 'dr', 'rd', 'st' ] unless defined?(Streets)

      @@abbreviations = Titles + Entities + Months + Days + Streets + Misc

      # Split the passed text into individual sentences, trim these and return
      # as an array. A sentence is marked by one of the punctuation marks ".", "?"
      # or "!" followed by whitespace. Sequences of full stops (such as an
      # ellipsis marker "..." and stops after a known abbreviation are ignored.
      def self.sentences(text)

        text = text.dup

        # initial split after punctuation - have to preserve trailing whitespace
        # for the ellipsis correction next
        # would be nicer to use look-behind and look-ahead assertions to skip
        # ellipsis marks, but Ruby doesn't support look-behind
        text.gsub!( /([\.?!](?:\"|\'|\)|\]|\})?)(\s+)/ ) { $1 << EOS << $2 }

        # correct ellipsis marks and rows of stops
        text.gsub!( /(\.\.\.*)#{EOS}/ ) { $1 }

        # correct abbreviations
        # TODO - precompile this regex?
        text.gsub!( /(#{@@abbreviations.join("|")})\.#{EOS}/i ) { $1 << '.' }

        # split on EOS marker, strip gets rid of trailing whitespace
        text.split(EOS).map { | sentence | sentence.strip }
      end

      # add a list of abbreviations to the list that's used to detect false
      # sentence ends. Return the current list of abbreviations in use.
      def self.abbreviation(*abbreviations)
        @@abbreviations += abbreviations
        @@abbreviations
      end
    end
  end
end
