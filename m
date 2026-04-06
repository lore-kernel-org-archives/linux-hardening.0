Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556AE38F24C;
	Mon,  6 Apr 2026 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504071; cv=none; b=H2YJfVQQQjcLfOfoUiXTT1Dm/JwjznUxTNK5HrpWSssREUpZRcDtvgQ9YkCliVzci/PRQPtMAWnkbTgCckwEVBKpXycf9nZjNkbKNZ/vGUXGBgu2srD4t3b6vnseNwqwFLapgukcesqbxiFJZ2wDSeE3YUov4H7/3Fn2pguhXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504071; c=relaxed/simple;
	bh=LS8osYZkFWGCw5Tv9fxALxptLqlXe9FberpBOc+5JFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAbo2QtFeAoebLavE9KNXmrk50mRyxHZ6RSyg8FIcxs9oS/MjPXu/AgWq6gcti63Bxl+kzWNyRzbbtes8w5Gwr8ctGMKzCgUcm4S67Vpg3KB095c+heEHEdCPdo7Ij6IJBZM2nYcFU4dQk9cQhqfylZUi6UayAxIJUYiFkypasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lX0vuRqj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lX0vuRqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775504068; x=1807040068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LS8osYZkFWGCw5Tv9fxALxptLqlXe9FberpBOc+5JFg=;
  b=lX0vuRqjTfayriXBcMVzUVKXIPaF8Sjc1yiJcn0rLO3fu3GFCmOTzBFe
   g8Pt9ToYiRJtqZEhJnOtNLw9VM4Nfj4mkTfSfnLb3Vc5nZNVWV1Om7eEq
   /pot8eFSCqodb011lmbqxC0xTJdOyyd4NrZk4dpUZ7OBj28HMkZD2x/il
   Bj+V/tAIXIzlKRSLRO7FnAEzgwX5vCqJTVRaUThzJZDwrV4MKd4cuhjZe
   1SfK3IhxSXLHt8abzCcvEVFef5mayvIpcD/0iGDvSu17poq44a09gnTYh
   8Gazcu4sGlDmm0U1HtJpIvyGPe3H2zq0oL7l1LvvMZyxPehnJQ56rNS3Q
   w==;
X-CSE-ConnectionGUID: 1T/DVgL5QNeAXG0EYcHQHQ==
X-CSE-MsgGUID: 4e9nr14oSt210qJ8RiXZMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76421552"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76421552"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 12:34:27 -0700
X-CSE-ConnectionGUID: Bszym1/KSW+eUJDKBTGzkA==
X-CSE-MsgGUID: oZDzYq6dSfawJVcwUDFLPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="227898400"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 06 Apr 2026 12:34:27 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5CF6B99; Mon, 06 Apr 2026 21:34:26 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 2/2] lib/tests: string_helpers: Don't use "proxy" headers
Date: Mon,  6 Apr 2026 21:32:48 +0200
Message-ID: <20260406193425.1534197-3-andriy.shevchenko@linux.intel.com>
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

Update header inclusions to follow IWYU (Include What You Use) principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/tests/string_helpers_kunit.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/tests/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
index cd08e79a857d..9fbe91079c7e 100644
--- a/lib/tests/string_helpers_kunit.c
+++ b/lib/tests/string_helpers_kunit.c
@@ -5,11 +5,16 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <kunit/test.h>
+
 #include <linux/array_size.h>
-#include <linux/kernel.h>
+#include <linux/bug.h>
+#include <linux/limits.h>
+#include <linux/module.h>
 #include <linux/random.h>
-#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/sprintf.h>
 #include <linux/string_helpers.h>
+#include <linux/types.h>
 
 static void test_string_check_buf(struct kunit *test,
 				  const char *name, unsigned int flags,
-- 
2.50.1

