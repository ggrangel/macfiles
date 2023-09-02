vim.g.projectionist_heuristics = {
    -- src/main/java/com/amazon/jaguar/recorder/br/client/fiorino/FiorinoClientWrapperImpl.java
    -- src/test/java/com/amazon/jaguar/recorder/br/client/fiorino/FiorinoClientWrapperImplTest.java
    -- /Volumes/workplace/TbsPortal/src/TbsPortalBackend
    ["*"] = {
        ["src/main/java/*.java"] = {
            alternate = "src/test/java/{}Test.java",
        },
        ["src/test/java/*Test.java"] = {
            alternate = "src/main/java/{}.java",
        },
        ["src/*/src/*.ts"] = {
            alternate = "src/{}/test/{}.test.ts",
        },
        ["/Volumes/workplace/src/TbsPortalBackend/test/*.test.ts"] = {
            alternate = "/Volumes/workplace/src/TbsPortalBackend/src/{}.ts",
        },
    },
    -- [".tsx"] = {
    --     ["src/*.tsx"] = {
    --         alternate = "tst/{}.test.tsx",
    --     },
    --     ["tst/*.test.tsx"] = {
    --         alternate = "src/{}.tsx",
    --     },
    -- },
}
