Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307220FA81
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691116; cv=none; b=MnhNPBS0l3KvbH80L5bdPtzqD9m4Tdp9TOIAIsuaCy26Gd/Bip/Ag76ySgTqutoGqD9Ic4pRcyZQCLpMgU9HVoH/g9IYqvh02ZsEtpG4Hf7S/NugU4KhYg1UIlepOKAX4XrTtV2cnkOJYczWqn8jtwJbQbedubMrCoIRCpoznTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691116; c=relaxed/simple;
	bh=cnFTBvFOE02qszQRsoFNjB4aRZKwNh0wwx/QPYEd69k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrjtZuHFemeBt6IHQJ7EULvCpgHaWqn2HZsvR4ZBi/PjL5AOQ2pXmIJhqzzML9ue9xiHLW/Kh71Kms29ibcCVQdNWLlAS4IEfS7DukgT2dSt6d6kv5gqaWQFXhb72nTJ9i4f1Xp4xuSq68VWnzk77Ek438A5tPIzgo0uGpcIZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=yD/GoYvG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="yD/GoYvG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso13893405e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1780691113; x=1781295913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0S6qYgoJwJ+u3IcQSZi/E2Ivhrh0VmQhQvreQMFH+IM=;
        b=yD/GoYvGyTKe4fKqPEuSfphLZJ2pWyTsQaoAg710uzTfcnaowpWqVjMrBCm33k/mUJ
         LHWdGoESyyj1b0c4XMr/y0xhj7neWnSJjqIAdXe9RyvZIH46bvNfq+VnVotS4xky/J40
         Mr8pHVLvzfXawLynagwXFM59WbP084p/NCH+TrUP2k/bx1cc2976B7qSTQ15eDC/w5nm
         pDegjgZBrZMtA7NRYyhgz+3UNi7/Nv3jRrh2qLwtAzQ0f/B5qW9d3xbxq5Q0wOT4ISle
         yVQ9dFip50pu3/65HxxYcp/lii4SumWHDbTtWsTu1ZRCTz6eTIUvVCuThzcpPkwnRZYc
         yFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691113; x=1781295913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S6qYgoJwJ+u3IcQSZi/E2Ivhrh0VmQhQvreQMFH+IM=;
        b=ceHvwWvKqAzVYKPY/8j2JKIlSaI0oZAayODvICkkmWAl0ppC06r7h7yP2uFi2kZ+qX
         Ugf1qmDYu27hqT0Lz/8YTtQyZy3gVPTGUpJdV4ZBhAknKBAUJKQ2JtsZrB6EYvo101Rg
         zz7ImYGJRYmy3WAS+ha+y+BVIib7DZy8vJk1WXUdW75yTiDcXEg183YAcMeQWnm8Unss
         2CHw5u30MK6Obr+3ZCFHGVDz/m4o9Iu4QJyIfNxuE7Jn01kWjf5N3+Cyf7yRYtuMRyJa
         KTCb8Y8HNlyDcgpE+eQBbc3Im7d1vry4QM9pCWAiHnj8SySBNPnkVnupnCPHxsBMrnkY
         i2Qg==
X-Gm-Message-State: AOJu0YyUdiryW/CYpYAJkP5PpnYmyGgnpQTGMeINJ6Qa6Ep3rff9YABS
	FmwhXexNlG2kxSARsT62LXbi5KTsjoJfOE8qg3XX5fDNNxxBIQ9lVVZOQf/DsURDvdlEWyYK+WL
	M2rI/nMQ9
