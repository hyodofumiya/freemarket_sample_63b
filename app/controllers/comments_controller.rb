class CommentsController < ApplicationController
    before_action :must_logined

    def create
        comment = Comment.new(comment_params.merge(user_id: current_user.id, item_id: params[:item_id]))
        unless comment.save
            flash[:notice] = comment.errors.full_messages.first#現状jsで空で入力できないようにしているが、一応フラッシュメッセージは入れる。（現状未使用）
        end
        redirect_to item_path(params[:item_id])
    end

    private

    def comment_params
        params.require(:post).permit(:comment)
    end
end
