vim.g.projectionist_heuristics = {
    ["*.java"] = {
        ["src/java/*.java"] = {
            alternate = "src/tst/java/{}Test.java",
            type = "source",
        },
        ["src/tst/java/*Test.java"] = {
            alternate = "src/main/java/{}.java",
            type = "test",
        },
    },
    ["*.ts"] = {
        ["src/*.ts"] = {
            alternate = "test/{}.test.ts",
            type = "source",
        },
        ["test/*.test.ts"] = {
            alternate = "src/{}.ts",
            type = "test",
        },
        ["src/*.tsx"] = {
            alternate = "tst/{}.test.tsx",
        },
        ["tst/*.test.tsx"] = {
            alternate = "src/{}.tsx",
        },
    },
}
