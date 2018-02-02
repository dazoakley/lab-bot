Sequel.migration do
  change do
    create_table(:messages) do
      primary_key :id

      String :text, text: true, null: false
      String :ts, size: 50, null: false

      DateTime :created_at
      DateTime :updated_at

      foreign_key :user_id, :users
      foreign_key :channel_id, :channels
    end
  end
end
