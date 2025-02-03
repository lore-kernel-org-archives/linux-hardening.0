Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCE620011F;
	Mon,  3 Feb 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578510; cv=none; b=DYjyx/9Pkj/mcNEnwTz4gvyeBfTyAE8HZQ+2BlFaf2POPQ4K6sRKWvget1/oT53vgY8N1aFBPruUMTVz87zPddu06ULTEQVDOlgP53Sp+AjW/zkUI6yrIF8EhXLH4TLTtnDGtzw5smpPA+2nHQz3uLr+GmaDje6U+uJS98st+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578510; c=relaxed/simple;
	bh=nndbetBnx656EtX9iQmko8tW9FJvoGALvcKDMFN5czM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IDXXLoAPVx7KKRIvsrFFxNIuZjtS9z76JiR15psFvRjJqUXbUiE/w1GvPQ5doUzT0vThfLBWP3VjVTLGwbM0ngCheVsuIEyuh0ghdcWbdi2WjSUugpAHBMyuwaJwuYp7qE7im19xDyeymsedt7hicfDB9iUiJlP4GKjRhOhF9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9997611FB;
	Mon,  3 Feb 2025 02:28:51 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6890F3F63F;
	Mon,  3 Feb 2025 02:28:23 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Howells <dhowells@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
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
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [RFC PATCH 0/8] pkeys-based cred hardening
Date: Mon,  3 Feb 2025 10:28:01 +0000
Message-ID: <20250203102809.1223255-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims at hardening struct cred using the kpkeys
infrastructure proposed in [1]. The idea is to enforce the immutability
of live credentials (task->{creds,read_creds}) by allocating them in
"protected" memory, which cannot be written to in the default pkey
configuration (kpkeys level). Code that genuinely requires writing to
live credentials, such as get_cred(), explicitly switches to a
privileged kpkeys level, enabling write access to the protected mapping.

The main challenge with this approach is to minimise the disruption to
existing code. Directly allocating credentials in protected memory would
force any code setting up credentials to switch kpkeys level. Instead,
we use the fact that commit_creds() "eats" the caller's reference,
meaning that the caller cannot use that reference after calling
commit_creds(). This allows us to move the credentials to a new location
in commit_creds(): prepare_creds() still allocates them in regular
memory, and commit_creds() moves them to protected memory (that is
memory mapped with a non-default pkey). This ensures that *live*
credentials are protected, without affecting users of commit_creds().

The situation isn't as simple with override_creds(), as the caller may
(and often does) keep using the reference it passed. In this case, the
caller should explicitly call a new helper, protect_creds(), to move
the credentials to protected memory. This seems to be the most robust
approach, and the number of call sites to amend looks reasonable (patch
7 covers the most important ones). No failure should occur if a call
site is missed; the credentials will simply be unprotected.

In order to allocate credentials in protected memory, this series
introduces support for mapping slabs with a non-default pkey, using the
SLAB_SET_PKEY kmem_cache_create() flag (patch 3). The complexity is kept
minimal by setting the pkey at the slab level; it should also be
possible to do this at the page level, but it isn't immediately obvious
where the pkey value could be stored in struct page - especially since
we've almost run out of GFP flags.

Most of the cover letter for the original kpkeys series [1] is relevant
to this series as well. In particular, the threat model is unchanged:
the aim is to mitigate data-only attacks, such as use-after-free. It is
therefore assumed that control flow is not corrupted, and that the
attacker does not achieve arbitrary code execution.

The most significant caveat in this RFC is RCU handling. Storing struct
cred in memory that is read-only by default would break RCU without
special handling, as it needs to write to cred->rcu (to zero out the
callback field, for instance). There is currently no efficient way for
RCU to know whether the object to be freed is protected or not, and
executing the whole of RCU at a higher kpkeys level would imply running
RCU callbacks at that level too, which isn't ideal (a callback could be
exploited to write to protected locations). The current approach (patch
4) therefore switches kpkeys level whenever any struct rcu_head is
written to. This is safe, but the overhead is likely to be unacceptably
large. Ideally, RCU would be able to tell if a struct rcu_head resides
in protected memory, maybe using a flag - it isn't clear where that flag
could be stored though.

