require 'rubygems'
require 'spec'
require 'lib/path_collapser'

describe PathCollapser do

  it "should return the pattern text if matched" do
    collapser = PathCollapser.new
    collapser.add '/images/.*'
    collapser.collapse('/images/1234.jpg').should == '/images/.*'
  end

  it "should return original path if not matched" do
    collapser = PathCollapser.new
    collapser.add '/images/.*'
    collapser.collapse('/motorcycle/something/else').should == '/motorcycle/something/else'
  end

  it "should match from the start of the string" do
    collapser = PathCollapser.new
    collapser.add '/images/.*'
    collapser.collapse('/foo/images/1234.jpg').should == '/foo/images/1234.jpg'
  end

end