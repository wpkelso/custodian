/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 William Kelso <wpkelso@posteo.net>
 */

namespace App.Views {
    public class LoginView : ViewBase {
        construct {
            var instance_label = new Gtk.Label ("Base URL:");
            var instance_entry = new Gtk.Entry () {
                text = App.Configs.Constants.BITWARDEN_BASE_URL
            };
            var instance_box = new Granite.Box (HORIZONTAL);
            instance_box.append (instance_label);
            instance_box.append (instance_entry);

            var email_label = new Gtk.Label ("Email:");
            var email_entry = new Gtk.Entry ();
            var email_box = new Granite.Box (HORIZONTAL);
            email_box.append (email_label);
            email_box.append (email_entry);

            var password_label = new Gtk.Label ("Password:");
            var password_entry = new Gtk.Entry ();
            var password_box = new Granite.Box (HORIZONTAL);
            password_box.append (password_label);
            password_box.append (password_entry);

            var two_factor_label = new Gtk.Label ("OTP Code:");
            var two_factor_entry = new Gtk.Entry ();
            var two_factor_box = new Granite.Box (HORIZONTAL);
            two_factor_box.append (two_factor_label);
            two_factor_box.append (two_factor_entry);

            var login_action_button = new Gtk.Button.with_label ("Login");
            //login_button.clicked.connect (on_login_clicked);

            var login_content_box = new Granite.Box (VERTICAL);
            login_content_box.append (instance_box);
            login_content_box.append (email_box);
            login_content_box.append (password_box);
            login_content_box.append (two_factor_box);
            login_content_box.append (login_action_button);

            content = login_content_box;
        }
    }
}
