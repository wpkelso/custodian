using App.Configs;

namespace App.Dialogs {
    public class LoginWindow : Gtk.Window {

        private static LoginWindow dialog;

        private Gtk.Window main_window;

        private Gtk.Button login_button;
        private Gtk.Image logo;
        private Gtk.Entry instance_entry;
        private Gtk.Entry email_entry;
        private Gtk.Entry password_entry;
        private Gtk.Label two_factor_label;
        private Gtk.Entry two_factor_entry;
        private Gtk.Label error_label;

        public LoginWindow (Gtk.Window window) {
            Object (
                deletable: true,
                resizable: false,
                title: "Login",
                transient_for: window
            );

            main_window = window;

            var instance_label = new Gtk.Label ("Base URL:");
            instance_entry = new Gtk.Entry ();
            instance_entry.text = App.Configs.Constants.BITWARDEN_BASE_URL;
            var instance_box = new Granite.Box (Gtk.Orientation.HORIZONTAL);
            instance_box.append (instance_label);
            instance_box.append (instance_entry);

            var email_label = new Gtk.Label ("Email:");
            email_entry = new Gtk.Entry ();
            var email_box = new Granite.Box (Gtk.Orientation.HORIZONTAL);
            email_box.append (email_label);
            email_box.append (email_entry);

            var password_label = new Gtk.Label ("Password:");
            password_entry = new Gtk.Entry ();
            var password_box = new Granite.Box (Gtk.Orientation.HORIZONTAL);
            password_box.append (password_label);
            password_box.append (password_entry);

            var two_factor_label = new Gtk.Label ("OTP Code:");
            two_factor_entry = new Gtk.Entry ();
            var two_factor_box = new Granite.Box (Gtk.Orientation.HORIZONTAL);
            two_factor_box.append (two_factor_label);
            two_factor_box.append (two_factor_entry);

            login_button = new Gtk.Button.with_label ("Login");
            login_button.clicked.connect (on_login_clicked);

            var content_box = new Granite.Box (Gtk.Orientation.VERTICAL);
            content_box.append (instance_box);
            content_box.append (email_box);
            content_box.append (password_box);
            content_box.append (two_factor_box);
            content_box.append (login_button);


            this.set_child (content_box);
            this.present ();
        }

        private void clear () {
            password_entry.text = "";
            two_factor_entry.hide ();
            two_factor_label.hide ();
        }

        private void on_login_clicked () {
            string instance = instance_entry.text;
            string email = email_entry.text;
            string password = password_entry.text;

            /*var bitwarden = App.Bitwarden.get_instance ();
            if (two_factor_entry.text != "") {
                result = bitwarden.login (email, password, 0, two_factor_entry.text);
            } else {
                result = bitwarden.login (email, password);
            }
            if (result.error != null) {
                error_label.label = _ (result.error_description);
                switch (result.error) {
                case "two_factor_required":
                    two_factor_label.show ();
                    two_factor_entry.show ();
                    break;
                case "invalid_grant":
                    switch (result.error_description) {
                    case "invalid_username_or_password":
                        error_label.label = _ ("Invalid username or password");
                        break;
                    }
                    break;
                }
                stdout.printf ("%s\n".printf (result.error));
            } else {
                App.Bitwarden.get_instance ().sync ();
                error_label.hide ();
                main_window.present ();
                destroy ();
            }*/
        }

        public static void open (Gtk.Window window) {
            if (dialog == null)
                dialog = new LoginWindow (window);
        }
    }
}
