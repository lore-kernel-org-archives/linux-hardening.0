Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB5443CAE;
	Thu,  8 Jan 2026 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864523; cv=none; b=g+YmFq39pczsKpfKaMtb4aHtz0UHsfL0k944YXMOt2iScpeInH1V9ZPoUzONrklZxKfwdn8nClkZqPhaCll2yTEfTPmPUZOfnkbjDHi9LKzQG7REewqFpnT6/f+swrBeZCz3LHd4yKoYRR7lGmHngFkSir/Dh/cCwsW7yqPQ0P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864523; c=relaxed/simple;
	bh=bpSLYp7XpHWabHOuGWxPQHhBYa5mB/Z2Nl1nh/H2Kwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GudJMCxNjuX393MLeimfSeCv31IsPKjmzKbbR9L39G7vW0CZ9R007LW2xAn82L78SnICsIHOW75STFzJHzWIJ3GpSfRikcd8sqe9eGST44Z4TUNYZ84ebDr0vc/hCtX+jZcoSKFSd/j3dGlstu+zLCywsiYcOniYb1WflbNWsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqZNnF1s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqZNnF1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB7CC19421;
	Thu,  8 Jan 2026 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864523;
	bh=bpSLYp7XpHWabHOuGWxPQHhBYa5mB/Z2Nl1nh/H2Kwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqZNnF1slLo3Axq/G/d2YKNvL1wn6cFtsiv8dlEwG2SasZU3wx3NsXDu8KqCJAtiw
	 CvMQW5tAMMCV32o4pS+F3k30lJsBqahp4MzBx8/Rk2YNNR6hmcll2DA1wJK1aBk+h/
	 XtIPSiG6P1lAPzFO5PcIai3QOp2Oxkj+4e+bxYfFFego7VwwWNfEMU5VduJ9fiF9kJ
	 XDYfdoc1/wWFwtOQDECXXmiNto4Ca6ufi+9SAaQMj/82ddOmEsd+/PmL1IoqNUJzdU
	 9FGHkN7AvbAvO2gPce38IORUABhcpL3geN+3WxbnS0Ni8suTaQ2o1Qi7Vnw0dgRavY
	 fZ3GF8Xu9V6Ng==
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
Subject: [RFC/RFT PATCH 17/19] x86/head64: Avoid absolute references in startup asm
Date: Thu,  8 Jan 2026 09:25:44 +0000
Message-ID: <20260108092526.28586-38-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510; i=ardb@kernel.org; h=from:subject; bh=bpSLYp7XpHWabHOuGWxPQHhBYa5mB/Z2Nl1nh/H2Kwc=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+Qi5T13rPBbOnk3ZrNbrqn2+eNHFZuM43h/LVmvO/r JvMLu7UUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayZibDP0Mbr3ULb7t7hcYo 8z1t35p+O4MvL2LljA82xjxBjScNLBgZtu/ckWgS9GG99GTjfIZDRXNNtu3tkOn85JQcY6T9Mo6 TGwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Replace a couple of occurrences of absolute references with RIP-relative
ones. This removes the need for boot-time fixups. This is a prerequisite
for PIE linking, which only permits 64-bit wide loader-visible absolute
references.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 21816b48537c..2c666c8c4519 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -179,8 +179,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	xorl	%r15d, %r15d
 
 	/* Derive the runtime physical address of init_top_pgt[] */
-	movq	phys_base(%rip), %rax
-	addq	$(init_top_pgt - __START_KERNEL_map), %rax
+	leaq	init_top_pgt(%rip), %rax
+	subq	$__START_KERNEL_map, %rax
+	addq	phys_base(%rip), %rax
 
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
@@ -232,6 +233,9 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 	btsl	$X86_CR4_PGE_BIT, %ecx
 	movq	%rcx, %cr4
 
+	/* Use .text as an anchor to emit PC-relative symbol references */
+	leaq	.text(%rip), %rbx
+
 #ifdef CONFIG_SMP
 	/*
 	 * For parallel boot, the APIC ID is read from the APIC, and then
@@ -288,10 +292,9 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 .Llookup_AP:
 	/* EAX contains the APIC ID of the current CPU */
 	xorl	%ecx, %ecx
-	leaq	cpuid_to_apicid(%rip), %rbx
 
 .Lfind_cpunr:
-	cmpl	(%rbx,%rcx,4), %eax
+	cmpl	cpuid_to_apicid - .text(%rbx,%rcx,4), %eax
 	jz	.Lsetup_cpu
 	inc	%ecx
 #ifdef CONFIG_FORCE_NR_CPUS
@@ -311,7 +314,7 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 
 .Lsetup_cpu:
 	/* Get the per cpu offset for the given CPU# which is in ECX */
-	movq	__per_cpu_offset(,%rcx,8), %rdx
+	movq	__per_cpu_offset - .text(%rbx,%rcx,8), %rdx
 #else
 	xorl	%edx, %edx /* zero-extended to clear all of RDX */
 #endif /* CONFIG_SMP */
@@ -322,7 +325,7 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 	 *
 	 * RDX contains the per-cpu offset
 	 */
-	movq	current_task(%rdx), %rax
+	movq	current_task - .text(%rbx,%rdx), %rax
 	movq	TASK_threadsp(%rax), %rsp
 
 	/*
@@ -343,7 +346,7 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 	 */
 	subq	$16, %rsp
 	movw	$(GDT_SIZE-1), (%rsp)
-	leaq	gdt_page(%rdx), %rax
+	leaq	gdt_page - .text(%rbx,%rdx), %rax
 	movq	%rax, 2(%rsp)
 	lgdt	(%rsp)
 	addq	$16, %rsp
-- 
2.47.3

