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

require File.expand_path('../test_helper', __dir__)

module RedmineEmailCustomizer
  class EmailCustomizerTest < ActiveSupport::TestCase
    test 'should respond to setup' do
      assert RedmineEmailCustomizer.respond_to? :setup
    end

    test 'should respond to partial' do
      assert RedmineEmailCustomizer.respond_to? :partial
    end

    test 'should respond to defaults' do
      assert RedmineEmailCustomizer.respond_to? :defaults
    end
  end
end
