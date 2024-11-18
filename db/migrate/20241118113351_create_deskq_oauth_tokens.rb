class CreateDeskqOauthTokens < ActiveRecord::Migration[7.2]
  def change
    create_table(:deskq_oauth_tokens) do |t|
      t.string(:access_token)
      t.string(:refresh_token)
      t.string(:scope)
      t.string(:expires_at)
      t.references(:integration_grant, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
