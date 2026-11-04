use vida_saude;

select p.nome as paciente, cv.nome as convenio, sum(c.valor) as total_gasto
from consulta c
join paciente p on p.id_paciente = c.id_paciente
join convenio cv on cv.id_convenio = p.id_convenio
where cv.nome like '%unimed%'
  and c.status <> 'cancelada'
group by p.id_paciente, p.nome, cv.nome
order by total_gasto desc;