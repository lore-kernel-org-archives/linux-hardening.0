Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4619E839
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962347; cv=none; b=o2hEH63I483OrGqYEMqHdIaG6sDaISgIREL4FXBjU2ruHbx4i/m9+DVjy7Sq/s+lkOjgoHBokn1ruNwPfMNaXoLVv0TJRMjymqr0q1W4HGhimy1aU1QNBmVxyE3S7YTy+sEQxqvPIxfh10g5bPGYfHI+uP1cPzDtNUv1twqSiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962347; c=relaxed/simple;
	bh=94wyGd8d7j3yqLVwUbkDShJlcKwVblQRYk+K1UMCkSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jS4cBo9XMGG12lxXYBxAdycDho8luW8m51HSjngf/UbxJgTzqUUUIanSB+DxZKq/yyVYbCaiJpE/p0r4wR3YuX+YrtuPUrgFSDtPm2Ep+Ru+uQAiMPxxcUmaOHFzk37Lz5t9e2vsXZsVulUlRgs5ROLhUjRfHCaxr6w73HBvbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=fG49bkh7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="fG49bkh7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-492329c5514so12125175e9.1
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1781962344; x=1782567144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eVuWyWL49muoP5YTl0gh8GuOwTURFiFzvYadHcA5WUU=;
        b=fG49bkh7Rt/tb7yTXG6VYcqpPN8Llwo75ZvwFu8N+iSu8H9VpBXMpie9OkZk+EsFjt
         V6QhhgcyIUkt2fsJYytIHmPX1lpxQdoBnoRB/35INj2RvpyAZLkGBMecojcHyOk238xq
         O0UZeYA1X7C+4otTT4gab0OFnayrZQTo3MRJD1DozaaQM7+/Z30biMenK+qbiCM385oj
         A8zXwqwAGUzjk+cewp6BBOwyg78guKob2SEOYwPMLVRGw9HPKWz3AXgruH7Bcq/ZVjxd
         FrbaL4ZZKAu5b5TwN++koZpJQFDGHqIRf+12JxHNwOeMEv8vnjivea1Xb8D8Ea3DTNrd
         3hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962344; x=1782567144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVuWyWL49muoP5YTl0gh8GuOwTURFiFzvYadHcA5WUU=;
        b=BboE6QUAIv9Nwo/vxx7BZB63+0exkroIByENwAEwsHP85V7/W6gH4PeprUsDN++P0z
         zfqj57U+UdJyTnGXpdFRVNF9w5F8VJ/nj1kZmVlszNGdXrBh/1A6qIbatux8vJDDUSMH
         vyPnhwG7hpWDbtrFD+ptL8khKeT0RzqKazQWEsZ0Cf5XQDmV/0N+Z41LmVziWV+FUJOo
         2+JUtw2BZBaQSTy2hfGXTIoQiHT7jhZO26Yg64+sjo+WAOzs0AmQ+OiNNP3mdnPKo3Ya
         QcdRzZO7w1sO/0+OlONARzAF7uu0+TvRgv2n61PjcPkuSdxefdiSJfvhL/S0DjuuLxIj
         bc8A==
X-Gm-Message-State: AOJu0YxMIRqeY+fwBfx+MHD7yZVTxoTJf6NNPdEnbyJ5fYvqEcr1rq2H
	kQYJzHIcIO2KS3vcFqCK6JvVNpRhonhJZEgFptduGIfvPgtHPFwYQeSH7Tn+qhc86bfb3UDMzoR
	kLH3Tsw==
X-Gm-Gg: AfdE7cn+9G7wHOPewe5S6ucxs5Y4Ag5v3+rMl3AuNMtrmLNQAWjwCraxP9/b0oJQWb8
	jjpaxF3xrJgtXaAuvNCwMPLCtqhPC126JpeoYlgojGQ7ryXnLakFy78tAMyWDf8JTnNXf7ufuwa
	OB/9HotSgRhBvbsWJs7cj17WG+ThFP8tR6tZwprrpRqb2zKO7kk2Bt1BI/Hxxpri0zRm55a8Krt
	8vGVhdEurXFS0CidkymcGIgeQD6Z9jBr0l7YTIG+4C6Kz8F569aUFiuiHqFAlCk+hPvBXinWfcx
	kAPtNUXXSVw7wYlIq6wz59CI6y71NiEedC/O4LfxWoGnJ5/E/MnV6uorMPPsa/aIadG0Gsp+IuN
	HYl4zrwriYEIO3O8XgNSdw2XqpsF6Gll556aa/+UtL1jbXgcWJKjCRyW47eX/GPh56VssNKCS0f
	YJpAvAp11JQ01JnAmmLjvlS25nteLK1C69eeAevqP50M9YbhVQxZN+Z8wcCDlC4YG1hJIFok4HD
	cwKNd5z5+qnX6ZZDMd2ZFxpA9E1
