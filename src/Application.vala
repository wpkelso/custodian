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

        protected override void activate() {

            var start_header = new Gtk.HeaderBar () {
                show_title_buttons = false
            };
            start_header.add_css_class (Granite.STYLE_CLASS_FLAT);
            start_header.pack_start (new Gtk.WindowControls (Gtk.PackType.START));

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
