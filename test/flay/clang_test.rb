require 'test_helper'

describe Flay do
  describe Flay::Clang do
    it "has a version number" do
      ::Flay::Clang::VERSION.wont_be_nil
    end

    it "parses a simple C file" do
      sexp = Flay::Clang.sexp_for FLAY_CLANG_FIXTURES.join("simple.c").to_s

      target = s(:TranslationUnit,
        s(:FunctionDecl,
          [s(:Parmdecl, :int, "foo"), s(:ParmDecl, :int, "bar")],
          s(:CompoundStmt,
            s(:DeclStmt,
              s(:VarDecl, :int, "value", s(:IntegerLiteral, "0"))),
            s(:BinaryOperator, "=",
              s(:DeclRefExpr, "value"),
              s(:BinaryOperator, "*",
                s(:BinaryOperator, "*",
                  s(:ImplicitCastExpr, "int",
                    s(:DeclRefExpr, "foo")),
                  s(:ImplicitCastExpr, "int",
                    s(:DeclRefExpr, "bar"))),
                s(:IntegerLiteral, "2"))),
            s(:ReturnStmt,
              s(:ImplicitCastExpr, "int",
                s(:DeclRefExpr, "value"))))))

      sexp.must_equal target
    end
  end
end
