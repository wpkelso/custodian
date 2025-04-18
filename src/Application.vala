/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2018 Daniel Liljeberg <liljebergxyz@protonmail.com>
 * SPDX-FileCopyrightText: 2025 William Kelso <wpkelso@posteo.net>
 */

using App.Dialogs;

namespace App {
    public class Application : Gtk.Application {
        public Application () {
            Object (
                application_id: "io.github.wpkelso.custodian",
                flags : ApplicationFlags.DEFAULT_FLAGS
            );
        }

        protected override void activate() {

            // Login Popover & Button
            var instance_label = new Gtk.Label ("Base URL:");
            var instance_entry = new Gtk.Entry () {
                text = App.Configs.Constants.BITWARDEN_BASE_URL
            };
            var instance_box = new Granite.Box (Gtk.Orientation.HORIZONTAL);
            instance_box.append (instance_label);
            instance_box.append (instance_entry);

            var email_label = new Gtk.Label ("Email:");
            var email_entry = new Gtk.Entry ();
            var email_box = new Granite.Box (Gtk.Orientation.HORIZONTAL);
            email_box.append (email_label);
            email_box.append (email_entry);

            var password_label = new Gtk.Label ("Password:");
            var password_entry = new Gtk.Entry ();
            var password_box = new Granite.Box (Gtk.Orientation.HORIZONTAL);
            password_box.append (password_label);
            password_box.append (password_entry);

            var two_factor_label = new Gtk.Label ("OTP Code:");
            var two_factor_entry = new Gtk.Entry ();
            var two_factor_box = new Granite.Box (Gtk.Orientation.HORIZONTAL);
            two_factor_box.append (two_factor_label);
            two_factor_box.append (two_factor_entry);

            var login_action_button = new Gtk.Button.with_label ("Login");
            //login_button.clicked.connect (on_login_clicked);

            var login_content_box = new Granite.Box (Gtk.Orientation.VERTICAL);
            login_content_box.append (instance_box);
            login_content_box.append (email_box);
            login_content_box.append (password_box);
            login_content_box.append (two_factor_box);
            login_content_box.append (login_action_button);

            var login_popover = new Gtk.Popover () {
                child = login_content_box
            };

            var login_button = new Gtk.MenuButton () {
                icon_name = "avatar-default",
                popover = login_popover,
            };
            login_button.add_css_class (Granite.STYLE_CLASS_LARGE_ICONS);

            // Primary window
            var start_header = new Gtk.HeaderBar () {
                show_title_buttons = false
            };
            start_header.add_css_class (Granite.STYLE_CLASS_FLAT);
            start_header.pack_start (new Gtk.WindowControls (Gtk.PackType.START));
            start_header.pack_end (login_button);

            var start_box = new Granite.Box (Gtk.Orientation.VERTICAL);
            start_box.append (start_header);

            var end_header = new Gtk.HeaderBar () {
                show_title_buttons = false
            };
            end_header.add_css_class (Granite.STYLE_CLASS_FLAT);
            end_header.pack_end (new Gtk.WindowControls (Gtk.PackType.END));

            var end_box = new Granite.Box (Gtk.Orientation.VERTICAL);
            end_box.append (end_header);

            var main_paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL) {
                start_child = start_box,
                end_child = end_box,
                resize_start_child = false,
                shrink_end_child = false,
                shrink_start_child = false,
            };

            var main_window = new Gtk.ApplicationWindow(this) {
                child = main_paned,
                default_height = 600,
                default_width = 800,
                titlebar = new Gtk.Grid () { visible = false },
                title = ""
            };
            main_window.present();
        }

        public static int main (string[] args) {
            return new Application ().run (args);
        }
    }
}
