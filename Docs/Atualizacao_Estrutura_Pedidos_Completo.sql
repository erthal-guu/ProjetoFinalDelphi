-- Script completo para atualizar a estrutura do banco de dados
-- Executar passos na ordem correta

-- 1. Remover constraint existente se houver
DO $$
BEGIN
    -- Verificar se a constraint existe antes de remover
    IF EXISTS (SELECT 1 FROM information_schema.table_constraints
               WHERE table_name = 'pedidos' AND constraint_name = 'fk_peca') THEN
        EXECUTE 'ALTER TABLE public.pedidos DROP CONSTRAINT fk_peca';
        RAISE NOTICE 'Constraint fk_peca removida com sucesso';
    END IF;
END
$$;

-- 2. Remover o campo id_peca da tabela pedidos (se ainda existir)
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns
               WHERE table_name = 'pedidos' AND column_name = 'id_peca') THEN
        EXECUTE 'ALTER TABLE public.pedidos DROP COLUMN id_peca';
        RAISE NOTICE 'Campo id_peca removido com sucesso';
    END IF;
END
$$;

-- 3. Adicionar campo status_pedido (se não existir)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                  WHERE table_name = 'pedidos' AND column_name = 'status_pedido') THEN
        EXECUTE 'ALTER TABLE public.pedidos ADD COLUMN status_pedido character varying(20) DEFAULT ''ABERTO''';
        RAISE NOTICE 'Campo status_pedido adicionado com sucesso';
    END IF;
END
$$;

-- 4. Criar a tabela intermediária pedido_fornecedor (se não existir)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables
                  WHERE table_name = 'pedido_fornecedor') THEN

        EXECUTE 'CREATE TABLE public.pedido_fornecedor (
            id integer NOT NULL,
            id_pedido integer NOT NULL,
            id_fornecedor integer NOT NULL,
            data_envio timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
            data_resposta timestamp without time zone,
            status character varying(20) DEFAULT ''ENVIADO'',
            valor_total_cotacao numeric(10,2),
            observacao text,
            ativo boolean DEFAULT true
        )';

        RAISE NOTICE 'Tabela pedido_fornecedor criada com sucesso';
    END IF;
END
$$;

-- 5. Criar sequence para a nova tabela (se não existir)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.sequences
                  WHERE sequence_name = 'pedido_fornecedor_id_seq') THEN
        EXECUTE 'CREATE SEQUENCE public.pedido_fornecedor_id_seq
            AS integer
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1';

        EXECUTE 'ALTER TABLE ONLY public.pedido_fornecedor ALTER COLUMN id SET DEFAULT nextval(''public.pedido_fornecedor_id_seq''::regclass)';

        RAISE NOTICE 'Sequence pedido_fornecedor_id_seq criada com sucesso';
    END IF;
END
$$;

-- 6. Adicionar chave primária (se não existir)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints
                  WHERE table_name = 'pedido_fornecedor' AND constraint_type = 'PRIMARY KEY') THEN
        EXECUTE 'ALTER TABLE ONLY public.pedido_fornecedor ADD CONSTRAINT pedido_fornecedor_pkey PRIMARY KEY (id)';
        RAISE NOTICE 'Chave primária adicionada com sucesso';
    END IF;
END
$$;

-- 7. Criar índices (se não existirem)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_pedido_fornecedor_pedido') THEN
        EXECUTE 'CREATE INDEX idx_pedido_fornecedor_pedido ON public.pedido_fornecedor USING btree (id_pedido)';
        RAISE NOTICE 'Índice idx_pedido_fornecedor_pedido criado';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_pedido_fornecedor_fornecedor') THEN
        EXECUTE 'CREATE INDEX idx_pedido_fornecedor_fornecedor ON public.pedido_fornecedor USING btree (id_fornecedor)';
        RAISE NOTICE 'Índice idx_pedido_fornecedor_fornecedor criado';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_pedidos_status_pedido') THEN
        EXECUTE 'CREATE INDEX idx_pedidos_status_pedido ON public.pedidos USING btree (status_pedido)';
        RAISE NOTICE 'Índice idx_pedidos_status_pedido criado';
    END IF;
END
$$;

-- 8. Adicionar restrição de unicidade (se não existir)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints
                  WHERE table_name = 'pedido_fornecedor' AND constraint_name = 'unq_pedido_fornecedor') THEN
        EXECUTE 'ALTER TABLE ONLY public.pedido_fornecedor ADD CONSTRAINT unq_pedido_fornecedor UNIQUE (id_pedido, id_fornecedor)';
        RAISE NOTICE 'Restrição de unicidade adicionada com sucesso';
    END IF;
END
$$;

-- 9. Criar chaves estrangeiras (se não existirem)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints
                  WHERE table_name = 'pedido_fornecedor' AND constraint_name = 'fk_pedido_fornecedor_pedido') THEN
        EXECUTE 'ALTER TABLE ONLY public.pedido_fornecedor ADD CONSTRAINT fk_pedido_fornecedor_pedido FOREIGN KEY (id_pedido) REFERENCES public.pedidos(id_pedido) ON DELETE CASCADE';
        RAISE NOTICE 'Chave estrangeira fk_pedido_fornecedor_pedido criada';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints
                  WHERE table_name = 'pedido_fornecedor' AND constraint_name = 'fk_pedido_fornecedor_fornecedor') THEN
        EXECUTE 'ALTER TABLE ONLY public.pedido_fornecedor ADD CONSTRAINT fk_pedido_fornecedor_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES public.fornecedores(id) ON DELETE CASCADE';
        RAISE NOTICE 'Chave estrangeira fk_pedido_fornecedor_fornecedor criada';
    END IF;
END
$$;

-- Mensagem final
RAISE NOTICE 'Atualização da estrutura concluída com sucesso!';
RAISE NOTICE 'Tabelas atualizadas:';
RAISE NOTICE '1. pedidos - campo id_peca removido, status_pedido adicionado';
RAISE NOTICE '2. pedido_fornecedor - nova tabela criada com todas as constraints';