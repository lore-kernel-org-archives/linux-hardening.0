Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D027450;
	Sun, 31 Aug 2025 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756607037; cv=none; b=TSL01SvcktOLICOwaSY85UijZ+gLO7lgR0h63VOJ/AGNqa+Gb0VIBCQYH6ZaH4ek3FebkSD8N1GDnQOB904DuN4X6QdfvzSbXSbWXbPEoUkP6HZHW+zMVRRhq9Q3SMKJ/EBXgTvUVgMX8eAtvtUOlQJNJhJm8XzMQNKuVud/h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756607037; c=relaxed/simple;
	bh=QY+f+HqL7N0KVufxdAS9SBjt9GAPYlHKLVQxyLvCaMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KbKkCNuNLsAfgQY/NqAfK4qyj4R9Q+xUL6OEP2B7NHjus5InKAMNgy0QfhfVsyjssU5eNdpF17MHlsEbj/6Fzd7YjbYxDbuW9a1u/4a3zEvcopW4ivYUlWoTtWaRWnDn0ZS3PxSLHMJqC9xCzm+EpP0r6dskIyj51E1nbBOMSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8Si7Gnt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8Si7Gnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34929C4CEEB;
	Sun, 31 Aug 2025 02:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756607036;
	bh=QY+f+HqL7N0KVufxdAS9SBjt9GAPYlHKLVQxyLvCaMc=;
	h=From:To:Cc:Subject:Date:From;
	b=o8Si7Gnt6ZuN7xodmjugjqU6kz6F8MvjVBX8il20JsGzqFFx3tZVeOtczyDmhoQ2F
	 Kbfml7DY/iOBvBhmQ/CVFwo75xhouBEJa7ClAxXCK21a4IOzsDlUqrgxYKg4K4JoBb
	 NXh+YXabf7RISM3AWSjr5E8OKFqfzDzaje/4XccYX3Ikr4BEE5zUyJFdEvctl2pUfs
	 rR9tvDQmuyOWjptphylOmrC6hT/I6pz72puJEosqLauj2tOyJ3gpvbq2un4crbmQWi
	 nNzdzk8c9TplJfVznmb4Cp3jkKYeQttnDWWZL14o5g2ju7ab2sbFm2s4H2A5iiuRS1
	 dM5EhSuLQCeng==
From: Kees Cook <kees@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] arc: Fix __fls() const-foldability via __builtin_clzl()
Date: Sat, 30 Aug 2025 19:23:53 -0700
Message-Id: <20250831022352.it.055-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2452; i=kees@kernel.org; h=from:subject:message-id; bh=QY+f+HqL7N0KVufxdAS9SBjt9GAPYlHKLVQxyLvCaMc=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmbN1ksCfpj2HxijuWzN0bihen7c97kM6xgN+BlFO3z5 3v1VLC7o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJH+hkZmpa+62KwOpTOJJ21 vkZeSD+98DH3XrdQ06LjJqpxrSsSGBk6NThnTWyxOZcXW1cjoXyp/VHzki8f/yad+Lz97uF5SdM YAA==
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
compile-time constant folding, and KUnit testing of ffs/fls fails on
arc[3]. A patch[2] to GCC to solve this has been sent.

Add a fix for this by handling compile-time constants with the standard
__builtin_clzl() builtin (which has const attribute) while preserving
the optimized arc-specific builtin for runtime cases. This has the added
benefit of skipping runtime calculation of compile-time constant values.
Even with the GCC bug fixed (which is about "attribute const") this is a
good change to avoid needless runtime costs, and should be done
regardless of the state of GCC's bug.

Build tested ARCH=arc allyesconfig with GCC arc-linux 15.2.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2025-August/693273.html
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508031025.doWxtzzc-lkp@intel.com/ [3]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: clarify commit log (we want this patch regardless of GCC being fixed)
 v1: https://lore.kernel.org/lkml/20250826034354.work.684-kees@kernel.org/
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

