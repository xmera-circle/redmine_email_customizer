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

##
# Fetch Redmine plugin settings or return its default value
#
class EmailCustomizer
  def self.[](attr)
    setting = Setting.send :find_or_default, :plugin_redmine_email_customizer
    setting.value[attr.to_sym] || send(:default, attr)
  end

  def self.default(attr)
    RedmineEmailCustomizer.send(attr.to_s)[attr.to_sym] || ''
  end

  def self.checked?(attr)
    self[attr].to_i.positive?
  end
end
