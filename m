Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69253DF006
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794261; cv=none; b=Bggp974VbpXYkILUhtaQFXYkYC3F2WBBQYsB2/a6k3UfqcV3AeAabbxlAvuy7koq32C8+1j94COXByahMdVWFzpBU0BLI5prbgVCGib3Yhj+ByaZWai1Sy6VXQw1PPS6AVSjmGQ/GZa73J1kGrJSv/auQDfaJb0x+6JRtZTh5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794261; c=relaxed/simple;
	bh=g5SIlfhNFVkGHqg4H9aglJHNTgTJdaH8G/qaojIJDnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wljo5NLNFKxBCKUJeKISmxQqr7gWq9wB4TocGSQdxv1jweJcHsO5/n5eGCCrKeHJJdM/Y546gsTB18F14NOVE24d/Z31lmCIipFXQ5IkJOoLHGBAbPeQONoRCJOZ6RMHqGSR4XkEEJjsIy4dUzZdfgRN/GBazVJGYwd0fyCDGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fi+UYaEU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fi+UYaEU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24AD8169C;
	Tue, 26 May 2026 04:17:34 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56D133F7D8;
	Tue, 26 May 2026 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779794259; bh=g5SIlfhNFVkGHqg4H9aglJHNTgTJdaH8G/qaojIJDnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fi+UYaEUI3ApllTrH+WrLvAM4f0KPGB9ULkC7CRHLYRvBGxLjCI3am8deLBrDJnoI
	 psOMxzYECWd5moN7XVrVApszsdb2OyHG/qOWJeiRdhZqeY7fLZYcOap+VENpMo8ai0
	 AlfXf1zM7i+XN0JkdtLCFK7q/9miEXIIWfMQxfys=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 26 May 2026 12:15:57 +0100
Subject: [PATCH RFC v8 08/24] arm64: Initialize POR_EL1 register on
 cpu_resume()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-kpkeys-v8-8-eaaacdacc67c@arm.com>
References: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
In-Reply-To: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
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
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779794212; l=1238;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=X72DCdJX2SxlqX4hafcg68D9WxF9xj/CvQA2EQYYzDc=;
 b=xTqK9y0/jfN6rkxWDlafJT2Opd2CvHu41k45n5VTUfNU5mVSqsubT5frcWIwDYbLHbHAM1udS
 SU7qCdKiicNC9JxB02tTDLd6gkulMR5AFGVMO5fVIu4p1YIXdwXjz6H
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
2.51.2

