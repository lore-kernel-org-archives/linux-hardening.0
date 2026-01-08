Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7323C00AE;
	Thu,  8 Jan 2026 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864477; cv=none; b=uTHffmBrQxcx8+JXD42JX0n6J7cVH26G4k63PTc4qhZbMI4yD3NpGcgkeU/00N0egFrspQg6z2fdyfP+xYZa/ZIbJQPIC8v/UShqKKJjBlXc/HkveQArgansh9lCQ7kCV/OWvm7r2r1BcEg7gX2iUM6Ch1GZ0AKgbzEftDs2bWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864477; c=relaxed/simple;
	bh=1IPcno0QyDQ6qY90wvHx3R8y442rlsydtB4H2AZjgYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHjLEpC7SIJdpeXgMlzxx0oXX1w5vSU0g0m8eybqNxVx9czHcMfbLv2wI+/X1xly+kLBRrIV69OFS2jmBKg64qDyu0f9pPqiSFFXNb9yviYmdgekH8jICpkSoV7DfR0bnxTjlA75aN5SQF6/z+8t5HcWz2jyAbH8Hsbc2RcRwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOG4QAqi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOG4QAqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28FAC116C6;
	Thu,  8 Jan 2026 09:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864476;
	bh=1IPcno0QyDQ6qY90wvHx3R8y442rlsydtB4H2AZjgYU=;
	h=From:To:Cc:Subject:Date:From;
	b=gOG4QAqiTh/LmaCykZfOEcdVg4S68pLuMyMxOG60Y5ajnFbELDrKr5cN3j/wUj/+v
	 SBJjDK8uur4PqkzKQaJ4gcLVBkLh0xeoY5Dl/36LRam+e2h/pCGy5uYEwOae8sLkeT
	 IiYjsQFPsBO5ee1NqTCpfmU3grD0K03ahg+FRwGtIdsCPdU59hXjqwHxYpVFcNpPwW
	 WVaLogmn6VLk7esHkG0Ia/YC9Lvhu9x1APsRX4XSu3xorgLbUXmAhsW9upZ7LVcqiu
	 O79PX59SX7lNDZ0p0aU5IS4YiwjJ5RFkx5UZ7ZnlZdr0nJMBcXk0cA/cFSEskWCpA7
	 xuHlC/00Slpjg==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [RFC/RFT PATCH 00/19] Link the relocatable x86 kernel as PIE
Date: Thu,  8 Jan 2026 09:25:27 +0000
Message-ID: <20260108092526.28586-21-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5954; i=ardb@kernel.org; h=from:subject; bh=1IPcno0QyDQ6qY90wvHx3R8y442rlsydtB4H2AZjgYU=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+gu35j3UHZj+48PzQFA2tiRJ7LjzX3rVz959Hhl/F3 u/c/jZjY0cpC4MYF4OsmCKLwOy/73aenihV6zxLFmYOKxPIEAYuTgGYyN0ZjAwrsv5Is24tzDC3 YblycJezelHx1FNi1UzFuTUJD35et9vK8FeIpUQ/xklVQz3/lEPoXR6PaZbSf/cszF0Qc2rG0/1 Pd3ADAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

This series is a follow-up to a series I sent a bit more than a year
ago, to switch to PIE linking of x86_64 vmlinux, which is a prerequisite
for further hardening measures, such as fg-kaslr [1], as well as further
harmonization of the boot protocols between architectures [2].

The main sticking point is the fact that PIE linking on x86_64 requires
PIE codegen, and that was shot down before on the basis that
a) GOTs in fully linked binaries are stupid
b) the code size increase would be prohibitive
c) the performance would suffer.

This series implements PIE codegen without permitting the use of GOT
slots. The code size increase is between 0.2% (clang) and 0.5% (gcc),
and I could not identify any performance regressions (using hackbench)
on various different micro-architectures that I tried it on.
(Suggestions for other benchmarks/test cases are welcome)

