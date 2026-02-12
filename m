Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48A35D5F2;
	Thu, 12 Feb 2026 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914662; cv=none; b=i/QCYqlXOtvvmgsXLD18sxHFrV1idReR2Kp7jLxDTn644h0+d0tPsjccjiRwRY5CumUPpVjYwKWHFg+XHMEa42vLfd7ea3fdNGZMjLO3D054kSr9CMntBpO057IjiJqlVDnKTMArjK8WyBeKBAt5UFcPTEEmoOeRtFqcg+buY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914662; c=relaxed/simple;
	bh=b25GLa6Nxa0JkVVRcxgvW+qahIyegLcJ0z46wPRIPQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzuk6s5vmHTR/otesSsRM6MO1kLcdbQ0S57ICZDQa5XEuApcn84kmr393ejzS6f8NGxCJCPi6kaXJ8l0Eq99gX0oNdg4g9G6lEG3ky5AYquSM0V5Asshi230fvY+EqVeAS/l1HmHLEPIxCWg4YBnwAO1YhKPUtQylMrs/TKCnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=X/474Hx3; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="X/474Hx3"
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:3990:0:640:454b:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 2F59EC0080;
	Thu, 12 Feb 2026 19:44:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EiXcAWCGxeA0-2EWwl2fW;
	Thu, 12 Feb 2026 19:44:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770914657; bh=xpMpHVbNQyEu3bVeX/qstTUz7i5myZeY5ImYtYMRO48=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=X/474Hx3OHnAEVMwY17g2QOQ83VAoMZLKIZKWwmH6sl/+KNmOiYuCjwOFEhlshcWB
	 pd0EXRnZK+q6mUQGiR66tm2Cmb3WkTZj9txPjGsIvu/H33OjDZ2Z/tjo1EXKJFQQuj
	 gTSEN+IIQTSTLgIF+c4pZvimlE4AFJ5wjDL3ikoI=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v8 3/5] lib: add more string to 64-bit integer conversion overflow tests
Date: Thu, 12 Feb 2026 19:44:11 +0300
Message-ID: <20260212164413.889625-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212164413.889625-1-dmantipov@yandex.ru>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
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
v5 and upwards: bump version to match the series
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
2.53.0

