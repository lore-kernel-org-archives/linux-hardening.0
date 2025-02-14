Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C12AF16;
	Fri, 14 Feb 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739560946; cv=none; b=eQ43qSvkP0wHQ6JE9FHju1G/dHq7Fer+NqrgC74ktLjBZUMwLwd33sQHxqlwo6wg12L1Y8WVM3aNSoD5FdBw1LiL/sS01y5xIpv91/HOU2/2rwjd1IJuuhkfmQE1dmV07ewfAAseTq8n9ywP5609DXwsrmh9GWxRZkiTONkkuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739560946; c=relaxed/simple;
	bh=cIlnWIeklYExmWQ9uJGg+d9BS8uNzeL7FRL/jhePM1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GekBydewwG5qttawIUJf9UM9BUgV3BpLdADr8C0Dxfi6zYEzO94xh1/lykHBvTrJvDLqC4t4zFOkKFSAH7+68bvRlehJLs2YYEAwqXTjy5W/eGqe6e9XCMsEEFLJtqoSdDdbS87UCLmRXU2mo6VOdI0GKP2prYtf5UiE7CsnClo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCJHxda2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCJHxda2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25462C4CED1;
	Fri, 14 Feb 2025 19:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739560946;
	bh=cIlnWIeklYExmWQ9uJGg+d9BS8uNzeL7FRL/jhePM1A=;
	h=From:To:Cc:Subject:Date:From;
	b=GCJHxda2cLx9E8KruDRAgDid7tBsFCFo1v4uwGGE+BQya1Kie8RHjF8cHi+Hs3wcM
	 w0gRKgUwUocX4p/9YG8lMindbQHXlrt2M9dgWkuSD/LBvbeLxkjFzXs0qqrbJsovkC
	 4XjXON8CM+KtI/AnfNNSiPX/esPfTEHsMSNI+lTq2bZtxig1zWW8fzlkcNj7we0BUC
	 sfNKCO8Rm/DeSKnzc3W7Brn1jieeWIHNfOoqv+Nnh9Rxw17pmhJMId2fTy1qr51HHj
	 sTTOuH7KJ6HQ28ADgUrIGce0JUqB17nM8IVGqCufZafla0COwLeskwT/kflpUGZnXS
	 DmDJv4QnMR69A==
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>,
	Jennifer Miller <jmill@asu.edu>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jann Horn <jannh@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] x86/kcfi: Require FRED for FineIBT
Date: Fri, 14 Feb 2025 11:22:21 -0800
Message-Id: <20250214192210.work.253-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3289; i=kees@kernel.org; h=from:subject:message-id; bh=cIlnWIeklYExmWQ9uJGg+d9BS8uNzeL7FRL/jhePM1A=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnrp79JVhbVXKZ1YaejybItzMfZXm1eJ3YvMC8jR6PlA LvBX/kvHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABN5aMbI0Dv936u9X6b78R1P F8u0+ubVtcrsWbN7U5vczwKlnp1a1xn+x3qsC3orGXtwW5pTkHZtuSa/PJ/F+k9Krre8Fr2//WM /NwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With what appears to be an unavoidable pivot gadget always present in
the kernel (the entry code), FineIBT's lack of caller-side CFI hash
validation leaves it critically flawed[1]. Require FRED for FineIBT[2]
(and probably should also require eXecute-Only memory too), and default
to kCFI when CFI is built in.

Link: https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/ [1]
Link: https://lore.kernel.org/linux-hardening/c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com/ [2]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jennifer Miller <jmill@asu.edu>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
---
 arch/x86/Kconfig              | 9 +++++----
 arch/x86/include/asm/cfi.h    | 2 +-
 arch/x86/kernel/alternative.c | 4 +++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c94dae634176..47aec3a497f6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2432,12 +2432,13 @@ config STRICT_SIGALTSTACK_SIZE
 
 config CFI_AUTO_DEFAULT
 	bool "Attempt to use FineIBT by default at boot time"
-	depends on FINEIBT
+	depends on FINEIBT && X86_FRED
 	default y
 	help
-	  Attempt to use FineIBT by default at boot time. If enabled,
-	  this is the same as booting with "cfi=auto". If disabled,
-	  this is the same as booting with "cfi=kcfi".
+	  Attempt to use FineIBT by default at boot time if supported
+	  and sensible for the hardware. If enabled, this is the same
+	  as booting with "cfi=auto". If disabled, this is the same as
+	  booting with "cfi=kcfi".
 
 source "kernel/livepatch/Kconfig"
 
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index ef5e0a698253..dfa2ba4cceca 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -93,7 +93,7 @@
  *
  */
 enum cfi_mode {
-	CFI_AUTO,	/* FineIBT if hardware has IBT, otherwise kCFI */
+	CFI_AUTO,	/* FineIBT if hardware has IBT, FRED, and XOM */
 	CFI_OFF,	/* Taditional / IBT depending on .config */
 	CFI_KCFI,	/* Optionally CALL_PADDING, IBT, RETPOLINE */
 	CFI_FINEIBT,	/* see arch/x86/kernel/alternative.c */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 97422292b609..acc12a6efc18 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1323,7 +1323,9 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 
 	if (cfi_mode == CFI_AUTO) {
 		cfi_mode = CFI_KCFI;
-		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
+		/* FineIBT requires IBT and will only be safe with FRED */
+		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT) &&
+		    cpu_feature_enabled(X86_FEATURE_FRED))
 			cfi_mode = CFI_FINEIBT;
 	}
 
-- 
2.34.1

