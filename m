Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598F246BC7;
	Tue, 27 Jan 2026 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477190; cv=none; b=NYHYEitoR9LYp+GBridhlxkNHKt9WOHxYwTTCJcD0dtdBmGYeApkWuBxs1s13BhrTPvSo5CYLIUsJ1/eMH+ZctQxh37I5fvpVv4yn70PsekihlwGayVqbk/HBfqNrz6mOQNcMKzpna7K2y2xP+HU/iTdyYGJTQs7Xr+xvEehrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477190; c=relaxed/simple;
	bh=gdp0TkFXB6tIKP75KCs0gmk3wZBq+K9AMFnNVtN0+zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWCJrhG00KfebW4/3ATnDtivMu7p8pS0SyHOltWvnahB4DvC5NzL5hQv1JnPUOKrdwsygUlDKhWLG2Ycm61FHt4de/np9mIljyzPdx0MBnMsUl7fsNUXIIUj/bHrSUOUsgvqyuHMrjy79NR7IgwfhuwGZmusrta9cs+n7xpXgy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2fb64fe0fb1f11f0b0f03b4cfa9209d1-20260127
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:d4ca1490-5d8d-4a91-ac0a-51a841116038,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:876203e88ad206fc665525193757f4da,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2fb64fe0fb1f11f0b0f03b4cfa9209d1-20260127
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1638620801; Tue, 27 Jan 2026 09:26:21 +0800
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
Subject: [PATCH v5 3/8] lib/string_kunit: add correctness test for strrchr()
Date: Tue, 27 Jan 2026 09:25:53 +0800
Message-Id: <20260127012558.40025-4-jiangfeng@kylinos.cn>
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

Introduce a KUnit test to verify strrchr() across various memory
alignments and character positions. This ensures the implementation
correctly identifies the last occurrence of a character.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
Acked-by: Andy Shevchenko <andy@kernel.org>
Tested-by: Joel Stanley <joel@jms.id.au>
---
 lib/tests/string_kunit.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 991f01d52eb2..7f1e2bf6a352 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -184,6 +184,35 @@ static void string_test_strchr(struct kunit *test)
 	KUNIT_ASSERT_NULL(test, result);
 }
 
+static void string_test_strrchr(struct kunit *test)
+{
+	const size_t buf_size = STRING_TEST_MAX_LEN + STRING_TEST_MAX_OFFSET + 1;
+	size_t offset, len;
+	char *buf;
+
+	buf = kunit_kzalloc(test, buf_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	memset(buf, 'A', buf_size);
+	buf[buf_size - 1] = '\0';
+
+	for (offset = 0; offset < STRING_TEST_MAX_OFFSET; offset++) {
+		for (len = 0; len <= STRING_TEST_MAX_LEN; len++) {
+			buf[offset + len] = '\0';
+
+			KUNIT_EXPECT_PTR_EQ(test, strrchr(buf + offset, 'Z'), NULL);
+
+			if (len > 0)
+				KUNIT_EXPECT_PTR_EQ(test, strrchr(buf + offset, 'A'),
+						buf + offset + len - 1);
+			else
+				KUNIT_EXPECT_PTR_EQ(test, strrchr(buf + offset, 'A'), NULL);
+
+			buf[offset + len] = 'A';
+		}
+	}
+}
+
 static void string_test_strnchr(struct kunit *test)
 {
 	const char *test_string = "abcdefghijkl";
@@ -679,6 +708,7 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_strnlen),
 	KUNIT_CASE(string_test_strchr),
 	KUNIT_CASE(string_test_strnchr),
+	KUNIT_CASE(string_test_strrchr),
 	KUNIT_CASE(string_test_strspn),
 	KUNIT_CASE(string_test_strcmp),
 	KUNIT_CASE(string_test_strcmp_long_strings),
-- 
2.25.1

