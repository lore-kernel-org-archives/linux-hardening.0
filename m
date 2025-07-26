Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24686207A0B;
	Sat, 26 Jul 2025 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753565389; cv=none; b=bakC8/Bidwx7p7W34So7ZEJ4RUSowXVIc8PxXM6c6MSaq+vFnXLC5Ismfsxalqds4QNGI+A2MjSdZirVZic6LaNoBdTY/sPYFLNCZkUGa5frfTc8WE/8ifCEZb6Gp76pJKCkwz97w8vELwNV6Jx4Gs656PyoDKMn3+Ib0wudUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753565389; c=relaxed/simple;
	bh=HSq9GVJebOQfQB9sT81R3PDtAZ/ze381+caKN1MH1OM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SIwQQguxAIpnPhUyuOS886B7eM+XTDyfmtM20Oup4VpePEsBgm5bCbyxJ/BoPfAk77EvNKi5CFj4E9xc9s83799ioKxaWfMHhj2uizoi3e9zpmRLnyIlhBH2h9WihUIV59SUWqUCdAzY26FMeW5ajFmRE/Pgd0VrCaLGPz0+dIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj2Xxygg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj2Xxygg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6C7C4CEED;
	Sat, 26 Jul 2025 21:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753565388;
	bh=HSq9GVJebOQfQB9sT81R3PDtAZ/ze381+caKN1MH1OM=;
	h=From:To:Cc:Subject:Date:From;
	b=Uj2Xxygg6ssYQsxZ5CxC4TyGoFDgIJEJFPw5gPQIiKSgwcvSqDG9L2HF78J7DeG73
	 2tDtC6VaTvX9N+K9ZFhrcUdUSSnbivKWxJYLlpPDhw1t11czrS3oDB/XBfAtG2R+VV
	 TuspiNNBbE0AIN9OCJNKo6DbR2a0a3ZSV+30Hk7/x2LIdmKOzz3WKTZlDop6XuMVO4
	 q8QWSW8wl/lTW/jrTqGPzsn3V+OMKmYzBbePZVQxov4CpZa3aSsVVxKZ0d65A9TH/5
	 sFmm1ADshAGOYue6kWXL8ssA5wlvOARnrV7vydTx2az71RSEXtsXp3trJhAW+c8BmB
	 vtXYdO1gpjT4Q==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] kstack_erase: Disable kstack_erase for all of arm compressed boot code
Date: Sat, 26 Jul 2025 14:29:45 -0700
Message-Id: <20250726212945.work.975-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=kees@kernel.org; h=from:subject:message-id; bh=HSq9GVJebOQfQB9sT81R3PDtAZ/ze381+caKN1MH1OM=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmtHiffaX4tSiqs9K65/7rYQtbQ4mFj+8e4R+pVZmtf3 is/ayjdUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJE1nxgZ5t1q1Dl54euh+Ojd xYevtGn/PjVj3pYgc6aPyxJmbZZW0WD4X5zKMVlatP39hnx3p9nLkzautbP3mf7DiWHBQu1ze8o ncQMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When building with CONFIG_KSTACK_ERASE=y and CONFIG_ARM_ATAG_DTB_COMPAT=y,
the compressed boot environment encounters an undefined symbol error:

    ld.lld: error: undefined symbol: __sanitizer_cov_stack_depth
    >>> referenced by atags_to_fdt.c:135

This occurs because the compiler instruments the atags_to_fdt() function
with sanitizer coverage calls, but the minimal compressed boot environment
lacks access to sanitizer runtime support.

The compressed boot environment already disables stack protector with
-fno-stack-protector. Similarly disable sanitizer coverage by adding
$(DISABLE_KSTACK_ERASE) to the general compiler flags (and remove it
from the one place it was noticed before), which contains the appropriate
flags to prevent sanitizer instrumentation.

This follows the same pattern used in other early boot contexts where
sanitizer runtime support is unavailable.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYtBk8qnpWvoaFwymCx5s5i-5KXtPGpmf=_+UKJddCOnLA@mail.gmail.com
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20250726004313.GA3650901@ax162
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/arm/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index f9075edfd773..a159120d1e42 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -9,7 +9,6 @@ OBJS		=
 
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
-CFLAGS_decompress.o += $(DISABLE_KSTACK_ERASE)
 ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
 OBJS	+= debug.o
 AFLAGS_head.o += -DDEBUG
@@ -96,6 +95,7 @@ KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 
 ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin \
 	     -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
+	     $(DISABLE_KSTACK_ERASE) \
 	     -I$(obj)
 ccflags-remove-$(CONFIG_FUNCTION_TRACER) += -pg
 asflags-y := -DZIMAGE
-- 
2.34.1

