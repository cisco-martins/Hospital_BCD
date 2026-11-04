use vida_saude;

-- 1
select p.nome as paciente, m.nome as medico, c.data_hora as data_consulta,
       med.nome as medicamento, pr.quantidade
from prescricao pr
join consulta c on c.id_consulta = pr.id_consulta
join paciente p on p.id_paciente = c.id_paciente
join medico m on m.id_medico = c.id_medico
join medicamento med on med.id_medicamento = pr.id_medicamento
order by c.data_hora;

-- 2
select p.nome as paciente, q.numero as quarto, q.andar,
       i.data_entrada, q.valor_diaria
from internacao i
join paciente p on p.id_paciente = i.id_paciente
join quarto q on q.id_quarto = i.id_quarto
order by i.data_entrada;

-- 3
select p.nome as paciente, cv.nome as convenio,
       m.nome as medico, e.nome as especialidade
from paciente p
left join convenio cv on cv.id_convenio = p.id_convenio
left join consulta c on c.id_paciente = p.id_paciente
left join medico m on m.id_medico = c.id_medico
left join especialidade e on e.id_especialidade = m.id_especialidade
order by p.nome;

-- 4
select m.nome as medico, e.nome as especialidade,
       p.nome as paciente, med.nome as remedio
from prescricao pr
join consulta c on c.id_consulta = pr.id_consulta
join medico m on m.id_medico = c.id_medico
join especialidade e on e.id_especialidade = m.id_especialidade
join paciente p on p.id_paciente = c.id_paciente
join medicamento med on med.id_medicamento = pr.id_medicamento
order by m.nome;

-- 5
select distinct p.nome as paciente, q.numero as quarto,
       m.nome as medico, c.data_hora as data_consulta
from paciente p
join internacao i on i.id_paciente = p.id_paciente
join quarto q on q.id_quarto = i.id_quarto
join consulta c on c.id_paciente = p.id_paciente
join medico m on m.id_medico = c.id_medico
order by p.nome, c.data_hora;

-- 6
select p.nome as paciente, m.nome as medico, c.data_hora as data_consulta
from consulta c
join paciente p on p.id_paciente = c.id_paciente
join medico m on m.id_medico = c.id_medico
order by c.data_hora desc;

-- 7
select p.nome as paciente, q.numero as quarto, q.valor_diaria
from internacao i
join paciente p on p.id_paciente = i.id_paciente
join quarto q on q.id_quarto = i.id_quarto
order by q.valor_diaria asc;

-- 8
select round(avg(valor), 2) as valor_medio_consulta
from consulta
where status <> 'cancelada';

-- 9
select sum(valor) as total_arrecadado
from consulta
where status <> 'cancelada';

-- 10
select p.nome as paciente, m.nome as medico, c.data_hora as data_consulta
from consulta c
join paciente p on p.id_paciente = c.id_paciente
join medico m on m.id_medico = c.id_medico
where p.nome like '%silva%'
order by c.data_hora;

-- 11
select p.nome as paciente, m.nome as medico, e.nome as especialidade
from consulta c
join paciente p on p.id_paciente = c.id_paciente
join medico m on m.id_medico = c.id_medico
join especialidade e on e.id_especialidade = m.id_especialidade
where e.nome like '%cardio%';

-- 12
select p.nome as paciente, q.numero as quarto, i.data_entrada
from internacao i
join paciente p on p.id_paciente = i.id_paciente
join quarto q on q.id_quarto = i.id_quarto
where i.data_entrada between '2026-01-01' and '2026-06-30'
order by i.data_entrada;

-- 13
select p.nome as paciente, cv.nome as convenio, sum(c.valor) as total_gasto
from consulta c
join paciente p on p.id_paciente = c.id_paciente
join convenio cv on cv.id_convenio = p.id_convenio
where cv.nome like '%unimed%'
  and c.status <> 'cancelada'
group by p.id_paciente, p.nome, cv.nome
order by total_gasto desc;

-- 14
select q.andar,
       sum(q.valor_diaria *
           greatest(datediff(coalesce(i.data_saida, curdate()), i.data_entrada), 1)
       ) as custo_total_diarias
from internacao i
join paciente p on p.id_paciente = i.id_paciente
join quarto q on q.id_quarto = i.id_quarto
where p.nome like '%oliveira%'
group by q.andar
order by q.andar asc;

-- 15
select e.nome as especialidade, sum(c.valor) as total_arrecadado
from consulta c
join medico m on m.id_medico = c.id_medico
join especialidade e on e.id_especialidade = m.id_especialidade
where e.nome like '%cirurgia%'
  and c.status <> 'cancelada'
group by e.id_especialidade, e.nome
order by total_arrecadado desc;