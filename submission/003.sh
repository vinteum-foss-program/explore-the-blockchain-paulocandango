#!/bin/bash

hash_do_bloco=$(bitcoin-cli getblockhash 123456)


dados_do_bloco=$(bitcoin-cli getblock "$hash_do_bloco" true)


total_outputs=0

for tx in $(echo "$dados_do_bloco" | jq -r '.tx[]'); do

    tx=$(echo "$tx" | tr -d '\n' | tr -d '\r' | tr -d ' ')


    raw_transaction=$(bitcoin-cli getrawtransaction "$tx" true)
    quantidade=$(echo "$raw_transaction" | jq '.vout | length')
    total_outputs=$((total_outputs + quantidade))
done

echo "$total_outputs"
