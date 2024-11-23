# How many new outputs were created by block 123,456?
hash_do_bloco=$(bitcoin-cli getblockhash 123456)
dados_do_bloco=$(bitcoin-cli getblock $hash_do_bloco true)
quantidade_saidas=$(echo "$dados_do_bloco" | jq '[.tx[] | . as $tx | length] | add')
echo $quantidade_saidas