X-Gm-Gg: Acq92OHBNnJKNm5UR967pt0Gf6vd7tmxzUcn5IgSuZ5gmoD1BbGyQXoSI7l7/mYb81L
	6AvNnifXj11qS8hG/FXz9O/obyKq9AXsYqgxgqiISSrfSETGbbNeoxuImQO8UaPeZeo8RU3buZo
	l1BJRvdoZQ7US06BMeUQNu2p93nji/Cm/DXCq39Nji5dzsnjGVZtzmP7CGBF9vhLrM+hQ7IGU5N
	TW59it5e5/jwwYLBLRdaQ1ydMdq1UryxS86q62m0+BC1l5i8SQWU+6CUjYsFCOhuj1wtjym236y
	dKo0ee/EkPBQYqgNFMdZyp5jfDzw6LoIp7g3MZIu1VaPsg/h6KCd8Rv1OnGqTSNmt1Nh+a9Du98
	Jx9I+bGnC50zRXFBUPrzFerS+8LKc0BNQC6wI5LswClwS6LkQ7k0r91vd70JZMJB3hvWuUuLmHs
	FeyencdbJUjsl2ZE9ctnyeK2/dcaHNPIi6ZOEV0xI6Dso1pewPVFqCd/CQHSFZ5EZWR0a4fjRpQ
	jfzyxjrPlnV9rr/M/DMVOQP5aqQuu+24aek4kzPw7mDvZ8D8g==
