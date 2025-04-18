/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 William Kelso <wpkelso@posteo.net>
 */

namespace App {
    public class Application : Gtk.Application {
        public Application () {
            Object (
                application_id: "io.github.wpkelso.custodian",
                flags : ApplicationFlags.DEFAULT_FLAGS
            );
        }


        public override void startup () {
            Granite.init ();
            base.startup ();
        }

        protected override void activate() {
            // Folder Management Button
            // FIXME: use searchable dropdown rather than placeholder button
            var folder_button = new Gtk.Button.with_label ("Folder");

            // Fine filtering menu
            var category_label = new Granite.HeaderLabel ("Categories") {size = H4};
            var all_items_radio = new Gtk.CheckButton.with_label ("All Items") {active = true};
            var linked_category_radios = new Granite.Box (VERTICAL, HALF);
            linked_category_radios.append (all_items_radio);
            linked_category_radios.append (new Gtk.CheckButton.with_label ("Favorites") {group = all_items_radio});
            linked_category_radios.append (new Gtk.CheckButton.with_label ("Trash") {group = all_items_radio});
            var category_box = new Granite.Box (VERTICAL);
            category_box.append (category_label);
            category_box.append (linked_category_radios);

            var type_label = new Granite.HeaderLabel ("Types") {size = H4};
            var type_all_radio = new Gtk.CheckButton.with_label ("All Types") {active = true};
            var linked_type_radios = new Granite.Box (VERTICAL, HALF);
            linked_type_radios.append (type_all_radio);
            linked_type_radios.append (new Gtk.CheckButton.with_label ("Login") {group = type_all_radio});
            linked_type_radios.append (new Gtk.CheckButton.with_label ("Card") {group = type_all_radio});
            linked_type_radios.append (new Gtk.CheckButton.with_label ("Identity") {group = type_all_radio});
            linked_type_radios.append (new Gtk.CheckButton.with_label ("Secure Note") {group = type_all_radio});
            linked_type_radios.append (new Gtk.CheckButton.with_label ("SSH Key") {group = type_all_radio});
            var type_box = new Granite.Box (VERTICAL);
            type_box.append (type_label);
            type_box.append (linked_type_radios);

            var filter_menu_box = new Granite.Box (VERTICAL);
            filter_menu_box.append (category_box);
            filter_menu_box.append (type_box);

            var filter_menu_popover = new Gtk.Popover () {
                child = filter_menu_box
            };

            var filter_menu_button = new Gtk.MenuButton () {
                // FIXME: this should use a "filter" icon, rather than "view-more"
                icon_name = "view-more-symbolic",
                popover = filter_menu_popover
            };

            // Vault info Popover & Button
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

            var vault_popover = new Gtk.Popover () {
                child = login_content_box
            };

            var vault_button = new Gtk.MenuButton () {
                icon_name = "avatar-default",
                popover = vault_popover,
            };

            // Primary window

            // Left Pane
            var start_header = new Gtk.HeaderBar () {
                show_title_buttons = false
            };
            start_header.add_css_class (Granite.STYLE_CLASS_FLAT);
            start_header.pack_start (new Gtk.WindowControls (Gtk.PackType.START));
            start_header.pack_end (filter_menu_button);
            start_header.pack_end (folder_button);

            var start_header_box = new Granite.Box (VERTICAL);
            start_header_box.append (start_header);

            // FIXME: add linked buttons for filtering item types
            var status_box = new Granite.Box (HORIZONTAL);
            status_box.append (vault_button);


            var left_pane = new Gtk.Paned (VERTICAL) {
                start_child = start_header_box,
                end_child = status_box,
                resize_start_child = false,
                resize_end_child = false,
                shrink_end_child = false,
                shrink_start_child = false,
            };
            left_pane.add_css_class (Granite.STYLE_CLASS_SIDEBAR);

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
