Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECEC364EA9
	for <linux-hardening@vger.kernel.org>; Mon,  2 Feb 2026 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033622; cv=none; b=X/NEONn2JMoBF7ILjuER4Gt0zvIvnczCTyObT8G+dR5862nmo85jS/P8lHbw8QQ4Tr5PEomZ0gcnYbbSSbD1MBKdLAsAwwkWaZz7kBxq3dVgdl6oV5jpGB2+OIs4cwVaZLlZpX3Dph8C1mrlnc7czVQ8tcMbmt6j54sKMW4TUis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033622; c=relaxed/simple;
	bh=9Dr94TtmN2jC6MftU1ZiLI/VzaAcdtuS+ZBMUX1o0xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4pXRR1LJTrdoeP9cDT4qlGEReCYeizlIoruPQTPeJgr80BevXPENgHOyD+pxktkXXghK5Qm1KL/nLI4dsXMrcy3qqfYSe+wGXMHGMXgM+c6dAG7tA9+McUGHyqYrbMO2ab8ei5Lmpnr97/gC5f/pWVtCaxRKbV6/Eydp8pD/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=OrxD0kks; arc=none smtp.client-ip=178.154.239.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="OrxD0kks"
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward203a.mail.yandex.net (Yandex) with ESMTPS id AB8E389901
	for <linux-hardening@vger.kernel.org>; Mon, 02 Feb 2026 14:55:06 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1a9f:0:640:207a:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 1A05380842;
	Mon, 02 Feb 2026 14:54:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tslFK8gGKCg0-FGcqw0qf;
	Mon, 02 Feb 2026 14:54:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770033298; bh=ntiSgGhU0t3M/eRxzmsH4O+fIm1MY3BFiACWT11Eg/k=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=OrxD0kksnuWzXSRs4XgP3u3e8bwzSi/i8jBK5HTYMaWN/3BzojVugG8zCs7+zaaT8
	 JKu8fRpyEgfW5vRZI4f+a1HDUbC5qm1FZxDjEsJe/br8HV80LR2cRUvgtKkXRo9mvm
	 6HpJ3xxzt9G+RhnwHCGXE0oYyW7v7CqKOYz2dspg=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v4 3/4] lib/cmdline_kunit: add test case for memparse()
Date: Mon,  2 Feb 2026 14:54:50 +0300
Message-ID: <20260202115451.290173-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202115451.290173-1-dmantipov@yandex.ru>
References: <20260202115451.290173-1-dmantipov@yandex.ru>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: move actual overflow tests to test-kstrtox.c
v3: adjust style as suggested by Andy
v2: few more test cases to trigger overflows
---
 lib/tests/cmdline_kunit.c | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/lib/tests/cmdline_kunit.c b/lib/tests/cmdline_kunit.c
index c1602f797637..94d9afec2513 100644
--- a/lib/tests/cmdline_kunit.c
+++ b/lib/tests/cmdline_kunit.c
@@ -6,6 +6,7 @@
 #include <kunit/test.h>
 #include <linux/kernel.h>
 #include <linux/random.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
 
 static const char *cmdline_test_strings[] = {
@@ -139,11 +140,60 @@ static void cmdline_test_range(struct kunit *test)
 	} while (++i < ARRAY_SIZE(cmdline_test_range_strings));
 }
 
+struct cmdline_test_memparse_entry {
+	const char *input;
+	const char *unrecognized;
+	unsigned long long result;
+};
+
+static const struct cmdline_test_memparse_entry testdata[] = {
+	{ "0",				"",	0ULL },
+	{ "1",				"",	1ULL },
+	{ "a",				"a",	0ULL },
+	{ "0xb",			"",	11ULL },
+	{ "0xz",			"x",	0ULL },
+	{ "1234",			"",	1234ULL },
+	{ "04567",			"",	2423ULL },
+	{ "0x9876",			"",	39030LL },
+	{ "05678",			"8",	375ULL },
+	{ "0xabcdefz",			"z",	11259375ULL },
+	{ "0cdba",			"c",	0ULL },
+	{ "4K",				"",	SZ_4K },
+	{ "0x10k@0xaaaabbbb",		"@",	SZ_16K },
+	{ "32M",			"",	SZ_32M },
+	{ "067m:foo",			":",	55 * SZ_1M },
+	{ "2G;bar=baz",			";",	SZ_2G },
+	{ "07gz",			"z",	7ULL * SZ_1G },
+	{ "3T+data",			"+",	3 * SZ_1T },
+	{ "04t,ro",			",",	SZ_4T },
+	{ "012p",			"",	11258999068426240ULL },
+	{ "7P,sync",			",",	7881299347898368ULL },
+	{ "0x2e",			"",	46ULL },
+	{ "2E and more",		" ",	2305843009213693952ULL },
+	{ "18446744073709551615",	"",	ULLONG_MAX },
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

