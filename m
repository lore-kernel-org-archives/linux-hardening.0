Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F8D27CB08;
	Tue,  4 Mar 2025 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128979; cv=none; b=XgoSVsIv5Az2SkmaMdMaNJCP5A2w7NVnf/sJSEedIlPKdsSuR3hU7XwqnDN9v16ARMB6h9ojTNHNRz4KVGldmSmYFzxd/s9CJquZxe0UC0x50Fif7BbVCy1k/s+bms98xJdV9vj0gISu+PGyBRedAMkCx35uDja8esZ8Ioa8PrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128979; c=relaxed/simple;
	bh=n+/WSocsvdBPUsvMvUSOulmX88PqQT4UKt2KUc6G5RI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e3UNSEfKU2WGuKTmJjByIUaB1y+SjeVCwqbjzM3PccjvpLn/HbVnPFlxrLcX53eAvaHQiDh9i4DZQMtuLR1ZLT9Elejp4FtH7Fya8RCS9HlD1iD2VTlQE4SLNFAynNqBYLmiF1LZCVdzuDx6B750N4K/n+nz2ldGGAY0j6LaSL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+wJw5rN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+wJw5rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ACBC4CEE8;
	Tue,  4 Mar 2025 22:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741128979;
	bh=n+/WSocsvdBPUsvMvUSOulmX88PqQT4UKt2KUc6G5RI=;
	h=From:To:Cc:Subject:Date:From;
	b=Y+wJw5rN7vp9GhuO2zWNZiwQ4YFK5ObJ+Df8sf+TUjJvvknpDpXUYYIvN/GB2gYlf
	 ffGmHdh7Vzx/nqBZiUVQm6ZQ95RuYFmC6LxWwJn2WAPy3nJpKs07i4b5Fw6Lw3I/Ah
	 ZIfO9TR1ntiGK9rAv7VwB79YrF9faoq5BkqBpFo8Kr07nqUg8hFx/wJmxhAm6SEXfh
	 4ENoVeRk4oVuO3fvwjpQ36MzYPPX+NproebohxIpSoC6L1fWqbCZw/BTxc9Zi0pBVE
	 kLwsIVlU9TaEcM//KNMIExTXXXiFECMAuAr3DJ7+DUWSIqKA9nQHBz5XW2UoAXCzW8
	 HE3QesiiHqGNA==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	David Gow <davidgow@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] kunit/stackinit: Use fill byte different from Clang i386 pattern
Date: Tue,  4 Mar 2025 14:56:11 -0800
Message-Id: <20250304225606.work.030-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4717; i=kees@kernel.org; h=from:subject:message-id; bh=n+/WSocsvdBPUsvMvUSOulmX88PqQT4UKt2KUc6G5RI=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnHW7kq5TO/i6ubCe/xdNLVttp55kGiAO/l94YPFLjOX p/50/5pRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwESW+TD8r7vPedcpaXfBtft6 txPnfZPf9PqmpdWj9MNZ1o9doy/kqzAyXD3go1b3bHW4ourffzUth0VvVhlxK2Zd2po99dcv0ws unAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The byte initialization values used with -ftrivial-auto-var-init=pattern
(CONFIG_INIT_STACK_ALL_PATTERN=y) depends on the compiler, architecture,
and byte position relative to struct member types. On i386 with Clang,
this includes the 0xFF value, which means it looks like nothing changes
between the leaf byte filling pass and the expected "stack wiping"
pass of the stackinit test.

Use the byte fill value of 0x99 instead, fixing the test for i386 Clang
builds.

Reported-by: ernsteiswuerfel
Closes: https://github.com/ClangBuiltLinux/linux/issues/2071
Fixes: 8c30d32b1a32 ("lib/test_stackinit: Handle Clang auto-initialization pattern")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: llvm@lists.linux.dev
---
 lib/tests/stackinit_kunit.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/lib/tests/stackinit_kunit.c b/lib/tests/stackinit_kunit.c
