class AddRefToReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :booking, null: false, foreign_key: true
  end
end
