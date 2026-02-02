Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A42D2488
	for <linux-hardening@vger.kernel.org>; Mon,  2 Feb 2026 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033309; cv=none; b=ka5A6E3tbU2St9DJbPYZArB99A/GqOoJCxp2o0cU5W+r/1uS6JAFd2G6Bsa+XBtDLyHkrLWSAiyATHCZt73Sdf8EpPG/prQ3f9IF+waHzyqqRdcZjw20P/qdONCr0iNkufyFfppJrZTk6yAgfNBBAfXoPBlZTvaToOaUJ7Da2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033309; c=relaxed/simple;
	bh=tcWa1L0ozRu/LaqZyL0+tMtpRtQPiTly+7kdWJsNQrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Be6XfwNv1qQP5FCVB/1cxxWw6BUwOr5kz6SKPHOrbtKOzW/KUFI8tnq8CDImXUmnDT3GfAfTpvBFbFne58UkyqHarA1K2C49WJtz9tAImZoyi7OO1L5GP408ciJrkxGXixXy5Fj1t3MvZhTwdjDODfLZeYaINeF4RbJpKqsMfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Vj7XAw4P; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Vj7XAw4P"
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1a9f:0:640:207a:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 5BFF0C0048;
	Mon, 02 Feb 2026 14:54:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tslFK8gGKCg0-50l8J6TZ;
	Mon, 02 Feb 2026 14:54:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770033297; bh=uYCWbJ1g9OgCKGITRUJQXLR+afBEVeXQv/JkfCX/Tbw=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Vj7XAw4PuHnxojuCgLLDQqzeiYccm/fYu5BsXBlCYtlu8f5Q05LJWivIZUyIpR2As
	 RbrOsfTKaFuxQ3NLCSsOCIWqkFsc1wXvLjGRqhpBQ8h/c3iICAGzjMhm4wxr4rYXOk
	 5PuNjlsWYSwLN/qPkvS5JmH66/QhIAjdCXr2UsJQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v4 2/4] lib: add more string to 64-bit integer conversion overflow tests
Date: Mon,  2 Feb 2026 14:54:49 +0300
Message-ID: <20260202115451.290173-3-dmantipov@yandex.ru>
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

Add a few more string to 64-bit integer conversion tests to
check whether 'kstrtoull()', 'kstrtoll()', 'kstrtou64()' and
'kstrtos64()' can handle overflows reported by
'_parse_integer_limit()'.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
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

