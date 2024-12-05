#!/bin/bash
echo "##############################"
echo "##############################"
echo "#####MEU PRIMEIRO SCRIPT######"
echo "###BORA BARULHAR QUEM HOJE?###"
echo "##############################"
echo "##############################"
echo " "
echo "Aqui o uso eh simples: digita um site que bora varrer hosts:"
read site

# Baixar o HTML do site
wget -q -O index.html $site

# Verificar se o arquivo foi baixado corretamente
if [ ! -f index.html ]; then
    echo "Erro ao baixar o site. Verifique o endereço e tente novamente."
    exit 1
fi

# Extrair subdomínios do HTML e salvar na lista
grep href index.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l" | sort -u > lista

# Verificar se a lista contém subdomínios
if [ ! -s lista ]; then
    echo "Nenhum subdomínio encontrado no HTML."
    rm -f index.html
    exit 1
fi

# Exibir subdomínios encontrados
echo "Subdomínios encontrados:"
cat lista
echo " "

# Resolver os IPs dos subdomínios
echo "IPs vinculados aos subdomínios:"
while read -r subdominio; do
    host $subdominio | grep "has address" || echo "Não foi possível resolver $subdominio"
done < lista

# Limpar arquivos temporários
rm -f index.html lista
