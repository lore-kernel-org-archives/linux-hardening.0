Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015623E346;
	Tue, 27 Jan 2026 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477188; cv=none; b=PYU2OnSS8PI9O9mobPqoRaQ7yVVAU+XXTx8ykn/ZEHn1vKdTcCzV+AQkUJX0OPoPWu1wLAUpkOzVP4U1KlOKt39NO1I+ronGequDlxOpAJ/GsJpp4REyDD8aQFAemEVmVafCGyXx+bhLvsbxqPdUPEuiDvKQ/iWRMB+VG3staV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477188; c=relaxed/simple;
	bh=G3JduIQ0bYDMiO7BzZxEuhqqJowH3AYuMESNCYPa5mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hEf3SEdIs0Gien1ODIPpWR61TGFaF6s5mP/R9KcOTegHq53+c71z9qGOa7G+g3bWsKmYWMXlyJmUHRl+gPz8ByeJlCCqhkHa2wXgi0C3idCZpHfdmP1Xu6Y3n1aNgqSS2ZR5zHpb3CwzDCOfmd00gpA5JZv48YzrS5hB4Vygk6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2f497c1cfb1f11f0b0f03b4cfa9209d1-20260127
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2a4ca430-e0fe-4b59-a8bf-8bb8da9c2c0d,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:7fa9e6fe111993874ae748b0cc659389,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2f497c1cfb1f11f0b0f03b4cfa9209d1-20260127
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 838438080; Tue, 27 Jan 2026 09:26:20 +0800
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
	sohil.mehta@intel.com,
	charlie@rivosinc.com,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	linus.walleij@linaro.org,
	nathan@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH v5 2/8] lib/string_kunit: add correctness test for strnlen()
Date: Tue, 27 Jan 2026 09:25:52 +0800
Message-Id: <20260127012558.40025-3-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260127012558.40025-1-jiangfeng@kylinos.cn>
References: <20260127012558.40025-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KUnit test for strnlen() to verify correctness across
different string lengths and memory alignments.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
Acked-by: Andy Shevchenko <andy@kernel.org>
Tested-by: Joel Stanley <joel@jms.id.au>
---
 lib/tests/string_kunit.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index bc5130c6e5e9..991f01d52eb2 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -129,6 +129,38 @@ static void string_test_strlen(struct kunit *test)
 	}
 }
 
+static void string_test_strnlen(struct kunit *test)
+{
+	const size_t buf_size = STRING_TEST_MAX_LEN + STRING_TEST_MAX_OFFSET + 1;
+	size_t len, offset;
+	char *s;
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
+
+			if (len > 0)
+				KUNIT_EXPECT_EQ(test, strnlen(s + offset, len - 1), len - 1);
+			if (len > 1)
+				KUNIT_EXPECT_EQ(test, strnlen(s + offset, len - 2), len - 2);
+
+			KUNIT_EXPECT_EQ(test, strnlen(s + offset, len), len);
+
+			KUNIT_EXPECT_EQ(test, strnlen(s + offset, len + 1), len);
+			KUNIT_EXPECT_EQ(test, strnlen(s + offset, len + 2), len);
+			KUNIT_EXPECT_EQ(test, strnlen(s + offset, len + 10), len);
+
+			s[offset + len] = 'A';
+		}
+	}
+}
+
 static void string_test_strchr(struct kunit *test)
 {
 	const char *test_string = "abcdefghijkl";
@@ -644,6 +676,7 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_memset32),
 	KUNIT_CASE(string_test_memset64),
 	KUNIT_CASE(string_test_strlen),
+	KUNIT_CASE(string_test_strnlen),
 	KUNIT_CASE(string_test_strchr),
 	KUNIT_CASE(string_test_strnchr),
 	KUNIT_CASE(string_test_strspn),
-- 
2.25.1

