# elixir-phoenix-liveview 🔴

Bölüm 1 — Framework / proje tipi. **Saf mix (Dockerfile YOK).**

Phoenix + **LiveView** (ana sayfa `/` bir LiveView — uzun ömürlü WebSocket). Beklenen:
`Framework=Phoenix`. 🔴 Asıl risk: LiveView WS "circuit" rollout/deploy sırasında kopar mı;
sticky-session / WS-uyumlu rollout gerekir. Bu blok saf-mix olduğundan WS davranışı ancak
build+deploy başarılı olursa (muhtemelen sonraki Dockerfile bölümünde) ölçülür.

- Dil/Framework: Elixir 1.20 / Phoenix 1.7.18 + LiveView (CounterLive `/`)
- Bağımlılık: Phoenix LiveView + esbuild/tailwind; DB yok
- Mimari: Monolit
- Build path: Dockerfile yok — komuta davranışı gözlemlenecek
- Port: 4000 (WS `/live` üzerinden)
- Dockerfile: yok
