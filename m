Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B434B437;
	Wed, 22 Jul 2026 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702618; cv=none; b=JbC6KDeYAl8qa5EaIvrYKPGBa4/yYIcnwUUY7yA5CMJbk59hBnV60knuypoPj2mUxeHIA1PL3led2XV19YN6pZA39mSDIPSBzB/esicLZvpc+pd2YoKAdvqHMwfxIyV0hHqp+Q9tgMOWdmGb1hoa9m2C3DlH9Bk07axlfS7e51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702618; c=relaxed/simple;
	bh=tSkfKA3vHyfoeHiWXwZIgl+mspI0/YAEiQfKW4Dh4o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTb5ChaMZy/qR+PIVyTDU5RBWPkm/UTGQV/JnQ1HL9b+NpMH6NxwWpyi8zevryZwj8gSsOISLRjonNy4tMQzMeay1WHPJs6RLcHbCo7J5WgvV4v21i+94muI2E2VkUC7V5GZ/dmRJkGgRHCvKOxw7T/ws44DSeVGPsILmavMxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h4l871gggz5B10G;
	Wed, 22 Jul 2026 14:43:35 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 66M6hPBW061860;
	Wed, 22 Jul 2026 14:43:25 +0800 (+08)
	(envelope-from gao.rui@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Wed, 22 Jul 2026 14:43:27 +0800
X-Zmail-TransId: 3e816a60668f00d-a0abd
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: gao.rui@zte.com.cn
From: Gao Rui <gao.rui@zte.com.cn>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Feng Jiang <jiangfeng@kylinos.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gao Rui <gao.rui@zte.com.cn>, Kees Cook <kees@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] kunit: string: add strnlen SIZE_MAX test coverage
Date: Wed, 22 Jul 2026 14:40:27 +0800
Message-ID: <20260722064037.1111467-3-gao.rui@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260722064037.1111467-1-gao.rui@zte.com.cn>
References: <20260722064037.1111467-1-gao.rui@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 66M6hPBW061860
X-TLS: YES
X-ENVELOPE-SENDER: gao.rui@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 22 Jul 2026 14:43:35 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A606697.000/4h4l871gggz5B10G

Extend string_test_strnlen to validate strnlen behavior with
SIZE_MAX input:

- Add explicit test case for strnlen(s, SIZE_MAX).
- Ensure fallback to generic path returns correct length when
  string has no NUL terminator.
- Complements existing tests for non-terminated strings and
  boundary conditions.

This improves KUnit coverage for extreme inputs and verifies
the correctness of the new fallback logic in strnlen.S.

Signed-off-by: Gao Rui <gao.rui@zte.com.cn>
---
 lib/tests/string_kunit.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 0819ace5b027..8e2e8980aa75 100644
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
 
@@ -169,6 +179,9 @@ static void string_test_strnlen(struct kunit *test)
 			KUNIT_EXPECT_EQ(test, strnlen(s, len + 2), len);
 			KUNIT_EXPECT_EQ(test, strnlen(s, len + 10), len);
 
+			/* Test Count overflow fallback */
+			KUNIT_EXPECT_EQ(test, strnlen(s, SSIZE_MAX), len);
+
 			s[len] = 'A';
 		}
 	}
-- 
2.27.0

