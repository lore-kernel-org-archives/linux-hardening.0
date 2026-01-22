Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B9426EA6
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080418; cv=none; b=nbr/8fmNqrlO91mQ0euwvAjE7dtcHWJYX6LZ5muJ4C1oBM9tNTe7dsRfXqgQyU46MasfD4w1YiMpMzdAwk9xUa5nbrvzIIeSvx8dtXm2pdVFEHzYrVRoCz/gEvj6gFaTq294turnDowLGDFyc86wm+hjNK9tkExmpXP7jKDcro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080418; c=relaxed/simple;
	bh=D6yc6p10jt1SuGrY5fp5fGd/lfysP/iEFjhKXpjingc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPKZvK983CsPzMhl2SDk5YKmjQSkOrTf7vovdVxJetA3u+i9OqdE2bHY+yuFU+uP9JrBCl8AtLjw5zw/V1QKU7h2XrwV6w0WpBanwHL23xJo371yZRcMUzIM9oFMiTaEKGeZwP0D+8FqsyWzxJK3SUANUqRDdT3VTXpzfImriBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=OatTTtkm; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="OatTTtkm"
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4702:0:640:9195:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 19053C0098;
	Thu, 22 Jan 2026 14:13:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ODaD4vJG4a60-JLVjqDwG;
	Thu, 22 Jan 2026 14:13:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769080407; bh=ur+zv2byl+4Valm6iWk1cAZKC2ItdQ836SAet9SHX28=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=OatTTtkmOSJM5yL+P5IMasA85ys0IzdHH92ByD1/cnISy4t39FYzr8gTu7FyyVctd
	 xtTPwH7xnOZClVJyHdr52LuLx9cZoW0cfTtSCbZHXWyWWXownV3vzSYjqXjLEd3UaP
	 +U8EJhR1dTUqfQjt3T5TiZrWylblNRCzBowB7pjM=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] lib/cmdline_kunit: add test case for memparse()
Date: Thu, 22 Jan 2026 14:12:53 +0300
Message-ID: <20260122111254.1111811-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122111254.1111811-1-dmantipov@yandex.ru>
References: <20260122111254.1111811-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Better late than never, now there is a long-awaited basic
test for 'memparse()' which is provided by cmdline.c.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 lib/tests/cmdline_kunit.c | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/lib/tests/cmdline_kunit.c b/lib/tests/cmdline_kunit.c
index c1602f797637..afde35f44690 100644
--- a/lib/tests/cmdline_kunit.c
+++ b/lib/tests/cmdline_kunit.c
@@ -139,11 +139,61 @@ static void cmdline_test_range(struct kunit *test)
 	} while (++i < ARRAY_SIZE(cmdline_test_range_strings));
 }
 
+struct cmdline_test_memparse_entry {
+	const char *input;
+	const char *unrecognized;
+	unsigned long long result;
+};
+
+static const struct cmdline_test_memparse_entry testdata[] = {
+	{ "0",			"",	0ULL },
+	{ "1",			"",	1ULL },
+	{ "a",			"a",	0ULL },
+	{ "0xb",		"",	11ULL },
+	{ "0xz",		"x",	0ULL },
+	{ "1234",		"",	1234ULL },
+	{ "04567",		"",	2423ULL },
+	{ "0x9876",		"",	39030LL },
+	{ "05678",		"8",	375ULL },
+	{ "0xabcdefz",		"z",	11259375ULL },
+	{ "0cdba",		"c",	0ULL },
+	{ "4K",			"",	4096ULL },
+	{ "0x10k@0xaaaabbbb",	"@",	16384ULL },
+	{ "32M",		"",	33554432ULL },
+	{ "067m:foo",		":",	57671680ULL },
+	{ "2G;bar=baz",		";",	2147483648ULL },
+	{ "07gz",		"z",	7516192768ULL },
+	{ "3T+data",		"+",	3298534883328ULL },
+	{ "04t,ro",		",",	4398046511104ULL },
+	{ "012p",		"",	11258999068426240ULL },
+	{ "7P,sync",		",",	7881299347898368ULL },
+	{ "0x2e",		"",	46ULL },
+	{ "2E and more",	" ",	2305843009213693952ULL },
+	{ "18446744073709551615", "",	18446744073709551615ULL },
+	{ "18446744073709551616", "",	0ULL }
+};
+
+static void cmdline_test_memparse(struct kunit *test)
+{
+	const struct cmdline_test_memparse_entry *e;
+	unsigned long long ret;
+	char *retptr;
+
+	for (e = testdata; e < testdata + ARRAY_SIZE(testdata); e++) {
+		ret = memparse(e->input, &retptr);
+		KUNIT_EXPECT_EQ_MSG(test, ret, e->result,
+				    "    when parsing '%s'", e->input);
+		KUNIT_EXPECT_EQ_MSG(test, *retptr, *e->unrecognized,
+				    "    when parsing '%s'", e->input);
+	}
+}
+
 static struct kunit_case cmdline_test_cases[] = {
 	KUNIT_CASE(cmdline_test_noint),
 	KUNIT_CASE(cmdline_test_lead_int),
 	KUNIT_CASE(cmdline_test_tail_int),
 	KUNIT_CASE(cmdline_test_range),
+	KUNIT_CASE(cmdline_test_memparse),
 	{}
 };
 
-- 
2.52.0

