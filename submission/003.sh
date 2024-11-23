#!/bin/bash

hash_do_bloco=$(bitcoin-cli getblockhash 123456)
echo "Hash do bloco: $hash_do_bloco"

dados_do_bloco=$(bitcoin-cli getblock "$hash_do_bloco" true)
echo "Dados do bloco processados: $dados_do_bloco"

total_outputs=0

for tx in $(echo "$dados_do_bloco" | jq -r '.tx[]'); do

    tx=$(echo "$tx" | tr -d '\n' | tr -d '\r' | tr -d ' ')

    echo "Processando transação: $tx"
    raw_transaction=$(bitcoin-cli getrawtransaction "$tx" true)
    quantidade=$(echo "$raw_transaction" | jq '.vout | length')
    total_outputs=$((total_outputs + quantidade))
done

echo "$total_outputs"
