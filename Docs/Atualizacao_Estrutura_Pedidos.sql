-- Script para atualizar a estrutura do banco de dados
-- Adicionar tabela intermediária pedido_fornecedor e modificar tabela pedidos

-- 1. Criar a tabela intermediária pedido_fornecedor
CREATE TABLE public.pedido_fornecedor (
    id integer NOT NULL,
    id_pedido integer NOT NULL,
    id_fornecedor integer NOT NULL,
    data_envio timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    data_resposta timestamp without time zone,
    status character varying(20) DEFAULT 'ENVIADO',
    valor_total_cotacao numeric(10,2),
    observacao text,
    ativo boolean DEFAULT true
);

-- 2. Criar sequence para a nova tabela
CREATE SEQUENCE public.pedido_fornecedor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- 3. Configurar default para o ID
ALTER TABLE ONLY public.pedido_fornecedor ALTER COLUMN id SET DEFAULT nextval('public.pedido_fornecedor_id_seq'::regclass);

-- 4. Adicionar chave primária
ALTER TABLE ONLY public.pedido_fornecedor ADD CONSTRAINT pedido_fornecedor_pkey PRIMARY KEY (id);

-- 5. Criar índices para melhor performance
CREATE INDEX idx_pedido_fornecedor_pedido ON public.pedido_fornecedor USING btree (id_pedido);
CREATE INDEX idx_pedido_fornecedor_fornecedor ON public.pedido_fornecedor USING btree (id_fornecedor);

-- 6. Adicionar restrições de unicidade
ALTER TABLE ONLY public.pedido_fornecedor ADD CONSTRAINT unq_pedido_fornecedor UNIQUE (id_pedido, id_fornecedor);

-- 7. Criar chaves estrangeiras
ALTER TABLE ONLY public.pedido_fornecedor ADD CONSTRAINT fk_pedido_fornecedor_pedido FOREIGN KEY (id_pedido) REFERENCES public.pedidos(id_pedido) ON DELETE CASCADE;
ALTER TABLE ONLY public.pedido_fornecedor ADD CONSTRAINT fk_pedido_fornecedor_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES public.fornecedores(id) ON DELETE CASCADE;

-- 8. Adicionar campo status_pedido à tabela pedidos
ALTER TABLE public.pedidos ADD COLUMN status_pedido character varying(20) DEFAULT 'ABERTO';

-- 9. Criar índice para o novo campo
CREATE INDEX idx_pedidos_status_pedido ON public.pedidos USING btree (status_pedido);

-- Inserir dados iniciais de teste na tabela pedido_fornecedor
-- (descomente se necessário)
/*
INSERT INTO public.pedido_fornecedor (id_pedido, id_fornecedor, status, observacao) VALUES
(1, 1, 'ENVIADO', 'Pedido enviado para cotação'),
(2, 1, 'RESPONDIDO', 'Resposta recebida com orçamento'),
(1, 2, 'ENVIADO', 'Segunda cotação solicitada');
*/