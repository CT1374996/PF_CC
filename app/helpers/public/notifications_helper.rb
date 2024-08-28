module Public::NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    @visitor_comment = notification.comment_id
    case notification.action
    when "follow"
      tag.a(notification.visitor.name, href: user_path(@visitor)) + "さんがあなたをフォローしました"
    when "favorite"
      tag.a(notification.visitor.name, href: user_path(@visitor)) + "さんが" + tag.a("#{@impression_title}", href: impression_path(notification.impression_id)) + "にいいねしました"
    when "comment"
      @comment = Comment.find_by(id: @visitor_comment)
      @impression_title = @comment.impression.title
      tag.a(@visitor.name, href: user_path(@visitor)) + "さんが" + tag.a("#{@impression_title}", href: impression_path(notification.impression_id)) + "にコメントしました"
    end
  end
end
