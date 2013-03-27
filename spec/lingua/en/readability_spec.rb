require File.dirname(__FILE__) + "/../../spec_helper"

describe Lingua::EN::Readability do
  before(:each) do
    @text = <<-EOF
    After marriage, the next big event in the couples lives will be their honeymoon. It is a time when the newly weds can get away from relatives and friends to spend some significant time getting to know one another. This time alone together that the couple shares is called the honeymoon. A great gift idea for the married couple would be to give them a surprise tour package. Most women would like to go on a honeymoon.

    The week or two before the ceremonies would be the best time to schedule a tour because then the budget for this event could be considered. In winter there are more opportunities for the couple to get close to one another because of the cold weather. It is easier to snuggle when the weather is not favorable to outdoor activities. This would afford the couple ample time to know more about themselves during the honeymoon.

    Honeymoon plans should be discussed with the wife to ensure that the shock is pleasant and not a negative experience to her. It is also a good idea in this case, to ask her probing questions as to where she would like to go. Perhaps you could get a friend or family member to ask her what would be her favorite travel location. That would ensure that you know just what she is looking for.

    Make sure that the trip is exactly what she wants. Then on the wedding night tell her about the adventure so that the needed accommodations can be made.
    EOF

    @report = Lingua::EN::Readability.new(@text)
  end

  describe "#flesch" do
    it "should be the correct Flesch Reading Ease" do
      @report.flesch.should be_within(0.001).of(71.471)
    end
  end

  describe "#fog" do
    it "should be the correct Gunning Fog Index" do
      @report.fog.should be_within(0.001).of(10.721)
    end
  end

  describe "#kincaid" do
    it "should be the correct Flesch-Kincaid grade level" do
      @report.kincaid.should be_within(0.1).of(7.5)
    end
  end

  describe "#num_chars" do
    it "should be the correct count of characters" do
      @report.num_chars.should == 1405
    end
  end

  describe "#num_paragraphs" do
    it "should return the correct count of paragraphs" do
      @report.num_paragraphs.should == 4
    end
  end

  describe "#num_sentences" do
    it "should be the correct count of sentences" do
      @report.num_sentences.should == 15
    end
  end

  describe "#num_syllables" do
    it "should be the correct count of syllables" do
      @report.num_syllables.should == 356
    end
  end

  describe "#num_unique_words" do
    it "should be the correct count of unique words" do
      @report.num_unique_words.should == 141
    end
  end

  describe "#num_words" do
    it "should be the correct count of words" do
      @report.num_words.should == 255
    end
  end

  describe "#occurrences" do
    it "should return the correct count of occurrences of the word 'the'" do
      @report.occurrences('the').should == 20
    end
  end

  describe "#percent_fog_complex_words" do
    it "should be the correct percentage of complex words according to Fog Index" do
      @report.percent_fog_complex_words.should be_within(0.001).of(9.803)
    end
  end

  describe "#syllables_per_word" do
    it "should be the correct average of syllables per word" do
      @report.syllables_per_word.should be_within(0.001).of(1.396)
    end
  end

  describe "#unique_words" do
    it "should be an array of unique words" do
      unique_words = @report.unique_words
      unique_words.should be_a(Array)
      unique_words.length.should == 141
    end
  end

  describe "#words_per_sentence" do
    it "should be the correct count of words per sentence" do
      @report.words_per_sentence.should be_within(0.001).of(17.0)
    end
  end

end
