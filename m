Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D991443CA5;
	Thu,  8 Jan 2026 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864516; cv=none; b=qJWKoiqqLCo6eoT/HFg9J4px7+6sJ0GlrefeKWbUa/Hzl2Su4EVRD4bqBajTvDczDqCXirqmNvGUaJfjxsGUoyQt1ePSwmm0kk5AnsWdiS1Fw2nZDUM2uZGY9soLMhbCBavN3o6uRFOQUSJ1KOO7xMwciepEeeSLBZ9iyepl4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864516; c=relaxed/simple;
	bh=zfrVg75Z35z2oocHCko1HgTUe+XNiB/uDzsXNZhpNQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9fVF5P3Bed41NPIK8tT4zinLRxyQujQgNt2t9O+TZgwWbk6D0xZBsOO1r+zYTOiI2YNQmKIWSIkWbSrCQSTbZrezVuXsXAlHqUw9sgGxSnDXlhfu4wetfxti4TltXAWDEG+kwRgGRFqgrQK86m0WH38mLG2avy/rje5d1113Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeU18qKY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeU18qKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F92C16AAE;
	Thu,  8 Jan 2026 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864514;
	bh=zfrVg75Z35z2oocHCko1HgTUe+XNiB/uDzsXNZhpNQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeU18qKYZHmj0RkHtk5d54Rdrzc6BL2hnOW64m4WuAJnYYpr1yCRWDGCqur64e0p3
	 6Mf3BsW9dK2t4Rjdh58qeLu2X+WnNG64CqFAKFDHh/xJ6IFtJzEiVZ6U2MHQa+zAv/
	 spFST6PhdUX3QqUdIQFp+rBhI2Z+grdQpm6kZtE6xC5zcOpm4XjP3cAu8EofQsiI0a
	 rJ1RUIMGEaL2aYrzJmL89SaSf3C80YoD+MDwzU9sDzENLiFg5yOwCWRVadI3FzhYbH
	 JSfzhmTW2v1ZOTaSI5Im4j6KLM6eK/0WdNTUhTgIZF6I9Y7PAvZ753qUYS5/hRie78
	 VFY5s7KQB7E0w==
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
Subject: [RFC/RFT PATCH 14/19] x86/hibernate: Prefer RIP-relative accesses
Date: Thu,  8 Jan 2026 09:25:41 +0000
Message-ID: <20260108092526.28586-35-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=ardb@kernel.org; h=from:subject; bh=zfrVg75Z35z2oocHCko1HgTUe+XNiB/uDzsXNZhpNQ8=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+Qurvnaa9+/M/zv949MW6i8Fuh5exHtr3MPV9qfIjK WdXN9WsjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR4w8Y/qde2msXrib92O/A 78/rFse/eD21jz89+OyKa4G3bU6JTDRlZJhXpnxzwuuwA5uyNJSX3zXNvr5hnsHSsLW90seeC53 dVccJAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Replace some absolute symbol references with RIP-relative ones, to avoid
fixups at boot time. This is a prerequisite for PIE linking, which only
permits 64-bit wide loader-visible absolute references.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/power/hibernate_asm_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index c73be0a02a6c..173df717275a 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -40,7 +40,7 @@ SYM_FUNC_START(restore_registers)
 	movq	%rax, %cr4;  # turn PGE back on
 
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	pt_regs_sp(%rax), %rsp
 	movq	pt_regs_bp(%rax), %rbp
 	movq	pt_regs_si(%rax), %rsi
@@ -71,7 +71,7 @@ SYM_FUNC_START(restore_registers)
 SYM_FUNC_END(restore_registers)
 
 SYM_FUNC_START(swsusp_arch_suspend)
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
-- 
2.47.3

