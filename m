Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37DD38F82;
	Wed,  8 Jan 2025 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332453; cv=none; b=c9N0+0GCqALeSJAoR+9Mz5EoOxNVqzQuO8gSvRLQW7RcxI/DR7Wr6TNuUrwS1llbKC6xVKJWc9hjh9ifNhPaQ/me+MMjMjgcT9XngFU+vxfVyHOBp0ZGom5CtofJ260J06xrf2iEFvAXueg3+eyfE5Y3hzrCKNedLpFH6UO76/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332453; c=relaxed/simple;
	bh=Z/uLNeqasakeRgbyL5XY9YJieW/efvnVXS2BYs/Q9eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HV+wAVUlhumdnvbHViV2MvLsP3zXaoziQppbJc0d12uSCYllfynx6LBqLlrwws64APCu5jT0QJCWg++y10glHgQNoX0VQDWjHx9QwtQSk8XF1NgMHGv7dlAitmoOqAP+kGWkb87RPlmZJGJQbVplNON+EkUbZWjDrLLJs8yDE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EBEE13D5;
	Wed,  8 Jan 2025 02:34:38 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6A03F673;
	Wed,  8 Jan 2025 02:34:06 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [RFC PATCH v2 00/15] pkeys-based page table hardening
Date: Wed,  8 Jan 2025 10:32:35 +0000
Message-ID: <20250108103250.3188419-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a proposal to leverage protection keys (pkeys) to harden
critical kernel data, by making it mostly read-only. The series includes
a simple framework called "kpkeys" to manipulate pkeys for in-kernel use,
as well as a page table hardening feature based on that framework
(kpkeys_hardened_pgtables). Both are implemented on arm64 as a proof of
concept, but they are designed to be compatible with any architecture
implementing pkeys.

The proposed approach is a typical use of pkeys: the data to protect is
mapped with a given pkey P, and the pkey register is initially configured
to grant read-only access to P. Where the protected data needs to be
written to, the pkey register is temporarily switched to grant write
access to P on the current CPU.

The key fact this approach relies on is that the target data is
only written to via a limited and well-defined API. This makes it
possible to explicitly switch the pkey register where needed, without
introducing excessively invasive changes, and only for a small amount of
trusted code.

Page tables were chosen as they are a popular (and critical) target for
attacks, but there are of course many others - this is only a starting
point (see section "Further use-cases"). It has become more and more
common for accesses to such target data to be mediated by a hypervisor
in vendor kernels; the hope is that kpkeys can provide much of that
protection in a simpler manner. No benchmarking has been performed at
this stage, but the runtime overhead should also be lower (though likely
not negligible).

# kpkeys

The use of pkeys involves two separate mechanisms: assigning a pkey to
pages, and defining the pkeys -> permissions mapping via the pkey
register. This is implemented through the following interface:

- Pages in the linear mapping are assigned a pkey using set_memory_pkey().
  This is sufficient for this series, but of course higher-level
  interfaces can be introduced later to ask allocators to return pages
  marked with a given pkey. It should also be possible to extend this to
  vmalloc() if needed.

- The pkey register is configured based on a *kpkeys level*. kpkeys
  levels are simple integers that correspond to a given configuration,
  for instance:

  KPKEYS_LVL_DEFAULT:
        RW access to KPKEYS_PKEY_DEFAULT
        RO access to any other KPKEYS_PKEY_*

  KPKEYS_LVL_<FEAT>:
        RW access to KPKEYS_PKEY_DEFAULT
        RW access to KPKEYS_PKEY_<FEAT>
        RO access to any other KPKEYS_PKEY_*

  Only pkeys that are managed by the kpkeys framework are impacted;
  permissions for other pkeys are left unchanged (this allows for other
  schemes using pkeys to be used in parallel, and arch-specific use of
  certain pkeys).

  The kpkeys level is changed by calling kpkeys_set_level(), setting the
  pkey register accordingly and returning the original value. A
  subsequent call to kpkeys_restore_pkey_reg() restores the kpkeys
  level. The numeric value of KPKEYS_LVL_* (kpkeys level) is purely
  symbolic and thus generic, however each architecture is free to define
  KPKEYS_PKEY_* (pkey value).

# kpkeys_hardened_pgtables

The kpkeys_hardened_pgtables feature uses the interface above to make
the (kernel and user) page tables read-only by default, enabling write
access only in helpers such as set_pte(). One complication is that those
helpers as well as page table allocators are used very early, before
kpkeys become available. Enabling kpkeys_hardened_pgtables, if and when
kpkeys become available, is therefore done as follows:

1. A static key is turned on. This enables a transition to
   KPKEYS_LVL_PGTABLES in all helpers writing to page tables, and also
   impacts page table allocators (see step 3).

