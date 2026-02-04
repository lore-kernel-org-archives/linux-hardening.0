Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999933542D4;
	Wed,  4 Feb 2026 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213598; cv=none; b=hOs1wiQ1lL2xt4d2M/4tumA0iqFcdrL5DDwtHTuo+jXEs4kJfmQL8FpvVN0L3vMMHkhtz2WsYh2id7KuAETPMc0zCNg6L4r7PWuR8M2fhFNmvg1neeT6eFJv8sL2TSAHivMPzmRnoiFlwBTsqBUL/wNW3Km9y9eSfl5chphYn5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213598; c=relaxed/simple;
	bh=IoWTscMXu90WPT9YAOKC1OM9eFzsxf545fN9v0TAQSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQ1zEVioi55YM+axsU63I7qWrA3gXcZfizL77kxhPg4KTrjS7B3QjHMxeli0Nq6ym9Ush0FhlRAh6+t8H/m7WAidr1jgEqIXe49AABL4fDgQlIU8mbeqwrTZOoLOlMW+jJ19NJ4pJ/MZTW35xMGTypG6MKiLaB5Gg2xMBAz/pFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=f62RzuI9; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="f62RzuI9"
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4f41:0:640:844:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id BF0DFC0083;
	Wed, 04 Feb 2026 16:59:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ixp7xlOGqOs0-mqAHaCfI;
	Wed, 04 Feb 2026 16:59:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770213588; bh=b4uXku/dWVzrhcn5CJ5kVruyZ0arrfLsiINpqGsUm7c=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=f62RzuI9rDAUwPvJRv22A3FB42UDhKRcnmwyGS0UE1G+d/Xpw3RITV3yO5l/T/73h
	 r7WcywfIyHoahfwx/h9Gn0fICz23F7Suf6SHNg+ijrrjYNsmZmZAO6R1kTDTSqdUbC
	 KDq+Yu4t/SxfiFg3sMmKodESVL/sK8LD4k5GPjLc=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v5 3/5] lib: add more string to 64-bit integer conversion overflow tests
Date: Wed,  4 Feb 2026 16:57:15 +0300
Message-ID: <20260204135717.941256-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204135717.941256-1-dmantipov@yandex.ru>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few more string to 64-bit integer conversion tests to
check whether 'kstrtoull()', 'kstrtoll()', 'kstrtou64()' and
'kstrtos64()' can handle overflows reported by
'_parse_integer_limit()'.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v5: bump version to match the series
v4: initial version to join the series
---
 lib/test-kstrtox.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/test-kstrtox.c b/lib/test-kstrtox.c
index ee87fef66cb5..811128d0df16 100644
--- a/lib/test-kstrtox.c
+++ b/lib/test-kstrtox.c
@@ -198,6 +198,7 @@ static void __init test_kstrtoull_fail(void)
 		{"10000000000000000000000000000000000000000000000000000000000000000",	2},
 		{"2000000000000000000000",	8},
 		{"18446744073709551616",	10},
+		{"569202370375329612767",	10},
 		{"10000000000000000",	16},
 		/* negative */
 		{"-0", 0},
@@ -275,9 +276,11 @@ static void __init test_kstrtoll_fail(void)
 		{"9223372036854775809",	10},
 		{"18446744073709551614",	10},
 		{"18446744073709551615",	10},
+		{"569202370375329612767",	10},
 		{"-9223372036854775809",	10},
 		{"-18446744073709551614",	10},
 		{"-18446744073709551615",	10},
+		{"-569202370375329612767",	10},
 		/* sign is first character if any */
 		{"-+1", 0},
 		{"-+1", 8},
@@ -334,6 +337,7 @@ static void __init test_kstrtou64_fail(void)
 		{"-1",	10},
 		{"18446744073709551616",	10},
 		{"18446744073709551617",	10},
+		{"569202370375329612767",	10},
 	};
 	TEST_FAIL(kstrtou64, u64, "%llu", test_u64_fail);
 }
@@ -386,6 +390,8 @@ static void __init test_kstrtos64_fail(void)
 		{"18446744073709551615",	10},
 		{"18446744073709551616",	10},
 		{"18446744073709551617",	10},
+		{"569202370375329612767",	10},
+		{"-569202370375329612767",	10},
 	};
 	TEST_FAIL(kstrtos64, s64, "%lld", test_s64_fail);
 }
-- 
2.52.0