So now that we have some actual numbers, I would like to try and revisit
this discussion, and get a conclusion on whether this is really a
non-starter. Note that only the KASLR kernel would rely on this, and
disabling CONFIG_RANDOMIZE_BASE will revert to the current situation
(provided that patch #4 is applied)

Some minor asm tweaks are needed too (patches #9 - #17), but those all
seem uncontroversial to me. 

The first 5 patches are general cleanup, and could be taken into
consideration independently of the discussion around PIC codegen.

[1] There have been a few attempts at landing fine grained KASLR for
x86, but the main problem is that it was tied to the x86 relocation
format, which deviates from how fully linked relocatable ELF binaries
are generally constructed (using PIE). Implementing fgkaslr in the ELF
domain would make it suitable for other architectures too, as well as
other use cases (bare metal or hosted) where no dynamic linking is
performed (firmware, hypervisors). In order to implement this properly,
i.e., with debugging support etc, it needs support from the tooling
side. (Fine grained KASLR in combination with execute-only code mappings
makes it extremely difficult for an attacker to subvert the control flow
in the kernel in a way that can be meaningfully exploited).

[2] EFI zboot is already used by various architectures that have no
decompressor stage at all (arm64, RISC-V, LoongArch), and this format
can be combined with an ELF payload too. EFI zboot accommodates non-EFI
boot chains by describing the size, offset, payload type and compression
type in its header, so that it can be extracted and booted by other
means.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: linux-hardening@vger.kernel.org

Ard Biesheuvel (19):
  x86/idt: Move idt_table to __ro_after_init section
  x86/sev: Don't emit BSS_DECRYPT section unless it is in use
  x86: Combine .data with .bss in kernel mapping
  x86: Make the 64-bit bzImage always physically relocatable
  x86/efistub: Simplify early remapping of kernel text
  alloc_tag: Use __ prefixed ELF section names
  tools/objtool: Treat indirect ftrace calls as direct calls
  x86: Use PIE codegen for the relocatable 64-bit kernel
  x86/pm-trace: Use RIP-relative accesses for .tracedata
  x86/kvm: Use RIP-relative addressing
  x86/rethook: Use RIP-relative reference for fake return address
  x86/sync_core: Use RIP-relative addressing
  x86/entry_64: Use RIP-relative addressing
  x86/hibernate: Prefer RIP-relative accesses
  x64/acpi: Use PIC-compatible references in wakeup_64.S
  x86/kexec: Use 64-bit wide absolute reference from relocated code
  x86/head64: Avoid absolute references in startup asm
  x86/boot: Implement support for RELA/RELR/REL runtime relocations
  x86/kernel: Switch to PIE linking for the relocatable kernel

 arch/x86/Kconfig                        |  45 ++++---
 arch/x86/Makefile                       |  24 +++-
 arch/x86/boot/Makefile                  |   1 +
 arch/x86/boot/compressed/Makefile       |   2 +-
 arch/x86/boot/compressed/head_64.S      |   4 -
 arch/x86/boot/compressed/misc.c         |  85 +++++++++++--
 arch/x86/boot/header.S                  |   8 +-
 arch/x86/entry/calling.h                |   9 +-
 arch/x86/entry/entry_64.S               |  14 +--
 arch/x86/entry/vdso/Makefile            |   1 +
 arch/x86/include/asm/boot.h             |   2 -
 arch/x86/include/asm/pm-trace.h         |   4 +-
 arch/x86/include/asm/sync_core.h        |   3 +-
 arch/x86/kernel/acpi/wakeup_64.S        |  11 +-
 arch/x86/kernel/head_64.S               |  17 +--
 arch/x86/kernel/idt.c                   |   5 +-
 arch/x86/kernel/kvm.c                   |   5 +-
 arch/x86/kernel/relocate_kernel_64.S    |   2 +-
 arch/x86/kernel/rethook.c               |   6 +-
 arch/x86/kernel/vmlinux.lds.S           | 132 ++++++++++++--------
 arch/x86/mm/init_64.c                   |   5 +-
 arch/x86/mm/pat/set_memory.c            |   2 +-
 arch/x86/power/hibernate_asm_64.S       |   4 +-
 arch/x86/realmode/rm/Makefile           |   1 +
 drivers/base/power/trace.c              |   6 +-
 drivers/firmware/efi/libstub/x86-stub.c |   4 +-
 include/asm-generic/codetag.lds.h       |  14 ++-
 include/asm-generic/vmlinux.lds.h       |   1 +
 include/linux/alloc_tag.h               |  11 +-
 include/linux/hidden.h                  |   2 +
 include/uapi/linux/elf.h                |   3 +
 lib/alloc_tag.c                         |   6 +-
 tools/objtool/check.c                   |  32 ++++-
 33 files changed, 315 insertions(+), 156 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3

