# Selou — Progress Log

Arquivo de acompanhamento do projeto: o que já foi feito, decisões confirmadas e o que vem a seguir. Atualizado a cada task aprovada.

## Status atual

- **Fase:** Fase 0 — Setup
- **Última task concluída:** TASK-003
- **Próxima task:** TASK-004 — Logging estruturado + configuração via env vars

## Processo de trabalho (combinado com o time)

1. Tech Lead (Claude) planeja e entrega uma task por vez, no formato TASK-XXX.
2. Tudo que for relacionado a teste é responsabilidade do Tech Lead: arquivos `_test.go` de cada task de domínio (criados **antes** da task ser entregue) e também a própria infraestrutura de testes (convenções, cobertura, CI). O desenvolvedor só escreve código de produção.
3. Desenvolvedor implementa o código de produção necessário para os testes passarem, e avisa quando terminar.
4. Claude revisa código, roda testes/build, e aprova (✅) ou reprova (❌) com uma lista objetiva do que corrigir.
5. Só avança para a próxima task depois de aprovação.
6. Testes automatizados e mensagens de commit em inglês; conversa e documentação de processo em português.

## Tasks concluídas

### TASK-001 — Inicializar projeto Go ✅ (aprovada em 2026-09-09)

- `go.mod` — module `github.com/Gustavo-Oliveira7/selou`, Go 1.26.3
- `cmd/api/main.go` — entrypoint mínimo, imprime mensagem de inicialização
- `.gitignore` e `README.md` criados/atualizados
- Sem testes automatizados (task de puro scaffolding, sem lógica de negócio)

### TASK-002 — Lint, format e Makefile ✅ (aprovada em 2026-09-10)

- `.golangci.yml` — govet, errcheck, staticcheck, unused, ineffassign, misspell + gofmt/goimports
- `Makefile` — `build`, `run`, `test`, `fmt`, `lint`, `tidy`
- README com seção "Development" e link para este progress.md
- Sem testes automatizados (task de tooling, sem lógica de negócio)

### TASK-003 — Convenções de testes ✅ (aprovada em 2026-09-13, implementada pelo Tech Lead)

- `docs/testing.md` — stdlib `testing` (sem testify), tests no mesmo pacote, padrão table-driven, convenção de build tag `integration` para testes de banco
- `make test-coverage` — cobertura com `go tool cover -func`
- `.gitignore` cobrindo `coverage.out`
- Task de tooling puro sobre testes: implementada diretamente pelo Tech Lead, não pelo dev (ver processo de trabalho acima)

## Decisões técnicas confirmadas

- Monólito modular, organizado por domínio (vertical slice) em `internal/`
- Módulos de domínio só são criados quando já têm conteúdo real (sem pastas vazias)
- Module path: `github.com/Gustavo-Oliveira7/selou`

Decisões planejadas mas ainda não aplicadas no código (ver plano completo no histórico da conversa): stdlib `net/http` para rotas, SQL explícito + `golang-migrate` (sem ORM), JWT + bcrypt para auth, `log/slog` para logging.

## Backlog completo

Detalhe de cada task (objetivo, critérios de aceite, testes, etc.) é entregue individualmente no formato TASK-XXX quando chega a vez dela. Aqui fica só o título, como referência rápida.

### Fase 0 — Setup

- [x] TASK-001 — Inicializar módulo Go e estrutura de diretórios
- [x] TASK-002 — Configurar lint/format (golangci-lint, gofmt) + Makefile
- [x] TASK-003 — Configurar convenções de testes (`make test`)
- [ ] TASK-004 — Logging estruturado (slog) + configuração via env vars
- [ ] TASK-005 — Servidor HTTP mínimo com `/healthz`

### Fase 1 — Merchant

- [ ] TASK-006 — Entidade Merchant + validações + testes
- [ ] TASK-007 — Repositório in-memory de Merchant + testes
- [ ] TASK-008 — Caso de uso "Registrar Merchant" + testes
- [ ] TASK-009 — Endpoint `POST /merchants`
- [ ] TASK-010 — Autenticação de Merchant (hash de senha, login, JWT)
- [ ] TASK-011 — Setup PostgreSQL (docker-compose, pool, golang-migrate)
- [ ] TASK-012 — Migration + Postgres repository de Merchant + testes de integração

### Fase 2 — Customer

- [ ] TASK-013 — Entidade Customer + testes
- [ ] TASK-014 — Repositório in-memory de Customer + testes
- [ ] TASK-015 — Caso de uso "Registrar Customer" + `POST /customers`
- [ ] TASK-016 — Autenticação de Customer (login + JWT)
- [ ] TASK-017 — Middleware de autenticação (protege rotas por tipo de ator)
- [ ] TASK-018 — Migration + Postgres repository de Customer + testes de integração

### Fase 3 — Loyalty (Programa + Recompensa)

- [ ] TASK-019 — Entidade LoyaltyProgram (regra de selo) + testes
- [ ] TASK-020 — Entidade Reward + testes
- [ ] TASK-021 — Repositório in-memory de LoyaltyProgram/Reward + testes
- [ ] TASK-022 — Caso de uso "Criar Programa" + `POST /programs`
- [ ] TASK-023 — Caso de uso "Cadastrar Recompensa" + `POST /programs/{id}/rewards`
- [ ] TASK-024 — `GET /merchants/me/programs`
- [ ] TASK-025 — Migration + Postgres repository + testes de integração

### Fase 4 — Membership (Participação + Selos)

- [ ] TASK-026 — Entidade Membership + testes
- [ ] TASK-027 — Caso de uso "Participar de programa" + `POST /programs/{id}/memberships`
- [ ] TASK-028 — Entidade Purchase + regra de cálculo de selos + testes (decisão do "resto" a validar aqui)
- [ ] TASK-029 — Caso de uso "Registrar Compra" + `POST /purchases`
- [ ] TASK-030 — `GET /memberships/{id}` (progresso do cliente)
- [ ] TASK-031 — Migration + Postgres repository + testes de integração

### Fase 5 — Redemption

- [ ] TASK-032 — Entidade Redemption + validação de selos suficientes + testes
- [ ] TASK-033 — Caso de uso "Resgatar Recompensa" + `POST /redemptions`
- [ ] TASK-034 — `GET /customers/me/redemptions`
- [ ] TASK-035 — `GET /programs/{id}/history` (histórico do merchant)
- [ ] TASK-036 — Migration + Postgres repository + testes de integração

### Fase 6 — Consolidação

- [ ] TASK-037 — Testes end-to-end do fluxo completo
- [ ] TASK-038 — Tratamento consistente de erros HTTP
- [ ] TASK-039 — Validação de entrada padronizada
- [ ] TASK-040 — Documentação da API
- [ ] TASK-041 — Dockerfile + docker-compose completo (app + Postgres)
