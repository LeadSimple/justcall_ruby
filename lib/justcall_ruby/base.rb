module JustCall
  class Base
    protected

    def requires!(*args)
      self.class.requires!(*args)
    end

    class << self
      def requires!(hash, *params)
        params.each do |param|
          if param.is_a?(Array)
            raise ArgumentError, "Missing required parameter: #{param.first}" unless hash.key?(param.first)

            valid_options = param[1..]

            unless valid_options.include?(hash[param.first])
              raise ArgumentError, "Parameter: #{param.first} must be one of: #{valid_options.join(', ')}"
            end
          else
            raise ArgumentError, "Missing required parameter: #{param}" unless hash.key?(param)
          end
        end
      end
    end
  end
end
