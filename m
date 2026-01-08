Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91023C00A8;
	Thu,  8 Jan 2026 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864486; cv=none; b=FiPzz45+9XPkh22Gcyqp5rMSfHCSEfeVkiDU2Dd+0PhKxd7+OeZTQKdFlq5ciGFcf8kR9v9HlYaEOiA2CsAe2NnUHVN7bkNAp5JZh8Fb6CR+oFtymGC2MAIMlCwuW//o8R5/tYCl/PzzkFe4LfULShK/oEKfY+QLoWF/qljFtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864486; c=relaxed/simple;
	bh=s1Q/RZ3WGfrQNkmrGvRKRmUOXkb9B504DHaeNuHZ02g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ajlhw4N0H24rgS5KnqGq9xkDpY6H0AELQWPdDku+qOvt3Oc9jHNcPR0K2XRWG2hTl8Osk2R6Nr5wzzudmXnfdOazyaC9QYrq7r/XWUpDPQeHWcuuNM5DsF+lD0P7AY6ohS0SnCSQl+kW6/7cY5RW9lhi5BisHKdutETPcY15ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5BFwaAU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5BFwaAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B38C116C6;
	Thu,  8 Jan 2026 09:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864481;
	bh=s1Q/RZ3WGfrQNkmrGvRKRmUOXkb9B504DHaeNuHZ02g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5BFwaAU3EK8knYcn+8QRpi0McB4l6KJSJSuzaEYudb3VaohSOcV6vOQWbWA6+vTX
	 nremnB8J0dgLHRA3DLEcwoKpmiBbujE0+RkWbwfQhR1iVdma8l1U02QGgV2+ORTLeO
	 QjNEWEo3u06Jz/4C49ZUOR+iM9TM2sVLQKheOAdtCeGTQKL8K95YyPKtoLT79BWKHW
	 a3VKsjPJbYSMZzuQRxCQnhcfHPN61UyZmEJCUQOBPVY9zYa5UyaZbzv3O0+KAAqIr2
	 RVIjH9UufDjOBuAPiONBNu6rt/uDA1+gA7OD4xGQtzWUfVfIdA1Ajom4X7Hk+saTFq
	 /mFUfJKHmmmIA==
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
Subject: [RFC/RFT PATCH 02/19] x86/sev: Don't emit BSS_DECRYPT section unless it is in use
Date: Thu,  8 Jan 2026 09:25:29 +0000
Message-ID: <20260108092526.28586-23-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=ardb@kernel.org; h=from:subject; bh=s1Q/RZ3WGfrQNkmrGvRKRmUOXkb9B504DHaeNuHZ02g=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+gvNxyPTu10E34uMPcLx9qxqys+fYIuWT9Xu6y2O07 tZU/jzRUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACby6w7Df7dZNw45X7+Yp1b8 6/jv1Q6s6zOqU7mDWM06nITE/HafKGT4K5/DcsBog1iZNFOgWcHWmRe17lyQU3/wvGFCzpf0zfk 6/AA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

The BSS_DECRYPT section that gets emitted into .bss will be empty if
CONFIG_AMD_MEM_ENCRYPT is not defined. However, due to the fact that it
is injected into .bss rather than emitted as a separate section, the
2 MiB alignment that it specifies is still taken into account
unconditionally, pushing .bss out to the next 2 MiB boundary, leaving a
gap that is never freed.

So only emit a non-empty BSS_DECRYPT section if it is going to be used.
In that case, it would still be nice to free the padding, but that is
left for later.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 21 +++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d7af4a64c211..3a24a3fc55f5 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -67,7 +67,18 @@ const_cpu_current_top_of_stack = cpu_current_top_of_stack;
 
 #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
+#else
+
+#define X86_ALIGN_RODATA_BEGIN
+#define X86_ALIGN_RODATA_END					\
+		. = ALIGN(PAGE_SIZE);				\
+		__end_rodata_aligned = .;
 
+#define ALIGN_ENTRY_TEXT_BEGIN
+#define ALIGN_ENTRY_TEXT_END
+#endif
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 /*
  * This section contains data which will be mapped as decrypted. Memory
  * encryption operates on a page basis. Make this section PMD-aligned
@@ -88,17 +99,9 @@ const_cpu_current_top_of_stack = cpu_current_top_of_stack;
 	__pi___end_bss_decrypted = .;				\
 
 #else
-
-#define X86_ALIGN_RODATA_BEGIN
-#define X86_ALIGN_RODATA_END					\
-		. = ALIGN(PAGE_SIZE);				\
-		__end_rodata_aligned = .;
-
-#define ALIGN_ENTRY_TEXT_BEGIN
-#define ALIGN_ENTRY_TEXT_END
 #define BSS_DECRYPTED
-
 #endif
+
 #if defined(CONFIG_X86_64) && defined(CONFIG_KEXEC_CORE)
 #define KEXEC_RELOCATE_KERNEL					\
 	. = ALIGN(0x100);					\
-- 
2.47.3

