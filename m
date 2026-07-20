Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15CF3911B2
	for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574711; cv=none; b=FkmlT0l0u0Qgt2NxRPnkF+VZ2Ai0siybscLPQn0Hw2hkOWw5/K6igtllgLe/xjQyJdqA+0n7W9l8j01RbgIjBs3U3k2AR08EXISeyDfNdUqbT3mFmF8UU5jNxx5BL2TmNBDpis7R+Eh+ICaEgxP0mojLP6R4xtrzg5Ira9D3Mpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574711; c=relaxed/simple;
	bh=2ctxrtH/5XbGbnpJpD4rlCSJMnv+vGkfBow+a2WpIlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMS+qB/zodlb0AUlhH76MPPQ5Ajf1YFjW7G7Kw8M92+2edQz18EBVMzyhZkS8++STypUiGFuzoU6VAoaOuQtvIG/scTbixKJhVIkuTepreKCH0r+aXHw7t9XSLuoAmxK2xp2il/VXWCG2AuAXxcrPMRSqYb/77Y/wrHtbMSuP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=ALEjxa3X; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="ALEjxa3X"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954aff6088so21395145e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1784574708; x=1785179508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CifOdF1U/jKgeu9YY0ikwBnZ67YXrW44iKCHCRnXdO8=;
        b=ALEjxa3Xm8u5HOjc1PaWwcXwZGXEJzJrotWkRUplLYkQ6HsxEJz+BOm+1ZKWpuFVOP
         dhdbCt2rK5qLVcPHtom1BEjOmdYzHtrwj2kEQu4W0HnMFEqwJ41HGd1hHcin2lCfikJQ
         61Zxsj/cxxb3wms+YLLLf7r3AkYG8Unsh0bHHYwqFUf9YMuzANON5i4hzQALKBvm7r5S
         zgzh57JG65wFZLm7BCvNQlxIXMZXfZ2N+966tmSfGu05taTeCzRddr5eFb5YAD9F/aky
         noPLG/B0oYeZQ280i6DFi1b90FO9ZVn7R4HVxUhzdRmCoyw8Vq07abb3rPVvbJuTBdtn
         yofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574708; x=1785179508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CifOdF1U/jKgeu9YY0ikwBnZ67YXrW44iKCHCRnXdO8=;
        b=AVY1jieGvhRCcMBwuJVZ9A1SO8tIJCqfAGOkuoIzmZPaMIfSPPq6u3ccKaY9n6b3qr
         N9tMPNRmgd/Lg96H1l7ixX33/atRpiPG+/Hkfgox7bT4q32lnwu/lFcrpkib0qYvrQWn
         7OZNH8UhbvM5JJXMN8/DK4VjThAl9JxmDjRANUYUp+bMgxuMRoZhZgvmSWNC7xW/6Xen
         AXA//4LE3nuioDWSV0xsYRNkLZYMvVFL56Qpf/AtH6hC2qaP5+lBQAWPYjX3GAwBEPaB
         BtQV6I9lsG8zFHUC96LvE+S08L5tsJeh2O0NtDSng234ObDryueXnOUfuka8aDs8zSPz
         Jl1g==
X-Gm-Message-State: AOJu0YwjgJ1hAXv2W/dnBHSx7hFa634gzAjEkkL2xB6DQqXsSDjPAJyC
	tKlWeFQuDZe7GHjbosO+zOHaD9vrMg7MwIgsBvLH+98m8vDgInk/NFPlqoKPB/325EaHh9pm/iD
	cN5ZqE4uS
X-Gm-Gg: AfdE7cnK68hWLxCWv9lYKYHdotvyzGAVCY1wJvtvnlTbmvwrLIaLLj2KwvtlYdbqwdj
	4fsCHZ46o7bEpQvdmvSxmDDzmlhlT/0hT3Im42H7Fq9PcHyTkLcCE8osQ2BSxINTF6bao0ZiX5L
	cDtg99Xs6lAJ27M9Bq/d5X6vSszlkL7tzI+HP0Z2Zd8Y3Waue3Lcua0Yk1y1DN/POxwKOi5q2rZ
	4j1v8nsqPGn3SWDQndLWaRItWQt3pNIa8bPx+Wyc15v1Sz0En9jCmh9vrHh6Sv2cXtvUbMs7PWB
	AXuPDpcInL2GJKrtfjDp9zNDTTZcPuF7AbaNcoUP4qgzJgCAXEm+d3IX6f8garrlvpxRVXO8Y42
	Ic8QwNSIooeURkVdWf3Tr7Q++tjK/0Qf7airh2hhF8RbAu0hvsm9Lo2SQkInOGIk8f09mZry95o
	qJm+E5shFCZaeREbGkZouG7ki3xPxmPGUtkjlJqN2z1HtL7e/gUiLLrqqUarYgH8EKOzVkMGJVL
	m2JC0eNbVBv4ZILuPI=
