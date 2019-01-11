#!/c/msys64/usr/bin/bash -l

# Exit immediately upon error
set -e

mkdir /c/build
cd /c/build

# Install dependencies
/c/msys64/usr/bin/pacman --noconfirm -Syw \
	mingw-w64-x86_64-pkg-config \
	mingw-w64-x86_64-assimp \
	mingw-w64-x86_64-bzip2 \
	mingw-w64-x86_64-freetype \
	mingw-w64-x86_64-SDL2 \
	mingw-w64-x86_64-SDL2_image \
	mingw-w64-x86_64-glew \
	mingw-w64-x86_64-libvorbis \
	mingw-w64-x86_64-zlib \
	mingw-w64-x86_64-libpng \
	mingw-w64-x86_64-libsigc++
for i in /var/cache/pacman/pkg/*.tar.xz; do tar xJf $i; rm $i; done

mv /c/build/mingw64 /c/Pioneer
cp /c/projects/pioneer-libs/SDL_config_windows.h /c/Pioneer/include/SDL2/SDL_config.h
