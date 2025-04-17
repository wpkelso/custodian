project('com.github.liljebergxyz.valawarden', ['vala', 'c'],
    version : '1.0.0',
    license: 'GPL-3.0'
)

add_project_arguments([
        '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    ],
    language: 'c',
)

gnome = import('gnome')
i18n = import('i18n')

gresource = gnome.compile_resources(
    'as-resources', 'data/com.github.liljebergxyz.valawarden.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

c_args = [
  '-include', 'config.h',
]

sources = files()

subdir('data')
subdir('po')
subdir('src')
subdir('tests')

add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')],
                      language: 'vala')
gcrypt_lib = meson.get_compiler('c').find_library('libgcrypt')
gcrypt_vapi = meson.get_compiler('vala').find_library('gcrypt', dirs: join_paths(meson.current_source_dir(), 'vapi'))
gcrypt_dep = declare_dependency(dependencies: [gcrypt_lib, gcrypt_vapi])

dependencies = [
    dependency('gobject-2.0'),
    dependency('glib-2.0'),
    dependency('gtk4'),
    dependency('libsoup-3.0'),
    dependency('json-glib-1.0'),
    dependency('uuid'),
    dependency('granite-7'),
    meson.get_compiler('c').find_library('m', required: false),
    gcrypt_dep
]

e = executable('com.github.liljebergxyz.valawarden',
    sources,
    gresource,
    c_args: c_args,
    dependencies: dependencies,
    install : true
)

#test('tests', e, args : ['--run-tests'])

meson.add_install_script('meson/post_install.py')
