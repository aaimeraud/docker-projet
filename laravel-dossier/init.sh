#!/bin/bash

type() {
	local txt="$1"
	for (( i=0; i<${#txt}; i++ )); do
		echo -n "${txt:$i:1}"
		sleep 0.05
	done
	echo ""
}

firstRun="/var/www/html/.firstrun"

if [ ! -f $firstRun ]; then

    type "Initialisation..."
    # Attendre que la base de données soit prête
    type "Attente de la base de données..."
    sleep 10
    
    # Installer les dépendances Composer
    type "Installation des dépendances Composer..."
    composer update --no-interaction --optimize-autoloader
    
    # Installer les dépendances NPM
    type "Installation des dépendances NPM..."
    npm install
    
    php artisan key:generate
    php artisan migrate:fresh --seed 
    

    # NPM - commenté car npm n'est pas installé dans le container
    # npm run build

    touch $firstRun
    type "Bravo beau gosse, l'initialisation terminée."
else
    type "Welcome Back l'ami, l'application a déjà été initialisée."
fi

# Lancer npm run dev en arrière-plan
type "Démarrage de npm run dev..."
npm run build &

# Lancer php-fpm au premier plan (processus principal)
exec php-fpm