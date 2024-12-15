-- Coletar os dados sobre os profissionais
-- Coletar competencia, código do município e CPF do profissional do CNES-PF de forma distinta.
-- Ou seja, busca-se encontrar para cada ano e cada profissional, uma linha para cada município onde ele atuou. Entende-se o 'ano' como a competência 01 (janeiro).
-- Nesse primeiro momento a análise está limitada apenas aos profissionais médicos e enfermeiros

SELECT DISTINCT
    COMPETEN,
    CODUFMUN,
    CASE
        WHEN pf.CBO LIKE '2235%' THEN 'Enfermeiro'
        WHEN pf.CBO LIKE '2232%' THEN 'Cirurgiões-dentistas'
        WHEN pf.CBO LIKE '3222%' THEN 'Técnicos e auxiliares de enfermagem'
        WHEN PF.CBO = '322405' THEN 'Técnico ou Auxiliar de Saúde Bucal'
        WHEN PF.CBO = '322415' THEN 'Técnico ou Auxiliar de Saúde Bucal'
        WHEN PF.CBO IN ('223145', '2231F5', '2231F4', '225290', '225121') THEN 'Oncologista'
        WHEN PF.CBO IN ('225151', '223104', '225205') THEN 'Anestesiologista'
        WHEN PF.CBO IN ('225133') THEN 'Psiquiatra'
        WHEN pf.CBO LIKE '225%' OR pf.CBO LIKE '2231%' THEN 'Médico'
        WHEN pf.CBO LIKE '2238%' THEN 'Fonoaudiólogo'
        WHEN pf.CBO LIKE '2236%' THEN 'Fisioterapeuta'
        WHEN pf.CBO = '223905' THEN 'Terapeuta Ocupacional'
        END AS categoria,
    CPF_PROF
FROM Dados.cnes.PF
WHERE
        SUBSTR(COMPETEN, 1, 4) >= 2006
  AND SUBSTR(COMPETEN, 5, 2) = '01'
  AND (
        (pf.CBO LIKE '225%' OR pf.CBO LIKE '2231%') OR -- Medico
        (pf.CBO LIKE '2235%') OR -- Enfermeiro
        (pf.CBO LIKE '2232%') OR -- Cirurgiões-dentistas
        (pf.CBO LIKE '3222%') OR -- Técnicos e auxiliares de enfermagem
        (PF.CBO = '322405') OR
        (PF.CBO = '322415') OR
        (PF.CBO IN ('223145', '2231F5', '2231F4', '225290', '225121')) OR -- Oncologista
        (PF.CBO IN ('225151', '223104', '225205')) OR -- Anestesiologista
        (PF.CBO IN ('225133')) OR -- Psiquiatra
        (pf.CBO LIKE '2238%') OR -- Fonoaudiólogo
        (pf.CBO LIKE '2236%') OR -- Fisioterapeuta
        (pf.CBO = '223905') -- Terapeuta Ocupacional
    )