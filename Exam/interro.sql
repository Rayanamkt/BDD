--1 

select r.nom_recette, ipr.id_i 
from recette r join ingredient_par_recette ipr on (r.id_r = ipr.id_r)
where ipr.quantite = (select max(ipr2.quantite) from ingredient_par_recette ipr2 where ipr2.id_r = ipr.id_r)
group by r.nom_recette, ipr.id_i
ORDER BY r.nom_recette;

--2
select r.nom_recette, count(distinct ipr.id_i) as nombre_ingredients
from recette r join ingredient_par_recette ipr on (r.id_r = ipr.id_r)
GROUP BY r.nom_recette
ORDER BY r.nom_recette DESC;

--3
select i.nom_ingredient, sum(r.temps_de_preparation) as temps_cumule
from ingredient i join ingredient_par_recette ipr on i.id_i = ipr.id_i
join recette r ON ipr.id_r = r.id_r
group by i.nom_ingredient
having sum(r.temps_de_preparation) > 24
order by temps_cumule;


--4
select nom_recette from recette r
join ingredient_par_recette ipr on (r.id_r = ipr.id_r)
group by r.nom_recette
having count(distinct ipr.quantite) = 1;
-- having min(ipr.quantite) = max(ipr.quantite);


select distinct r.nom_recette
from recette r join ingredient_par_recette ipr1 on (r.id_r = ipr1.id_r)
where not exists(
    select id_i
    from ingredient_par_recette ipr2
    where ipr2.id_r = ipr1.id_r AND ipr2.quantite != ipr1.quantite
);



