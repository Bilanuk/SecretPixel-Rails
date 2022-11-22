# frozen_string_literal: true

module Users
  class TokensController < ApiGuard::TokensController
    # before_action :find_refresh_token, only: [:create]
    #
    # def create
    #   create_and_set_token_pair(current_resource, resource_name)
    #
    #   @refresh_token.destroy
    #   blacklist_token if ApiGuard.blacklist_token_after_refreshing && access_token
    #
    #   render_success(message: I18n.t('api_guard.access_token.refreshed'))
    # end
    #
    # private
    #
    # def find_refresh_token
    #   refresh_token_from_request = if ApiGuard.enable_tokens_in_cookies
    #                                  request.cookies['refresh_token']
    #                                else
    #                                  request.headers['Refresh-Token']
    #                                end
    #
    #   if refresh_token_from_request
    #     @refresh_token = RefreshToken.find_by(token: refresh_token_from_request)
    #     return render_error(401, message: I18n.t('api_guard.refresh_token.invalid')) unless @refresh_token
    #   else
    #     render_error(401, message: I18n.t('api_guard.refresh_token.missing'))
    #   end
    # end
    #
    # def access_token
    #   @access_token ||= if ApiGuard.enable_tokens_in_cookies
    #                     request.cookies['access_token']
    #                   else
    #                     request.headers['Authorization']&.split('Bearer ')&.last
    #                   end
    # end
    #
    # def current_resource
    #   @current_resource ||= @refresh_token.send(resource_name)
    # end
    #
    # def blacklist_token
    #   return unless token_blacklisting_enabled?(current_resource)
    #
    #   blacklisted_tokens_for(current_resource).create(token: access_token)
    # end
  end
end
