class FavoriteMailer < ApplicationMailer
  default from: "erinresso@gmail.com"

  def new_comment(user, post, comment)

    headers["Message-ID"] = "<comments/#{comment.id}@gentle-escarpment-48909.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@gentle-escarpment-48909.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@gentle-escarpment-48909.herokuapp.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New Comment On #{post.title}")
  end

  def new_post(user, post)

    headers["Message-ID"] = "<post/#{post.id}@gentle-escarpment-48909.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@gentle-escarpment-48909.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@gentle-escarpment-48909.herokuapp.com>"

    @user = user
    @post = post

    mail(to: user.email, subject: "You are now following #{post.title}")
  end
end
