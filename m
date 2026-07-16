Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969038C40E;
	Thu, 16 Jul 2026 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193442; cv=none; b=CJYMoOAK0Ad0r1kbVvpAqqz9555hwREhV9LwuwL1mk5ZsNQPOXlOZsnp3WXGhBXWYoN7ZDMC3A9hXqzO1gkpz+RTSeGLD4Azv7YCXwSPc4b6cykm+B/a0L6ETQQ7JoXRP6emT31SKkU3ThOZ8hqQDfuOcriPSsde3VCGYHc6a6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193442; c=relaxed/simple;
	bh=0r8ODIZPMMonUvBM8SnKt8GPLAt04IeGSwSwMWqTBrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lryRYeSs1CkdVL8D0yBG8onSq84d6hviEHxpArjq074UIEtotyH8AtlmYInN0y/fEwgfxrdoUhMDTq9G82KmA/Zy9fNFS55a6BQBMS3ykpSm7h6BfUt4/gY46eXz3ARwsmFnjqUXAvrFqWYjFru/PBaQRPLqnvW6NXhoI71vrdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LJLM1W5A; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LJLM1W5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jw
	oo4Lze8ESagV/L0PikUZKIuUo9FLrqDtWPfeVpMG4=; b=LJLM1W5AZE05uzkMEj
	EvgqpuxI5E1N9yLf+s2Q0u00nHZBnCcA2LCL+9wxri7vrErwXZQtxxF84wozILtB
	kNKbx7umkgme989QKIFmOZYYWIVZD+RO98Te707WQqQonJ0wacaow92AFV0av8Wg
	3n4paz6XhUS4DRm5jHSAi7dV0=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAnMWuHoVhqusb4Jg--.29116S2;
	Thu, 16 Jul 2026 17:16:55 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: andy@kernel.org,
	kees@kernel.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>,
	Feng Jiang <jiangfeng@kylinos.cn>
Subject: [RESEND PATCH] lib/string_kunit: add strnlen() tests for strings without NUL terminator
Date: Thu, 16 Jul 2026 17:16:36 +0800
Message-Id: <20260716091636.51556-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526085913.429049-1-min_halo@163.com>
References: <20260526085913.429049-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnMWuHoVhqusb4Jg--.29116S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw43Ary7Wr4kXF4UXF4UXFb_yoW8Xw43pF
	92vay8Kr15Xr1xtws3Wr43XrykWw4Skr4fCrZrGw4fXrZYqFnxZrsIgr40yanxJry8ua1F
	vr98XFy5GasxGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j089NUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0gc65WpYoYe9RgAA3l

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


No virus found
		Checked by Hillstone Network AntiVirus

