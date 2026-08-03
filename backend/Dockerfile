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
        zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer


# Pasta da aplicação
WORKDIR /app


# Copia o projeto
COPY . .


# Instala dependências Laravel
RUN composer install \
    --no-dev \
    --prefer-dist \
    --optimize-autoloader \
    --no-interaction


# Cria pastas necessárias do Laravel
RUN mkdir -p \
    storage/app \
    storage/framework/cache \
    storage/framework/sessions \
    storage/framework/views \
    storage/logs \
    bootstrap/cache


# Permissões
RUN chmod -R 777 storage bootstrap/cache


# Porta do Render
EXPOSE 10000


# Inicialização
CMD php artisan migrate --force && \
    php artisan serve --host=0.0.0.0 --port=$PORT