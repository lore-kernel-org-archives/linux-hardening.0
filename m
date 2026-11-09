Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240072;
	b=aLH7+I4UywEkZf0/4R9sQNKLKA359yAxG0upypWgVWBFSP7pzKjUr1Av/0Iyd6g7yrvo
	 5/lHqITcQJpL8xoKA4sBs7j0o8PxDXTU13m2NS0xrKr8X69VoqI6JK+FotP2ToWjTwcoE
	 m+8Vr63QQxlHFbzYaPoBNUGHJFu9sXaJBqDLY8KFX8pHOr+Ofacrev1jFvoxy3mhU9B6M
	 B5eSi9IzfAAxxMAtz70Hf4/wtq8sAiWVm35TQmrEg/DGhyZ5e7F3JMZCV8pvBRsHiTK1n
	 ESOnMUAGIbGYXQPp+AHIlYvZ58EsDLvKxwaKo4LzZSV981tDUjNcX/A7mg+8IH1bXfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240072;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=btt91I3qkVKycKN2iTEdAlTvCKoqHGuYdHT3imsqzq4=;
	b=HaZVpATmI2MBcP15D7acgwh1QgI3PHFjQRf+O8TznHTlp0groTX0eOMwu/lgdMVmYUTo
	 F7gBbA7MFtmmEFzxw4x9RcY5d9bqkUIR3b16OWyjyGVmQOS2Rz8UJeIXQWMe8/POfMV4U
	 sOVWg/iZvbm1+BmzCZtg4hqhKLRe2h7rNCLL3Xm70pxDrbSCXH3ku7n9OqFIexSwc8ZJQ
	 6DZrxhwmT4NdozGpKFGStQHScIbPtVLKg9YmBJ4w0qBu+UD2d52BODml5mO4fchvWD3sc
	 d9Tofw9RvIHoCQavUV9MhsJF6WmbD4pxOj1iwJ6zTj0DBnLmTTu5nsrRAkdzi2puhuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TlZPPpIu;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7F1606EEB3;
	Mon,  9 Nov 2026 16:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C7F1606EEB3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TlZPPpIu
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6469014BF;
	Mon,  9 Nov 2026 08:01:08 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 834683F882;
	Mon,  9 Nov 2026 08:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240071; bh=mOcsxuhd+SBVwiebOzIYBEP81ioeefXUqmJIoRAwM7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TlZPPpIuSAP4I+z+O/V0g8YhQgOIXJl6Swij87O2nM0jC0yFMqzP4RnfBDhA0K2Np
	 zmenIGRDNNxgb7EkMlF/p+DzoptibtBufaC0+Z5nwO7L9q+HCuGpXOjPZRSyhynVh1
	 hhvLy4QHJR7+kuEIs/mMW0IpVln0Rc0+cAtMCVYk=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:32 +0000
Subject: [PATCH RFC v10 07/22] arm64: Initialize POR_EL1 register on
 cpu_resume()
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-kpkeys-v10-7-aa6c4d9603bc@arm.com>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
In-Reply-To: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ard Biesheuvel <ardb+git@google.com>, Andy Lutomirski <luto@kernel.org>, 
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
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
 Ira Weiny <iweiny@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=1238;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=4EcOfPYkS35WfcSTzCjV7Pft44Nt32DKIqSeTlSaAlM=;
 b=aF1hedIOdeeWnADYrxt7bKksACglTWRg1rdNE6Tt2euac3s0EchtRVpNYwIndfJ4IH5PknKuN
 icAYPbNLp7LAakUjUWc2ZYtxrMWslhblR5VgrliKrZYqBjuZmpAYHAn
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

From: Yeoreum Yun <yeoreum.yun@arm.com>

The POR_EL1 register is reset to an unknown value after cpu_suspend().
Since POR_EL1 always holds POR_EL1_INIT when entering cpu_suspend(),
initialize POR_EL1 with POR_EL1_INIT before cpu_do_resume().

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/kernel/sleep.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index f093cdf71be1..e0a6ad85cd24 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -3,6 +3,7 @@
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
+#include <asm/kpkeys.h>
 #include <asm/smp.h>
 
 	.text
@@ -134,6 +135,17 @@ SYM_FUNC_START(_cpu_resume)
 	/* load sp from context */
 	ldr	x2, [x0, #CPU_CTX_SP]
 	mov	sp, x2
+
+#ifdef CONFIG_ARM64_POE
+alternative_if_not ARM64_HAS_S1POE
+	b	.Lskip_por_set
+alternative_else_nop_endif
+	mov_q	x2, POR_EL1_INIT
+	msr_s	SYS_POR_EL1, x2
+	/* isb can be skipped since cpu_do_resume() will do it. */
+.Lskip_por_set:
+#endif /* CONFIG_ARM64_POE */
+
 	/*
 	 * cpu_do_resume expects x0 to contain context address pointer
 	 */

-- 
2.56.0

