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
  # Redmine won't load plugin fixtures out-of-the-box.
  # This module loads first the plugin fixtures and then Redmine fixtures
  # if the listed file does not exist in the plugin's fixture directory.
  #
  module LoadFixtures
    class << self
      def fixtures(*table_names)
        dir = File.join(File.dirname(__FILE__), '/fixtures')
        table_names.each do |file|
          create_fixtures(dir, file) if File.exist?("#{dir}/#{file}.yml")
        end
        super(table_names)
      end

      private

      def create_fixtures(dir, file)
        ActiveRecord::FixtureSet.create_fixtures(dir, file)
      end
    end
  end
end
