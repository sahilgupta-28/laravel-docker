#!/bin/sh
set -e

echo "🚀 Laravel container starting..."


# Wait for Postgres
until php -r "
try {
    new PDO('pgsql:host=postgres;dbname=laravel', 'laravel', 'secret');
} catch (Exception \$e) {
    exit(1);
}
"; do
  echo "⏳ Waiting for database..."
  sleep 2
done

if [ ! -d vendor ]; then
  echo "📦 Running composer install..."
  composer install --no-interaction --prefer-dist --optimize-autoloader
fi

php artisan key:generate --force || true
php artisan migrate --force
php artisan db:seed --force || true

echo "✅ Laravel ready"

exec "$@"
