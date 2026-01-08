Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAFD443CDC;
	Thu,  8 Jan 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864521; cv=none; b=rD+oR0kXjq8QhVRccrcfyAakNPDhEvU7PlIRDqt/Rbi9KxhAk851hSKgq4QkNxVQZC5eM/Qxk8t1RlGR+rSFxtAp6ly5T6KVKjqp8e8hE911v7SYcu+TfMtZGUUrB3zelT5C521A5ou2RwqLJyW1LBCE2/gG3+R1LuBdDpsUmqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864521; c=relaxed/simple;
	bh=myFOVNSBDPjvkqKce6iB/ppwMkoexRyj2C6Vu/MTr94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrBmo8+Xbdj/yMyan9R/44tuLj0oymhdJu4c+6Ijh8ZWPb9v4H0x63RoF8zLQuTOQw8ne1BES3JQL8vGeGNiNGCipaX/q8rS41eRChf/WUqYIjDSRIC0fnXBPIno7pqyWtLRRqUxiyPxtBOSFb0Kd85044NdvJSKi0o2r6q53iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtxB0+D3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtxB0+D3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433E4C116C6;
	Thu,  8 Jan 2026 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864517;
	bh=myFOVNSBDPjvkqKce6iB/ppwMkoexRyj2C6Vu/MTr94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtxB0+D36MMYwbk09SqTbMQnN1/jkA2LcpXbXKeapCcyDt8AHHWLDUUbyiC9GfbYC
	 vgGnS/Cl45q7ir4PJrcBIKZKrx8IdXel4G2trIUtu7wReBtC32t1sXvSxWJcvNAsKh
	 6hD21Cb64KGJiCLFFsFmA99hHxO9gVqzjc5ihQ79flSoFy6U3BYLdeyFqDcL2c4HMv
	 ovzUOhIINpPfuJujBM6hoGJIkH9S5UFa90QqnQ8YpF8cce8c1yoZNI9KuFeZ2JK6Wm
	 oBStLOTEIvG5kA3vxz0H3NKt1yfamRKi8UWW7QWXuhNy7m+ap3MJbWqLFlygioovkF
	 xyzK7Ea2Zsz/Q==
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
Subject: [RFC/RFT PATCH 15/19] x64/acpi: Use PIC-compatible references in wakeup_64.S
Date: Thu,  8 Jan 2026 09:25:42 +0000
Message-ID: <20260108092526.28586-36-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2095; i=ardb@kernel.org; h=from:subject; bh=myFOVNSBDPjvkqKce6iB/ppwMkoexRyj2C6Vu/MTr94=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+QvpUotLx3eZMygfvNUyYseTwhO2t65c9bvlXtFYu6 5L1pyfbO0pZGMS4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEcq4w/LNdUTjl++vb/7ky k/KX2j4OOXV77Se317XdJ711/9c5np3C8FdAgWG5ukr5T4VNArOcJDuvVnx4nv3aVdP/NIPnjPU N8zgB
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Use ordinary RIP-relative references to make the code compatible with
running the linker in PIE mode.

Note that wakeup_long64() runs in the kernel's ordinary virtual mapping
so there is no need to record the address of .Lresume_point in a global
variable. And fix the comment while at it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/acpi/wakeup_64.S | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 04f561f75e99..15233a4e1c95 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -14,7 +14,7 @@
 
 .code64
 	/*
-	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
+	 * Hooray, we are in Long 64-bit mode
 	 */
 SYM_FUNC_START(wakeup_long64)
 	ANNOTATE_NOENDBR
@@ -41,7 +41,7 @@ SYM_FUNC_START(wakeup_long64)
 	movq	saved_rsi(%rip), %rsi
 	movq	saved_rbp(%rip), %rbp
 
-	movq	saved_rip(%rip), %rax
+	leaq	.Lresume_point(%rip), %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 SYM_FUNC_END(wakeup_long64)
@@ -52,7 +52,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	xorl	%eax, %eax
 	call	save_processor_state
 
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -71,8 +71,6 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	pushfq
 	popq	pt_regs_flags(%rax)
 
-	movq	$.Lresume_point, saved_rip(%rip)
-
 	movq	%rsp, saved_rsp(%rip)
 	movq	%rbp, saved_rbp(%rip)
 	movq	%rbx, saved_rbx(%rip)
@@ -90,7 +88,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 .Lresume_point:
 	ANNOTATE_NOENDBR
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	saved_context_cr4(%rax), %rbx
 	movq	%rbx, %cr4
 	movq	saved_context_cr3(%rax), %rbx
@@ -139,7 +137,6 @@ saved_rsi:		.quad	0
 saved_rdi:		.quad	0
 saved_rbx:		.quad	0
 
-saved_rip:		.quad	0
 saved_rsp:		.quad	0
 
 SYM_DATA(saved_magic,	.quad	0)
-- 
2.47.3