2. All pages holding kernel page tables are set to KPKEYS_PKEY_PGTABLES.
   This ensures they can only be written when runnning at
   KPKEYS_LVL_PGTABLES.

3. Page table allocators set the returned pages to KPKEYS_PKEY_PGTABLES
   (and the pkey is reset upon freeing). This ensures that all page
   tables are mapped with that privileged pkey.

# Threat model

The proposed scheme aims at mitigating data-only attacks (e.g.
use-after-free/cross-cache attacks). In other words, it is assumed that
control flow is not corrupted, and that the attacker does not achieve
arbitrary code execution. Nothing prevents the pkey register from being
set to its most permissive state - the assumption is that the register
is only modified on legitimate code paths.

A few related notes:

- Functions that set the pkey register are all implemented inline.
  Besides performance considerations, this is meant to avoid creating
  a function that can be used as a straightforward gadget to set the
  pkey register to an arbitrary value.

- kpkeys_set_level() only accepts a compile-time constant as argument,
  as a variable could be manipulated by an attacker. This could be
  relaxed but it seems unlikely that a variable kpkeys level would be
  needed in practice.

# Further use-cases

It should be possible to harden various targets using kpkeys, including:

- struct cred (enforcing a "mostly read-only" state once committed)

- fixmap (occasionally used even after early boot, e.g.
  set_swapper_pgd() in arch/arm64/mm/mmu.c)

- SELinux state (e.g. struct selinux_state::initialized)

... and many others.

kpkeys could also be used to strengthen the confidentiality of secret
data by making it completely inaccessible by default, and granting
read-only or read-write access as needed. This requires such data to be
rarely accessed (or via a limited interface only). One example on arm64
is the pointer authentication keys in thread_struct, whose leakage to
userspace would lead to pointer authentication being easily defeated.

# This series

The series is composed of two parts:

- The kpkeys framework (patch 1-7). The main API is introduced in
  <linux/kpkeys.h>, and it is implemented on arm64 using the POE
  (Permission Overlay Extension) feature.

- The kpkeys_hardened_pgtables feature (patch 8-15). <linux/kpkeys.h> is
  extended with an API to set page table pages to a given pkey and a
  guard object to switch kpkeys level accordingly, both gated on a
  static key. This is then used in generic and arm64 pgtable handling
  code as needed. Finally a simple KUnit-based test suite is added to
  demonstrate the page table protection.

The arm64 implementation should be considered a proof of concept only.
The enablement of POE for in-kernel use is incomplete; in particular
POR_EL1 (pkey register) should be reset on exception entry and restored
on exception return.

# Performance

No particular efforts were made to optimise the use of kpkeys at this
stage (and no benchmarking was performed either). There are two obvious
low-hanging fruits in the kpkeys_hardened_pgtables feature:

- Always switching kpkeys level in leaf helpers such as set_pte() can be
  very inefficient if many page table entries are updated in a row. Some
  sort of batching may be desirable.

- On arm64 specifically, the page table helpers typically perform an
  expensive ISB (Instruction Synchronisation Barrier) after writing to
  page tables. Since most of the cost of switching the arm64 pkey
  register (POR_EL1) comes from the following ISB, the overhead incurred
  by kpkeys_restore_pkey_reg() would be significantly reduced by merging
  its ISB with the pgtable helper's. That would however require more
  invasive changes, beyond simply adding a guard object.

# Open questions

A few aspects in this RFC that are debatable and/or worth discussing:

- There is currently no restriction on how kpkeys levels map to pkeys
  permissions. A typical approach is to allocate one pkey per level and
  make it writable at that level only. As the number of levels
  increases, we may however run out of pkeys, especially on arm64 (just
  8 pkeys with POE). Depending on the use-cases, it may be acceptable to
  use the same pkey for the data associated to multiple levels.

  Another potential concern is that a given piece of code may require
  write access to multiple privileged pkeys. This could be addressed by
  introducing a notion of hierarchy in trust levels, where Tn is able to
  write to memory owned by Tm if n >= m, for instance.

- kpkeys_set_level() and kpkeys_restore_pkey_reg() are not symmetric:
  the former takes a kpkeys level and returns a pkey register value, to
  be consumed by the latter. It would be more intuitive to manipulate
  kpkeys levels only. However this assumes that there is a 1:1 mapping
  between kpkeys levels and pkey register values, while in principle
  the mapping is 1:n (certain pkeys may be used outside the kpkeys
  framework).

