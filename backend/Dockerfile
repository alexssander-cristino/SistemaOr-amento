FROM php:8.2-cli

# Dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    libpq-dev \
    libzip-dev \
    && docker-php-ext-install \
        pdo \
        pdo_pgsql \
        zip

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Copia apenas os arquivos do Composer primeiro
COPY composer.json composer.lock ./

RUN composer install \
    --no-dev \
    --optimize-autoloader \
    --no-interaction

# Copia o restante do projeto
COPY . .

# Permissões
RUN mkdir -p storage/framework/cache
RUN mkdir -p storage/framework/sessions
RUN mkdir -p storage/framework/views

RUN chmod -R 775 storage bootstrap/cache

# Porta do Render
EXPOSE 10000

CMD php artisan serve --host=0.0.0.0 --port=$PORT