X-Received: by 2002:a05:600c:c3cf:10b0:492:3fb5:3a17 with SMTP id 5b1f17b1804b1-492409fbeadmr77851685e9.2.1781962344114;
        Sat, 20 Jun 2026 06:32:24 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00ab2024b6c6d10e76.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:ab20:24b6:c6d1:e76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4666cea9581sm7567585f8f.0.2026.06.20.06.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:32:23 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: [RFC v2 0/5] Bootpatch-SLR: Randomizing Linux Kernel Structure Layouts at Boot
Date: Sat, 20 Jun 2026 15:32:22 +0200
Message-ID: <20260620133222.94647-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
this is the second RFC version of Bootpatch-SLR. Compared to v1, it
implements several bug fixes and general improvements. Additionally, it
greatly simplifies the build integration by moving SPSLR metadata into
ELF sections and getting rid of any extra build artifacts or stages.

RFC v1:
    https://lists.openwall.net/linux-hardening/2026/06/05/21

Changes since RFC v1:
  - Removed the separate pre-link metadata aggregation stage.
  - Moved SPSLR metadata into ELF sections emitted directly by pinpoint.
  - Integrated pinpoint plugin into existing plugin infrastructure.
  - Added per-module selfpatch workspace to support parallel module
    patching.
  - Added the nospslr boot parameter.

Several hardening mechanisms rely on compile-time diversification. While
these approaches can be highly effective, their benefits are reduced in
deployment scenarios where a single kernel build is distributed to
millions of systems. Once the layout and characteristics of that build
become known, they are known for every system running it. Selfpatch-SLR
investigates whether Structure Layout Randomization can be applied after
software has already been built, thereby allowing diversification to
occur at runtime rather than only at compile time. Bootpatch-SLR
explores that idea in the context of the Linux kernel. The goal of this
project is to investigate the feasibility of the approach and identify
assumptions and obstacles that would need to be addressed by a
production-quality implementation.

Additional information about the project can be found on the
documentation website: https://spslr.yjn-systems.com

Selfpatch-SLR consists of two components: pinpoint and selfpatch. During
compilation, the pinpoint GCC plugin records the structure accesses and
static instances of target structures which rely on field offsets to be
randomized. It produces accompanying metadata and injects runtime
descriptors directly into ELF sections in each compilation unit's
assembly output stream. On program startup or kernel boot, selfpatch
chooses the randomized layouts and patches the loaded image's code and
data segments to reflect the new field offsets.

Starting with RFC v2, there are no separate metadata files or other
artifacts that must be tracked by the build system.

The current Bootpatch-SLR prototype focuses on randomizing task_struct
in a v6.12 kernel, at early boot, with a small number of fields exempt
from randomization due to current SPSLR implementation details.
Specifically, early pinpoint stages cause target field offsets to not be
known at compile time, in some contexts, which makes their use inside
static initializer expressions and asm-offset operands impossible.

At this stage, SPSLR tooling is only available for x86_64.

Testing this patch series currently requires a custom toolchain based on
GCC 16, because mainline GCC folds important offsetof-like expressions
before the earliest plugin hooks. The required GCC patch is available
at: https://lists.openwall.net/linux-hardening/2026/06/05/29

On my test system (QEMU TCG on an i9-13900H), the additional boot time
is currently below one second. Most of this time is spent in the
current, largely unoptimized randomizer. The actual image patching phase
takes only a few milliseconds.

The design goal of SPSLR is to eliminate the need for runtime lookup
tables or similar indirection mechanisms. Structure access instructions
are patched directly to reflect the randomized field offsets before
normal kernel execution begins.

As a result, the implementation does not require additional memory
accesses when accessing randomized structures. The current prototype
does, however, introduce a single additional mov instruction per target
structure access. This overhead is an implementation artifact rather
than a fundamental requirement of the approach and may be removed by
future tooling improvements.

