class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :user

  belongs_to :user
end
