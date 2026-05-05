Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649647D93A
	for <linux-hardening@vger.kernel.org>; Tue,  5 May 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997293; cv=none; b=aJTAeH2TClbRLi6sjs0P81XEeFf1IjI8FUJEreCqSevtLGA/NiEuTaZHQTNawF74pqH8eyEyCX8DPxp0y5gN0FSeac9vmtjUqRBU99sSe7F/hSwYl1cXpSG9Bb/m5O/RA6mwOh6eSxRJCj70R9uJMkSERftfMaLRFycLykY2Ymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997293; c=relaxed/simple;
	bh=vINnrx3zWSjR/6habDkgMgD8LqwrfTQUOR9ysKRLj5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9WdJiLE8ow2kc4/LGfvwYA8JL0difEGc0EC5znFKH78FJBZxovRhmQo7Rr6f9CI7efWSgGSwBZSHzXglKoljwn1UtHFh9N72gCy+a1Ek7LuMk3Y/k5U721DHbE+zOqM1CnHoB8mgrQelRYrYNS1gMBVyS7C5yKZ74QAytXfs/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sz1by1e6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sz1by1e6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CA2414BF;
	Tue,  5 May 2026 09:08:06 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96D743F763;
	Tue,  5 May 2026 09:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777997291; bh=vINnrx3zWSjR/6habDkgMgD8LqwrfTQUOR9ysKRLj5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sz1by1e6eRhCELKEY+Eyq+rsTuniaXf5+PqT1X0yQjZIReJ6Gn5u8T9Go+2W19DZ0
	 raHdjjPsdL4frdLCpTofS2QdrvQAAIRb1YoQDErymK5RqV/u7JS+71Nyan7jKhDCQ9
	 gLo7S1Or5aq6f9fM8+yiKuhAEZ2gcih3LDnAGiC4=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 05 May 2026 17:06:04 +0100
Subject: [PATCH RFC v7 15/24] mm: kpkeys: Introduce hook for protecting
 static page tables
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-kpkeys-v7-15-20c0bdd97197@arm.com>
References: <20260505-kpkeys-v7-0-20c0bdd97197@arm.com>
In-Reply-To: <20260505-kpkeys-v7-0-20c0bdd97197@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
 Yang Shi <yang@os.amperecomputing.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777997220; l=1755;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=vINnrx3zWSjR/6habDkgMgD8LqwrfTQUOR9ysKRLj5A=;
 b=urhbr3eEotRkuf/VqGLzk0z6RAzpgYY8gl0kZHrHnrAINYjJtkYR1qbJSvZ0vXWCYj6mSlhWU
 aFlEW0GDkSuDNt6LxoaJCvAZ3wrc1GrmM9zW197X5jDBxuHt+bxXaM5
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The kpkeys_hardened_pgtables infrastructure introduced so far allows
compatible architectures to protect all page table pages (PTPs)
allocated at runtime (first via memblock, then the buddy allocator).
Some PTPs are however required even earlier, before any allocator is
available. This is typically needed for mapping the kernel image
itself.

These PTPs are at least as sensitive as those allocated later on,
and should be protected by mapping them with the privileged pkey.
Exactly how these pages are obtained is entirely arch-specific, so
we introduce a hook to let architectures that implement
kpkeys_hardened_pgtables do the right thing.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/kpkeys.h        | 4 ++++
 mm/kpkeys_hardened_pgtables.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
index 544a2d954bc1..3f7f980f3a7c 100644
--- a/include/linux/kpkeys.h
+++ b/include/linux/kpkeys.h
@@ -142,6 +142,10 @@ void kpkeys_hardened_pgtables_init(void);
 
 phys_addr_t kpkeys_physmem_pgtable_alloc(void);
 
+#ifndef arch_kpkeys_protect_static_pgtables
+static inline void arch_kpkeys_protect_static_pgtables(void) {}
+#endif
+
 #else /* CONFIG_KPKEYS_HARDENED_PGTABLES */
 
 static inline bool kpkeys_hardened_pgtables_enabled(void)
diff --git a/mm/kpkeys_hardened_pgtables.c b/mm/kpkeys_hardened_pgtables.c
index c7a8935571ac..9c6f32741009 100644
--- a/mm/kpkeys_hardened_pgtables.c
+++ b/mm/kpkeys_hardened_pgtables.c
@@ -66,6 +66,7 @@ void __init kpkeys_hardened_pgtables_init(void)
 	static_branch_enable(&kpkeys_hardened_pgtables_key);
 
 	ppa_finalize();
+	arch_kpkeys_protect_static_pgtables();
 }
 
 /*

-- 
2.51.2

