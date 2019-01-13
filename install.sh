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

cp /c/projects/pioneer-libs/SDL_config_windows.h /c/build/mingw64/include/SDL2/SDL_config.h
cp /mingw64/x86_64-w64-mingw32/lib/libmingw32.a /c/build/mingw64/lib/mingw32.lib

# Rename dynamic libraries from libfoo.dll.a pattern to foo.lib
cd /c/build/mingw64/lib
for i in *.dll.a
do
	NEW_NAME=$(echo $i |sed 's/lib\(.*\).dll.a/\1.lib/' -)
	mv $i $NEW_NAME
done

# Rename static libraries from libfoo.a pattern to foo.lib
for i in *.a
do
	NEW_NAME=$(echo $i |sed 's/lib\(.*\).a/\1.lib/' -)
	if [ -f $NEW_NAME ]
	then
		# Use the dynamic library if it exists
		rm $i
	else
		mv $i $NEW_NAME
	fi
done
