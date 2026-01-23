Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1831A7ED
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168888; cv=none; b=cxj5jkMrCtV5l0Gpdj2oIvwLT1Hnodqt8NLs/MwKwLtoCd6LNj6mOowOyKffepSK3UYtvu2YeXBjgu2RT8Ybf33I5RmlJ6yZIe648zTvqUNTWkk8ZPshOpnOoaH9Mime2Oj0xdDDjdGBNhgJKZoyy2mRyTS26yprDGg2y4I/a5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168888; c=relaxed/simple;
	bh=eoq/LMOjDX2JlpREvjLuXt6f2eMTkFCSvklcihFkBzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9p0B3ct+LPIyZVbwvmQG8uWHoiyQfqq6OZhMARlGH+Msp+TXTD9/F0XRyqOjkDWjMajfu8aZxE6N2+9T0zkMkLkOS8R3IAX5c0BUZBUbA29JTB4N1M98jd8M1vP0u1fHOJyYyzUcBd9dHxOjQmjMPg26btyioPE+Vl10mFHrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=gwoK0BdJ; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="gwoK0BdJ"
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id DB53A80DD5;
	Fri, 23 Jan 2026 14:47:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rlbvWNAHGiE0-n6bCaPdd;
	Fri, 23 Jan 2026 14:47:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769168876; bh=D29uu5x2C8KdbqBga7QjF4LYSMCG9cFlBUy6fT5l/Hw=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=gwoK0BdJD5xpaaj2BnF/EIJfZeeMAAqDxirdSlyZCdSN3ESYBwMnkwMiCZFhthikM
	 8U3QOhfFMiFjArEWm0sZXIlyt5xz8i2KEufkt1rK2T94GLN8a0VE1BE2okGe5xEeae
	 IHjk2vRIejupL7OL2OvMlb2+hHTG4IGa/4Sf2K6w=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 2/3] lib/cmdline_kunit: add test case for memparse()
Date: Fri, 23 Jan 2026 14:46:46 +0300
Message-ID: <20260123114647.1606335-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123114647.1606335-1-dmantipov@yandex.ru>
References: <20260123114647.1606335-1-dmantipov@yandex.ru>
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
v2: few more test cases to trigger overflows
---
 lib/tests/cmdline_kunit.c | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/lib/tests/cmdline_kunit.c b/lib/tests/cmdline_kunit.c
index c1602f797637..414dc919d1f6 100644
--- a/lib/tests/cmdline_kunit.c
+++ b/lib/tests/cmdline_kunit.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/random.h>
 #include <linux/string.h>
+#include <linux/sizes.h>
 
 static const char *cmdline_test_strings[] = {
 	"\"\"", ""  , "=" , "\"-", ","    , "-,"   , ",-"   , "-" ,
@@ -139,11 +140,62 @@ static void cmdline_test_range(struct kunit *test)
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
+	{ "4K",			"",	SZ_4K },
+	{ "0x10k@0xaaaabbbb",	"@",	SZ_16K },
+	{ "32M",		"",	SZ_32M },
+	{ "067m:foo",		":",	55 * SZ_1M },
+	{ "2G;bar=baz",		";",	SZ_2G },
+	{ "07gz",		"z",	7ULL * SZ_1G },
+	{ "3T+data",		"+",	3 * SZ_1T },
+	{ "04t,ro",		",",	SZ_4T },
+	{ "012p",		"",	11258999068426240ULL },
+	{ "7P,sync",		",",	7881299347898368ULL },
+	{ "0x2e",		"",	46ULL },
+	{ "2E and more",	" ",	2305843009213693952ULL },
+	{ "18446744073709551615", "",	ULLONG_MAX },
+	{ "18446744073709551616", "",	ULLONG_MAX },
+	{ "569202370375329612767", "",	ULLONG_MAX },
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

