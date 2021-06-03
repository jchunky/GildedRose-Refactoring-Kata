module ClassLoader
  extend self

  def classes(module_scope, file_pattern)
    Dir[file_pattern].map do |filename|
      filename_to_class(module_scope, filename)
    end
  end

  private

  def filename_to_class(module_scope, filename)
    clazz = filename.split("/").last.split(".").first.camelcase
    "#{module_scope}#{clazz}".constantize
  end
end
