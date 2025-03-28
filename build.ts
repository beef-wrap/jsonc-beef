import { type Build } from 'xbuild';

const build: Build = {
    common: {
        project: 'jsonc',
        archs: ['x64'],
        variables: [],
        copy: {},
        defines: [],
        options: [
            ['BUILD_SHARED_LIBS', false],
            ['BUILD_APPS', false]
        ],
        subdirectories: ['json-c'],
        libraries: {
            'json-c': {
                name: 'jsonc'
            }
        },
        buildDir: 'build',
        buildOutDir: '../libs',
        buildFlags: []
    },
    platforms: {
        win32: {
            windows: {},
            android: {
                archs: ['x86', 'x86_64', 'armeabi-v7a', 'arm64-v8a'],
            }
        },
        linux: {
            linux: {}
        },
        darwin: {
            macos: {}
        }
    }
}

export default build;