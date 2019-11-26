# frozen_string_literal: true
module Xirr
  #  Base module for XIRR calculation Methods
  module Base
    include NativeHelpers

    extend ActiveSupport::Concern
    attr_reader :cf

    # @param cf [Cashflow]
    # Must provide the calling Cashflow in order to calculate
    def initialize(cf)
      @cf = cf
    end

    # Calculates days until last transaction
    # @return [Rational]
    # @param date [Date]
    def periods_from_start(date)
      (date - cf.min_date) / cf.period
    end

    # Net Present Value function that will be used to reduce the cashflow
    # @param rate [BigDecimal]
    # @return [BigDecimal]
    def xnpv(rate)
      cf.inject(0) do |sum, t|
        sum + xirr_net_present_value(rate, t.amount, periods_from_start(t.date))
      end
    end

  end
end
