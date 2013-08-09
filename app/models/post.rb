class Post < ActiveRecord::Base
  has_many :post_tags
  has_many :tags, :through => :post_tags
  belongs_to :user

  validates_presence_of :title, :body
  

  after_destroy :delete_tags_with_no_posts

  def delete_tags_with_no_posts
    all_tags = Tag.all
    all_tags.each do |tag|
      tag.destroy if tag.posts.empty?
    end
  end

  def delete_tag(tag)
    self.tags.delete(tag)
  end
end