X-Received: by 2002:a05:600c:4687:b0:495:5845:fb2 with SMTP id 5b1f17b1804b1-495584510afmr96398085e9.38.1784574707825;
        Mon, 20 Jul 2026 12:11:47 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00c9c364f8ed993120.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:c9c3:64f8:ed99:3120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547323bsm8673315e9.4.2026.07.20.12.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:11:47 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: [RFC v3 0/5] Bootpatch-SLR: Randomizing Linux Kernel Structure Layouts at Boot
Date: Mon, 20 Jul 2026 21:11:46 +0200
Message-ID: <20260720191146.21473-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
this is the third RFC version of Bootpatch-SLR. The previous RFCs were
sent to linux-hardening; this version is also sent to LKML for broader
review. Compared to RFC v2, it uses a new GAS feature instead of a
dedicated assembler inside the compiler plugin. Additionally, it
introduces the Sanemaker validation framework. This version rebases
BPSLR onto Linux 7.2-rc3 and resolves the boot failures that prevented
earlier rebases.

RFC v2:
    https://lists.openwall.net/linux-hardening/2026/06/20/5

Changes since RFC v2:
  - Implemented GAS fieldlabel feature to label immediate instruction
    operand bytes.
  - Removed pinpoint instruction pin assembler. Metadata now links
    directly against fieldlabels emitted by GAS.
  - Implemented Sanemaker validation tool and integrated it into the
    kernel.
  - Rebased Bootpatch-SLR onto Linux 7.2-rc3.
  - Excluded some RCU fields of task_struct from randomization to
    prevent boot crashes on new version.

Bootpatch-SLR enables per-instance structure layout randomization for
distribution kernels. While GCC's RandStruct pass randomizes layouts at
compile-time, every machine running the same kernel image receives the
same layout. Bootpatch-SLR applies comparable randomization during boot.

A full architectural overview and additional resources are available at:

    https://spslr.yjn-systems.com

At this stage, tooling is only available for x86_64. It is based on
Linux 7.2-rc3. Bootpatch-SLR currently randomizes most of the
task_struct. A few fields are exempt from randomization because of
current implementation details (see v2 cover letter).

Bootpatch-SLR requires a custom toolchain based on GCC 16.1.0 and GAS
2.46.1. GCC is extended to provide access to COMPONENT_REFs that are
usually folded inside the parser. The custom GAS provides the new
fieldlabel feature used to annotate encoded instruction patch sites.

An example for the fieldlabel feature is:

    movq $fieldlabel(8, .Lspslr_ipin_42, .Lspslr_ipin_width_42), %0

This causes the custom GAS to put the .Lspslr_ipin_42 label directly
onto the bytes encoding the immediate value 8. It additionally defines
the .Lspslr_ipin_width_42 label to be the size of the immediate field.
The metadata emitted by the Pinpoint plugin directly references these
symbols to specify exact patch-site locations.

The toolchain patches are available at:

    https://github.com/YJN-Systems/Selfpatch-SLR/tree/rfc-v3/toolchain

This RFC patch series is organized as follows:

 * Patch 1 adds the Pinpoint GCC plugin.

 * Patch 2 adds the Selfpatch runtime.

 * Patch 3 adds linker scripts and build integration.

 * Patch 4 applies BPSLR to the task_struct and integrates Sanemaker.

 * Patch 5 adds a simple tasklist sample module for sanity checking.

The current baseline configuration for testing is defconfig plus
CONFIG_SPSLR. Additionally, CONFIG_SAMPLES, CONFIG_SAMPLES_SPSLR, and
CONFIG_SAMPLES_SPSLR_TASKLIST can be enabled to build a simple
sanity-check module. Lastly, CONFIG_SANEMAKER can be set to make the
build compatible with the Sanemaker validation tool.

The Sanemaker sources are available at:

    https://github.com/YJN-Systems/Sanemaker/tree/rfc-v3

Further reading material on it is available at:

    https://spslr.yjn-systems.com/sanemaker.html

