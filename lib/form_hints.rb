module FormHints
    module_function

    def reset
        @hints_db = nil
    end

    def load_from(path)
        @hints_db = YAML.safe_load(File.read(path))
    end

    def lookup(model_name, field_name)
        return [] if @hints_db.nil?

        model_fields = @hints_db[model_name.to_s]
        return [] if model_fields.nil?

        model_fields[field_name.to_s] || []
    end
end