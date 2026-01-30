Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E583330D22;
	Fri, 30 Jan 2026 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741445; cv=none; b=WwXe9IHVJ7IBIiaR3bW1PebeRnrR9vSCsHlmW4v0lS1XwkBBw/RbyzKLZYyk90XdcVMjqYiPpzPnIwayc65Y6LYjcZNL2S9QJW9Q2yaWwtObmM+LA+rAaA4y3ZiJ1xXm+dvBBe0uzOVEBPHcw+RKBPHTX9vpsXBU60E3rB7/tZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741445; c=relaxed/simple;
	bh=Cn8EcKDtg67A+WhdOux+iiVR9oVtZJ1AqJ8IVq+adWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTYv3qJQbQb0UecZ8JP3NvQ00TiXbq7r4SxdVyplT3psHGP03yK7TeWNDapNc57FvXmi2ua2sD5sKV2gHW7H2NLIyRlnbrojdDp4oRbddTXGGsl4QSSr9mz3+JnA7smDmpMWxL9w0d9i2WpCOaOJPchoWjUe1xTSJ6v682hSb3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 72acacd6fd8611f0b0f03b4cfa9209d1-20260130
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3a394fd2-a942-44c1-93c2-95d1243cc759,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:da19a108f6faa902453c68c6cfc2ad68,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 72acacd6fd8611f0b0f03b4cfa9209d1-20260130
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2145541441; Fri, 30 Jan 2026 10:50:33 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	kees@kernel.org,
	andy@kernel.org,
	jiangfeng@kylinos.cn,
	ebiggers@kernel.org,
	martin.petersen@oracle.com,
	herbert@gondor.apana.org.au,
	samuel.holland@sifive.com,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	charlie@rivosinc.com,
	nathan@kernel.org,
	linusw@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v7 1/8] lib/string_kunit: add correctness test for strlen()
Date: Fri, 30 Jan 2026 10:50:11 +0800
Message-Id: <20260130025018.172925-2-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260130025018.172925-1-jiangfeng@kylinos.cn>
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KUnit test for strlen() to verify correctness across
different string lengths and memory alignments. Use vmalloc()
to place the NUL character at the page boundary to ensure
over-reads are detected.

Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 lib/tests/string_kunit.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index f9a8e557ba77..26962118768e 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -6,10 +6,12 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <kunit/test.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/vmalloc.h>
 
 #define STRCMP_LARGE_BUF_LEN 2048
 #define STRCMP_CHANGE_POINT 1337
@@ -17,6 +19,9 @@
 #define STRCMP_TEST_EXPECT_LOWER(test, fn, ...) KUNIT_EXPECT_LT(test, fn(__VA_ARGS__), 0)
 #define STRCMP_TEST_EXPECT_GREATER(test, fn, ...) KUNIT_EXPECT_GT(test, fn(__VA_ARGS__), 0)
 
+#define STRING_TEST_MAX_LEN	128
+#define STRING_TEST_MAX_OFFSET	16
+
 static void string_test_memset16(struct kunit *test)
 {
 	unsigned i, j, k;
@@ -104,6 +109,30 @@ static void string_test_memset64(struct kunit *test)
 	}
 }
 
+static void string_test_strlen(struct kunit *test)
+{
+	size_t buf_size;
+	char *buf, *s;
+
+	buf_size = PAGE_ALIGN(STRING_TEST_MAX_LEN + STRING_TEST_MAX_OFFSET + 1);
+	buf = vmalloc(buf_size);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	memset(buf, 'A', buf_size);
+
+	for (size_t offset = 0; offset < STRING_TEST_MAX_OFFSET; offset++) {
+		for (size_t len = 0; len <= STRING_TEST_MAX_LEN; len++) {
+			s = buf + buf_size - 1 - offset - len;
+			s[len] = '\0';
+			KUNIT_EXPECT_EQ_MSG(test, strlen(s), len,
+				"offset:%zu len:%zu", offset, len);
+			s[len] = 'A';
+		}
+	}
+
+	vfree(buf);
+}
+
 static void string_test_strchr(struct kunit *test)
 {
 	const char *test_string = "abcdefghijkl";
@@ -618,6 +647,7 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_memset16),
 	KUNIT_CASE(string_test_memset32),
 	KUNIT_CASE(string_test_memset64),
+	KUNIT_CASE(string_test_strlen),
 	KUNIT_CASE(string_test_strchr),
 	KUNIT_CASE(string_test_strnchr),
 	KUNIT_CASE(string_test_strspn),
-- 
2.25.1

