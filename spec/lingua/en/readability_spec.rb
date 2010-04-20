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
end
