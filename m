Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020FD33D4E2
	for <linux-hardening@vger.kernel.org>; Tue,  5 May 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997329; cv=none; b=f5zwhWiPKIsKArSMG8OTjSBSUQfWHYIdXwelFQoCeMrZRaWKjyUDlI39GQsea3/Aczv9EWRS+G88MAdw946RqGoi9Rhaus9MVFbA6rsYjkriP7XjqodqowNlNd74Ld2cvtDr8KBBQyU/SXL5aCe7N3Z3iGtVJkinUYy2Tvft5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997329; c=relaxed/simple;
	bh=XtqotHlvxdKu6c1pkEmCr60+1y0cB/ILuH7HTvPuXjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJ31TvUYYd+TFXBrtan3Y3Ssyt33t7RqbFjk0aLYOifIzt57OqZresorLM26zUqwrAOwjLmhxpGge9Dny1X551n/MX8X+otrx5gITNaZBZsohtYf/DLSzxPxG/pGp3mvks9RzgUSU9JNrTgc60ZJUp5SWn+OK4OYlRRH4xr3bkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=luXYCNaz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="luXYCNaz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E98B114BF;
	Tue,  5 May 2026 09:08:41 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E6213F763;
	Tue,  5 May 2026 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777997327; bh=XtqotHlvxdKu6c1pkEmCr60+1y0cB/ILuH7HTvPuXjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=luXYCNazICc3tK6Lo75rwne6t5UDBAIT/GSy+kZtqZUQSSE+SVirz/40QTelJkaZH
	 JkYWQ7dTpIHd4QSAHQkyPD4tmU4aSFtVOzU4Qw9hg5SZ3yxDqLMi12/J4NzwvaWuli
	 Q50N8srUXZ+PY0p0gwMmTpE+ZFjErQD3dNlgJVHg=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 05 May 2026 17:06:12 +0100
Subject: [PATCH RFC v7 23/24] arm64: kpkeys: Enable
 kpkeys_hardened_pgtables support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-kpkeys-v7-23-20c0bdd97197@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777997220; l=1336;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=XtqotHlvxdKu6c1pkEmCr60+1y0cB/ILuH7HTvPuXjw=;
 b=K2Hh5ueB1qxUS4zdYcT6VsETD5dVbzMYDFrOcezoE2+rc8YHsqgE1mD0JpP0LvBzLWt4INwPH
 FdSpumdToMxA5c8hwuqM1w/44U4enD9R0cEYEWjqIAXB1BF6Z84tYVy
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
index ab06324a50ae..43d3ab744535 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2146,6 +2146,7 @@ config ARM64_POE
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

