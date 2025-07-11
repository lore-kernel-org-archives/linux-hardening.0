Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B610207E1D;
	Fri, 11 Jul 2025 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224189; cv=none; b=cqNgxmql788dDnn5bUUK58GAxr6MFOuCQR2GuCpNkByPw93KauJi6kXLHKSLjoSH22bNrsZXZ4qr9TsTij39QuiXxmjWycx7aH9tk4kcpgEkxC12UuowI8C99m703Vaqpi9fOmyON2ja3nTUvl5MQtQinoPUj3ZF2F731nrEOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224189; c=relaxed/simple;
	bh=NOkAhwytJRal2+sqXEue+X1Q+ohIpJDK3JfNVjzG7jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dr9dzzR5lO1D76kPYuLj4/fxp5Prs1b7lMnXcN4uiDt5VFXR7mJKZ+OMb2YXP6uWsfWU4taTSUbaceDCCD4U7yz/D0R9FVmV5y8saF2PLCVdJRCeZMYAtq6/FS4V9A6mMGBBwjNb2JUnwt30bVRYuCPMnJ9yzHxhqUHnnUuKco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4hCb+zu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4hCb+zu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752224187; x=1783760187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NOkAhwytJRal2+sqXEue+X1Q+ohIpJDK3JfNVjzG7jI=;
  b=k4hCb+zurMg0w4n7wK/2pvtWuydwN8cWNbgDt61jOyLaowqFrdIjA3J5
   M+Qmch90hXAPHxBloZ2b0b2Dd5XxzMvcrnDsyx9RkTp2GjlYsi9oGsshr
   P+uKzyKqOBPwxd1wQH50fd8KZYem7ZgtC688kzdFAPvtmIF37XoxfP5U8
   MDcXaZVh1COxlyVMqBtumuoYF7A9kv4yzYV/ln2EQ/2uW8Ufjo+/j6GJR
   J/t2BKFUNmwTWPKT/PsiGDByTMpwsTN7A2vCVvSuZfGPsZgDCpU5mMzI3
   iZTn5WR7WbgzAz2xrCQdGD80eKurYwW2Ehyn0Xa/3lBkbsxXUR0ZZBBnE
   Q==;
X-CSE-ConnectionGUID: 02h2BMgvTomMgTjNnek++w==
X-CSE-MsgGUID: u+LwOgXyS82XRjkCH3vtMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54393360"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="54393360"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 01:55:19 -0700
X-CSE-ConnectionGUID: wL+lODa3RpS43LnRs6M9ag==
X-CSE-MsgGUID: Zlw1iqPHTi2vzwbfNNV5Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="187303314"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 11 Jul 2025 01:55:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 301CB1A1; Fri, 11 Jul 2025 11:55:16 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] string: Group str_has_prefix() and strstarts()
Date: Fri, 11 Jul 2025 11:55:14 +0300
Message-ID: <20250711085514.1294428-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two str_has_prefix() and strstarts() are about the same
with a slight difference on what they return. Group them in
the header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 01621ad0f598..fdd3442c6bcb 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -345,16 +345,6 @@ extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
 
 int ptr_to_hashval(const void *ptr, unsigned long *hashval_out);
 
-/**
- * strstarts - does @str start with @prefix?
- * @str: string to examine
- * @prefix: prefix to look for.
- */
-static inline bool strstarts(const char *str, const char *prefix)
-{
-	return strncmp(str, prefix, strlen(prefix)) == 0;
-}
-
 size_t memweight(const void *ptr, size_t bytes);
 
 /**
@@ -562,4 +552,14 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
 	return strncmp(str, prefix, len) == 0 ? len : 0;
 }
 
+/**
+ * strstarts - does @str start with @prefix?
+ * @str: string to examine
+ * @prefix: prefix to look for.
+ */
+static inline bool strstarts(const char *str, const char *prefix)
+{
+	return strncmp(str, prefix, strlen(prefix)) == 0;
+}
+
 #endif /* _LINUX_STRING_H_ */
-- 
2.47.2

