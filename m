Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153228E0;
	Thu,  9 Apr 2026 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775712044; cv=none; b=PgXEUq40yMw28w/SpUBhurBSVm8eDL8H8A8rElYzrc3e80/HZg57H8MdjffsqOgtTouxDkS5iVJ1s5Oj3boFf3vWy1J6/MZ7Gfqxs68J4rdsgqZ5u5nOSnY7nz9XO1Fgc2cv3DY6oYVbguYFSzcwLuSLZXB5oFK5hjxdArLCX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775712044; c=relaxed/simple;
	bh=iSD8lx//1/eG9pu6VCuAmWIXKptBjif+THnfHLu57Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GM4U/ZjEMm1jBHpckOJ+ud6k3x+aD7aSuKQgJfPHTQdEGuIGatxTfVvYR3DF99tPbnJDOG4N3O2Gflquum0laDXol/7SabnYNJStbVG1VdnVbCnV3nU0BlnN8mee892s0Y9DeBnrmIbJQk8ZVmuPTEQc3eTZ/0lO8cLhBZapHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6e803eG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6e803eG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AEDC4CEF7;
	Thu,  9 Apr 2026 05:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775712044;
	bh=iSD8lx//1/eG9pu6VCuAmWIXKptBjif+THnfHLu57Wc=;
	h=From:To:Cc:Subject:Date:From;
	b=s6e803eGHZ7f5pAcGpSy62LjCUmp2EEphoJ7K+n5FnrTALwXBY/E9jYyD/AhavxA8
	 f5o58JeRKyuX7aQ/9wxppGcImlZcsRRWBde6yOqJLcdzbqRnCPoKQ8BlkfW/QxYtot
	 yrtETniNog8G+DzzuvH+5vNjISUWudoTFmtsTUfnDwYXTt16YzwUVIDTH6xtSpSvOL
	 JggL868gL33D2gDQjZuWvbKC/siKN72J8GQ90txUl/fMy5NXDhKecgNwiB2kX4s7X0
	 UDdDFDYuh6klvc4UrpNm4x/Xd2F6meVVbp+SIhQG2GhcWyYB0qB1R8oEK61HeqXrUc
	 d8ClQdT2trLfQ==
From: Kees Cook <kees@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] gcov: Disable GCOV_PROFILE_ALL on 32-bit UML with Clang 20/21
Date: Wed,  8 Apr 2026 22:20:42 -0700
Message-Id: <20260409052038.make.995-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=kees@kernel.org; h=from:subject:message-id; bh=iSD8lx//1/eG9pu6VCuAmWIXKptBjif+THnfHLu57Wc=; b=owGbwMvMwCVmps19z/KJym7G02pJDJnXzbXmbQrbJ+OnZaHhK/M/hX/p6mS3doXdIQ7ZSn/Fu BhNfAo7SlkYxLgYZMUUWYLs3ONcPN62h7vPVYSZw8oEMoSBi1MAJsLAwPA//tFOTYGCSH6Oy2cU n/Q92F/85+jv+R67uGc/ab7HyHA2meF/3C/pD2v1lq7b86Jo+9tr288HMlqtOfhTUTWRh0OBTU+ XAwA=
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

Prevent the bad combination by disabling UML's ARCH_HAS_GCOV_PROFILE_ALL
on 32-bit when using Clang 20.x or 21.x.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604030531.O6FveVgn-lkp@intel.com/
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Assisted-by: Claude:claude-opus-4-6[1m]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v3: disable via ARCH_HAS_GCOV_PROFILE_ALL instead (Nathan)
 v2: https://lore.kernel.org/lkml/20260408162607.it.347-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20260408005958.work.271-kees@kernel.org/
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: <llvm@lists.linux.dev>
Cc: <linux-um@lists.infradead.org>
---
 arch/um/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 098cda44db22..d9541d13d9eb 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -11,7 +11,9 @@ config UML
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
-	select ARCH_HAS_GCOV_PROFILE_ALL
+	# Clang 20 & 21 miscompute __builtin_object_size() under -fprofile-arcs
+	# on 32-bit, causing spurious compile-time errors in check_copy_size().
+	select ARCH_HAS_GCOV_PROFILE_ALL if !(!64BIT && CLANG_VERSION >= 200000 && CLANG_VERSION < 220100)
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-- 
2.34.1