index 135322592faf..63aa78e6f5c1 100644
--- a/lib/tests/stackinit_kunit.c
+++ b/lib/tests/stackinit_kunit.c
@@ -184,6 +184,15 @@ static bool stackinit_range_contains(char *haystack_start, size_t haystack_size,
 #define INIT_UNION_assigned_copy(var_type)		\
 	INIT_STRUCT_assigned_copy(var_type)
 
+/*
+ * The "did we actually fill the stack?" check value needs
+ * to be neither 0 nor any of the "pattern" bytes. The
+ * pattern bytes are compiler, architecture, and type based,
+ * so we have to pick a value that never appears for those
+ * combinations. Use 0x99 which is not 0xFF, 0xFE, nor 0xAA.
+ */
+#define FILL_BYTE	0x99
+
 /*
  * @name: unique string name for the test
  * @var_type: type to be tested for zeroing initialization
@@ -206,12 +215,12 @@ static noinline void test_ ## name (struct kunit *test)		\
 	ZERO_CLONE_ ## which(zero);				\
 	/* Clear entire check buffer for 0xFF overlap test. */	\
 	memset(check_buf, 0x00, sizeof(check_buf));		\
-	/* Fill stack with 0xFF. */				\
+	/* Fill stack with FILL_BYTE. */			\
 	ignored = leaf_ ##name((unsigned long)&ignored, 1,	\
 				FETCH_ARG_ ## which(zero));	\
-	/* Verify all bytes overwritten with 0xFF. */		\
+	/* Verify all bytes overwritten with FILL_BYTE. */	\
 	for (sum = 0, i = 0; i < target_size; i++)		\
-		sum += (check_buf[i] != 0xFF);			\
+		sum += (check_buf[i] != FILL_BYTE);		\
 	/* Clear entire check buffer for later bit tests. */	\
 	memset(check_buf, 0x00, sizeof(check_buf));		\
 	/* Extract stack-defined variable contents. */		\
@@ -222,7 +231,8 @@ static noinline void test_ ## name (struct kunit *test)		\
 	 * possible between the two leaf function calls.	\
 	 */							\
 	KUNIT_ASSERT_EQ_MSG(test, sum, 0,			\
-			    "leaf fill was not 0xFF!?\n");	\
+			    "leaf fill was not 0x%02X!?\n",	\
+			    FILL_BYTE);				\
 								\
 	/* Validate that compiler lined up fill and target. */	\
 	KUNIT_ASSERT_TRUE_MSG(test,				\
@@ -234,9 +244,9 @@ static noinline void test_ ## name (struct kunit *test)		\
 		(int)((ssize_t)(uintptr_t)fill_start -		\
 		      (ssize_t)(uintptr_t)target_start));	\
 								\
-	/* Look for any bytes still 0xFF in check region. */	\
+	/* Validate check region has no FILL_BYTE bytes. */	\
 	for (sum = 0, i = 0; i < target_size; i++)		\
-		sum += (check_buf[i] == 0xFF);			\
+		sum += (check_buf[i] == FILL_BYTE);		\
 								\
 	if (sum != 0 && xfail)					\
 		kunit_skip(test,				\
@@ -271,12 +281,12 @@ static noinline int leaf_ ## name(unsigned long sp, bool fill,	\
 	 * stack frame of SOME kind...				\
 	 */							\
 	memset(buf, (char)(sp & 0xff), sizeof(buf));		\
-	/* Fill variable with 0xFF. */				\
+	/* Fill variable with FILL_BYTE. */			\
 	if (fill) {						\
 		fill_start = &var;				\
 		fill_size = sizeof(var);			\
 		memset(fill_start,				\
-		       (char)((sp & 0xff) | forced_mask),	\
+		       FILL_BYTE & forced_mask,			\
 		       fill_size);				\
 	}							\
 								\
@@ -469,7 +479,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
 			fill_start = &var;
 			fill_size = sizeof(var);
 
-			memset(fill_start, forced_mask | 0x55, fill_size);
+			memset(fill_start, (forced_mask | 0x55) & FILL_BYTE, fill_size);
 		}
 		memcpy(check_buf, target_start, target_size);
 		break;
@@ -480,7 +490,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
 			fill_start = &var;
 			fill_size = sizeof(var);
 
-			memset(fill_start, forced_mask | 0xaa, fill_size);
+			memset(fill_start, (forced_mask | 0xaa) & FILL_BYTE, fill_size);
 		}
 		memcpy(check_buf, target_start, target_size);
 		break;
-- 
2.34.1

