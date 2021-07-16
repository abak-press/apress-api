# frozen_string_literal: true
namespace :docs do
  desc 'Generate api documentation'
  task generate: :environment do
    filename = 'swagger_v1.json'
    path = Rails.application.config.api[:v1_doc_path]
    FileUtils.mkdir_p(File.dirname(path))

    Apress::Api::Swagger::Generator.new(path).generate_file

    puts 'Done.'
  end
end