- An architecture that supports kpkeys is expected to select
  CONFIG_ARCH_HAS_KPKEYS and always enable them if available - there is
  no CONFIG_KPKEYS to control this behaviour. Since this creates no
  significant overhead (at least on arm64), it seemed better to keep it
  simple. Each hardening feature does have its own option and arch
  opt-in if needed (CONFIG_KPKEYS_HARDENED_PGTABLES,
  CONFIG_ARCH_HAS_KPKEYS_HARDENED_PGTABLES).


Any comment or feedback will be highly appreciated, be it on the
high-level approach or implementation choices!

- Kevin

---
Changelog RFC v1..v2:

- A new approach is used to set the pkey of page table pages. Thanks to
  Qi Zheng's and my own series [1][2], pagetable_*_ctor is
  systematically called when a PTP is allocated at any level (PTE to
  PGD), and pagetable_*_dtor when it is freed, on all architectures.
  Patch 11 makes use of this to call kpkeys_{,un}protect_pgtable_memory
  from the common ctor/dtor helper. The arm64 patches from v1 (patch 12
  and 13) are dropped as they are no longer needed. Patch 10 is
  introduced to allow pagetable_*_ctor to fail at all levels, since
  kpkeys_protect_pgtable_memory may itself fail.
  [Original suggestion by Peter Zijlstra]

- Changed the prototype of kpkeys_{,un}protect_pgtable_memory in patch 9
  to take a struct folio * for more convenience, and implemented them
  out-of-line to avoid a circular dependency with <linux/mm.h>.

- Rebased on next-20250107, which includes [1] and [2].

- Added locking in patch 8. [Peter Zijlstra's suggestion]

RFC v1: https://lore.kernel.org/linux-hardening/20241206101110.1646108-1-kevin.brodsky@arm.com/

[1] https://lore.kernel.org/linux-mm/cover.1736317725.git.zhengqi.arch@bytedance.com/
[2] https://lore.kernel.org/linux-mm/20250103184415.2744423-1-kevin.brodsky@arm.com/
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pierre Langlois <pierre.langlois@arm.com>
Cc: Quentin Perret <qperret@google.com>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: x86@kernel.org
---
Kevin Brodsky (15):
  mm: Introduce kpkeys
  set_memory: Introduce set_memory_pkey() stub
  arm64: mm: Enable overlays for all EL1 indirect permissions
  arm64: Introduce por_set_pkey_perms() helper
  arm64: Implement asm/kpkeys.h using POE
  arm64: set_memory: Implement set_memory_pkey()
  arm64: Enable kpkeys
  mm: Introduce kernel_pgtables_set_pkey()
  mm: Introduce kpkeys_hardened_pgtables
  mm: Allow __pagetable_ctor() to fail
  mm: Map page tables with privileged pkey
  arm64: kpkeys: Support KPKEYS_LVL_PGTABLES
  arm64: mm: Guard page table writes with kpkeys
  arm64: Enable kpkeys_hardened_pgtables support
  mm: Add basic tests for kpkeys_hardened_pgtables

 arch/arm64/Kconfig                    |   2 +
 arch/arm64/include/asm/kpkeys.h       |  45 +++++++++
 arch/arm64/include/asm/pgtable-prot.h |  16 +--
 arch/arm64/include/asm/pgtable.h      |  19 +++-
 arch/arm64/include/asm/por.h          |   9 ++
 arch/arm64/include/asm/set_memory.h   |   4 +
 arch/arm64/kernel/cpufeature.c        |   5 +-
 arch/arm64/kernel/smp.c               |   2 +
 arch/arm64/mm/fault.c                 |   2 +
 arch/arm64/mm/mmu.c                   |  28 ++----
 arch/arm64/mm/pageattr.c              |  21 ++++
 include/asm-generic/kpkeys.h          |  21 ++++
 include/asm-generic/pgalloc.h         |  15 ++-
 include/linux/kpkeys.h                | 112 +++++++++++++++++++++
 include/linux/mm.h                    |  27 ++---
 include/linux/set_memory.h            |   7 ++
 mm/Kconfig                            |   5 +
 mm/Makefile                           |   2 +
 mm/kpkeys_hardened_pgtables.c         |  44 +++++++++
 mm/kpkeys_hardened_pgtables_test.c    |  72 ++++++++++++++
 mm/memory.c                           | 137 ++++++++++++++++++++++++++
 security/Kconfig.hardening            |  24 +++++
 22 files changed, 576 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm64/include/asm/kpkeys.h
 create mode 100644 include/asm-generic/kpkeys.h
 create mode 100644 include/linux/kpkeys.h
 create mode 100644 mm/kpkeys_hardened_pgtables.c
 create mode 100644 mm/kpkeys_hardened_pgtables_test.c


base-commit: 7b4b9bf203da94fbeac75ed3116c84aa03e74578
-- 
2.47.0

