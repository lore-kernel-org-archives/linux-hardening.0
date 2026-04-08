Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C932D0CC;
	Wed,  8 Apr 2026 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610009; cv=none; b=LKtTZFxMiFVvfmGfuFtnNDiUjMfkTEKDg121nlDM7B0ypQEwzsmpqL6QR1aTI0LtAG0LM4cTIS1eZte1EHqsZtBqAiwJ97z0Iah63GW7xy6sDHblHUsn695vmiagxriIgenBNrF3TfhHWrjBdZahYrGM/O7Kh/RpwyOO/HhDlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610009; c=relaxed/simple;
	bh=0HDIYdAS3TdACnQ7Zzuvd6WtzLpKicWfd2xZMNjdbmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YLNBvXWLJw6sQ+NJaR3mUKz+ga0ABvMmoVjLTdPXW9W1ZgD0JO4wm7OEtI/CBGRiDSKYhSw0qNhefVgZfK3tGyvx6tWv2tTNtq7edKjn9oV3QluoHyo+79hHbxAZq3Tdk41rSjSVzlphxAcfFXLb0QL3ZdJIjdKMCQvrOiDR1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDveATMt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDveATMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A898C116C6;
	Wed,  8 Apr 2026 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610005;
	bh=0HDIYdAS3TdACnQ7Zzuvd6WtzLpKicWfd2xZMNjdbmE=;
	h=From:To:Cc:Subject:Date:From;
	b=HDveATMtP6e8TE6Gr7ebwzSv1XaXgaPrBrQqC23CriT11y1DVygwgjpSy5xev0sLR
	 FdLn7m9O2AbiYUCXZ//NSjQyUihyKcvlli9tHUgnMZnqCjIyWv80LdyUTOJzkPAtYU
	 H0rQrCfBkCLN3YXeUrPQG0fVbODDt9vvTjN9dku056acHoNKCdJY4yqNH0PqGveDkP
	 Nw5g7lgyh+tnAu0l7HbX4vWDJua4EToc6KIT+22HXbyNT5Q4gANzOVeH8U7QvenLVq
	 ICCNIdBuC9AnVp3rnU+zD8h6FFGbKuHIqM6rJml+hlZpqda58wPhJEhK9MyTsvmVcX
	 HbjYbeUEU7HWQ==
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
Subject: [PATCH] gcov: Disable GCOV_PROFILE_ALL on 32-bit UML with Clang 20/21
Date: Tue,  7 Apr 2026 18:00:02 -0700
Message-Id: <20260408005958.work.271-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246; i=kees@kernel.org; h=from:subject:message-id; bh=0HDIYdAS3TdACnQ7Zzuvd6WtzLpKicWfd2xZMNjdbmE=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlXV0yseverZeKngreb00XTgzeopsd7dOUFrD/sVRDmE PE5JOZtRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEUWMDLssWnV/m0+KURQrnLL khpRjf77vVOOFJ09kemXKx9UrazHyPCo4ebPmlmBXV6W1pOjf/4S41lq/2PJY6WXO5hSVW5c/88 IAA==
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
index 04f4ebdc3cf5..11c377019d01 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -42,6 +42,9 @@ config GCOV_PROFILE_ALL
 	depends on !COMPILE_TEST
 	depends on GCOV_KERNEL
 	depends on ARCH_HAS_GCOV_PROFILE_ALL
+	# Clang 20 & 21 miscompute __builtin_object_size() under -fprofile-arcs
+	# on 32-bit UML, causing spurious compile-time errors in check_copy_size().
+	depends on !(UML && !64BIT && CC_IS_CLANG && CLANG_VERSION >= 200000 && CLANG_VERSION <= 220100)
 	default n
 	help
 	This options activates profiling for the entire kernel.
-- 
2.34.1

