Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791945629C
	for <linux-hardening@vger.kernel.org>; Wed,  2 Sep 2026 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392034; cv=none; b=HRzkM67KhX0gC699Cfxz3VbEL+ryS8xuW2qLGwFGxLazMAbJuSCYVw7Ag1l2NeZOIoMg0klNx8Jpe6QpbD83yfwjtx4c97IcQuJ6oAbfwQCiTcALfT+AaeEt+RkriI5hR1LVxEFIdP1Q3fRhzAXru4PwI8E0Ye55DBl77jryCfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392034; c=relaxed/simple;
	bh=ww4pcJ4EMSo2NZBqBm7HyfKLoFq6Eem4j1Ll7F2X6GI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KzWQJBO3oBu8vL1auG5nfgLinMWZFCH0XmsatGGN39vxYFk1tnhrfqEInlMQvDZBKdxX5g3DpY0rwiMTkseCasAADkUNjB9xvMo33eq5Kg5RN3UtBzmdRk85fIc6Ja7APHvwIgiGFLzazSWi4xrhzsAx5m5p+NhrDkpodZfrwf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AygGQQ9r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AygGQQ9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614981F000E9;
	Wed,  2 Sep 2026 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788392029;
	bh=zXhwUKOpojPX+evprumYEDy5+//Od/XwyFgbiw1JC8A=;
	h=From:To:Cc:Subject:Date;
	b=AygGQQ9roMNG7YX6wuocO3KNEEQOq5PTIuofdicmoBkx+djXZsqojf263d6F3a1jk
	 SJOhX4biYVXlmEv55KmMxPva33EM9DOJgb4l6E4Blv3Z2pk88nvQI9DqDqNhTwJNgX
	 o6+4cnQeArA7UFAh0qQ/4YGHuaEkgxFanX3AGvptMqohTbbC4R+7Zb5iS11OPDVk15
	 BhcjHB1bqKuJi6CwYKrSbS6ldzFBqFrwu6TSKAeLxKa+DfoGCfKGw0EW/uIZMN2s8R
	 xGrwkZ8hQiR4OUjtovrXez39NWW64Ad26qhzMh/LFfoQDPM4KH50euA3UoVz/3JSPM
	 DDrfkZdFreGCA==
From: Kees Cook <kees@kernel.org>
To: York Jasper Niebuhr <yjn@yjn-systems.com>
Cc: Kees Cook <kees@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	franzen@sec.in.tum.de,
	linux-hardening@vger.kernel.org
Subject: [RFC][PATCH 0/3] SPSLR-v3 cleanups
Date: Wed,  2 Sep 2026 16:33:40 -0700
Message-Id: <20260902233338.i.375-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9472; i=kees@kernel.org; h=from:subject:message-id; bh=ww4pcJ4EMSo2NZBqBm7HyfKLoFq6Eem4j1Ll7F2X6GI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkzNoXKq5VIG63NO76uM95aUJntc2n8lAV5D/6LRr2/n bN64snUjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImk7WFkWHZGd+p75fepMzjX NCRt7/V6NWNRy12NkEm6v+e8N7326DfD/5jdB62/+fQtubP3JeP6nPC1T/+uc1+d+3dZ8YPGFOs PU5gB
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi Jasper,

I finally carved out some time to build, run, and test this. It works! :)

Below is what I did, what broke, and a few review notes. The three patches
that follow are small fixes and a reorganization.

Reproducing the whole thing
===========================

I built the required toolchain (GCC 16.1.0 + component_ref.patch,
binutils 2.46.1 + fieldlabel.patch), applied the series to v7.3-rc1,
and booted it under QEMU with a simple busybox userspace.

With CONFIG_SPSLR=y the kernel prints "Successfully applied SPSLR"
and then runs userspace normally:

    ===== USERSPACE UP =====
    -- ps (walks the task list) --      64 processes, rendered correctly
    -- /proc/self/stat --               plausible, correct pid/ppid
    -- /proc/self/status --             Name/State/Pid/PPid/Threads OK
    -- fork/exec storm: 200 processes -- completed, still alive
    -- signals, pipes, timers --        all OK
    ===== ALL USERSPACE TESTS PASSED =====

Three randomized boots (so three different task_struct layouts) plus one
"nospslr" control all completed with zero Oopses.

