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
            // Folder Management Button
            // FIXME: use searchable dropdown rather than placeholder button
            var folder_button = new Gtk.Button.with_label ("Folder");

            // Login Popover & Button
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

            var login_popover = new Gtk.Popover () {
                child = login_content_box
            };

            var login_button = new Gtk.MenuButton () {
                icon_name = "avatar-default",
                popover = login_popover,
            };
            login_button.add_css_class (Granite.STYLE_CLASS_LARGE_ICONS);

            // Primary window

            // Left Pane
            var start_header = new Gtk.HeaderBar () {
                show_title_buttons = false
            };
            start_header.add_css_class (Granite.STYLE_CLASS_FLAT);
            start_header.pack_start (new Gtk.WindowControls (Gtk.PackType.START));
            start_header.pack_end (login_button);
            start_header.pack_end (folder_button);

            var start_header_box = new Granite.Box (VERTICAL);
            start_header_box.append (start_header);

            // Section used to filter the list above it
            var all_items_button = new Gtk.ToggleButton () { active = true, icon_name = "user-home"};
            var linked_tag_buttons = new Granite.Box (HORIZONTAL, LINKED);
            linked_tag_buttons.append (all_items_button);
            linked_tag_buttons.append (new Gtk.ToggleButton () { group = all_items_button, icon_name = "user-bookmarks"});
            linked_tag_buttons.append (new Gtk.ToggleButton () { group = all_items_button, icon_name = "user-trash"});

            // FIXME: add linked buttons for filtering item types
            var filter_box = new Granite.Box (HORIZONTAL);
            filter_box.append (linked_tag_buttons);

            var left_pane = new Gtk.Paned (VERTICAL) {
                start_child = start_header_box,
                end_child = filter_box,
                resize_start_child = false,
                resize_end_child = false,
                shrink_end_child = false,
                shrink_start_child = false,
            };

            // Right Pane
            var end_header = new Gtk.HeaderBar () {
                show_title_buttons = false
            };
            end_header.add_css_class (Granite.STYLE_CLASS_FLAT);
            end_header.pack_end (new Gtk.WindowControls (Gtk.PackType.END));

            var end_header_box = new Granite.Box (VERTICAL);
            end_header_box.append (end_header);
            var right_pane = new Granite.Box (VERTICAL);
            right_pane.append (end_header_box);

            // Top-level panes
            var main_paned = new Gtk.Paned (HORIZONTAL) {
                start_child = left_pane,
                end_child = right_pane,
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