Sanemaker is a QEMU TCG plugin that traces every memory access that the
kernel performs. It normalizes accessed addresses to target type fields.
Between one run with BPSLR inactive and one run with the feature
enabled, it verifies that all instructions access the same fields in
both runs. Should an instruction be missed by pinpoint and thus be
insufficiently adjusted to a randomized layout, Sanemaker recognizes
that the instruction accesses the wrong field in the BPSLR-enabled run.
Integrated into CI pipelines, Sanemaker is meant to act as a deployment
barrier. It provides strong evidence that all instructions exercised
during testing behave correctly under BPSLR.

The RCU issue with the latest kernel version was reliably identified
using Sanemaker too. You can find a short blog post detailing the
investigation and results here:

    https://spslr.yjn-systems.com/blog/sanemk_kboot.html

The most immediate next points on my TODO list are:

  - Randomize the list heads. I intend to expand Selfpatch to refresh
    static data that depends on randomized field offsets.

  - Apply randomization to more target types. Optimally, v4 will
    randomize all types marked for randomization under RandStruct.

I immensely appreciate any feedback on any component or concept of this
system.

Thanks,
Jasper

York Jasper Niebuhr (5):
  Pinpoint plugin
  Selfpatch runtime
  SPSLR build integration
  SPSLR and Sanemaker source integration
  Tasklist sample module

 arch/x86/boot/startup/Makefile                |   4 +
 arch/x86/entry/vdso/common/Makefile.include   |   2 +-
 arch/x86/kernel/vmlinux.lds.S                 |  23 +
 include/linux/compiler_types.h                |   8 +
 include/linux/sched.h                         |  58 +-
 include/linux/spslr.h                         |  82 +++
 include/sanemaker/traps.h                     | 135 ++++
 init/Kconfig                                  |  13 +
 init/main.c                                   |  35 +
 kernel/Makefile                               |   2 +
 kernel/fork.c                                 |  10 +-
 kernel/module/main.c                          | 167 +++++
 kernel/spslr/Makefile                         |   7 +
 kernel/spslr/pinpoint.h                       |  76 +++
 kernel/spslr/sanemaker_traps.c                | 117 ++++
 kernel/spslr/spslr.c                          | 555 +++++++++++++++
 kernel/spslr/spslr_env.c                      |  74 ++
 kernel/spslr/spslr_env.h                      |  45 ++
 kernel/spslr/spslr_randomizer.c               | 646 ++++++++++++++++++
 kernel/spslr/spslr_randomizer.h               |  29 +
 samples/Kconfig                               |   3 +
 samples/Makefile                              |   1 +
 samples/spslr/Kconfig                         |  17 +
 samples/spslr/Makefile                        |   1 +
 samples/spslr/tasklist/Makefile               |   1 +
 samples/spslr/tasklist/tasklist.c             |  67 ++
 scripts/Makefile.gcc-plugins                  |   9 +
 scripts/gcc-plugins/Makefile                  |  18 +
 scripts/gcc-plugins/asm_offset_pass.c         |  79 +++
 scripts/gcc-plugins/dpin_registry.c           | 199 ++++++
 scripts/gcc-plugins/dpin_registry.h           |  22 +
 scripts/gcc-plugins/ipin_registry.c           | 367 ++++++++++
 scripts/gcc-plugins/ipin_registry.h           |  57 ++
 scripts/gcc-plugins/layout_hash.c             |  61 ++
 scripts/gcc-plugins/layout_hash.h             |   8 +
 scripts/gcc-plugins/on_finish_decl.c          |   8 +
 scripts/gcc-plugins/on_finish_type.c          |  12 +
 scripts/gcc-plugins/on_finish_unit.c          | 336 +++++++++
 .../gcc-plugins/on_preserve_component_ref.c   |  99 +++
 scripts/gcc-plugins/on_register_attributes.c  |  52 ++
 scripts/gcc-plugins/on_start_unit.c           |  11 +
 scripts/gcc-plugins/passes.h                  |  31 +
 scripts/gcc-plugins/pinpoint.c                | 103 +++
 scripts/gcc-plugins/pinpoint.h                |  75 ++
 .../gcc-plugins/rtl_ipin_survival_scan_pass.c |  37 +
 scripts/gcc-plugins/safe-attribs.h            |   9 +
 scripts/gcc-plugins/safe-diagnostic.h         |  10 +
 scripts/gcc-plugins/safe-gcc-plugin.h         |   6 +
 scripts/gcc-plugins/safe-ggc.h                |   8 +
 scripts/gcc-plugins/safe-gimple.h             |  14 +
 scripts/gcc-plugins/safe-input.h              |   9 +
 scripts/gcc-plugins/safe-langhooks.h          |   8 +
 scripts/gcc-plugins/safe-md5.h                |   8 +
 scripts/gcc-plugins/safe-output.h             |   8 +
 scripts/gcc-plugins/safe-plugin-version.h     |   8 +
 scripts/gcc-plugins/safe-rtl.h                |  17 +
 scripts/gcc-plugins/safe-tree.h               |  10 +
 scripts/gcc-plugins/separate_offset_pass.c    | 327 +++++++++
 scripts/gcc-plugins/serialize.c               | 303 ++++++++
 scripts/gcc-plugins/serialize.h               | 115 ++++
 .../gcc-plugins/target_hash_builtin_pass.c    | 167 +++++
 scripts/gcc-plugins/target_registry.c         | 492 +++++++++++++
 scripts/gcc-plugins/target_registry.h         |  59 ++
 scripts/module.lds.S                          |  25 +
 64 files changed, 5336 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/spslr.h
 create mode 100644 include/sanemaker/traps.h
 create mode 100644 kernel/spslr/Makefile
 create mode 100644 kernel/spslr/pinpoint.h
 create mode 100644 kernel/spslr/sanemaker_traps.c
 create mode 100644 kernel/spslr/spslr.c
 create mode 100644 kernel/spslr/spslr_env.c
 create mode 100644 kernel/spslr/spslr_env.h
 create mode 100644 kernel/spslr/spslr_randomizer.c
 create mode 100644 kernel/spslr/spslr_randomizer.h
 create mode 100644 samples/spslr/Kconfig
 create mode 100644 samples/spslr/Makefile
 create mode 100644 samples/spslr/tasklist/Makefile
 create mode 100644 samples/spslr/tasklist/tasklist.c
 create mode 100644 scripts/gcc-plugins/asm_offset_pass.c
 create mode 100644 scripts/gcc-plugins/dpin_registry.c
 create mode 100644 scripts/gcc-plugins/dpin_registry.h
 create mode 100644 scripts/gcc-plugins/ipin_registry.c
 create mode 100644 scripts/gcc-plugins/ipin_registry.h
 create mode 100644 scripts/gcc-plugins/layout_hash.c
 create mode 100644 scripts/gcc-plugins/layout_hash.h
 create mode 100644 scripts/gcc-plugins/on_finish_decl.c
 create mode 100644 scripts/gcc-plugins/on_finish_type.c
 create mode 100644 scripts/gcc-plugins/on_finish_unit.c
 create mode 100644 scripts/gcc-plugins/on_preserve_component_ref.c
 create mode 100644 scripts/gcc-plugins/on_register_attributes.c
 create mode 100644 scripts/gcc-plugins/on_start_unit.c
 create mode 100644 scripts/gcc-plugins/passes.h
 create mode 100644 scripts/gcc-plugins/pinpoint.c
 create mode 100644 scripts/gcc-plugins/pinpoint.h
 create mode 100644 scripts/gcc-plugins/rtl_ipin_survival_scan_pass.c
 create mode 100644 scripts/gcc-plugins/safe-attribs.h
 create mode 100644 scripts/gcc-plugins/safe-diagnostic.h
 create mode 100644 scripts/gcc-plugins/safe-gcc-plugin.h
 create mode 100644 scripts/gcc-plugins/safe-ggc.h
 create mode 100644 scripts/gcc-plugins/safe-gimple.h
 create mode 100644 scripts/gcc-plugins/safe-input.h
 create mode 100644 scripts/gcc-plugins/safe-langhooks.h
 create mode 100644 scripts/gcc-plugins/safe-md5.h
 create mode 100644 scripts/gcc-plugins/safe-output.h
 create mode 100644 scripts/gcc-plugins/safe-plugin-version.h
 create mode 100644 scripts/gcc-plugins/safe-rtl.h
 create mode 100644 scripts/gcc-plugins/safe-tree.h
 create mode 100644 scripts/gcc-plugins/separate_offset_pass.c
 create mode 100644 scripts/gcc-plugins/serialize.c
 create mode 100644 scripts/gcc-plugins/serialize.h
 create mode 100644 scripts/gcc-plugins/target_hash_builtin_pass.c
 create mode 100644 scripts/gcc-plugins/target_registry.c
 create mode 100644 scripts/gcc-plugins/target_registry.h

-- 
2.43.0

