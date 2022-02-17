# frozen_string_literal: true

# This file is part of the Plugin Redmine Legal Notes.
#
# Copyright (C) 2020-2021 Liane Hampe <liaham@xmera.de>, xmera.
#
# This plugin program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

module RedmineEmailCustomizer
  ##
  # Provide user login test
  #
  module AuthenticateUser
    module_function

    def log_user(login, password)
      login_page
      log_user_in(login, password)
      assert_equal login, User.find(user_session_id).login
    end

    private

    def login_page
      User.anonymous
      get '/login'
      assert_nil user_session_id
      assert_response :success
    end

    def user_session_id
      session[:user_id]
    end

    def log_user_in(login, password)
      post '/login', params: {
        username: login,
        password: password
      }
    end
  end
end
