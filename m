Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240078;
	b=YH2+lUjR8ydJU3yroa4D1KBuI1GgNJnUTMlH6B2uA74oR1AEbPrF24XwG55efkRBXKNl
	 gnizScS2jsCJ/hRm74t8+G4WxLMNyikeJDnAxxeZA+j4/PmMZN+z7Ch39DFSesIWdti1K
	 nWUyXKaxQvInpll1skxXscftTtZAPYawXMVzPbuP0LmNr33C76jVRNLjUvQ8dVPCpl/Nl
	 lfNassIYzK/TCM1z8urzKCfF6SCUs+beENyZPt56XtlrE9fvaj161UqBY0tfQEBUlh0JE
	 +MGYv7q3Y0WNhM7qwDpHPkhHWUisfG9Etd52tfEC0Uc4/wHBv2OLcPpo3du76+HPjWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240078;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=n+IvwUbalMB+lMEj2xh+/SJ+ZMqnlHDeMyWsUhxMutY=;
	b=Yxa0/Z4oPrAPh3FKQE8i3c6U+qThSgp9oo+7gKNFE2w09TjIgZCffb/aTWCloRk0yY2S
	 p2KJBvcOgsnRuvpjoAw0eAG5g8j9zYCXR1vUNd1ZmxoIHB5aYcbZCDAVbrwNPzoozaiUG
	 bgPu6hLiB5ZL4pWxr+wjsKnPlwYgZJ//qXAgcTpYJf9W6+1VpyeNDFWOfkw3JvUfK/ftk
	 2hTiZCDYftliXJVE27Y4L+AUCrpTGznSpTtSOjyrz1Ld/pEUBF6weLF8doZyOWt8AizbC
	 9G9EYkUh4WKlh2nUwdO0oXkmfrvSV8HiVFRqW5fPyjsv+BiHI7jRTzgSQzhFWwUjKtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UM9ZY938;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4854D6083617;
	Mon,  9 Nov 2026 16:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4854D6083617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UM9ZY938
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 954E21516;
	Mon,  9 Nov 2026 08:01:13 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BADC63F632;
	Mon,  9 Nov 2026 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240076; bh=69XjZGmtQpsQiw/RLc3kshkLffGbawQIbdoKaGDZULE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UM9ZY938suJnPaezt9DwztK24sCh6xVc8bxvjH925gRZ5QpwvdBF5JlzN9zILAnWt
	 75X067qjHkhks/llchFRr+0huGUhyju5W3N9EkRLbyXWCUzLymQZBQpxz+W3aVedGN
	 F9h9DhG1c3UN4l5xtCx4daM2U7r1KlKGW3NJWVdY=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:33 +0000
Subject: [PATCH RFC v10 08/22] arm64: Context-switch POR_EL1
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
Message-Id: <20261109-kpkeys-v10-8-aa6c4d9603bc@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=2136;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=69XjZGmtQpsQiw/RLc3kshkLffGbawQIbdoKaGDZULE=;
 b=5odrr2x68jCwQ+LojjKcXp9Zj53vS8pkd5Cr3SnsGrCwJYb2HeRqZVwI5XXSiJQI8HwY8d7kY
 BjKw/bkeILzDFc0crCchfxBG8yFGXa1Y5sKvtR8hH9jveFSPJe6gfkG
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

POR_EL1 is about to be used by the kpkeys framework, modifying it
for (typically small) sections of code. If an exception occurs
during that window and scheduling occurs, we must ensure that
POR_EL1 is context-switched as needed (saving the old value and
restoring the new one). An ISB is needed to ensure the write takes
effect, so we skip it if the new value is the same as the old, like
for POR_EL0.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Linu Cherian <linu.cherian@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/kernel/process.c        | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 481f1999f7c1..18424d91d8b2 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -195,6 +195,7 @@ struct thread_struct {
 	u64			svcr;
 	u64			tpidr2_el0;
 	u64			por_el0;
+	u64			por_el1;
 #ifdef CONFIG_ARM64_GCS
 	unsigned int		gcs_el0_mode;
 	unsigned int		gcs_el0_locked;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 42b15b0c069f..a3984aedfebe 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -51,6 +51,7 @@
 #include <asm/exec.h>
 #include <asm/fpsimd.h>
 #include <asm/gcs.h>
+#include <asm/kpkeys.h>
 #include <asm/mmu_context.h>
 #include <asm/mpam.h>
 #include <asm/mte.h>
@@ -446,6 +447,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 	ptrauth_thread_init_kernel(p);
 
+	if (system_supports_poe())
+		p->thread.por_el1 = POR_EL1_INIT;
+
 	if (likely(!args->fn)) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
@@ -698,6 +702,12 @@ static void permission_overlay_switch(struct task_struct *next)
 		 * of POR_EL0.
 		 */
 	}
+
+	current->thread.por_el1 = read_sysreg_s(SYS_POR_EL1);
+	if (current->thread.por_el1 != next->thread.por_el1) {
+		write_sysreg_s(next->thread.por_el1, SYS_POR_EL1);
+		isb();
+	}
 }
 
 /*

-- 
2.56.0