This RFC patch series is organized as follows:

 * Patch 1 adds the pinpoint GCC plugin.

 * Patch 2 adds the SPSLR runtime.

 * Patch 3 adds linker scripts and build integration.

 * Patch 4 applies BPSLR to the task_struct.

 * Patch 5 adds a simple tasklist sample module for sanity checking.

The current baseline configuration for testing is defconfig plus
CONFIG_SPSLR. Additionally, CONFIG_SAMPLES, CONFIG_SAMPLES_SPSLR,
and CONFIG_SAMPLE_SPSLR_TASKLIST can be enabled to build a simple
sanity-check module. Among other things, this module prints the values
of offsetof(task_struct, ...). After BPSLR has been applied
successfully, these offsets differ between boots.

With this configuration, the modified kernel successfully boots and
passes simple task_struct-related userspace tests. In addition, I have
successfully started an Ubuntu 24.04 userspace on top of BPSLR.

I have also attempted to port BPSLR to v6.18 and later releases. While I
got the system to build, occasional runtime failures currently prevent
successful operation.

I assume some kernel behaviors, access patterns, or subsystem
interactions present in newer kernels are not yet handled correctly by
the prototype. I am aware of but have not yet addressed BTF and I
suspect there are several other mechanisms that conflict with current
BPSLR assumptions and need to still be addressed separately.

Open questions:

  - I am currently investigating a QEMU TCG based validation tool to
    verify that all accesses to randomized structures are correctly
    instrumented. Feedback on this validation strategy would be welcome.

  - The current implementation uses a custom instruction immediate
    labeling mechanism in pinpoint. Longer term I would like to move
    this functionality into assembler and linker infrastructure and
    would appreciate suggestions on the most appropriate direction.

Additional background on these ideas follows in a reply to this cover
letter to keep the RFC itself reasonably concise.

I greatly appreciate any feedback on this.

Thanks,
Jasper

