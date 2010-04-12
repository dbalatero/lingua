module Lingua
  module EN
    module Syllable
      module Dictionary
        class LookUpError < IndexError
        end

        @@dictionary = nil
        @@dbmclass   = nil
        @@dbmext     = nil

        # use an available dbm-style hash
        [ 'gdbm', 'dbm'].each do | dbm |
          begin
            require dbm
            @@dbmclass = Module.const_get(dbm.upcase)
          rescue
            next
          end
        break
        end

        if @@dbmclass.nil?
          raise LoadError,
            "no dbm class available for Lingua::EN::Syllable::Dictionary"
        end

        # Look up word in the dbm dictionary.
        def Dictionary.syllables(word)
          if @@dictionary.nil?
            load_dictionary
          end
          word = word.upcase
          begin
            pronounce = @@dictionary.fetch(word)
          rescue IndexError
            if word =~ /'/
              word = word.delete "'"
              retry
            end
            raise LookUpError, "word #{word} not in dictionary"
          end

          pronounce.split(/-/).grep(/^[AEIUO]/).length
        end

        def Dictionary.dictionary
          if @@dictionary.nil?
            load_dictionary
          end
          @@dictionary
        end

        # convert a text file dictionary into dbm files. Returns the file names
        # of the created dbms.
        def Dictionary.make_dictionary(source_file, output_dir)
          begin
            Dir.mkdir(output_dir)
          rescue
          end

          # clean old dictionary dbms
          Dir.foreach(output_dir) do | x |
            next if x =~ /^\.\.?$/
            File.unlink(File.join(output_dir, x))
          end

          dbm = @@dbmclass.new(File.join(output_dir, 'dict'))

          begin
            IO.foreach(source_file) do | line |
              next if line !~ /^[A-Z]/
              line.chomp!
            (word, *phonemes) = line.split(/  ?/)
            next if word =~ /\(\d\) ?$/ # ignore alternative pronunciations
              dbm.store(word, phonemes.join("-"))
            end
          rescue
            # close and clean up
            dbm.close
            Dir.foreach(output_dir) do | x |
              next if x =~ /^\.\.?$/
              File.unlink(File.join('dict', x))
            end
            # delete files
            raise
          end

          dbm.close

          Dir.entries(output_dir).collect { | x |
            x =~ /^\.\.?$/ ? nil : File.join("dict", x)
          }.compact
        end

        private
        def Dictionary.load_dictionary
          @@dictionary = @@dbmclass.new( __FILE__[0..-14] + 'dict')
          if @@dictionary.keys.length.zero?
            raise LoadError, "dictionary file not found"
          end
        end
      end
    end
  end
end
