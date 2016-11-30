/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */


-- a) Quais os espaços com postos que nunca foram alugados?

select distinct P.morada, P.codigo_espaco
from Posto P
where (P.morada, P.codigo) not in (
  select distinct morada, codigo
  from Aluga
);



-- b) Quais edifícios com um número de reservas superior à média?

select M.morada
from (
  select distinct morada, count(1) as c
  from Aluga
  group by morada
) as M
where M.c > (
  select AVG(R.c)
  from (
    select distinct morada, count(1) as c
    from Aluga
    group by morada
  ) as R
);



-- c) Quais utilizadores cujos alugáveis foram fiscalizados sempre pelo mesmo
--    fiscal?

select nome
from User U
where (U.nif, 1) in (
  select distinct nif, count(1) as c
  from (
    select distinct nif, id
    from Arrenda natural join Fiscaliza
  ) as R
  group by nif
);
