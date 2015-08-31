Lotus::Model.migration do
  change do
    create_table :subscriptions do
      primary_key :id
      column :email,        String, null: false, unique: true
      column :first_name,   String, null: false
      column :last_name,    String
      column :created_at,   DateTime
    end
  end
end
