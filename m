Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2924E241C8C
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062368; cv=none; b=N9qdVP685Co7AV2RTtMTzX82YzOoc1joLnVP8/cUTG+5v/8i7XkRs7t1zoaNUV9n+grLXg+wUtRTqFCoeMSi85jtExkvRzElY2K/IgHyUl/B+1EwL9RX66hEpyPZFY914pvHcbclnQmb13F7xfGrAodwri8ylKPo0onJH4bkOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062368; c=relaxed/simple;
	bh=iuHkFnsaX/6Wt0s3WtH1IONd8/3ory872W49q7NS7GI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gtAAo5hPTYGdB5Ac/Ph4ZfgW+n+7yYwNLabsgz7bSn6HHRF5HD6Qk92jSqi+svVlvtK/6B88Ogh0KVlcelhczrUBeojLyYsZs+P60CJfohUoMa7JS76aTIjoDI//avMnKszIUj1rNr0q3tWX+q+4gSDRUl6OkxjSnP4vGXfPU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=P2m3rdwp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P2m3rdwp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D16B019F6;
	Tue, 18 Aug 2026 07:12:42 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18F7D3F85F;
	Tue, 18 Aug 2026 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787062366; bh=iuHkFnsaX/6Wt0s3WtH1IONd8/3ory872W49q7NS7GI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P2m3rdwpn8gldKYtBm8KL2r4oRsqWcL6F4o9V4G1tHbB9srkk9vFA0BAp6B/ip/Bf
	 DhMaQ6Xxpn03eOKwneq4rpz1kt+g3ozd9u+VJVAa0N1WDaGpub4I3T6nYdFSt9Gy87
	 3AS/bnhvOioX+O6k5Rh1LreS5iCGqFFulLtL87RQ=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 18 Aug 2026 15:08:59 +0100
Subject: [PATCH RFC v9 17/25] arm64: kpkeys: Support KPKEYS_CTX_PGTABLES
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-kpkeys-v9-17-743ad31b2c8f@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787062276; l=1174;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=iuHkFnsaX/6Wt0s3WtH1IONd8/3ory872W49q7NS7GI=;
 b=gQpjqvXD2ZEiIo5C/DaU185kZh9RB40StHJQpTmYLw+oVULaoiCKxWBhlNqsVRUbfAHBBpWZ5
 ky64mKf7BofAZgocHn4n2s+Xwk7Tk0745d4hmHnkcMMlGVjYgkG/UC+
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Enable RW access to KPKEYS_PKEY_PGTABLES (used to map page table
pages) if switching to KPKEYS_CTX_PGTABLES, otherwise only grant RO
access.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 284039e9a244..00e7e5956794 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -12,7 +12,8 @@
  * Equivalent to por_set_kpkeys_context(0, KPKEYS_CTX_DEFAULT), but can also be
  * used in assembly.
  */
-#define POR_EL1_INIT	POR_ELx_PERM_PREP(0, POE_RWX)
+#define POR_EL1_INIT	(POR_ELx_PERM_PREP(0, POE_RWX) | \
+			 POR_ELx_PERM_PREP(KPKEYS_PKEY_PGTABLES, POE_R))
 
 #ifndef __ASSEMBLY__
 
@@ -33,6 +34,8 @@ static inline bool arch_supports_kpkeys_early(void)
 static inline u64 por_set_kpkeys_context(u64 por, enum kpkeys_ctx ctx)
 {
 	por = por_elx_set_pkey_perms(por, 0, POE_RWX);
+	por = por_elx_set_pkey_perms(por, KPKEYS_PKEY_PGTABLES,
+				     ctx == KPKEYS_CTX_PGTABLES ? POE_RW : POE_R);
 
 	return por;
 }

-- 
2.51.2

