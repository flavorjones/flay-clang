require 'test_helper'

describe "Flay" do
  describe "Clang" do
    it "has a version number" do
      ::Flay::Clang::VERSION.wont_be_nil
    end
  end

  it "processes C code" do
    ast = Flay.new.process_c FLAY_CLANG_FIXTURES.join("simple.c")
    ast.must_be_kind_of Sexp
    ast.inspect.must_match /simple_method/
  end
end
