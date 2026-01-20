Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E737A49C;
	Tue, 20 Jan 2026 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892357; cv=none; b=dIAcOaEewg/o/cuygLcOCHrgbBScWZ8Pf5tEERY+sp3Rds3FOztDodAg16Mm0mzvXNfGv2K22NmiguuzKQpJ4OzWzXgFhj0xLhym5IAy6tspyA50KpJVDVS6F6rrYSz1/Pkd0FWnaKN5GWeX7wGAaKJF0mct+CxD77M3z5FguTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892357; c=relaxed/simple;
	bh=E4SNZytbhkJgmeZCkP4s6niTOoTmDqj758gCC8dkano=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4CsDyLT90nKw6Wp/2MtfAUQRfyKF54ttwlMN6biRQKWa7fC53Tnt3KLPL/us9Vzt1n1YCQeo9sAIa3NkIBzly0lfIOEqGIF44AtW/xuyvlZQU1XXGGwIgDctIYOlEKJNo3sFeA8J2et2MtbWjcAaEXcBmWbN18EpckFDPC4DnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7e56caaaf5cd11f0b0f03b4cfa9209d1-20260120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7c7b3d0f-0de2-45f6-8d98-b583270c1234,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:c221de7e3d13d1b5b960f3103e7d49ad,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7e56caaaf5cd11f0b0f03b4cfa9209d1-20260120
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 321619247; Tue, 20 Jan 2026 14:58:58 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	kees@kernel.org,
	andy@kernel.org,
	jiangfeng@kylinos.cn,
	ebiggers@kernel.org,
	martin.petersen@oracle.com,
	ardb@kernel.org,
	charlie@rivosinc.com,
	conor.dooley@microchip.com,
	ajones@ventanamicro.com,
	linus.walleij@linaro.org,
	nathan@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 1/8] lib/string_kunit: add correctness test for strlen
Date: Tue, 20 Jan 2026 14:58:45 +0800
Message-Id: <20260120065852.166857-2-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260120065852.166857-1-jiangfeng@kylinos.cn>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KUnit test for strlen() to verify correctness across
different string lengths and memory alignments.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Tested-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 lib/tests/string_kunit.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index f9a8e557ba77..88da97e50c8e 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -17,6 +17,9 @@
 #define STRCMP_TEST_EXPECT_LOWER(test, fn, ...) KUNIT_EXPECT_LT(test, fn(__VA_ARGS__), 0)
 #define STRCMP_TEST_EXPECT_GREATER(test, fn, ...) KUNIT_EXPECT_GT(test, fn(__VA_ARGS__), 0)
 
+#define STRING_TEST_MAX_LEN	128
+#define STRING_TEST_MAX_OFFSET	16
+
 static void string_test_memset16(struct kunit *test)
 {
 	unsigned i, j, k;
@@ -104,6 +107,28 @@ static void string_test_memset64(struct kunit *test)
 	}
 }
 
+static void string_test_strlen(struct kunit *test)
+{
+	char *s;
+	size_t len, offset;
+	const size_t buf_size = STRING_TEST_MAX_LEN + STRING_TEST_MAX_OFFSET + 1;
+
+	s = kunit_kzalloc(test, buf_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s);
+
+	memset(s, 'A', buf_size);
+	s[buf_size - 1] = '\0';
+
+	for (offset = 0; offset < STRING_TEST_MAX_OFFSET; offset++) {
+		for (len = 0; len <= STRING_TEST_MAX_LEN; len++) {
+			s[offset + len] = '\0';
+			KUNIT_EXPECT_EQ_MSG(test, strlen(s + offset), len,
+				"offset:%zu len:%zu", offset, len);
+			s[offset + len] = 'A';
+		}
+	}
+}
+
 static void string_test_strchr(struct kunit *test)
 {
 	const char *test_string = "abcdefghijkl";
@@ -618,6 +643,7 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_memset16),
 	KUNIT_CASE(string_test_memset32),
 	KUNIT_CASE(string_test_memset64),
+	KUNIT_CASE(string_test_strlen),
 	KUNIT_CASE(string_test_strchr),
 	KUNIT_CASE(string_test_strnchr),
 	KUNIT_CASE(string_test_strspn),
-- 
2.25.1

