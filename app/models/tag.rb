class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, :through => :post_tags

  validates_presence_of :name

  def delete_tags_with_no_posts
    all_tags = Tag.all
    all_tags.each do |tag|
      tag.destroy if tag.posts.empty?
    end
  end
end
