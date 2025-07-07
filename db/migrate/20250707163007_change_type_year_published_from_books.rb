class ChangeTypeYearPublishedFromBooks < ActiveRecord::Migration[7.1]
  def change
    change_column :books, :year_published, 'integer USING CAST(year_published AS integer)'
  end
end
