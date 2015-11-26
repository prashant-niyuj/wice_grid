# encoding: utf-8
module Wice
  module Columns #:nodoc:
    module CommonJsDateDatetimeConditionsGeneratorMixin #:nodoc:

      def generate_conditions(table_alias, opts)   #:nodoc:
        conditions = [[]]
        if opts[:fr]
          conditions[0] << " #{@column_wrapper.alias_or_table_name(table_alias)}.#{@column_wrapper.name} >= ? "
          #conditions << opts[:fr].to_datetime
          conditions << Time.zone.parse(opts[:fr]).utc
          #Convert user time zone to utc 
          #conditions << Time.zone.parse(opts[:fr]).utc.to_s(:form_format)
        end

        if opts[:to]
          conditions[0] << " #{@column_wrapper.alias_or_table_name(table_alias)}.#{@column_wrapper.name} <= ? "
          conditions << (Time.zone.parse(opts[:to]).utc + 1)
        end

        return false if conditions.size == 1

        conditions[0] = conditions[0].join(' and ')
        conditions
      end

    end
  end
end
