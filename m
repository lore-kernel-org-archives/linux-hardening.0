Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE5C30F92D;
	Tue, 26 May 2026 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785976; cv=none; b=JlGTdKNbyoljgZSmlevaG+/NN5l82zlBsa0UaI0OGsoLK5jWuk/I+bnEPd1CziX6LOrNpgLN6A+aaEfG20EmhtriR0ZDCOuMdbkbKAYCTFQw9bin4id0Qj47HLiWUg0uyeoumMkNw+QNQqXiiDg9Oo3ctt9fG5hc5uKvFWMLQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785976; c=relaxed/simple;
	bh=4cxEhkLd8u4stkPjeP7mPhVuIW/w/WfIYpRNi1Ucy1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QfMt+6uCXW6FDLFtzsJG0X6+LJ+yZR1vk2IRrDJLRYbV6hYz9MZ69PvANzUKLM0YD6m7P4D9WTnnpXIhYKFmUNmBEB5z75vSZekumjP2U6FWixtSEuFhqVa5LPmAgzTZoVV3zbEFGB8bTrR5fuFI/QvzKiFlaIWMANu4c/85Q5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZpyhNCWe; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZpyhNCWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=x3
	UPn9YkcVWJ6PGBUxyppQ/FxyqlN1wj6SwTbCyClWA=; b=ZpyhNCWeIOk3uZZWQi
	3wLoY+O0257QZhyMyM/XopSYu+S8hVUj3D6saWz5gAK0SguxctPRrVCIHoP6YY+t
	CZvtppFpfmKXlt1hl7o5wWbwiJTfcAH9+myLBYNi/NPXSj1ODUrr1IN60AQGPxmt
	sb2Ogpf/dPa6YOJQ3HkIRDmmc=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wA3c4HkYBVqxP6NDQ--.20557S2;
	Tue, 26 May 2026 16:59:17 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: kees@kernel.org,
	andy@kernel.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>,
	Feng Jiang <jiangfeng@kylinos.cn>
Subject: [PATCH] lib/string_kunit: add strnlen() tests for strings without NUL terminator
Date: Tue, 26 May 2026 16:59:13 +0800
Message-Id: <20260526085913.429049-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3c4HkYBVqxP6NDQ--.20557S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw43Ary7Wr4kXF4UXF4UXFb_yoW8XF4UpF
	92vay0kr15Xrn7tws3Wr43XrykWw4Skr4fArZrGw4fX39YqFnxZrsIgr40vasxXrWxua9Y
	vr98XFy5GasxGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn9N3UUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0gUx3GoVYOWvTwAA3g

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

The existing strnlen() tests only cover strings with a NUL terminator.
Add test cases for strings without a NUL terminator to verify that
strnlen() correctly returns the maximum length when no NUL is found
within the given bound.

Co-developed-by: Feng Jiang <jiangfeng@kylinos.cn>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 lib/tests/string_kunit.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 0819ace5b027..b0d5626a79c8 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -155,6 +155,16 @@ static void string_test_strnlen(struct kunit *test)
 
 	for (size_t offset = 0; offset < STRING_TEST_MAX_OFFSET; offset++) {
 		for (size_t len = 0; len <= STRING_TEST_MAX_LEN; len++) {
+			/* Test strings without NUL terminator */
+			s = buf + buf_size - offset - len;
+			if (len > 0)
+				KUNIT_EXPECT_EQ(test, strnlen(s, len - 1), len - 1);
+			if (len > 1)
+				KUNIT_EXPECT_EQ(test, strnlen(s, len - 2), len - 2);
+
+			KUNIT_EXPECT_EQ(test, strnlen(s, len), len);
+
+			/* Test strings with NUL terminator */
 			s = buf + buf_size - 1 - offset - len;
 			s[len] = '\0';
 
@@ -169,6 +179,7 @@ static void string_test_strnlen(struct kunit *test)
 			KUNIT_EXPECT_EQ(test, strnlen(s, len + 2), len);
 			KUNIT_EXPECT_EQ(test, strnlen(s, len + 10), len);
 
+			/* Restore buffer */
 			s[len] = 'A';
 		}
 	}
-- 
2.34.1

