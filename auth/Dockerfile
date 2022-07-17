# Specify the Dart SDK base image version using dart:<version> (ex: dart:2.12)
FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code and AOT compile it.
COPY .. .
# Ensure packages are still up-to-date if anything has changed
RUN dart pub get --offline
RUN dart compile exe bin/auth.dart -o bin/lyria-auth

# Build minimal serving image from AOT-compiled `/auth` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/lyria-auth /app/bin/

# Start server.
EXPOSE 80
ENTRYPOINT ["/app/bin/lyria-auth", "http", "start"]