The toolchain build straight forward, but I had one packaging nit:
fieldlabel.patch is two commits concatenated, and the second edits a
test file the first creates. "patch --dry-run" therefore reports a bogus
failure; it applies fine for real. Anyone sanity-checking with --dry-run
first will think the patch is broken. Probably better as 2 patches.

Two build failures
==================

1) CONFIG_SPSLR=y with CONFIG_SANEMAKER=n does not build.

That is the baseline configuration named in your cover letter, so I
suspect you have only ever built with SANEMAKER=y lately. :)

  kernel/module/main.c:105:63: error: suggest braces around empty body
    in an 'if' statement [-Werror=empty-body]

The sanemaker_*() stubs expand to nothing when CONFIG_SANEMAKER is off,
and sanemaker_register_module_image() uses them as an if body. Patch 2/3
gives the stubs the usual do { } while (0) form.

2) Out-of-tree (O=builddir...) builds do not work.

  scripts/gcc-plugins/asm_offset_pass.c:3:10: fatal error: pinpoint.h:
    No such file or directory

The plugin sources include their own headers with angle brackets, which
search only -I paths. plugin_cxxflags carries -I $(obj), which exists for
randstruct's *generated* randomize_layout_seed.h; for an in-tree build
$(obj) happens to equal $(src), so it works by accident. Patch 1/3
switches the plugin's own 19 headers to quoted includes, which need no -I
at all.

Pinpoint can live in a subdirectory
===================================

Patch 3/3 moves the pinpoint files into scripts/gcc-plugins/pinpoint/.
The rest of your series is already organized hierarchically
(kernel/spslr/, samples/spslr/ tasklist/), so I suspect the flat layout
here was not a preference but a belief that the plugin build could not
do subdirectories. But it can, with no Kbuild changes! :)

The rules in scripts/gcc-plugins/Makefile are pattern rules:

	$(plugin-objs): $(obj)/%.o: $(src)/%.c FORCE

and GNU make's % matches a '/', so listing objects with a directory
prefix is sufficient; Kbuild creates the output subdirectory itself. I
verified this with a throwaway two-file plugin before touching pinpoint.

Smaller review notes
====================

- All 35 pinpoint files are missing SPDX-License-Identifier tags.
  pinpoint.c starts with #include <filesystem>, passes.h with
  #pragma once. I deliberately did not fold an SPDX sweep into the move
  patch; it belongs in your 1/5.

- The new "nospslr" early_param is not documented in
  Documentation/admin-guide/kernel-parameters.txt. The series adds no
  Documentation/ at all, but I know it's an RFC.

- "Boot Patch SLR" vs "Self Patch SLR" confused me briefly. I think the
  whole thing should be just called Self Patch SLR?

- I was expecting this to build on randstruct, but I see it's making its
  own choices about things. I was expecting SPSLR to attempt to randomize
  the same things randstruct targets, but it seems not? E.g. It looks like
  you're trying to randomize the _entire_ task_struct instead of just the
  substruct within that is marked with __randomize_layout. And since you're
  doing your own struct randomization, there some thing missing here, e.g.
  trailing flexible arrays, auto-randomizing all-function structs, etc.
  And as part of not being built on randstruct, probably the Kconfigs
  should be mutually exclusive. :P


Anyway, impressive work! I'm looking forward to seeing this continue
to expand and getting the self-reference pointer stuff fixed and the
offsetof() stuff working for BPF folks too. :)

-Kees


