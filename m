Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A93542CF;
	Mon,  6 Apr 2026 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504071; cv=none; b=XgetS0NIsHy5IqjFafvdNImS+g3/5nHTMujWd1YXYblQB+PJnuVUmYbpZtINd9cuekpCFWTDGEFMKTAiT/K7/NDnCj4tpega8UIJ4MA/FLGJ1R7NS2ncLfn/Y1N/GrmPP5H3Jii3ql/aiEHfW+0ZaU+cNjC6bMrFZKi4fZy53lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504071; c=relaxed/simple;
	bh=gMYKypcBN/KaEn+dMVS3v7k4JeqfyCFogqb/G7ve1a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/Hv1mguSxaTOt9ZCPqmQiWSIZ7hR+a+7t0HC8BwXkFWuMw7gNAw4oJtIxv6n3mDJOV5U4BfymSAcst4SSb4KkYkhz0+nsQylx7RI1ovCtJJ0BJJTIO5XvC3AecX27As2mDV92JiDOawKu7DVMawGpLkP5HwDv7GgOg5t6ht8J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d568e4Ul; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d568e4Ul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775504070; x=1807040070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMYKypcBN/KaEn+dMVS3v7k4JeqfyCFogqb/G7ve1a4=;
  b=d568e4UlxeTtgln91cKwBfWCT0s1XTXQMpNM32mV+fTYzL1/NDB8ZuXN
   TFlNK/BeQOvRzH+ZBrUAb7zo8+huIT9VTfbZ/pxvDhCPH4ukWK6/uhwpP
   q8SlJaVT8xJvINOncQ+bU67fHX2GkLkxpPDLAqiwkJKn+ctROo3Wo3r0K
   2CUJiYIstA0HlMp+Fe6yzzBZ1LOgfdflnXhcPx8E5kaVuzEVbcr8nLUvx
   bRA91UTUBDlOQ3JM+VzaFwJaaX/1H/SgdLdtgCU97msMhWW3yX7XCi/O6
   3hMyvYl7jQjJ/pOF8mg9B4pHBSQ7vmtZikA2onm79DLjG4xvhW+q/wniu
   g==;
X-CSE-ConnectionGUID: YUVMjy/TQeqi+UaBjwCHrA==
X-CSE-MsgGUID: rpEKHxvcQlyI7fg/3ERq5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76354585"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76354585"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 12:34:29 -0700
X-CSE-ConnectionGUID: nuDToCECSGm+7cjfw8Jfug==
X-CSE-MsgGUID: ey9TFUpeSMCTwM9WdyygJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="221377447"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 06 Apr 2026 12:34:27 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5919A98; Mon, 06 Apr 2026 21:34:26 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/2] lib/tests: string_helpers: Decouple unescape and escape cases
Date: Mon,  6 Apr 2026 21:32:47 +0200
Message-ID: <20260406193425.1534197-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260406193425.1534197-1-andriy.shevchenko@linux.intel.com>
References: <20260406193425.1534197-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the escape and unescape test cases go in one step.
Decouple them for the better granularity and understanding test
coverage in the results.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/tests/string_helpers_kunit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/tests/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
index c853046183d2..cd08e79a857d 100644
--- a/lib/tests/string_helpers_kunit.c
+++ b/lib/tests/string_helpers_kunit.c
@@ -601,6 +601,11 @@ static void test_unescape(struct kunit *test)
 		test_string_unescape(test, "unescape", i, false);
 	test_string_unescape(test, "unescape inplace",
 			     get_random_u32_below(UNESCAPE_ALL_MASK + 1), true);
+}
+
+static void test_escape(struct kunit *test)
+{
+	unsigned int i;
 
 	/* Without dictionary */
 	for (i = 0; i < ESCAPE_ALL_MASK + 1; i++)
@@ -615,6 +620,7 @@ static struct kunit_case string_helpers_test_cases[] = {
 	KUNIT_CASE(test_get_size),
 	KUNIT_CASE(test_upper_lower),
 	KUNIT_CASE(test_unescape),
+	KUNIT_CASE(test_escape),
 	{}
 };
 
-- 
2.50.1

