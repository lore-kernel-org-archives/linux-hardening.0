Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E2443557;
	Thu,  8 Jan 2026 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864513; cv=none; b=f98mmpDjrs9QfEUxx6bK3TpSPQQewONyRbyBV+U05q7nB/+p1xUZhfA57yv/iIFt9HEHO8Piq3f0gn+mhGbaKRq7g+vYTWciSywqMEFFeuzXHqFkUVEcmI7imAbx7ys0mnWVRptU2jHX3Eul80CPZrIAM2GhBzpWTGl1sRaYeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864513; c=relaxed/simple;
	bh=6scAsjRD5Wriwk6GrdhKjIHbQzXMRVcf7w3xNozkua4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLDJ72ekFE/EzP8f/cBrpALHWxRiy0qr4P5CVkH37dAgpAeXYCWzhzNmffv+10O2oxRxL66y7vH99GEAtRJFe8KDIYoL0rtr/+e7fdtkMHOSSjBM771uZmHosShWiiJwaROoG8jTFdDsHXVheuR537RNZ8dAIddvVw6sPhIfUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONfuBzDH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONfuBzDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8F1C116C6;
	Thu,  8 Jan 2026 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864512;
	bh=6scAsjRD5Wriwk6GrdhKjIHbQzXMRVcf7w3xNozkua4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONfuBzDHpkTFUFzfXWfYXgVyIt0TgAesi2qYP801WGdFM4MkafgGRErX3fwN7x1kF
	 pJD7kIklLTIjYnmJOzJybmbuk36oGoLsRcKRztjZ4kxjQsYZo89gSVkrQNyLa2cwzl
	 jTJ8rGG3JVQI7GvFZLbAhoMgFS0MLoPjzSQJ8ebFgaba4q+8MXdfH2hIIT5JA3UR0m
	 JXzP143igchj1CKPD7DC9alu8WLvPo7CMVB9FEPEMGMSh7M49XBO3IZB9Cvg+WDaLg
	 ZPCgvyhVCsHHguCUJINPlPC0AE1+NCJ85Pscfz6KziV2jbpflR8FjZbYrxN1ycF1PJ
	 PymWHwAEcK2WQ==
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
Subject: [RFC/RFT PATCH 13/19] x86/entry_64: Use RIP-relative addressing
Date: Thu,  8 Jan 2026 09:25:40 +0000
Message-ID: <20260108092526.28586-34-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=ardb@kernel.org; h=from:subject; bh=6scAsjRD5Wriwk6GrdhKjIHbQzXMRVcf7w3xNozkua4=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+QqL5eVfkj91yf241nIixqFX6MHOngV5aU/CPZPZnM RFVb3d1lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIm8OMjIcPOFu5yr5PYTbZvn S3P8fxq/7tDbdKY5PwK/ukgHbZTK5WH479a+rPn32b+XTP9prjJ8mXXirpt+isf0s+/n97sn/X+ awwgA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Replace a couple of instances in the x86_64 entry code where the
absolute address of a symbol is taken in a manner that is not supported
when linking in PIE mode, and use RIP-relative references instead, which
don't require boot-time fixups at all.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/entry/calling.h  |  9 +++++----
 arch/x86/entry/entry_64.S | 14 +++++++-------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 77e2d920a640..a37b402432a3 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -376,8 +376,8 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 
 .macro SAVE_AND_SET_GSBASE scratch_reg:req save_reg:req
+	GET_PERCPU_BASE \scratch_reg \save_reg
 	rdgsbase \save_reg
-	GET_PERCPU_BASE \scratch_reg
 	wrgsbase \scratch_reg
 .endm
 
@@ -413,15 +413,16 @@ For 32-bit we have the following conventions - kernel is built with
  * Thus the kernel would consume a guest's TSC_AUX if an NMI arrives
  * while running KVM's run loop.
  */
-.macro GET_PERCPU_BASE reg:req
+.macro GET_PERCPU_BASE reg:req scratch:req
 	LOAD_CPU_AND_NODE_SEG_LIMIT \reg
 	andq	$VDSO_CPUNODE_MASK, \reg
-	movq	__per_cpu_offset(, \reg, 8), \reg
+	leaq	__per_cpu_offset(%rip), \scratch
+	movq	(\scratch, \reg, 8), \reg
 .endm
 
 #else
 
-.macro GET_PERCPU_BASE reg:req
+.macro GET_PERCPU_BASE reg:req scratch:req
 	movq	pcpu_unit_offsets(%rip), \reg
 .endm
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f9983a1907bf..77584f5ebb4b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1040,7 +1040,8 @@ SYM_CODE_START(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	leaq	.Lgs_change(%rip), %rcx
+	cmpq	%rcx, RIP+8(%rsp)
 	jne	.Lerror_entry_done_lfence
 
 	/*
@@ -1252,10 +1253,10 @@ SYM_CODE_START(asm_exc_nmi)
 	 * the outer NMI.
 	 */
 
-	movq	$repeat_nmi, %rdx
+	leaq	repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	1f
-	movq	$end_repeat_nmi, %rdx
+	leaq	end_repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	nested_nmi_out
 1:
@@ -1309,7 +1310,8 @@ nested_nmi:
 	pushq	%rdx
 	pushfq
 	pushq	$__KERNEL_CS
-	pushq	$repeat_nmi
+	leaq	repeat_nmi(%rip), %rdx
+	pushq	%rdx
 
 	/* Put stack back */
 	addq	$(6*8), %rsp
@@ -1348,10 +1350,8 @@ first_nmi:
 	addq	$8, (%rsp)	/* Fix up RSP */
 	pushfq			/* RFLAGS */
 	pushq	$__KERNEL_CS	/* CS */
-	pushq	$1f		/* RIP */
-	iretq			/* continues at repeat_nmi below */
+	call	native_irq_return_iret
 	UNWIND_HINT_IRET_REGS
-1:
 #endif
 
 repeat_nmi:
-- 
2.47.3

