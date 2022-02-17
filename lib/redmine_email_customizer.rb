# frozen_string_literal: true

# This file is part of the Plugin Redmine Email Styling.
#
# Copyright (C) 2022 Liane Hampe <liaham@xmera.de>, xmera.
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

require 'redmine_email_customizer/helpers/email_customizer_helper'
require 'redmine_email_customizer/hooks/views'

##
# Plugin setup
#
module RedmineEmailCustomizer
  class << self
    def setup
      Rails.configuration.to_prepare do
        unless Redmine.included_modules.include?(RedmineEmailCustomizer::Helpers)
          SettingsController.prepend(RedmineEmailCustomizer::Helpers)
        end
      end
    end

    def partial
      'settings/redmine_email_customizer_settings'
    end

    def defaults
      attributes.inject(&:merge)
    end

    private

    def body_bg_color
      { body_bg_color: '#f0f0f0' }
    end

    def primary_color
      { primary_color: '#9e1030' }
    end

    def secondary_color
      { secondary_color: '#666666' }
    end

    def title_color
      { title_color: '#000000' }
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

    def complimentary_close
      { complimentary_close: '' }
    end

    def company_data
      { company_data: '' }
    end

    def footer_text
      { footer_text: '' }
    end

    def attributes
      [body_bg_color, primary_color, secondary_color,
       title_color, text_primary_color, text_secondary_color,
       form_of_address, complimentary_close, company_data,
       footer_text, email_title, email_title_primary_color]
    end
  end
end
