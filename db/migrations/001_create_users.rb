Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :slack_id, size: 50, null: false, unique: true
      String :name
      String :real_name
    end
  end
end
