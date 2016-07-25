module Swagger
  module V1
    module Models
      module Apress
        module Api
          class Client < ::Apress::Api::Swagger::Schema
            swagger_schema name.to_sym do
              key :required, [
                :id,
                :access_id,
                :secret_token_expire_at,
                :secret_token,
                :refresh_token_expire_at,
                :refresh_token,
                :user_agent,
                :updated_at,
                :created_at
              ]

              property :id do
                key :type, :integer
                key :format, :int64
              end

              {
                access_id: '6760dc04-db3e-4c18-b7a3-5cd68718e869',
                secret_token: 'fflnVd5JyQAlH4EICLEV/c49RQRj0MaINNKFAVsuxngfcQHzLw7L9uF7fnOm/mbn4SBs3ssCUjvjcTjb4nQ==',
                refresh_token: 'kmwCUAQxg2YOCZg2ENLQ4t4hfH8DYKPb6e+6ZkSl1K/zOyAXflUeL9Ef/jL7rEMTfuu0QqbrMm8SNsEnww==',
                secret_token_expire_at: Time.current,
                refresh_token_expire_at: Time.current,
                user_agent: nil
              }.each do |k, v|
                property k do
                  key :type, :string
                  key :example, v if v
                end
              end

              [:created_at, :updated_at].each do |k|
                property k do
                  key :type, :string
                  key :format, :date
                end
              end
            end

            ActiveSupport.run_load_hooks(:'swagger/models/v1/apress/api/client', self)
          end
        end
      end
    end
  end
end
