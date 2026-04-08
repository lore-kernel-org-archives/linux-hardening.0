Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9184348465;
	Wed,  8 Apr 2026 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665583; cv=none; b=OPKyq44AVIu1wE4IwKcEKkwXI49ZnK3FaxwJ4ey+xbzXR1hxnKwIcBYJ3fRaqPuEtMMTLJ3cluv7+XYVow4VZ4YqaSJ3JEo8Ba21qRwlwHUxmXkbz2x4XLpbBdL+9tdeDYUQkP4A8BTZZCnzsM2s+x2gMOJ0kVuaYuZDWNVa2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665583; c=relaxed/simple;
	bh=paRGL9e82dHaLbjAcC4/Vy1sJ+vwpBDGXlAEv2gx80I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D+15415y5BTZ9mzGbrODxtGv39Okh4qhwDF5r5yQRomApfHxE6h+acTiCrjC9wfSm31HNXXnAKlueH/H34qsA8ndjOziH0E1Qc0h4Rn/oQmvEbCBkmclp9dIl3LmNeHiSf0EWSlod6N4Hdd9JpNiTXMgw2DbcJjBRMcniW3HFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvQlyg/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvQlyg/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5157AC19421;
	Wed,  8 Apr 2026 16:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775665583;
	bh=paRGL9e82dHaLbjAcC4/Vy1sJ+vwpBDGXlAEv2gx80I=;
	h=From:To:Cc:Subject:Date:From;
	b=RvQlyg/TcZxLExv0BhOJYAApo8cdiTt5ZMJxVYUjGkUW8odOezy6eRHTFMbHiYKUt
	 iROBSA64nPjMoHMt9GDy0rLyteW9sEzs7UerFelVZAX8uga0hXRo0pqz49/6KEYcTA
	 PenYCtcFTynJs97l8picYVMwDzEaNQfnR+XieyoNIUXvPdbFcTVEauS1N8I6qb+5Tw
	 YVQmVyToWhig9Ggi29rttEXIRqBiG0+eTHG7YIMxDH/1/bBc3Ss29P0ZQ7rePp55oy
	 ybJXE0SoB98VDMoK8pZ77gvk/j8nc1iuavmmbZoiSPA3VKTCM2rDB6FRT5RH0ty7P5
	 gSIzA2Tkmv9fw==
From: Kees Cook <kees@kernel.org>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] gcov: Disable GCOV_PROFILE_ALL on 32-bit UML with Clang 20/21
Date: Wed,  8 Apr 2026 09:26:12 -0700
Message-Id: <20260408162607.it.347-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387; i=kees@kernel.org; h=from:subject:message-id; bh=paRGL9e82dHaLbjAcC4/Vy1sJ+vwpBDGXlAEv2gx80I=; b=owGbwMvMwCVmps19z/KJym7G02pJDJnXGhevdv8z6bu6lLhPx4QY5zn75yyLtjBbHNTSKGP84 vsiTzePjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlor2BkOK7UoLPBc+WJCo+Q OYvMPu5axrp4qswLz55FRz9leHYqZDP8M+c97jD5+u+/x0qyXt8VtF61eBbn+Sknv036s2HPqbc aF9kA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Clang 20 and 21 miscompute __builtin_object_size() when -fprofile-arcs
is active on 32-bit UML targets, which passes incorrect object size
calculations for local variables through always_inline copy_to_user()
and check_copy_size(), causing spurious compile-time errors:

  include/linux/ucopysize.h:52:4: error: call to '__bad_copy_from' declared with 'error' attribute: copy source size is too small

The regression was introduced in LLVM commit 02b8ee281947 ("[llvm]
Improve llvm.objectsize computation by computing GEP, alloca and malloc
parameters bound"), which shipped in Clang 20. It was fixed in LLVM
by commit 45b697e610fd ("[MemoryBuiltins] Consider index type size
when aggregating gep offsets"), which was backported to the LLVM 22.x
release branch.

The bug requires 32-bit UML + GCOV_PROFILE_ALL (which uses -fprofile-arcs),
though the exact trigger depends on optimizer decisions influenced by other
enabled configs.

Prevent the broken combination by disabling GCOV_PROFILE_ALL on 32-bit
UML when using Clang 20.x or 21.x.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604030531.O6FveVgn-lkp@intel.com/
Assisted-by: Claude:claude-opus-4-6[1m]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: fixed typo in version comparison: needed < not <= (Sashiko)
 v1: https://lore.kernel.org/lkml/20260408005958.work.271-kees@kernel.org/
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: <llvm@lists.linux.dev>
---
 kernel/gcov/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 04f4ebdc3cf5..56abff785654 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -42,6 +42,9 @@ config GCOV_PROFILE_ALL
 	depends on !COMPILE_TEST
 	depends on GCOV_KERNEL
 	depends on ARCH_HAS_GCOV_PROFILE_ALL
+	# Clang 20 & 21 miscompute __builtin_object_size() under -fprofile-arcs
+	# on 32-bit UML, causing spurious compile-time errors in check_copy_size().
+	depends on !(UML && !64BIT && CC_IS_CLANG && CLANG_VERSION >= 200000 && CLANG_VERSION < 220100)
 	default n
 	help
 	This options activates profiling for the entire kernel.
-- 
2.34.1

