Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B7442AFF;
	Thu,  8 Jan 2026 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864511; cv=none; b=oP6CeSqumPR4iCJLJjH8h0J8fv/FHWpxaTHYc3ENP77BLqA9Qa04zBQhCB/KwjUxFjR3oKsJG5ONn4NjnQl2Zm3ykV36U3wViZNK2M/ibIKLqritA9v5hXVTSXwYVJL3D2TecRnwMcYqEQFVgJaeFtZv7kCiAisF1nGz/2iUG6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864511; c=relaxed/simple;
	bh=N1TUW6ASyVJu7d2IzQFvCBSY/IugmyoO6hh1JgUNO14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly4bFGAEZHU6EchF0T5GemNTJwQgnzCfSJmZRKIWdLjPrWXklWNWn/MW6DqYiXqJ84jR9pX/fI0WvZuVpjy5LzW9IWxBDUbwTbA/4TLUTs85wyK4BulIb2i2TyTYNqkjSyLina3p+dxvam97m9OmHYIjFjf5M9PyIAmtc9MXRN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxz25/2m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxz25/2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C7EC19425;
	Thu,  8 Jan 2026 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864509;
	bh=N1TUW6ASyVJu7d2IzQFvCBSY/IugmyoO6hh1JgUNO14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxz25/2mUbOkfj729LDlEyYGss74sG3uOPuWAT54Z7yxtkrWhmpXg6/Z3s8olGccZ
	 VHT1wtviIFEgI0sYgiwIxjY8r7XHZncsBouNIC+gduH3GhrOdEPM2KwKxUONQg5qKd
	 UNW3nZPy/KNNunNYhopV9uLpDTX0CANfidH8zvvNLOIe6lQYwb1bSrmRnsHITKDkYA
	 oRDeWogAfBwa1AFbjT0yy/tSu2gweyhXANC6aWxhMK1ady38LS06nh6d4ZpK8gDWNC
	 Cw6BCLGjAIvaN3dY5NV4SsfDnItVGpy0Wpbqk3Cj/OPrVgr1H7Dck79OBw55Gqadgs
	 YcznqFGN6wKaQ==
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
Subject: [RFC/RFT PATCH 12/19] x86/sync_core: Use RIP-relative addressing
Date: Thu,  8 Jan 2026 09:25:39 +0000
Message-ID: <20260108092526.28586-33-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=ardb@kernel.org; h=from:subject; bh=N1TUW6ASyVJu7d2IzQFvCBSY/IugmyoO6hh1JgUNO14=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+Qpxl9seT85/F8HQ3cfh9n+91kFFz6p1TBYkStdPr9 ptFpxd3lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIn8PcTIsNp12ssgqUuLKiZH Sf9Y5nzus8h5u2yuO73zC1LjrnfNWcrIML935iTXDxJ3Ln0qVbec/SDXRVaBa1l3ftjsr3u+LWu 4yQ8A
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Use RIP-relative accesses for sync_core(). This removes a 32-bit
absolute reference that requires fixing up at runtime when KASLR is
enabled. This is a prerequisite for PIE linking, which only permits
64-bit wide loader-visible absolute references.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/sync_core.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 96bda43538ee..547fdc690ecc 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -31,7 +31,8 @@ static __always_inline void iret_to_self(void)
 		"pushfq\n\t"
 		"mov %%cs, %0\n\t"
 		"pushq %q0\n\t"
-		"pushq $1f\n\t"
+		"leaq 1f(%%rip), %q0\n\t"
+		"pushq %q0\n\t"
 		"iretq\n\t"
 		"1:"
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
-- 
2.47.3

