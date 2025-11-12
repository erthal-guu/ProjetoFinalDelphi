-- =====================================================
-- RELATÓRIO DE RECEITAS FINANCEIRAS CANCELADAS E ORÇAMENTOS
-- Medição do valor que a oficina deixou de ganhar
-- =====================================================

-- Query Principal - Visão Consolidada
SELECT
    'RESUMO GERAL' AS categoria,
    'TOTAL' AS tipo_analise,
    COUNT(DISTINCT r.id) AS quantidade_registros,
    COALESCE(SUM(r.valor_total), 0) AS valor_total_orcado,
    COALESCE(SUM(r.valor_recebido), 0) AS valor_ja_recebido,
    COALESCE(SUM(r.valor_total - r.valor_recebido), 0) AS valor_perdido_potencial,
    ROUND(
        CASE
            WHEN SUM(r.valor_total) > 0
            THEN (SUM(r.valor_total - r.valor_recebido) * 100.0 / SUM(r.valor_total))
            ELSE 0
        END, 2
    ) AS percentual_perda,
    'Valor total perdido pela oficina' AS descricao
FROM receitas r
INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id
INNER JOIN clientes c ON r.id_cliente = c.id
WHERE (r.status = 'Cancelado' OR r.status = 'ORÇAMENTO')
  AND r.ativo = TRUE
  AND os.ativo = TRUE
  AND c.ativo = TRUE

UNION ALL

-- Detalhamento por Status
SELECT
    'DETALHE POR STATUS' AS categoria,
    r.status AS tipo_analise,
    COUNT(r.id) AS quantidade_registros,
    COALESCE(SUM(r.valor_total), 0) AS valor_total_orcado,
    COALESCE(SUM(r.valor_recebido), 0) AS valor_ja_recebido,
    COALESCE(SUM(r.valor_total - r.valor_recebido), 0) AS valor_perdido_potencial,
    ROUND(
        CASE
            WHEN SUM(r.valor_total) > 0
            THEN (SUM(r.valor_total - r.valor_recebido) * 100.0 / SUM(r.valor_total))
            ELSE 0
        END, 2
    ) AS percentual_perda,
    CASE
        WHEN r.status = 'Cancelado' THEN 'Serviços cancelados após execução'
        WHEN r.status = 'ORÇAMENTO' THEN 'Orçamentos não confirmados pelos clientes'
        ELSE 'Outros status'
    END AS descricao
FROM receitas r
INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id
INNER JOIN clientes c ON r.id_cliente = c.id
WHERE (r.status = 'Cancelado' OR r.status = 'ORÇAMENTO')
  AND r.ativo = TRUE
  AND os.ativo = TRUE
  AND c.ativo = TRUE
GROUP BY r.status

UNION ALL

-- Análise por Período (Mês Atual vs Mês Anterior)
SELECT
    'ANÁLISE POR PERÍODO' AS categoria,

    CASE
        WHEN DATE_TRUNC('month', r.data_emissao) = DATE_TRUNC('month', CURRENT_DATE)
        THEN 'MÊS ATUAL'
        WHEN DATE_TRUNC('month', r.data_emissao) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')
        THEN 'MÊS ANTERIOR'
        ELSE 'OUTROS MESES'
    END AS tipo_analise,

    COUNT(r.id) AS quantidade_registros,
    COALESCE(SUM(r.valor_total), 0) AS valor_total_orcado,
    COALESCE(SUM(r.valor_recebido), 0) AS valor_ja_recebido,
    COALESCE(SUM(r.valor_total - r.valor_recebido), 0) AS valor_perdido_potencial,
    ROUND(
        CASE
            WHEN SUM(r.valor_total) > 0
            THEN (SUM(r.valor_total - r.valor_recebido) * 100.0 / SUM(r.valor_total))
            ELSE 0
        END, 2
    ) AS percentual_perda,
    'Análise temporal das perdas' AS descricao
FROM receitas r
INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id
INNER JOIN clientes c ON r.id_cliente = c.id
WHERE (r.status = 'Cancelado' OR r.status = 'ORÇAMENTO')
  AND r.ativo = TRUE
  AND os.ativo = TRUE
  AND c.ativo = TRUE
  AND DATE_TRUNC('month', r.data_emissao) >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')
