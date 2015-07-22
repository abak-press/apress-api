# coding: utf-8
require "migration_comments"

class CreateApiClients < ActiveRecord::Migration
  def up
    create_table :api_clients, comment: "Пользователи API" do |t|
      t.string :access_id, null: false, limit: 36, comment: "Уникальный ID пользователя"
      t.string :device_id, limit: 36, comment: "ID устройства мобильного пользователя"
      t.string :secret_token, null: false, comment: "Секретный ключ для подписи запроса"
      t.datetime :secret_token_expire_at, null: false, comment: "Время протухания"
      t.string :refresh_token, null: false, comment: "Ключ для получения нового секретного ключа"
      t.datetime :refresh_token_expire_at, null: false, comment: "Время протухания"
      t.string :user_agent, comment: "User-Agent пользователя"
      t.timestamps null: false
    end

    execute <<-SQL
      ALTER TABLE api_clients
        ADD CONSTRAINT uniq_api_clients_on_access_id
        UNIQUE(access_id)
        DEFERRABLE INITIALLY DEFERRED;
    SQL
  end

  def down
    drop_table :api_clients
  end
end
