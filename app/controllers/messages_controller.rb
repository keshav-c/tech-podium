class MessagesController < ApplicationController
  before_action :authorize, only: :create

  def create
    message = current_user.messages.build(message_params)
    if message.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path,
                    flash: { danger: message.errors.full_messages.join(', ') })
    end
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