GROUP BY
    CASE
        WHEN DATE_TRUNC('month', r.data_emissao) = DATE_TRUNC('month', CURRENT_DATE)
        THEN 'MÊS ATUAL'
        WHEN DATE_TRUNC('month', r.data_emissao) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')
        THEN 'MÊS ANTERIOR'
        ELSE 'OUTROS MESES'
    END
ORDER BY categoria, tipo_analise;

-- =====================================================
-- QUERY DETALHADA PARA LISTAGEM ESPECÍFICA
-- =====================================================

-- Query para listagem detalhada dos registros perdidos
SELECT
    r.id AS receita_id,
    os.id AS ordem_servico_id,
    c.nome AS cliente_nome,
    c.telefone AS cliente_telefone,
    r.status AS status_receita,
    r.valor_total,
    r.valor_recebido,
    (r.valor_total - r.valor_recebido) AS valor_perdido,
    r.data_emissao,
    r.data_vencimento,
    CASE
        WHEN r.status = 'Cancelado' THEN 'CANCELADO'
        WHEN r.status = 'ORÇAMENTO' THEN 'ORÇAMENTO NÃO CONFIRMADO'
        ELSE r.status
    END AS tipo_perda,
    os.data_abertura AS data_abertura_os,
    os.data_conclusao AS data_conclusao_os,
    EXTRACT(DAYS FROM CURRENT_DATE - r.data_emissao) AS dias_em_aberto,

    -- Classificação do tempo de perda
    CASE
        WHEN EXTRACT(DAYS FROM CURRENT_DATE - r.data_emissao) <= 7 THEN 'Perda Recente'
        WHEN EXTRACT(DAYS FROM CURRENT_DATE - r.data_emissao) <= 30 THEN 'Perda Mês Atual'
        WHEN EXTRACT(DAYS FROM CURRENT_DATE - r.data_emissao) <= 90 THEN 'Perda Trimestre'
        ELSE 'Perda Antiga'
    END AS classificacao_tempo

FROM receitas r
INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id
INNER JOIN clientes c ON r.id_cliente = c.id
WHERE (r.status = 'Cancelado' OR r.status = 'ORÇAMENTO')
  AND r.ativo = TRUE
  AND os.ativo = TRUE
  AND c.ativo = TRUE
ORDER BY
    CASE WHEN r.status = 'Cancelado' THEN 1 ELSE 2 END,
    r.data_emissao DESC;

-- =====================================================
-- QUERY PARA ANÁLISE POR CLIENTE
-- =====================================================

-- Análise de clientes com maior incidência de perdas
SELECT
    c.id AS cliente_id,
    c.nome AS cliente_nome,
    c.telefone AS cliente_telefone,
    COUNT(DISTINCT r.id) AS quantidade_perdas,
    COALESCE(SUM(r.valor_total), 0) AS valor_total_perdido,
    COALESCE(SUM(r.valor_recebido), 0) AS valor_ja_recebido,
    COALESCE(SUM(r.valor_total - r.valor_recebido), 0) AS valor_liquido_perdido,

    -- Distribuição por tipo de perda
    COUNT(CASE WHEN r.status = 'Cancelado' THEN 1 END) AS cancelamentos,
    COUNT(CASE WHEN r.status = 'ORÇAMENTO' THEN 1 END) AS orcamentos_nao_confirmados,

    -- Última ocorrência
    MAX(r.data_emissao) AS ultima_perda_data,
    MIN(r.data_emissao) AS primeira_perda_data,

    -- Classificação de risco
    CASE
        WHEN COUNT(DISTINCT r.id) >= 5 THEN 'ALTO RISCO'
        WHEN COUNT(DISTINCT r.id) >= 3 THEN 'MÉDIO RISCO'
        WHEN COUNT(DISTINCT r.id) >= 1 THEN 'BAIXO RISCO'
        ELSE 'SEM RISCO'
    END AS nivel_risco

FROM receitas r
INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id
INNER JOIN clientes c ON r.id_cliente = c.id
WHERE (r.status = 'Cancelado' OR r.status = 'ORÇAMENTO')
  AND r.ativo = TRUE
  AND os.ativo = TRUE
  AND c.ativo = TRUE
