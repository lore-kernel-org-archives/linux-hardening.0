Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D850443CD3;
	Thu,  8 Jan 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864521; cv=none; b=bLrXPzheg0yTNT7NVViM0gdkloPTTggOkQ1W/91/NKwxzMppv221HL/MvkLXCJjRPlUnl9sHmFqckEgTHth8osox9yYagXCuaA7evTuKZrFlVz3n/OS/U+sQWf0+auu4AIRBapJyuueVCk86Kt68uKzziQb1UjqzP+5wmpa76JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864521; c=relaxed/simple;
	bh=Me24Xe8jlmsEJjlmbTQiFymbguEG0EEq4PfTyqWGNgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pr2LkVM1lLfaE/UDvQZUiCMjaBPGmaIqUS7+kGJ+xdMpNOOBgkKt5cZiqtJv+2H6va5jlAFGiWz5BT/d99VuucUEiJyCaYRQmyzmBKySMfXn43QykaDmDEiFVSRHmLV1xUh+Q6PQZ3FmmItzOwmvo2MTa625USLjcdzp9HSrmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIjAAvpY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIjAAvpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D19FC16AAE;
	Thu,  8 Jan 2026 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864520;
	bh=Me24Xe8jlmsEJjlmbTQiFymbguEG0EEq4PfTyqWGNgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIjAAvpY/cJ9+muqPobtVjzBZDh6MSC5vwV4o/rqtNneRFQJmcW+TlUKxNIBewyBJ
	 66c8+ysys9upa/25hVQfSkO8rBKTOg7FQqAKEHBqj2MhB1Ahzpd+9U4gmsr7xuRj98
	 2XSYD2B9ofk7OB8a7hlX8UNsp06w5eoPpLnSRNAcN145deJSvZSDBQO7yMJKB3Z5WK
	 o6v5xkM2u8wf7gB/jL+eHJE4eAajmmw7FfZ7QDfchqfIDmnV1K/5ohXn3HvRst5QU0
	 5HBx9LaAMHVC/H73IB/akhYDZ9uTDn5Q4TAfY2kMlAlpAwIyCFIYmcJ0qG5qED4Dxo
	 PP76ZWnxj46Hg==
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
Subject: [RFC/RFT PATCH 16/19] x86/kexec: Use 64-bit wide absolute reference from relocated code
Date: Thu,  8 Jan 2026 09:25:43 +0000
Message-ID: <20260108092526.28586-37-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=ardb@kernel.org; h=from:subject; bh=Me24Xe8jlmsEJjlmbTQiFymbguEG0EEq4PfTyqWGNgg=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+Qoa9260i3M7Rs9vyys20PzuTFlg3MsybIlq6o0Gbb 4Fu5JqOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJHmcEaGR5/uJ55saGL/NzXK itdX0uXAOu1i61OrSpQPRwYHX5W0Z2RY5rpGhdde8o1VhuzhOzwTZX5+Pne7J/NVcsmmqdc/LWb lAgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

The virtual_mapped() kexec routine runs from a different virtual address
than it was linked at, and so it needs to use an absolute reference to
load the address of 'saved_context'. Change this reference to a 64-bit
wide one, to make the code compatible with linking in PIE mode.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 4ffba68dc57b..3fc1a3002e32 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -311,7 +311,7 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 
 #ifdef CONFIG_KEXEC_JUMP
 	/* Saved in save_processor_state. */
-	movq    $saved_context, %rax
+	movabsq $saved_context, %rax
 	lgdt    saved_context_gdt_desc(%rax)
 #endif
 
-- 
2.47.3

