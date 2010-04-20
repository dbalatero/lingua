require File.dirname(__FILE__) + "/../../spec_helper"

describe Lingua::EN::Paragraph do
  describe "#paragraphs" do
    it "should return paragraphs with extra whitespace in the line breaks" do
      text = "Ok.\n    \nTest."
      result = Lingua::EN::Paragraph.paragraphs(text)
      result.should have(2).things
      result[0].should == "Ok."
      result[1].should == "Test."
    end

    it "should break up paragraphs with > 2 line breaks" do
      text = "Ok.\n\n\nTest."
      result = Lingua::EN::Paragraph.paragraphs(text)
      result.should have(2).things
      result[0].should == "Ok."
      result[1].should == "Test."
    end

    it "should ignore trailing newline chars" do
      text = "Ok.\n  \n\nTest.\n  \r\n  \n\n"
      result = Lingua::EN::Paragraph.paragraphs(text)
      result.should have(2).things
      result[0].should == "Ok."
      result[1].should == "Test."
    end
  end
end
