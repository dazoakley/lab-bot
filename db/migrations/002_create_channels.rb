Sequel.migration do
  change do
    create_table(:channels) do
      primary_key :id
      String :slack_id, size: 50, null: false, unique: true
      String :name
      Boolean :archived
      Boolean :private
      String :topic
    end
  end
end
