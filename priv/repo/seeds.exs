# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Escala.Repo.insert!(%Escala.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Escala.CMS.InputType

Escala.Repo.insert!(%InputType{name: "پاسخ متنی", has_option: false})
Escala.Repo.insert!(%InputType{name: "چند گزینه ای", has_option: true})
