return {
  {
    "TaDaa/vimade",
    -- Security-audited locally on 2026-09-07: no network, shell, telemetry,
    -- credential, or exfiltration paths found in this exact commit.
    commit = "3d3d2db7ecd43c0181b20fede11d26f090dbc0d9",
    event = "VeryLazy",
    opts = {
      -- Fade every inactive split, including two views of the same buffer.
      ncmode = "windows",
      fadelevel = 0.45,
    },
  },
}
