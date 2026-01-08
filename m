Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F006A442B04;
	Thu,  8 Jan 2026 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864508; cv=none; b=digIPii4YjePa3K/7FQunFxAEcpsAIUY+FTEYrJzmRb6HlJs2wirhWgnkIqRiQCtz2ON+ZPCj2YfCLW5qIjLbllh2Et7q8Iy8IaUC84BEdFf08PQEJYzGE4CjFI3alRRoxPogQ20JpEMoRK4uRYRUDaxYSyGyzavKzzCUK/LxLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864508; c=relaxed/simple;
	bh=XQEzizKeIH1kxwO1qDXCpqKupc0ETqfSJihMTXf8Zk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOwRRRwGs5CsFpDtK31JOhwnu7oOs4KsOlUp5ukzuiNdCsOjzvPgbTJ11Vs+6u4HYwtHY78qKqndKXpZacmWXoUYv4FcXOseDNt2ddO5pso7DKc14lFRM6a/jg5xcwOwTJ2dxkB8oVnaEMwAgzm2PM2cjE7w6mh9MwGB2HhfGl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/RCdxeJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/RCdxeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231D8C116C6;
	Thu,  8 Jan 2026 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864506;
	bh=XQEzizKeIH1kxwO1qDXCpqKupc0ETqfSJihMTXf8Zk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/RCdxeJXtZwVRb6KHJtH1h/tJjUTp9Ue3MsipaIF3fANLIMaH57U22CVKy2s2RVg
	 Eqtvglv4sRC0ke4AVg9wokJqrPvmpr/JbSAGHr9B60bLvybnicJE597CRYmo4YJUZT
	 b1NIYDgdmkxRsHIBtgs1BJvk+0fS5+gpqVsMr2G4hcytZiUmUocDnWMvsYz4HZr5nx
	 shnXvaF3a9c7YY7rvM88eO0Un+qe370LYWoTb3YgqGEQeq8rsPes2ktvQGFliOWOUF
	 6gIKbQyZ3OSZfXkeJ5N22IEM0LH0RDjps6HdanQJ7z7wTYb8tm1dM2okDuaJycjjZR
	 weJLZOB1egcaw==
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
Subject: [RFC/RFT PATCH 11/19] x86/rethook: Use RIP-relative reference for fake return address
Date: Thu,  8 Jan 2026 09:25:38 +0000
Message-ID: <20260108092526.28586-32-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=ardb@kernel.org; h=from:subject; bh=XQEzizKeIH1kxwO1qDXCpqKupc0ETqfSJihMTXf8Zk4=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+QpR186vea+z+xqJ5S2r2n6ntPWl/1f21zeQTrayFS Td0ph/uKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZqcXI8POK2MYfK2Q5Yv7G cCTyBfW6tdgtv7vIdteaKL4D1bOf72RkWPdI/5ePwKmr5dl159vviR3oX+SpHJBnctY4do9iid4 1TgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Pushing an immediate absolute address to the stack is not permitted when
linking x86_64 code in PIE mode. Usually, the address can be taken using
a RIP-relative LEA instruction, but this is not possible here as there
are no available registers.

So instead, take the address into a static global, and push it onto the
stack using a RIP-relative memory operand.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/rethook.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
index 85e2f2d16a90..50812ac718b0 100644
--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -11,6 +11,10 @@
 
 __visible void arch_rethook_trampoline_callback(struct pt_regs *regs);
 
+#ifdef CONFIG_X86_64
+static __used void * const __arch_rethook_trampoline = &arch_rethook_trampoline;
+#endif
+
 #ifndef ANNOTATE_NOENDBR
 #define ANNOTATE_NOENDBR
 #endif
@@ -27,7 +31,7 @@ asm(
 #ifdef CONFIG_X86_64
 	ANNOTATE_NOENDBR "\n"	/* This is only jumped from ret instruction */
 	/* Push a fake return address to tell the unwinder it's a rethook. */
-	"	pushq $arch_rethook_trampoline\n"
+	"	pushq __arch_rethook_trampoline(%rip)\n"
 	UNWIND_HINT_FUNC
 	"       pushq $" __stringify(__KERNEL_DS) "\n"
 	/* Save the 'sp - 16', this will be fixed later. */
-- 
2.47.3