Other performance-related caveats:

* In many cases, the use of guard objects to obtain write access to
  protected data is nested: a function holding a guard calls another
  that will also create a guard object. This seems difficult to avoid
  without heavy refactoring. With the assumption that writing to the
  pkey register is expensive (which is the case at least on arm64/POE),
  patch 1 mitigates the cost by skipping the setting/restoring of the
  register if the new value is equal to the current one, as is the case
  when guards are nested.

* Because a struct cred may be freed before being ever installed,
  put_cred_rcu() may be operating on an object that is located either
  in regular or protected memory. This is handled by looking up the slab
  containing the object and checking if its flags include SLAB_SET_PKEY.
  The overhead is hopefully acceptable on that path, but the approach is
  not particularly elegant.

* Similarly, put_cred(), get_cred() and other helpers may be called on
  unprotected objects. Those helpers however create a guard object
  unconditionally if they need to write to the credentials. It is
  unclear whether skipping the guard for unprotected objects would give
  a performance uplift, as this depends on the cost of checking if an
  object is protected or not.

* It is assumed that calling arch_kpkeys_enabled() is cheap, as multiple
  guards are conditional on that function. (This boils down to a static
  branch on arm64, which should indeed be cheap.)

This series applies on top of v6.14-rc1 + the kpkeys RFC v3 [1] + a
cleanup patch for SLAB flags [2]. A next step will be to estimate the
performance impact of the kpkeys-based features (page table and struct
cred hardening); no benchmarking has been performed at this stage.

Any comment or feedback will be highly appreciated, be it on the
high-level approach or implementation choices!

- Kevin

[1] https://lore.kernel.org/linux-hardening/20250203101839.1223008-1-kevin.brodsky@arm.com/
[2] https://lore.kernel.org/lkml/20250124164858.756425-1-kevin.brodsky@arm.com/
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
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
Cc: linux-mm@kvack.org
Cc: x86@kernel.org

Kevin Brodsky (8):
  arm64: kpkeys: Avoid unnecessary writes to POR_EL1
  mm: kpkeys: Introduce unrestricted level
  slab: Introduce SLAB_SET_PKEY
  rcu: Allow processing kpkeys-protected data
  mm: kpkeys: Introduce cred pkey/level
  cred: Protect live struct cred with kpkeys
  fs: Protect creds installed by override_creds()
  mm: Add basic tests for kpkeys_hardened_cred

 arch/arm64/include/asm/kpkeys.h |  14 ++-
 fs/aio.c                        |   2 +-
 fs/fuse/passthrough.c           |   2 +-
 fs/nfs/nfs4idmap.c              |   2 +-
 fs/nfsd/auth.c                  |   2 +-
 fs/nfsd/nfs4recover.c           |   2 +-
 fs/nfsd/nfsfh.c                 |   2 +-
 fs/open.c                       |   2 +-
 fs/overlayfs/dir.c              |   2 +-
 fs/overlayfs/super.c            |   2 +-
 include/asm-generic/kpkeys.h    |   4 +
 include/linux/cred.h            |   6 ++
 include/linux/kpkeys.h          |  16 ++-
 include/linux/slab.h            |  21 ++++
 kernel/cred.c                   | 178 +++++++++++++++++++++++++++-----
 kernel/rcu/rcu_segcblist.c      |  10 +-
 kernel/rcu/tree.c               |   4 +-
 mm/Kconfig                      |   2 +
 mm/Makefile                     |   1 +
 mm/kpkeys_hardened_cred_test.c  |  42 ++++++++
 mm/slab.h                       |   7 +-
 mm/slab_common.c                |   2 +-
 mm/slub.c                       |  58 ++++++++++-
 security/Kconfig.hardening      |  24 +++++
 24 files changed, 361 insertions(+), 46 deletions(-)
 create mode 100644 mm/kpkeys_hardened_cred_test.c

-- 
2.47.0

