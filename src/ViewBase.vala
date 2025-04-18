/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2025 William Kelso <wpkelso@posteo.net>
 */

 namespace App {
     public class ViewBase : Gtk.Box {
        public Gtk.Widget content {
            set {
                scrolled_window.child = value;
            }
        }

        private Gtk.ScrolledWindow scrolled_window;

        construct {
            var header_box = new Gtk.HeaderBar () {
                show_title_buttons = false
            };
            header_box.add_css_class (Granite.STYLE_CLASS_FLAT);
            header_box.pack_end (new Gtk.WindowControls (END));

            scrolled_window = new Gtk.ScrolledWindow () {
                vexpand = true
            };

            orientation = VERTICAL;
            append (header_box);
            append (scrolled_window);
            add_css_class(Granite.STYLE_CLASS_VIEW);
        }
     }
 }
