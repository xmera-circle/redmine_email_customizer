# frozen_string_literal: true

# This file is part of the Plugin Redmine Custom Email Styling.
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

require 'forwardable'

##
# Prepares all required email components to be ready for rendering.
#
class EmailPresenter < AdvancedPluginHelper::BasePresenter
  extend Forwardable
  include ApplicationHelper

  presents :issue

  def_delegators Setting, :emails_header, :emails_footer
  def_delegators :customizer, :[], :checked?

  def initialize(object, view)
    @current_user = User.current
    @customizer = EmailCustomizer
    super
  end

  def branding
    tag.h2 do
      tag.span style: branding_style do
        self[:email_title]
      end
    end
  end

  def greeting
    tag.h3("#{self[:form_of_address]} #{current_user.name unless current_user.is_a?(AnonymousUser)},")
  end

  def default_header
    return unless emails_header.present? && checked?(:use_default_header)

    tag.span textilizable(emails_header), class: 'header'
  end

  def issue_footer
    return unless issue

    call_hook(:view_layouts_mailer_issue_bottom, issue: issue)
  end

  def complimentary_close
    textilizable self[:complimentary_close]
  end

  def company_data
    tag.p do
      tag.small do
        textilizable self[:company_data]
      end
    end
  end

  # rubocop:disable Rails/OutputSafety
  def footer
    tag.p do
      text = +''
      text << footer_text
      text << default_footer
      text.html_safe
    end
  end
  # rubocop:enable Rails/OutputSafety

  private

  attr_reader :current_user, :customizer

  def branding_style
    checked?(:email_title_primary_color) ? "color: #{self[:primary_color]}" : "color: #{self[:title_color]}"
  end

  def footer_text
    textilizable self[:footer_text] || ''
  end

  def default_footer
    return '' unless emails_footer.present? && checked?(:use_default_footer)

    tag.div textilizable(emails_footer), class: 'footer'
  end
end
