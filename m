Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E21CD0C;
	Tue, 26 Aug 2025 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179844; cv=none; b=DlpEmkw/ph5kYc9RnCd4L1yxYMiq04n4j9sRO36FwB1q+sZkzYufEkC0vuakSkiunyaIa+XyrWTMUX+TZkQgbkpChaSA7rYG6aV8cAVT3vZH7Zl60DaBIb6skD84IzMbaKWdcPeHotGmV1OkIjNdSzqx51+pMIbn7Q5zsGo+9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179844; c=relaxed/simple;
	bh=qViKu2G3S4xLHtRgNf8GgW5zqv9/Lpel9naK3zFCNMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N36F0lrsw4866doVBzBl3b1NzC913krmIlV2VwFbjO5FOclLJKP+sv/tfJv3/Ns9ZLkgfMEj6Nenro0UEuSPMESnv9tCqTjJVZdRRpNVHuQbp4CfHKUqw2LGsn39KLptskCyEwWTD8MtgzDvXCzTdIcmurF0COy8oGkTnNMwTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0buhXl3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0buhXl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE58C4CEF1;
	Tue, 26 Aug 2025 03:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756179844;
	bh=qViKu2G3S4xLHtRgNf8GgW5zqv9/Lpel9naK3zFCNMU=;
	h=From:To:Cc:Subject:Date:From;
	b=a0buhXl3Jjdcb2R4aAtZilC57yTt2X0OQtPsV5WYI0sKem4AC+TB/8oOjKBqCNgkl
	 BD6F1gNvr9sR+WyMhQd5s+fIvuywsGIjnlOS4u0e1oHPw6HQYQA917oYeJZcaFRPXK
	 rXmcI6dE2iqe3SQsBbFoyuTUAYIQWyHNuiFUThoUHdaiR3CqD3+kefi7OoAMgkQO9Z
	 9eCzrIZoF+yX7Hb/52qY/PbTwaqCxl1w7WffAOFde/z8r01ntiUndnCzvSoK1Owt/0
	 oaMg0c7dTaoUPump4o8B28ZcZuSS32e3lwFO9g70xrsiHxZDuBI/Z1CjiQeBHOFs5p
	 7YPYDTXO2yTEA==
From: Kees Cook <kees@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] arc: Fix __fls() const-foldability via __builtin_clzl()
Date: Mon, 25 Aug 2025 20:43:58 -0700
Message-Id: <20250826034354.work.684-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182; i=kees@kernel.org; h=from:subject:message-id; bh=qViKu2G3S4xLHtRgNf8GgW5zqv9/Lpel9naK3zFCNMU=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlrdWt3LrKv3/v55yrWvjUJfq1/aj60ecWkPma7dWtH3 9zb9Wd3dpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAFwkieGf1rrQN5vXbnG9UMns suOD2aOLnzjFY8zzK9cziuj6G3/XZfjJqHas7VBxoqhHYlXiD+Paouxd+38dT+diZWZ7FluynZs bAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While tracking down a problem where constant expressions used by
BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
initializer was convincing the compiler that it couldn't track the state
of the prior statically initialized value. Tracing this down found that
ffs() was used in the initializer macro, but since it wasn't marked with
__attribute__const__, the compiler had to assume the function might
change variable states as a side-effect (which is not true for ffs(),
which provides deterministic math results).

For arc architecture with CONFIG_ISA_ARCV2=y, the __fls() function
uses __builtin_arc_fls() which lacks GCC's const attribute, preventing
compile-time constant folding[2]. Fix this by handling compile-time
constants with the standard __builtin_clzl() builtin (which has const
attribute) while preserving the optimized arc-specific builtin for runtime
cases. This has the added benefit of skipping runtime calculation of
compile-time constant values.

Build tested ARCH=arc allyesconfig with GCC arc-linux 15.2.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Link: https://lore.kernel.org/all/202508031025.doWxtzzc-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508031025.doWxtzzc-lkp@intel.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: <linux-snps-arc@lists.infradead.org>
---
 arch/arc/include/asm/bitops.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 5340c2871392..df894235fdbc 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -133,6 +133,8 @@ static inline __attribute__ ((const)) int fls(unsigned int x)
  */
 static inline __attribute__ ((const)) unsigned long __fls(unsigned long x)
 {
+	if (__builtin_constant_p(x))
+		return x ? BITS_PER_LONG - 1 - __builtin_clzl(x) : 0;
 	/* FLS insn has exactly same semantics as the API */
 	return	__builtin_arc_fls(x);
 }
-- 
2.34.1

