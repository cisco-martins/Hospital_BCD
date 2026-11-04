# Sistema de Gestão Hospitalar "Vida & Saúde"

Banco de dados relacional em MySQL desenvolvido para substituir o controle em planilhas e papel do Hospital Geral Vida & Saúde. O objetivo é centralizar as informações em um esquema normalizado até a 3ª Forma Normal, com integridade referencial e consultas prontas para a tomada de decisão da diretoria.

## Arquivos

O arquivo 01_ddl.sql cria o banco, as tabelas e as restrições. O arquivo 02_dml.sql insere os dados de teste. O arquivo 03_dql.sql reúne as 15 queries estratégicas, numeradas de acordo com o enunciado, e a pasta dql contém as mesmas queries em arquivos separados.

## Como executar

No MySQL Workbench, execute os arquivos na ordem: 01_ddl.sql, 02_dml.sql e 03_dql.sql. Atenção: o primeiro arquivo apaga e recria o banco vida_saude, então use apenas em ambiente de homologação. Para gerar o diagrama, use Database > Reverse Engineer com o schema vida_saude.

## Modelo de dados

O banco possui nove tabelas: convenio, paciente, especialidade, medico, consulta, medicamento, prescricao, quarto e internacao. Cada paciente pode ter um convênio ou ser particular, cada médico pertence a uma especialidade, e as consultas ligam pacientes a médicos. As prescrições relacionam consultas e medicamentos, e as internações relacionam pacientes e quartos.

## Integridade

Todas as chaves estrangeiras usam exclusão restrita, o que impede apagar pacientes, médicos ou consultas que tenham histórico. CPF, CRM, CNPJ e número do quarto são únicos, e há validações para valores, quantidades e datas de internação.

Esta versão não possui triggers, portanto o banco não bloqueia sozinho a sobreposição de horários de médicos nem a ocupação duplicada de quartos. Esse controle deve ser feito pela aplicação.

## Observações sobre as queries

Consultas canceladas não entram nos cálculos de média, total e faturamento. No custo das diárias, internações em aberto são contadas até a data atual, com mínimo de uma diária. Como os dados estão em minúsculo, as buscas com like usam termos em minúsculo.
