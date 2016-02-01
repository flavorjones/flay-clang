class Flay
  module Clang
    class Visitor
      CONTAINER_NODES = %w[TranslationUnit CompoundStmt DeclStmt ReturnStmt]
      LITERAL_NODES = %w[IntegerLiteral]
      LEAF_NODES = %w[ParmDecl DeclRefExpr]
      ALL_NODES = CONTAINER_NODES + LITERAL_NODES + LEAF_NODES +
        %w[FunctionDecl VarDecl BinaryOperator UnexposedExpr]

      def initialize filename
        @filename = filename
      end

      def accept cursor
        fname = "visit_#{cursor.kind_spelling}"
        send fname, cursor
      end

      CONTAINER_NODES.each do |node|
        define_method "visit_#{node}" do |cursor|
          children(cursor)
        end
      end

      LITERAL_NODES.each do |node|
        define_method "visit_#{node}" do |cursor|
          read_range cursor.extent
        end
      end

      LEAF_NODES.each do |node|
        define_method "visit_#{node}" do |cursor|
          [cursor.type.spelling.to_sym, cursor.display_name]
        end
      end

      def visit_FunctionDecl cursor
        sexp = []
        sexp << arguments(cursor)
        cursor.visit_children do |cursor, parent|
          if cursor.kind_spelling != "ParmDecl"
            sexp << accept(cursor)
          end
          next :continue
        end
        sexp
      end

      def visit_VarDecl cursor
        sexp = [cursor.type.spelling.to_sym, cursor.display_name]
        sexp += children(cursor)
        sexp
      end

      def visit_BinaryOperator cursor
        sexp = [read_range(cursor.extent)]
        sexp += children(cursor)
        sexp
      end

      def visit_UnexposedExpr cursor
        children(cursor)
      end

      private

      def file
        @file ||= File.open(@filename)
      end

      def arguments cursor
        args = []
        (0..cursor.num_arguments-1).each do |j|
          args << accept(cursor.argument(j))
        end
        args
      end

      def children cursor
        sexp = []
        cursor.visit_children do |cursor, parent|
          sexp << accept(cursor)
          next :continue
        end
        sexp
      end

      def read_range range
        offset = range.start.offset
        length = range.end.offset - offset
        file.sysseek(offset)
        file.sysread(length)
      end

      def read_some start, length
        file.sysseek(start)
        file.sysread(length)
      end

      def debug_dump thing
        (thing.methods - Object.methods - [:visit_children]).select do |method|
          thing.method(method).arity == 0
        end.inject({}) do |hash, method|
          hash[method] = thing.send(method)
          hash
        end
      end
    end
  end
end
