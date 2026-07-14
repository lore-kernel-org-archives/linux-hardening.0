Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D344C64E;
	Tue, 14 Jul 2026 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057765; cv=none; b=IXhxQADVQmU4RUKqMCcl1e4eIokzIDfAlRpzk6ekzhTZLY9cNEbx078mM9qiiNyHULXn5QwawGKBH3xmuENFZ5Q0y2u6+tVM66b4EDAcAwxg07n+r5tR3prVntTaz3DM9xbzaOolW18urcgzEr6GzDfXHNRoHIuwI8Cuyp9Qlek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057765; c=relaxed/simple;
	bh=V+dxP2MKZFyQvonniRH08CNvUHJHMDcdU9VEg0Osq7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubbIQulT4BWoEM5ayRiz+W/9gRQZtRv9VBOkKd53RQl5Q/wRfAEvqK4KTm0e7dsH1sK3mKhDHgDgbEIXGn78YXW1vUSu5mL5rMFgwg1S25C59Uz61mUmBhSvRjRIscQ5Uzx6T3p9Qq5sAaYWRhExWJ2g3tDZBDOpploXUPlXKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sd4S+UXm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sd4S+UXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784057763; x=1815593763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V+dxP2MKZFyQvonniRH08CNvUHJHMDcdU9VEg0Osq7c=;
  b=Sd4S+UXmho9poHIt2DIsYhjcVpE22LtDCCk21BjMF6Ch0ZmVmueMF3Hy
   +/wA5g2uyUeOdhgyQ+RCxlEKy70wPwnQ8oITg9NihzA3okdrB3w9PMmDJ
   ypW+pWBEo40rua5IyNeLfLzrmoLuBIEX0BKPSTPR6YAQG+PwesBRA5gfx
   VNa92/JUO14yUk3nCxR4R6ISb3DbP++hCPBOVFFpjnT5Xtu0PaZKxNRTl
   y5vPUAMU+97xYpPb6RjGRJPPgYOs31Lk2nQqRQeoPxIUcl0Bg4tqRJQDe
   TLNNDgaDyerBokrxsnLg/M4o4FE16LDHQZcnQnshS1igzL8neeKAyPeHO
   Q==;
X-CSE-ConnectionGUID: +MLuJnsgRD6+aoyU6dv4Rw==
X-CSE-MsgGUID: +JnKP8knSSWh9yolDgsiJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95043225"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95043225"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:36:02 -0700
X-CSE-ConnectionGUID: R1W0fAQuSEeFyP9xAdNPTg==
X-CSE-MsgGUID: tRewb2NPTaepYM4u8roZPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="251984195"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 14 Jul 2026 12:36:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0CE8995; Tue, 14 Jul 2026 21:36:00 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 1/1] string: Add missing Return sections
Date: Tue, 14 Jul 2026 21:34:56 +0200
Message-ID: <20260714193557.868356-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc unfortunately can't catch some corner cases. Hence
the commit 645b9ad2dc6b ("string: Add missing kernel-doc return descriptions")
missed that. On top there is no consistency in use of Return/Returns.
Address both problems here. Choose Returns over Return as it will be
less invasive change.

Fixes: 645b9ad2dc6b ("string: Add missing kernel-doc return descriptions")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed reference to a parameter in __sysfs_match_string()
 include/linux/string.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 5702daca4326..75bfc194ad20 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -25,7 +25,7 @@ extern void *memdup_user_nul(const void __user *, size_t);
  * @n: number of array members to copy
  * @size: size of one array member
  *
- * Return: an ERR_PTR() on failure. Result is physically
+ * Returns: an ERR_PTR() on failure. Result is physically
  * contiguous, to be freed by kfree().
  */
 static inline __realloc_size(2, 3)
@@ -45,7 +45,7 @@ void *memdup_array_user(const void __user *src, size_t n, size_t size)
  * @n: number of array members to copy
  * @size: size of one array member
  *
- * Return: an ERR_PTR() on failure. Result may be not
+ * Returns: an ERR_PTR() on failure. Result may be not
  * physically contiguous. Use kvfree() to free.
  */
 static inline __realloc_size(2, 3)
@@ -103,7 +103,8 @@ ssize_t sized_strscpy(char *, const char *, size_t);
  * doesn't unnecessarily force the tail of the destination buffer to be
  * zero padded. If padding is desired please use strscpy_pad().
  *
- * Returns the number of characters copied in @dst (not including the
+ * Returns:
+ * The number of characters copied in @dst (not including the
  * trailing %NUL) or -E2BIG if @size is 0 or the copy from @src was
  * truncated.
  */
@@ -286,7 +287,7 @@ char *strreplace(char *str, char old, char new);
  * @s: The memory area
  * @n: The size of the area
  *
- * Return: True if the area of memory is all 0's.
+ * Returns: True if the area of memory is all 0's.
  */
 static inline bool mem_is_zero(const void *s, size_t n)
 __sysfs_match_string{
@@ -328,7 +329,11 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *s);
  * @_a: array of strings
  * @_s: string to match with
  *
- * Helper for __sysfs_match_string(). Calculates the size of @a automatically.
+ * Helper for __sysfs_match_string(). Calculates the size of @_a automatically.
+ *
+ * Returns:
+ * The index of the matching string in the array or negative error code
+ * otherwise.
  */
 #define sysfs_match_string(_a, _s) __sysfs_match_string(_a, ARRAY_SIZE(_a), _s)
 
-- 
2.50.1

