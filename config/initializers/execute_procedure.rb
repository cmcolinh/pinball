ActiveRecord::Base.connection

module ActiveRecord
  module ConnectionAdapters
    class Mysql2Adapter < ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter
      def execute_procedure(proc_name, *variables)
        vars = variables.map{ |v| quote(v) }.join(', ')
        response = execute "CALL #{proc_name}(#{vars})", 'Execute Procedure'
        response.each
        ensure raw_connection.abandon_results!
      end

      def invoke_function(func_name, *variables)
        name = 'Invoke Function'

        vars = variables.map{ |v| quote(v) }.join(', ')
        response = exec_query("SELECT #{func_name}(#{vars})", name).to_hash.first.values&.first
      end
    end
  end
end
