class CommentsController < ApplicationController
    before_action :must_logined

    def create
        comment = Comment.new(comment_params)
        unless comment.save
            flash[:notice] = comment.errors.first.full_message
        end
        redirect_to item_path(params[:item_id])
    end
end
