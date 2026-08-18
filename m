Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13022478E20
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062403; cv=none; b=Gd8NMu8vDrh85gqNeTVV4KjnKCPqURMzOU1UM+H41zYiKfN5vL/d6DppsOMQp6EThODpDiFjLqvDWAWQKf8CRFAZ1v3BDy9JZPZEa4mEU5HvArVUDsUi26sPN4RwHDS8lj/2+8fUs2hLn6NghTHUtmRncvA8AfXZ/TG1aW+n6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062403; c=relaxed/simple;
	bh=deqcIO8WoW8ZUIxodPxPJxHyzGgyRHFEpIWwkIpsoHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n3pPFT/Xi8hebCnedoJiX2J6bRjTnFx/jcFVNogIEngeLffwKHpQQUpQvOLDOlmh3+a0Mhr+dn9a180k2OoREAouMP1B+oYHnB9VP/l70FM16q2azDYJS58HeLD+gIy2q7gAJ9q035GkphlQoNPSF//KLfBGeG3USap6C82eR3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wakfnd/j; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wakfnd/j"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB94D1A00;
	Tue, 18 Aug 2026 07:13:17 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E704D3F85F;
	Tue, 18 Aug 2026 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787062401; bh=deqcIO8WoW8ZUIxodPxPJxHyzGgyRHFEpIWwkIpsoHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wakfnd/jp0XFaEXDa8GOOOrShfuIESM4+0taZqqVMIl02MEpCgGw14EgqvvyL5yBG
	 o1+mk+qzVPuL8Rd9ieuL3fbg0f2zvcr1KENhYiYcPUpj9JoXCujFcnK0U/7B5OsrvO
	 mUs3g3DyPckWZwcg7iQ2BnXyxqiVKdropvzuz4AY=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 18 Aug 2026 15:09:06 +0100
Subject: [PATCH RFC v9 24/25] arm64: kpkeys: Enable
 kpkeys_hardened_pgtables support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-kpkeys-v9-24-743ad31b2c8f@arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
In-Reply-To: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>, 
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787062277; l=1336;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=deqcIO8WoW8ZUIxodPxPJxHyzGgyRHFEpIWwkIpsoHY=;
 b=8Zvb9dgw8pGXz4V0LB4l31N6PHQBF1+79rdAlXKfUMt8pwgyVAcEZlljLDnHbeenNl7hIsZ2G
 qM+wAXlkOfZBjrezKjv9TZqt0L6GYTtrJd9TeNXf9l835YTjNO5ekJ9
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The kpkeys_hardened_pgtables feature needs to be initialised as soon
as the buddy allocator becomes available. The canonical place to
handle this is mem_init().

With that done, all the bits are in place and we can advertise
support for kpkeys_hardened_pgtables by selecting
ARCH_HAS_KPKEYS_HARDENED_PGTABLES if ARM64_POE is enabled.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/Kconfig   | 1 +
 arch/arm64/mm/init.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0afa085c66be..ac9faec1a018 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2203,6 +2203,7 @@ config ARM64_POE
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
 	select ARCH_HAS_KPKEYS
+	select ARCH_HAS_KPKEYS_HARDENED_PGTABLES
 	help
 	  The Permission Overlay Extension is used to implement Memory
 	  Protection Keys. Memory Protection Keys provides a mechanism for
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 97987f850a33..7985045875cf 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -386,6 +386,7 @@ bool page_alloc_available __ro_after_init;
 void __init mem_init(void)
 {
 	page_alloc_available = true;
+	kpkeys_hardened_pgtables_init();
 	swiotlb_update_mem_attributes();
 }
 

-- 
2.51.2

