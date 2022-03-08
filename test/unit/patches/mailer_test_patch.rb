# frozen_string_literal: true

# This file is part of the Plugin Redmine Email Customizer.
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

class MailerTest
  define_method('test_reminders') do
    users(:users_003).pref.update_attribute :time_zone, 'UTC' # dlopper
    days = 42
    Mailer.reminders(days: days)
    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = last_email
    assert mail.bcc.include?('dlopper@somenet.foo')
    assert_mail_body_match 'Bug #3: Error 281 when updating a recipe (5 days late)', mail
    assert_mail_body_match 'View all issues (2 open)', mail
    url =
      'http://localhost:3000/issues?f%5B%5D=status_id&f%5B%5D=assigned_to_id' \
      '&f%5B%5D=due_date&op%5Bassigned_to_id%5D=%3D&op%5Bdue_date%5D=%3Ct%2B&op%5B' \
      'status_id%5D=o&set_filter=1&sort=due_date%3Aasc&v%5B' \
      "assigned_to_id%5D%5B%5D=me&v%5Bdue_date%5D%5B%5D=#{days}"
    assert_select_email do
      assert_select 'a[href=?]',
                    url,
                    text: '1'
      assert_select 'a[href=?]',
                    'http://localhost:3000/issues?assigned_to_id=me&set_filter=1&sort=due_date%3Aasc',
                    text: 'View all issues'

      # deletes the last line in this block
    end
    assert_equal "1 issue(s) due in the next #{days} days", mail.subject
  end
end
