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

require_relative 'redmine_email_customizer/hooks/views'

##
# Plugin setup
#
module RedmineEmailCustomizer
  class << self
    def setup
      add_helpers
      AdvancedPluginHelper::Presenter.register('EmailPresenter', 'Issue')
    end

    def partial
      'settings/redmine_email_customizer_settings'
    end

    def defaults
      attributes.inject(&:merge)
    end

    private

    def add_helpers
      settings_controller = { klass: SettingsController, patch: EmailCustomizerHelper, strategy: :helper }
      AdvancedPluginHelper::Patch.register(settings_controller)
    end

    def body_bg_color
      { body_bg_color: '#ffffff' }
    end

    def primary_color
      { primary_color: '#f55e2c' }
    end

    def secondary_color
      { secondary_color: '#666666' }
    end

    def title_color
      { title_color: '#1a1a1a' }
    end

    def text_primary_color
      { text_primary_color: '#333333' }
    end

    def text_secondary_color
      { text_secondary_color: '#aaaaaa' }
    end

    def email_title
      { email_title: '' }
    end

    def email_title_primary_color
      { email_title_primary_color: '1' }
    end

    def form_of_address
      { form_of_address: '' }
    end

    def use_default_header
      { use_default_header: '1' }
    end

    def complimentary_close
      { complimentary_close: '' }
    end

    def company_data
      { company_data: '' }
    end

    def footer_text
      { footer_text: '' }
    end

    def use_default_footer
      { use_default_footer: '1' }
    end

    def attributes
      [body_bg_color, primary_color, secondary_color,
       title_color, text_primary_color, text_secondary_color,
       email_title_primary_color, form_of_address, use_default_header,
       complimentary_close, company_data, footer_text, email_title,
       use_default_footer]
    end
  end
end
