# frozen_string_literal: true
require 'bigdecimal/newton'

module Xirr
  # Class to calculate IRR using Newton Method
  class NewtonMethod
    include Base
    include Newton

    # Base class for working with Newton's Method.
    # @api private
    class Function
      values = {
          eps: Xirr::EPS,
          one:  '1.0',
          two:  '2.0',
          ten:  '10.0',
          zero: '0.0'
      }

      # define default values
      values.each do |key, value|
        define_method key do
          BigDecimal(value, Xirr::PRECISION)
        end
      end

      # @param transactions [Cashflow]
      # @param function [Symbol]
      # Initializes the Function with the Cashflow it will use as data source and the function to reduce it.
      def initialize(transactions, function)
        @transactions = transactions
        @function = function
      end

      # Necessary for #nlsolve
      # @param x [BigDecimal]
      def values(x)
        value = @transactions.send(@function, BigDecimal(x[0].to_s, Xirr::PRECISION))
        [BigDecimal(value.to_s, Xirr::PRECISION)]
      end
    end

    # Calculates XIRR using Newton method
    # @return [BigDecimal]
    # @param guess [Float]
    def xirr guess, options
      func = Function.new(self, :xnpv)
      rate = [guess || cf.irr_guess]
      begin
        nlsolve(func, rate)
        (rate[0] <= -1 || rate[0].nan?) ? nil : rate[0].round(Xirr::PRECISION)

          # rate[0].round(Xirr::PRECISION)
      rescue
        nil
      end
    end
  end
end
