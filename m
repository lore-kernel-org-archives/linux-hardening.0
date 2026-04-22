Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7937332E72F;
	Wed, 22 Apr 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873561; cv=none; b=iq6HOXC2ugAiMSxdnuEJPMZt2bSHqSJcu/wsQUaAopVm/AhobTWbV7e/TDjr9XUdfqsUnkfIYdbjz9f2MsNvk4RLaF1YDWKiWmeXcCGIw1yg93jFb1M72tAURhI3C1J1zY4K0VydyLWJni0DrxGBFUI+LwcnCjIVwLCWoM9CZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873561; c=relaxed/simple;
	bh=RZ/5dbC8MnDILJIRSCKet73ixD4oBZWe1jy13l0HzS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNPLaZFhtv06qwgYR4BS4LN9NsTiQGnKOpVcQELqARMoUaUwi1mul1WF7dvz6pfXT7ODvMGOPWYAVu/14JTEnWG6CRcOlP9oHWpapMW/gUjk1puUXWbe8bM0qsFrBeDrxus58h69ZXOj1hdpFbMqEXYyKHWY97mCZqOVUU2iArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gz/ANckz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gz/ANckz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776873560; x=1808409560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RZ/5dbC8MnDILJIRSCKet73ixD4oBZWe1jy13l0HzS0=;
  b=Gz/ANckzYZAkrpxby3r9a5blLuD9K6qVhhpqcrDDXb/aMpV17TWBae0I
   AJfUyZgMxT2hUTyEarpId0ANIAOxENU1r3yz33gze1evrek1RPv4bY2wE
   MFwEFKg0/p+3EdlRYi8oiDskVsL2p7X4f7OIqItbtFQoC2EDlvMFrQn1I
   fqrdeHfPnk+Kn22wh9of73xTPyV0lr8HwNsMzMxAP115sPyiYgJO/6wcG
   KRCHFyqP54KbZwCF6CdTJ/7yd6RmyN0jRhaca9zulmZTMeQ7Wen0LMHmM
   mKbrbm9NLOkAJe0c/B7A3xXg73/nVP6d16eaupHz/N7pysl3aODQq2NCb
   A==;
X-CSE-ConnectionGUID: gFDq24zdQQ6Wr92he8tZHQ==
X-CSE-MsgGUID: 3ijpq/rbSC2BmYeqKzGMYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88906154"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="88906154"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 08:58:31 -0700
X-CSE-ConnectionGUID: VSo1VDwOSgO2Y3K7pyFEmA==
X-CSE-MsgGUID: lwMlpIgMSFOYoq4Tcd7RNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="262781604"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 22 Apr 2026 08:58:29 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id CAD7D95; Wed, 22 Apr 2026 17:58:27 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] string: Group zero related memory APIs in the header
Date: Wed, 22 Apr 2026 17:58:24 +0200
Message-ID: <20260422155824.769913-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move mem_is_zero() closer to memzero_explicit() to group semantically
close APIs in the header for better browsing experience. No functional
changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b850bd91b3d8..3840be921d79 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -284,18 +284,6 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *str, char old, char new);
 
-/**
- * mem_is_zero - Check if an area of memory is all 0's.
- * @s: The memory area
- * @n: The size of the area
- *
- * Return: True if the area of memory is all 0's.
- */
-static inline bool mem_is_zero(const void *s, size_t n)
-{
-	return !memchr_inv(s, 0, n);
-}
-
 extern void kfree_const(const void *x);
 
 extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
@@ -367,6 +355,18 @@ static inline void memzero_explicit(void *s, size_t count)
 	barrier_data(s);
 }
 
+/**
+ * mem_is_zero - Check if an area of memory is all 0's.
+ * @s: The memory area
+ * @n: The size of the area
+ *
+ * Return: True if the area of memory is all 0's.
+ */
+static inline bool mem_is_zero(const void *s, size_t n)
+{
+	return !memchr_inv(s, 0, n);
+}
+
 /**
  * kbasename - return the last part of a pathname.
  *
-- 
2.50.1