York Jasper Niebuhr (5):
  SPSLR pinpoint plugin
  SPSLR selfpatch
  SPSLR build integration
  SPSLR source integration
  SPSLR tasklist sample module

 Makefile                                      |  11 +
 arch/x86/boot/compressed/Makefile             |   2 +
 arch/x86/entry/vdso/Makefile                  |   3 +-
 arch/x86/kernel/vmlinux.lds.S                 |  23 +
 drivers/firmware/efi/libstub/Makefile         |   2 +
 include/linux/compiler_types.h                |  12 +
 include/linux/sched.h                         |  50 +-
 include/linux/spslr.h                         |  65 ++
 init/Kconfig                                  |   7 +
 init/main.c                                   |  32 +
 kernel/Makefile                               |   2 +
 kernel/module/main.c                          |  92 +++
 kernel/spslr/Makefile                         |   5 +
 kernel/spslr/pinpoint.h                       |  89 +++
 kernel/spslr/spslr.c                          | 527 +++++++++++++++
 kernel/spslr/spslr_env.c                      |  74 +++
 kernel/spslr/spslr_env.h                      |  45 ++
 kernel/spslr/spslr_randomizer.c               | 598 ++++++++++++++++++
 kernel/spslr/spslr_randomizer.h               |  29 +
 samples/Kconfig                               |   3 +
 samples/Makefile                              |   1 +
 samples/spslr/Kconfig                         |  17 +
 samples/spslr/Makefile                        |   1 +
 samples/spslr/tasklist/Makefile               |   1 +
 samples/spslr/tasklist/tasklist.c             |  67 ++
 scripts/Makefile.gcc-plugins                  |   9 +
 scripts/gcc-plugins/Makefile                  |  17 +
 scripts/gcc-plugins/pinpoint.c                |  94 +++
 .../gcc-plugins/pinpoint_asm_offset_pass.c    | 133 ++++
 scripts/gcc-plugins/pinpoint_config.h         |   7 +
 scripts/gcc-plugins/pinpoint_error.h          |  28 +
 scripts/gcc-plugins/pinpoint_final.h          |   3 +
 scripts/gcc-plugins/pinpoint_gc_preserve.c    |  10 +
 scripts/gcc-plugins/pinpoint_gc_preserve.h    |  39 ++
 scripts/gcc-plugins/pinpoint_layout_hash.c    |  55 ++
 scripts/gcc-plugins/pinpoint_layout_hash.h    |   8 +
 scripts/gcc-plugins/pinpoint_on_finish_decl.c | 205 ++++++
 scripts/gcc-plugins/pinpoint_on_finish_type.c |  21 +
 scripts/gcc-plugins/pinpoint_on_finish_unit.c | 346 ++++++++++
 .../pinpoint_on_preserve_component_ref.c      |  95 +++
 .../pinpoint_on_register_attributes.c         |  53 ++
 scripts/gcc-plugins/pinpoint_on_start_unit.c  |  11 +
 .../gcc-plugins/pinpoint_rtl_pin_lower_pass.c | 278 ++++++++
 .../pinpoint_separate_offset_pass.c           | 324 ++++++++++
 scripts/gcc-plugins/pinpoint_separator.c      | 123 ++++
 scripts/gcc-plugins/pinpoint_serialize.c      | 298 +++++++++
 scripts/gcc-plugins/pinpoint_serialize.h      | 114 ++++
 scripts/gcc-plugins/pinpoint_stage0.h         | 105 +++
 scripts/gcc-plugins/pinpoint_stage1.h         |  11 +
 scripts/gcc-plugins/pinpoint_stage2.h         |  22 +
 scripts/gcc-plugins/pinpoint_target.c         | 460 ++++++++++++++
 scripts/gcc-plugins/safe-attribs.h            |   8 +
 scripts/gcc-plugins/safe-diagnostic.h         |   9 +
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
 scripts/module.lds.S                          |  25 +
 64 files changed, 4742 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/spslr.h
 create mode 100644 kernel/spslr/Makefile
 create mode 100644 kernel/spslr/pinpoint.h
 create mode 100644 kernel/spslr/spslr.c
 create mode 100644 kernel/spslr/spslr_env.c
 create mode 100644 kernel/spslr/spslr_env.h
 create mode 100644 kernel/spslr/spslr_randomizer.c
 create mode 100644 kernel/spslr/spslr_randomizer.h
 create mode 100644 samples/spslr/Kconfig
 create mode 100644 samples/spslr/Makefile
 create mode 100644 samples/spslr/tasklist/Makefile
 create mode 100644 samples/spslr/tasklist/tasklist.c
 create mode 100644 scripts/gcc-plugins/pinpoint.c
 create mode 100644 scripts/gcc-plugins/pinpoint_asm_offset_pass.c
 create mode 100644 scripts/gcc-plugins/pinpoint_config.h
 create mode 100644 scripts/gcc-plugins/pinpoint_error.h
 create mode 100644 scripts/gcc-plugins/pinpoint_final.h
 create mode 100644 scripts/gcc-plugins/pinpoint_gc_preserve.c
 create mode 100644 scripts/gcc-plugins/pinpoint_gc_preserve.h
 create mode 100644 scripts/gcc-plugins/pinpoint_layout_hash.c
 create mode 100644 scripts/gcc-plugins/pinpoint_layout_hash.h
 create mode 100644 scripts/gcc-plugins/pinpoint_on_finish_decl.c
 create mode 100644 scripts/gcc-plugins/pinpoint_on_finish_type.c
 create mode 100644 scripts/gcc-plugins/pinpoint_on_finish_unit.c
 create mode 100644 scripts/gcc-plugins/pinpoint_on_preserve_component_ref.c
 create mode 100644 scripts/gcc-plugins/pinpoint_on_register_attributes.c
 create mode 100644 scripts/gcc-plugins/pinpoint_on_start_unit.c
 create mode 100644 scripts/gcc-plugins/pinpoint_rtl_pin_lower_pass.c
 create mode 100644 scripts/gcc-plugins/pinpoint_separate_offset_pass.c
 create mode 100644 scripts/gcc-plugins/pinpoint_separator.c
 create mode 100644 scripts/gcc-plugins/pinpoint_serialize.c
 create mode 100644 scripts/gcc-plugins/pinpoint_serialize.h
 create mode 100644 scripts/gcc-plugins/pinpoint_stage0.h
 create mode 100644 scripts/gcc-plugins/pinpoint_stage1.h
 create mode 100644 scripts/gcc-plugins/pinpoint_stage2.h
 create mode 100644 scripts/gcc-plugins/pinpoint_target.c
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

-- 
2.43.0

