if Rails::VERSION::MAJOR > 4
  MIGRATION_CLASS = ActiveRecord::Migration[4.2]
else
  MIGRATION_CLASS = ActiveRecord::Migration
end

class CreateApiClients < MIGRATION_CLASS
  def up
    create_table :api_clients do |t|
      t.string :access_id, null: false, limit: 36
      t.string :secret_token, null: false
      t.datetime :secret_token_expire_at, null: false
      t.string :refresh_token, null: false
      t.datetime :refresh_token_expire_at, null: false
      t.string :user_agent
      t.timestamps null: false
    end

    execute <<-SQL
      COMMENT ON TABLE api_clients IS 'Пользователи API';
      COMMENT ON COLUMN api_clients.access_id IS 'Уникальный ID пользователя';
      COMMENT ON COLUMN api_clients.secret_token IS 'Секретный ключ для подписи запроса';
      COMMENT ON COLUMN api_clients.secret_token_expire_at IS 'Время протухания';
      COMMENT ON COLUMN api_clients.refresh_token IS 'Ключ для получения нового секретного ключа';
      COMMENT ON COLUMN api_clients.refresh_token_expire_at IS 'Время протухания';
      COMMENT ON COLUMN api_clients.user_agent IS 'User-Agent пользователя';

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