X-Received: by 2002:a05:600c:83c6:b0:490:bcc1:4edb with SMTP id 5b1f17b1804b1-490c25fc11cmr92084505e9.27.1780691113010;
        Fri, 05 Jun 2026 13:25:13 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf13e6006c589ea22c400ee8.dip0.t-ipconnect.de. [2003:dc:bf13:e600:6c58:9ea2:2c40:ee8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm168442995e9.7.2026.06.05.13.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:25:12 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de
Subject: [RFC 0/7] Bootpatch-SLR: Randomizing Linux Kernel Structure Layouts at Boot
Date: Fri,  5 Jun 2026 22:25:04 +0200
Message-ID: <20260605202511.79272-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

my name is York Jasper Niebuhr. I am a Master's student in Informatics
at the Technical University of Munich.

For a while now, I have been developing Selfpatch-SLR (SPSLR), a system
to apply Structure Layout Randomization at runtime, and its Linux kernel
implementation, Bootpatch-SLR (BPSLR), as an independent research
project in my spare time. I am now beginning my Master's thesis, which
will build upon and further evaluate this work. This patch series
contains the current state of Bootpatch-SLR.

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

Additional information about the project can be found at:

Documentation:
https://spslr.yjn-systems.com

Selfpatch-SLR repository:
https://github.com/YJN-Systems/Selfpatch-SLR

Bootpatch-SLR kernel mirror:
https://github.com/YJN-Systems/Bootpatch-SLR

The documentation website contains an overview of the architecture and
design of the system. I also intend to maintain a list of known issues,
limitations, observations, and other findings there as development
continues.

Selfpatch-SLR consists of three main parts: pinpoint, patchcompile, and
selfpatch. During compilation, the pinpoint GCC plugin records the
structure accesses that may later need to be adjusted. The patchcompile
command line tool then aggregates this metadata from all compilation
units and generates the runtime information needed for patching. At
startup, selfpatch chooses the randomized layouts and patches the image
before the randomized structures are used. For more details on the
architecture, please refer to:

https://spslr.yjn-systems.com/architecture.html

The current Bootpatch-SLR prototype focuses on randomizing task_struct
in a v6.12 kernel, at early boot, with a small number of fields exempt
from randomization due to current SPSLR implementation details. At this
stage, SPSLR tooling is only available for x86_64.

Building the SPSLR or BPSLR currently requires a custom toolchain based
on GCC 16, because mainline GCC folds important offsetof-like
expressions before the earliest plugin hooks. This patch is not part of
the kernel series and is not intended for upstream GCC at this stage.
For reviewers interested in reproducing the build and test environment,
I will provide the GCC patch separately in this thread and in the
Selfpatch-SLR repository.

On my test system (QEMU on an i9-13900H), the additional boot time is
currently below one second. Most of this time is spent in the current,
largely unoptimized randomizer. The actual image patching phase takes
only a few milliseconds.

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

 * Patches 1 and 2 add the SPSLR tooling sources: the pinpoint GCC
   plugin and the patchcompile command-line tool.

 * Patch 3 integrates these tools into the kernel build system.

 * Patch 4 adds the selfpatch runtime support used to randomize and
   apply structure layouts during boot.

 * Patch 5 adds the BPSLR task_struct integration.

 * Patch 6 adds a simple tasklist sample module for sanity checking.

 * Patch 7 ignores BPSLR-generated files.

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

I would greatly appreciate feedback regarding kernel subsystems,
debugging and tracing infrastructure, metadata consumers, or other
mechanisms that may make assumptions about structure layouts, field
offsets, or object access patterns.

In particular, I would be interested in pointers to areas that are
likely to require special handling, as well as assumptions made by the
kernel that may not be obvious to someone approaching the problem from
outside the subsystem in question.

As I am only now beginning the thesis work associated with this project,
I expect to continue active development over the next approximately six
months. Early feedback on architectural concerns, missing subsystem
support, and problematic assumptions would therefore be especially
valuable.

I look forward to your feedback.

York Jasper Niebuhr

York Jasper Niebuhr (7):
  SPSLR pinpoint plugin source
  SPSLR patchcompile cli source
  SPSLR tool build integration
  SPSLR selfpatch
  BPSLR task_struct integration
  BPSLR tasklist sample module
  Ignore BPSLR generated files

 .gitignore                                    |   7 +
 Makefile                                      | 131 +++++
 arch/x86/boot/compressed/Makefile             |   2 +
 arch/x86/kernel/vmlinux.lds.S                 |   8 +
 drivers/firmware/efi/libstub/Makefile         |   2 +
 include/linux/compiler_types.h                |  12 +
 include/linux/sched.h                         |  50 +-
 include/linux/spslr.h                         |  48 ++
 init/Kconfig                                  |   7 +
 init/main.c                                   |  15 +
 kernel/Makefile                               |   2 +
 kernel/module/main.c                          |  62 ++
 kernel/spslr/Makefile                         |   5 +
 kernel/spslr/spslr.c                          | 267 +++++++++
 kernel/spslr/spslr_env.c                      |  74 +++
 kernel/spslr/spslr_env.h                      |  42 ++
 kernel/spslr/spslr_list.h                     |  63 +++
 kernel/spslr/spslr_list_link.h                |  21 +
 kernel/spslr/spslr_randomizer.c               | 382 +++++++++++++
 kernel/spslr/spslr_randomizer.h               |  26 +
 samples/Kconfig                               |   3 +
 samples/Makefile                              |   1 +
 samples/spslr/Kconfig                         |  17 +
 samples/spslr/Makefile                        |   1 +
 samples/spslr/tasklist/Makefile               |   1 +
 samples/spslr/tasklist/tasklist.c             |  68 +++
 scripts/Makefile.build                        |   9 +-
 scripts/Makefile.modfinal                     | 131 ++++-
 scripts/Makefile.vmlinux                      |   4 +
 scripts/Makefile.vmlinux_o                    |   1 +
 scripts/link-vmlinux.sh                       |   5 +
 tools/Makefile                                |  15 +-
 tools/spslr/Makefile                          |  78 +++
 tools/spslr/src/patchcompile/accumulation.cpp | 529 ++++++++++++++++++
 tools/spslr/src/patchcompile/accumulation.h   |  78 +++
 tools/spslr/src/patchcompile/emit.cpp         | 451 +++++++++++++++
 tools/spslr/src/patchcompile/emit.h           |   4 +
 tools/spslr/src/patchcompile/patchcompile.cpp | 167 ++++++
 .../src/patchcompile/patchcompile_error.h     |  41 ++
 tools/spslr/src/patchcompile/spslr_list.h     |  13 +
 tools/spslr/src/pinpoint/final/final.h        |  13 +
 .../src/pinpoint/final/on_finish_unit.cpp     | 190 +++++++
 tools/spslr/src/pinpoint/pinpoint.cpp         | 128 +++++
 tools/spslr/src/pinpoint/pinpoint_config.h    |   9 +
 tools/spslr/src/pinpoint/pinpoint_error.h     |  27 +
 .../spslr/src/pinpoint/safegcc/safe-attribs.h |   8 +
 .../src/pinpoint/safegcc/safe-diagnostic.h    |   9 +
 .../src/pinpoint/safegcc/safe-gcc-plugin.h    |   6 +
 .../spslr/src/pinpoint/safegcc/safe-gimple.h  |  13 +
 tools/spslr/src/pinpoint/safegcc/safe-input.h |   9 +
 .../src/pinpoint/safegcc/safe-langhooks.h     |   8 +
 tools/spslr/src/pinpoint/safegcc/safe-md5.h   |   8 +
 .../spslr/src/pinpoint/safegcc/safe-output.h  |   8 +
 .../pinpoint/safegcc/safe-plugin-version.h    |   8 +
 tools/spslr/src/pinpoint/safegcc/safe-rtl.h   |  17 +
 tools/spslr/src/pinpoint/safegcc/safe-tree.h  |   9 +
 .../src/pinpoint/stage0/on_finish_decl.cpp    | 216 +++++++
 .../src/pinpoint/stage0/on_finish_type.cpp    |  16 +
 .../stage0/on_preserve_component_ref.cpp      |  58 ++
 .../stage0/on_register_attributes.cpp         |  52 ++
 .../src/pinpoint/stage0/on_start_unit.cpp     |  19 +
 .../pinpoint/stage0/separate_offset_pass.cpp  | 315 +++++++++++
 tools/spslr/src/pinpoint/stage0/separator.cpp | 117 ++++
 tools/spslr/src/pinpoint/stage0/stage0.h      | 103 ++++
 tools/spslr/src/pinpoint/stage0/target.cpp    | 411 ++++++++++++++
 .../src/pinpoint/stage1/asm_offset_pass.cpp   | 133 +++++
 tools/spslr/src/pinpoint/stage1/stage1.h      |  11 +
 .../pinpoint/stage2/rtl_pin_lower_pass.cpp    | 283 ++++++++++
 tools/spslr/src/pinpoint/stage2/stage2.h      |  22 +
 69 files changed, 5041 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/spslr.h
 create mode 100644 kernel/spslr/Makefile
 create mode 100644 kernel/spslr/spslr.c
 create mode 100644 kernel/spslr/spslr_env.c
 create mode 100644 kernel/spslr/spslr_env.h
 create mode 100644 kernel/spslr/spslr_list.h
 create mode 100644 kernel/spslr/spslr_list_link.h
 create mode 100644 kernel/spslr/spslr_randomizer.c
 create mode 100644 kernel/spslr/spslr_randomizer.h
 create mode 100644 samples/spslr/Kconfig
 create mode 100644 samples/spslr/Makefile
 create mode 100644 samples/spslr/tasklist/Makefile
 create mode 100644 samples/spslr/tasklist/tasklist.c
 create mode 100644 tools/spslr/Makefile
 create mode 100644 tools/spslr/src/patchcompile/accumulation.cpp
 create mode 100644 tools/spslr/src/patchcompile/accumulation.h
 create mode 100644 tools/spslr/src/patchcompile/emit.cpp
 create mode 100644 tools/spslr/src/patchcompile/emit.h
 create mode 100644 tools/spslr/src/patchcompile/patchcompile.cpp
 create mode 100644 tools/spslr/src/patchcompile/patchcompile_error.h
 create mode 100644 tools/spslr/src/patchcompile/spslr_list.h
 create mode 100644 tools/spslr/src/pinpoint/final/final.h
 create mode 100644 tools/spslr/src/pinpoint/final/on_finish_unit.cpp
 create mode 100644 tools/spslr/src/pinpoint/pinpoint.cpp
 create mode 100644 tools/spslr/src/pinpoint/pinpoint_config.h
 create mode 100644 tools/spslr/src/pinpoint/pinpoint_error.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-attribs.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-diagnostic.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-gcc-plugin.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-gimple.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-input.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-langhooks.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-md5.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-output.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-plugin-version.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-rtl.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-tree.h
 create mode 100644 tools/spslr/src/pinpoint/stage0/on_finish_decl.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/on_finish_type.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/on_preserve_component_ref.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/on_register_attributes.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/on_start_unit.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/separate_offset_pass.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/separator.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/stage0.h
 create mode 100644 tools/spslr/src/pinpoint/stage0/target.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage1/asm_offset_pass.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage1/stage1.h
 create mode 100644 tools/spslr/src/pinpoint/stage2/rtl_pin_lower_pass.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage2/stage2.h

-- 
2.43.0

