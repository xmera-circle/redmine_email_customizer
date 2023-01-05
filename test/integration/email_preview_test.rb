# frozen_string_literal: true

# This file is part of the Plugin Redmine Email Customizer.
#
# Copyright (C) 2022-2023 Liane Hampe <liaham@xmera.de>, xmera Solutions GmbH.
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

require File.expand_path("#{File.dirname(__FILE__)}/../test_helper")
require File.expand_path("#{File.dirname(__FILE__)}/../authenticate_user")
require File.expand_path("#{File.dirname(__FILE__)}/../load_fixtures")

module RedmineEmailCustomizer
  class EmailPreviewTest < ActionDispatch::IntegrationTest
    include RedmineEmailCustomizer::AuthenticateUser
    include RedmineEmailCustomizer::LoadFixtures

    fixtures :users, :email_addresses, :roles

    test 'render email setting tabs' do
      log_user('admin', 'admin')
      get '/settings/plugin/redmine_email_customizer'
      assert_response :success
      assert_select '#tab-content'
      assert_select '#tab-design'
      assert_select '#tab-preview'
    end

    test 'render email preview' do
      log_user('admin', 'admin')
      email_title = 'Email Customizer'
      Setting.plugin_redmine_email_customizer = { email_title: email_title }
      get '/settings/plugin/redmine_email_customizer?tab=preview'
      assert_response :success
      assert_select '.branding'
      assert_select 'h2 span', text: EmailCustomizer[:email_title]
      assert_select 'h2 span[style=?]', 'color: #9e1030'
    end
  end
end
