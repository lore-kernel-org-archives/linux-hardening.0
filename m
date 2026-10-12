Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB346F4A1;
	Mon, 12 Oct 2026 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795879; cv=none; b=sRWua8eGmwviDTP3T4P9Tub1+6dKHgtcYjJV3WfhOQ0c7JG8tbxfBBQO03ERxRl6LbTcUf7B1SMPT04AWdNkRmTwO6ERW2KDYhFUG5Y0j9nkcJU4OfcgP3KDwFd3Uoq/u/+/9ZJ4mmuWzFJGxq0xUybQc5gsgeRA/Yrc+4yrf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795879; c=relaxed/simple;
	bh=rqSJmZkc3v7G/5AS5Mdsxc3B7f1mI1+jW4CgqSEVauE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0ulLaRXX0fchNuzYGMvhI+2oFybl51NZFUjjcuNGlVc1FUwg8xCx9T+YKG7bT9I10G0S9mUdrr5phOl3BBEPpc9/Um+S64FsfEolBR9fkiBCLlRz0BRFb+TtYueLmQX5daerg2XEn8Uvp0qQs8PRm0JDcyC9mxYL7CIiMBa9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8sjmvwc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8sjmvwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72531F0089D;
	Mon, 12 Oct 2026 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795876;
	bh=mMjotEINmFuNpUySn99N3cbT1ZYDRfEhnSMUQy3XpDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l8sjmvwcIRZvTEitj0bazjj0wX42kFZ9TYCVq9kGVXuVf3G6QGlJZ0g8bVR5tCATa
	 P8GP3Q2QH7Mrt5oxVuJ+kvmPn/jpnRAgVjfnecb8qN9rc30V3/KZYT9O79gFFU9xiz
	 CseJg36l88rHwU6kBq56QW2Me7AkZ+mqrmfCefJoZDAKX7s0sznUKK+tOlcAN6f2MG
	 E/yai18KpJG4obvN+mNXrLm7S3g/SePZkaf3p/zvpWvDFy0yQyTYe3mSQCrBQ89X+0
	 0wRxN8VlBVpOG3V5yXbub4tV6qiJfWcm2prLnHF9ygGYefAXooTAR/832vccSQzCCX
	 pdjufN/IOptzw==
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	x86@kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] x86/kcfi: Emit the FineIBT paranoid "cs" prefix as a byte
Date: Mon, 12 Oct 2026 02:04:25 -0700
Message-ID: <20261012090436.1676525-2-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012090424.i.497-kees@kernel.org>
References: <20261012090424.i.497-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=kees@kernel.org; h=from:subject; bh=rqSJmZkc3v7G/5AS5Mdsxc3B7f1mI1+jW4CgqSEVauE=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlnFs1UWRLUqjG75YHRLqNVr7tX7zwV5qtk283Y06Mvq yfRlijeUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJHkzQx/OM6vefVf598zk7Bf C+7VudlNefhncurmZ75zdBKeXJy6XpaR4d7C0Ig/O3w7O+aquX9uzStSbkr3uaIvHqkeer6iZiY 7AwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The "cs" prefix on the LEA in the FineIBT paranoid caller template is
padding: it places the LEA's 0xf0 immediate byte where it doubles as the
LOCK prefix that makes the failing Jcc raise #UD. GNU as warns about it
in every CONFIG_FINEIBT=y build:

  Warning: segment override on `lea' is ineffectual

Clang's integrated assembler does not warn, and both assemble the same
bytes. Emit the prefix with ".byte 0x2e" to silence GNU as.

Build tested ARCH=x86_64 defconfig with CONFIG_CFI=y, with GCC 17.0.0
(experimental, with the kCFI series) and GNU as 2.47, and with Clang
24.0.0git: GNU as no longer warns, and the template assembles to the
same bytes as before with both. Under QEMU with cfi=fineibt,paranoid,
the paranoid caller check catches LKDTM's CFI_FORWARD_PROTO with both.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/x86/kernel/alternative.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 91b1cdd16569..1300ca50e770 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1448,7 +1448,8 @@ asm(	".pushsection .rodata				\n"
 	"fineibt_paranoid_start:			\n"
 	"	mov	$0x12345678, %eax		\n"
 	"	cmpl	-11(%r11), %eax			\n"
-	"	cs lea	-0x10(%r11), %r11		\n"
+	"	.byte	0x2e				\n"
+	"	lea	-0x10(%r11), %r11		\n"
 	"#fineibt_caller_size:                          \n"
 	"	jne	fineibt_paranoid_start+0xd	\n"
 	"fineibt_paranoid_ind:				\n"
-- 
2.55.0