GROUP BY c.id, c.nome, c.telefone
HAVING COUNT(DISTINCT r.id) > 0
ORDER BY valor_liquido_perdido DESC, quantidade_perdas DESC;

-- =====================================================
-- QUERY PARA MÉTRICAS E INDICADORES
-- =====================================================

-- Indicadores de performance financeira
WITH
receitas_perdidas AS (
    SELECT
        r.*,
        os.*,
        c.*
    FROM receitas r
    INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id
    INNER JOIN clientes c ON r.id_cliente = c.id
    WHERE (r.status = 'Cancelado' OR r.status = 'ORÇAMENTO')
      AND r.ativo = TRUE
      AND os.ativo = TRUE
      AND c.ativo = TRUE
),
receitas_totais AS (
    SELECT
        r.*,
        os.*,
        c.*
    FROM receitas r
    INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id
    INNER JOIN clientes c ON r.id_cliente = c.id
    WHERE r.ativo = TRUE
      AND os.ativo = TRUE
      AND c.ativo = TRUE
)
SELECT
    'INDICADORES' AS metrica,

    -- Taxa de perda geral
    ROUND(
        (SELECT COUNT(*) FROM receitas_perdidas) * 100.0 /
        NULLIF((SELECT COUNT(*) FROM receitas_totais), 0), 2
    ) AS taxa_perda_percentual,

    -- Valor médio por perda
    COALESCE(
        (SELECT AVG(valor_total - valor_recebido) FROM receitas_perdidas), 0
    ) AS valor_medio_perda,

    -- Concentração de perdas (top 10% clientes)
    ROUND(
        (SELECT SUM(valor_total - valor_recebido)
         FROM (
             SELECT (valor_total - valor_recebido) AS perda, id_cliente
             FROM receitas_perdidas
             ORDER BY (valor_total - valor_recebido) DESC
             LIMIT CEIL((SELECT COUNT(DISTINCT id_cliente) FROM receitas_perdidas) * 0.1)
         ) top_clientes) * 100.0 /
        NULLIF((SELECT SUM(valor_total - valor_recebido) FROM receitas_perdidas), 0), 2
    ) AS concentracao_top10_percentual,

    -- Tempo médio de conversão (ou perda)
    COALESCE(
        (SELECT AVG(EXTRACT(DAYS FROM CURRENT_DATE - data_emissao))
         FROM receitas_perdidas), 0
    ) AS tempo_medio_dias,

    -- Eficiência de recuperação (quanto foi recebido mesmo em cancelados/orçamentos)
    ROUND(
        (SELECT SUM(valor_recebido) FROM receitas_perdidas) * 100.0 /
        NULLIF((SELECT SUM(valor_total) FROM receitas_perdidas), 0), 2
    ) AS taxa_recuperacao_percentual;

-- =====================================================
-- PARÂMETROS PARA FILTROS NO DELPHI
-- =====================================================

-- Query parametrizável para uso no Delphi (exemplo)
/*
SELECT
    r.id,
    r.status,
    r.valor_total,
    r.valor_recebido,
    (r.valor_total - r.valor_recebido) AS valor_perdido,
    r.data_emissao,
    c.nome AS cliente_nome,
    os.id AS ordem_servico_id
FROM receitas r
INNER JOIN ordens_servico os ON r.id_ordem_servico = os.id
INNER JOIN clientes c ON r.id_cliente = c.id
WHERE (r.status = 'Cancelado' OR r.status = 'ORÇAMENTO')
  AND r.ativo = TRUE
  AND os.ativo = TRUE
  AND c.ativo = TRUE
  -- Filtros dinâmicos (exemplo)
  AND (:data_inicial IS NULL OR r.data_emissao >= :data_inicial)
  AND (:data_final IS NULL OR r.data_emissao <= :data_final)
  AND (:status_filtro IS NULL OR r.status = :status_filtro)
  AND (:cliente_id IS NULL OR c.id = :cliente_id)
  AND (:valor_minimo IS NULL OR (r.valor_total - r.valor_recebido) >= :valor_minimo)
ORDER BY
    CASE
        WHEN :ordenacao = 'data' THEN r.data_emissao
        WHEN :ordenacao = 'valor' THEN (r.valor_total - r.valor_recebido)
        WHEN :ordenacao = 'cliente' THEN c.nome
    END DESC;
*/