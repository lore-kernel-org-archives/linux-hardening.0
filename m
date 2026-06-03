Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9339023B;
	Wed,  3 Jun 2026 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471169; cv=none; b=tuhuOJJfJKa1VI4//f9JlwUMSGOY3wZ3NR3JDbll1QBKZ79qp9+5w7nPV2yoH9aN/fO3OVk/J1960bVe2lwstsC5frTfmr3o9yTXjlVKkkkWUhHE5INJqqZrk3jPub91QaQX5nDCSkz9x7q8EaZSStJqNNemOONQYlvaqxdH5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471169; c=relaxed/simple;
	bh=x0LhgwABGSDUEu8vMddJXLrg1h/k0CcY0OYz4YFruSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFYbSGHSKaMCaF81w+7ASIhnICs6U5G9k5v2mGssMpXqHpQ8Ny5ai+vYRE18UAhogykZzHW8dGI6bwldn92nNqwy4k8YOeYB+uoM4YNyaPLd7f7Srv2gzrgUEcaPXo2bDGFQktz+rbjoiHE05gA0E3ZDtalZ2idqqkreQa+fPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpvDDaia; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpvDDaia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780471167; x=1812007167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x0LhgwABGSDUEu8vMddJXLrg1h/k0CcY0OYz4YFruSw=;
  b=mpvDDaiaRk3dVZnNOOp3K80UcSipKGXKM3YZHokLMXq6TH350l2iDk5I
   QSq1aVKsLlJ91ttSZD0aSLc8ouVXdvZq+XtI5TOWbEV9/3qBwIQkF5EKz
   EUJUt7DlUKqJDah7JXpiO3yGPk3XlPy1aNrC9Zd+oyPEJYS/YYJScUb+U
   5VMoQOVLwo8tmssXVtv5xifqP+8Hz5n3Q/Enhx7X6oRjc9tB6KlDh7xE6
   ZOYLPtpYVu0pTRwBmTC1rWEKSPT1GPCngyfpx+GKYK4JMdCNoijynAoKW
   YxAtOCETeRPwF62JhayJUD5/kkkqisr5fkHRpKMq2oD5eUe5gJlbdEcij
   w==;
X-CSE-ConnectionGUID: g0C0IdFLRkOzAIakIwaRyA==
X-CSE-MsgGUID: W6in6bZ4RdmjtI2O7/JS6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="83849916"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="83849916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:19:11 -0700
X-CSE-ConnectionGUID: RQdfRwQ9QxC2Bs/gQA7Y/A==
X-CSE-MsgGUID: /s8uEVlVSyG50aKNL90DCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="248457151"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 03 Jun 2026 00:19:09 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2D26295; Wed, 03 Jun 2026 09:19:08 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 1/1] string: Add missing Return sections
Date: Wed,  3 Jun 2026 09:15:52 +0200
Message-ID: <20260603071648.106679-2-andriy.shevchenko@linux.intel.com>
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

Cc'ed to the Documentation and kernel-doc people to point out on this
kernel-doc corner cases. It didn't complain on the macros that return
a value. Also it would be nice to have file level consistency on
the naming of the same type of sections, e.g., Returns vs. Return.

Kees, feel free to drop Fixes whilst applying in case you think it not
worth it. The commit message still has a pointer.

 include/linux/string.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b850bd91b3d8..549f327e33fb 100644
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
@@ -106,7 +106,8 @@ ssize_t sized_strscpy(char *, const char *, size_t);
  * doesn't unnecessarily force the tail of the destination buffer to be
  * zero padded. If padding is desired please use strscpy_pad().
  *
- * Returns the number of characters copied in @dst (not including the
+ * Returns:
+ * The number of characters copied in @dst (not including the
  * trailing %NUL) or -E2BIG if @size is 0 or the copy from @src was
  * truncated.
  */
@@ -289,7 +290,7 @@ char *strreplace(char *str, char old, char new);
  * @s: The memory area
  * @n: The size of the area
  *
- * Return: True if the area of memory is all 0's.
+ * Returns: True if the area of memory is all 0's.
  */
 static inline bool mem_is_zero(const void *s, size_t n)
 {
@@ -332,6 +333,10 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *s);
  * @_s: string to match with
  *
  * Helper for __sysfs_match_string(). Calculates the size of @a automatically.
+ *
+ * Returns:
+ * The index of the matching string in the array or negative error code
+ * otherwise.
  */
 #define sysfs_match_string(_a, _s) __sysfs_match_string(_a, ARRAY_SIZE(_a), _s)
 
-- 
2.50.1

