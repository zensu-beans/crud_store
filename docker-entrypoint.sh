#!/bin/bash
set -e

# Disable ALL conflicting MPM modules
a2dismod mpm_event 2>/dev/null || true
a2dismod mpm_worker 2>/dev/null || true
a2dismod mpm_prefork 2>/dev/null || true

# Enable ONLY the required module for PHP
a2enmod mpm_prefork

# Start Apache
exec apache2-foreground   
