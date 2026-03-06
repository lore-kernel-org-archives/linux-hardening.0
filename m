Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C773AE6FB;
	Fri,  6 Mar 2026 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809580; cv=none; b=KoBYFWyMT2l4KzAcza4m6IQVEaeRVeQIagZ46DLSOGHDkyEP/7SfL6D4gllfDWPShnk/XITtXrdkBMLCW+7grumFdzdWymjgoTK0AxUOCNthOSCI61hreU8/x2jJXcmQYfyUfR59Wx46ify3e9piHPQKFDGM4n5rnvTc2/5EDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809580; c=relaxed/simple;
	bh=Kvw8Ndr8jNcvE5TUiNuyuhdLOCnX6CEmPLgxPo8iI8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nYkw/rT8uQb2uGbmBdy3FyVXOZ87omaI3N+fepLYHIGrdw12EthO4Y7kSTHHwiiPVdlRWvOWoYyHg4FAVL7YqqqFL1y1U9XDT+oOtoeUkcSjojS2BlAA8GqoMGAtv3MvGYeit2AK4uoky+XBLJQYcDHq2uMUpqdA66uGjW1XxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDpuoWA5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDpuoWA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CE7C2BC9E;
	Fri,  6 Mar 2026 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772809579;
	bh=Kvw8Ndr8jNcvE5TUiNuyuhdLOCnX6CEmPLgxPo8iI8Y=;
	h=From:To:Cc:Subject:Date:From;
	b=IDpuoWA53nsMphSgS8EwODEhFc2GC96LBFngQoBVQP7okdRu+cE0gAD+4oqXe7XJs
	 BAHT0AP57c3iP7+JO2Z3diywzNust+4eWUMLT6Pv9qfpZ0kztZ/WqyW5Y20fS5uWS8
	 PN+mNjueixgYlb0/Tx2RrAD7hxnuGOfKmdhX+ZJRWQWvbjJb6KXISaP3MTIG2vQIDX
	 93RDSDJEboXQM0NnWQqkm9VWKV3W9U97siXZl52aZTRY6xPS+4LYKryPP29jthfNnb
	 AsRnraJi38dnhwHznErBobRFUhUxmTmrRgQoa1gWmYpsMP5qNUA7pvVNDhNL54Bw4B
	 2RIMA7Z35EBag==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ubsan: turn off kmsan inside of ubsan instrumentation
Date: Fri,  6 Mar 2026 16:05:49 +0100
Message-Id: <20260306150613.350029-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The structure initialization in the two type mismatch handling functions
causes a call to __msan_memset() to be generated inside of a UACCESS
block, which in turn leads to an objtool warning about possibly leaking
uaccess-enabled state:

lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch+0xda: call to __msan_memset() with UACCESS enabled
lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch_v1+0xf4: call to __msan_memset() with UACCESS enabled

Most likely __msan_memset() is safe to be called here and could be added
to the uaccess_safe_builtin[] list of safe functions, but seeing that
the ubsan file itself already has kasan, ubsan and kcsan disabled itself,
it is probably a good idea to also turn off kmsan here, in particular this
also avoids the risk of recursing between ubsan and kcsan checks in
other functions of this file.

I saw this happen while testing randconfig builds with clang-22, but did
not try older versions, or attempt to see which kernel change introduced
the warning.

Cc: Kees Cook <kees@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Makefile b/lib/Makefile
index 280a71e4f813..3e1eeefd9832 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -306,6 +306,7 @@ obj-$(CONFIG_UBSAN) += ubsan.o
 UBSAN_SANITIZE_ubsan.o := n
 KASAN_SANITIZE_ubsan.o := n
 KCSAN_SANITIZE_ubsan.o := n
+KMSAN_SANITIZE_ubsan.o := n
 CFLAGS_ubsan.o := -fno-stack-protector $(DISABLE_KSTACK_ERASE)
 
 obj-$(CONFIG_SBITMAP) += sbitmap.o
-- 
2.39.5

