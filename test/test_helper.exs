Bureaucrat.start(
 writer: Bureaucrat.MarkdownWriter,
 default_path: "web/controllers/READMEE.md",
 paths: [],
 env_var: "DOC"
)
ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])

Mix.Task.run "ecto.create", ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]
Ecto.Adapters.SQL.begin_test_transaction(Spell.Repo)

