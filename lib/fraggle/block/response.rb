module Fraggle
  module Block
    class Response
      SET = 4
      DEL = 8

      def set?
        !!flags && ((flags & SET) > 0)
      end

      def del?
        !!flags && ((flags & SET) > 0)
      end

      def missing?
        rev == 0
      end

      def ok?
        err_code.nil?
      end
    end
  end
end
