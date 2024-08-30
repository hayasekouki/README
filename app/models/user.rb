class User < ApplicationRecord
  authenticates_with_sorcery!
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  #ユーザーが削除のときに、ユーザーにBoardも一緒に削除
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy

  #コメント作成者にだけ、編集と削除ボタンを表示
  def own?(object)
    id == object&.user_id
  end
  validates :reset_password_token, uniqueness: true, allow_nil: true
end