Kees Cook (3):
  gcc-plugins: pinpoint: use quoted includes for internal headers
  gcc-plugins: sanemaker: make the no-op trap macros statement-safe
  gcc-plugins: pinpoint: move to subdirectory

 scripts/gcc-plugins/Makefile                  | 32 +++++++++----------
 .../{ => pinpoint}/asm_offset_pass.c          |  6 ++--
 .../{ => pinpoint}/dpin_registry.c            |  6 ++--
 .../{ => pinpoint}/dpin_registry.h            |  2 +-
 .../{ => pinpoint}/ipin_registry.c            |  6 ++--
 .../{ => pinpoint}/ipin_registry.h            |  6 ++--
 .../gcc-plugins/{ => pinpoint}/layout_hash.c  |  6 ++--
 .../gcc-plugins/{ => pinpoint}/layout_hash.h  |  2 +-
 .../{ => pinpoint}/on_finish_decl.c           |  4 +--
 .../{ => pinpoint}/on_finish_type.c           |  4 +--
 .../{ => pinpoint}/on_finish_unit.c           | 16 +++++-----
 .../on_preserve_component_ref.c               | 10 +++---
 .../{ => pinpoint}/on_register_attributes.c   |  4 +--
 .../{ => pinpoint}/on_start_unit.c            |  8 ++---
 scripts/gcc-plugins/{ => pinpoint}/passes.h   |  4 +--
 scripts/gcc-plugins/{ => pinpoint}/pinpoint.c |  8 ++---
 scripts/gcc-plugins/{ => pinpoint}/pinpoint.h |  4 +--
 .../rtl_ipin_survival_scan_pass.c             |  8 ++---
 .../gcc-plugins/{ => pinpoint}/safe-attribs.h |  2 +-
 .../{ => pinpoint}/safe-diagnostic.h          |  2 +-
 .../{ => pinpoint}/safe-gcc-plugin.h          |  0
 scripts/gcc-plugins/{ => pinpoint}/safe-ggc.h |  2 +-
 .../gcc-plugins/{ => pinpoint}/safe-gimple.h  |  4 +--
 .../gcc-plugins/{ => pinpoint}/safe-input.h   |  2 +-
 .../{ => pinpoint}/safe-langhooks.h           |  2 +-
 scripts/gcc-plugins/{ => pinpoint}/safe-md5.h |  2 +-
 .../gcc-plugins/{ => pinpoint}/safe-output.h  |  2 +-
 .../{ => pinpoint}/safe-plugin-version.h      |  2 +-
 scripts/gcc-plugins/{ => pinpoint}/safe-rtl.h |  2 +-
 .../gcc-plugins/{ => pinpoint}/safe-tree.h    |  2 +-
 .../{ => pinpoint}/separate_offset_pass.c     |  8 ++---
 .../gcc-plugins/{ => pinpoint}/serialize.c    |  0
 .../gcc-plugins/{ => pinpoint}/serialize.h    |  0
 .../{ => pinpoint}/target_hash_builtin_pass.c | 12 +++----
 .../{ => pinpoint}/target_registry.c          | 10 +++---
 .../{ => pinpoint}/target_registry.h          |  2 +-
 include/sanemaker/traps.h                     | 16 +++++-----
 37 files changed, 104 insertions(+), 104 deletions(-)
 rename scripts/gcc-plugins/{ => pinpoint}/asm_offset_pass.c (95%)
 rename scripts/gcc-plugins/{ => pinpoint}/dpin_registry.c (98%)
 rename scripts/gcc-plugins/{ => pinpoint}/dpin_registry.h (93%)
 rename scripts/gcc-plugins/{ => pinpoint}/ipin_registry.c (99%)
 rename scripts/gcc-plugins/{ => pinpoint}/ipin_registry.h (95%)
 rename scripts/gcc-plugins/{ => pinpoint}/layout_hash.c (94%)
 rename scripts/gcc-plugins/{ => pinpoint}/layout_hash.h (83%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_finish_decl.c (72%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_finish_type.c (78%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_finish_unit.c (97%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_preserve_component_ref.c (95%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_register_attributes.c (97%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_start_unit.c (51%)
 rename scripts/gcc-plugins/{ => pinpoint}/passes.h (95%)
 rename scripts/gcc-plugins/{ => pinpoint}/pinpoint.c (97%)
 rename scripts/gcc-plugins/{ => pinpoint}/pinpoint.h (97%)
 rename scripts/gcc-plugins/{ => pinpoint}/rtl_ipin_survival_scan_pass.c (87%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-attribs.h (78%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-diagnostic.h (83%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-gcc-plugin.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-ggc.h (71%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-gimple.h (79%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-input.h (77%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-langhooks.h (75%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-md5.h (71%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-output.h (73%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-plugin-version.h (78%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-rtl.h (88%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-tree.h (80%)
 rename scripts/gcc-plugins/{ => pinpoint}/separate_offset_pass.c (98%)
 rename scripts/gcc-plugins/{ => pinpoint}/serialize.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/serialize.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/target_hash_builtin_pass.c (96%)
 rename scripts/gcc-plugins/{ => pinpoint}/target_registry.c (98%)
 rename scripts/gcc-plugins/{ => pinpoint}/target_registry.h (98%)

-- 
2.34.1

