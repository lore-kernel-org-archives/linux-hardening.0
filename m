Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C42343213;
	Fri, 29 Aug 2025 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489590; cv=none; b=pAXDDcH0Kw9/rW+KOjnzJs3JEZrcdRHn4Sg+qJuFGr8vvlgLJbJG9/Ul3VKhF3UhAhpaNH3JVDOkeMY9o4vkg2W8ezur8WZLA9wuR4xYlPLDH44jpU9xpXsuYM9/4sVyXwS7aNb22U7CAaMtVzn4qgHwDRaGq7K+6Gq5egJ7J4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489590; c=relaxed/simple;
	bh=ffhQYsIDiciYhH+b5mTnOldlYmqjRKlLJpxwdY8kaKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2faLn0pkaRYU+WnnI8S9fWziftcIfZLf4VqNNiFfBNO1MgXfMS8/Axi86DOJUCua/sF4y6bZ6O4dWVZLXRO/HzTRFKUijtR7c2DCRh7GkRMaMr8/10umy2/WtRWgAhh9HG4NKg5Bf7Xeyo6T227bWXl49Ct7TfQw6wr6pX0bm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdHDF/OR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdHDF/OR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756489588; x=1788025588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ffhQYsIDiciYhH+b5mTnOldlYmqjRKlLJpxwdY8kaKM=;
  b=FdHDF/ORjTykHzDvfkMrhDXH5I5Kc+BOEsEYQQ6KMHkk4kdBfwO/80bm
   d03ac4CK0tPqbEuUHm+M6/vpxaA/LFl06YPZzaApZ1yfP9P4KHaJD2p9o
   f4VwdcHtA3i58NTpfXq3gbir4/ssRAyoSIJcAKVv4BUP1c9XH5OvYHiwT
   f4VeWYcpLXGaJDXPK1y+w65bQ5fg++jOmZiXU2IRM6JqmDPBPHMGovu4n
   fgEf9TxuNXnKG7Z61vSLVNfxETMH294PSmx/zVtaDnpbGHm14MnYBpKv8
   xNT837i0FM5CmbEdY1Kc9ttosoMlbnnkBvt/2TChnqyve6I45UsaigoZv
   A==;
X-CSE-ConnectionGUID: EGvCSZZ7Tn2SPmb8gL9FhA==
X-CSE-MsgGUID: KHtJnDTUTbiKIsNJbhcZLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58851406"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58851406"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:46:28 -0700
X-CSE-ConnectionGUID: fGPMj5/lRymVIoM1KyC6qA==
X-CSE-MsgGUID: oKGJbnFSTQKo7EXZ0qa+Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175716544"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.58])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:46:25 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	jani.nikula@intel.com,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] overflow: add range_overflows() and range_end_overflows()
Date: Fri, 29 Aug 2025 20:46:01 +0300
Message-ID: <20250829174601.2163064-3-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829174601.2163064-1-jani.nikula@intel.com>
References: <20250829174601.2163064-1-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Move the range_overflows() and range_end_overflows() along with the _t
variants over from drm/i915 and drm/buddy to overflow.h.

Cc: Kees Cook <kees@kernel.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/i915_utils.h | 70 -------------------------------
 include/drm/drm_buddy.h           |  9 ----
 include/linux/overflow.h          | 70 +++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index 968dae941532..eb4d43c40009 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -67,76 +67,6 @@ bool i915_error_injected(void);
 		drm_err(&(i915)->drm, fmt, ##__VA_ARGS__); \
 })
 
-/**
- * range_overflows() - Check if a range is out of bounds
- * @start: Start of the range.
- * @size:  Size of the range.
- * @max:   Exclusive upper boundary.
- *
- * A strict check to determine if the range [@start, @start + @size) is
- * invalid with respect to the allowable range [0, @max). Any range
- * starting at or beyond @max is considered an overflow, even if @size is 0.
- *
- * Returns: true if the range is out of bounds.
- */
-#define range_overflows(start, size, max) ({ \
-	typeof(start) start__ = (start); \
-	typeof(size) size__ = (size); \
-	typeof(max) max__ = (max); \
-	(void)(&start__ == &size__); \
-	(void)(&start__ == &max__); \
-	start__ >= max__ || size__ > max__ - start__; \
-})
-
-/**
- * range_overflows_t() - Check if a range is out of bounds
- * @type:  Data type to use.
- * @start: Start of the range.
- * @size:  Size of the range.
- * @max:   Exclusive upper boundary.
- *
- * Same as range_overflows() but forcing the parameters to @type.
- *
- * Returns: true if the range is out of bounds.
- */
-#define range_overflows_t(type, start, size, max) \
-	range_overflows((type)(start), (type)(size), (type)(max))
-
-/**
- * range_end_overflows() - Check if a range's endpoint is out of bounds
- * @start: Start of the range.
- * @size:  Size of the range.
- * @max:   Exclusive upper boundary.
- *
- * Checks only if the endpoint of a range (@start + @size) exceeds @max.
- * Unlike range_overflows(), a zero-sized range at the boundary (@start == @max)
- * is not considered an overflow. Useful for iterator-style checks.
- *
- * Returns: true if the endpoint exceeds the boundary.
- */
-#define range_end_overflows(start, size, max) ({ \
-	typeof(start) start__ = (start); \
-	typeof(size) size__ = (size); \
-	typeof(max) max__ = (max); \
-	(void)(&start__ == &size__); \
-	(void)(&start__ == &max__); \
-	start__ > max__ || size__ > max__ - start__; \
-})
-
-/**
- * range_end_overflows_t() - Check if a range's endpoint is out of bounds
- * @type:  Data type to use.
- * @start: Start of the range.
- * @size:  Size of the range.
- * @max:   Exclusive upper boundary.
- *
- * Same as range_end_overflows() but forcing the parameters to @type.
- *
- * Returns: true if the endpoint exceeds the boundary.
- */
-#define range_end_overflows_t(type, start, size, max) \
-	range_end_overflows((type)(start), (type)(size), (type)(max))
-
 #define ptr_mask_bits(ptr, n) ({					\
 	unsigned long __v = (unsigned long)(ptr);			\
 	(typeof(ptr))(__v & -BIT(n));					\
diff --git a/include/drm/drm_buddy.h b/include/drm/drm_buddy.h
index 513837632b7d..04afd7c21a82 100644
--- a/include/drm/drm_buddy.h
+++ b/include/drm/drm_buddy.h
@@ -13,15 +13,6 @@
 
 #include <drm/drm_print.h>
 
-#define range_overflows(start, size, max) ({ \
-	typeof(start) start__ = (start); \
-	typeof(size) size__ = (size); \
-	typeof(max) max__ = (max); \
-	(void)(&start__ == &size__); \
-	(void)(&start__ == &max__); \
-	start__ >= max__ || size__ > max__ - start__; \
-})
-
 #define DRM_BUDDY_RANGE_ALLOCATION		BIT(0)
 #define DRM_BUDDY_TOPDOWN_ALLOCATION		BIT(1)
 #define DRM_BUDDY_CONTIGUOUS_ALLOCATION		BIT(2)
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 154ed0dbb43f..725f95f7e416 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -238,6 +238,76 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 			      __overflows_type_constexpr(n, T),	\
 			      __overflows_type(n, T))
 
+/**
+ * range_overflows() - Check if a range is out of bounds
+ * @start: Start of the range.
+ * @size:  Size of the range.
+ * @max:   Exclusive upper boundary.
+ *
+ * A strict check to determine if the range [@start, @start + @size) is
+ * invalid with respect to the allowable range [0, @max). Any range
+ * starting at or beyond @max is considered an overflow, even if @size is 0.
+ *
+ * Returns: true if the range is out of bounds.
+ */
+#define range_overflows(start, size, max) ({ \
+	typeof(start) start__ = (start); \
+	typeof(size) size__ = (size); \
+	typeof(max) max__ = (max); \
+	(void)(&start__ == &size__); \
+	(void)(&start__ == &max__); \
+	start__ >= max__ || size__ > max__ - start__; \
+})
+
+/**
+ * range_overflows_t() - Check if a range is out of bounds
+ * @type:  Data type to use.
+ * @start: Start of the range.
+ * @size:  Size of the range.
+ * @max:   Exclusive upper boundary.
+ *
+ * Same as range_overflows() but forcing the parameters to @type.
+ *
+ * Returns: true if the range is out of bounds.
+ */
+#define range_overflows_t(type, start, size, max) \
+	range_overflows((type)(start), (type)(size), (type)(max))
+
+/**
+ * range_end_overflows() - Check if a range's endpoint is out of bounds
+ * @start: Start of the range.
+ * @size:  Size of the range.
+ * @max:   Exclusive upper boundary.
+ *
+ * Checks only if the endpoint of a range (@start + @size) exceeds @max.
+ * Unlike range_overflows(), a zero-sized range at the boundary (@start == @max)
+ * is not considered an overflow. Useful for iterator-style checks.
+ *
+ * Returns: true if the endpoint exceeds the boundary.
+ */
+#define range_end_overflows(start, size, max) ({ \
+	typeof(start) start__ = (start); \
+	typeof(size) size__ = (size); \
+	typeof(max) max__ = (max); \
+	(void)(&start__ == &size__); \
+	(void)(&start__ == &max__); \
+	start__ > max__ || size__ > max__ - start__; \
+})
+
+/**
+ * range_end_overflows_t() - Check if a range's endpoint is out of bounds
+ * @type:  Data type to use.
+ * @start: Start of the range.
+ * @size:  Size of the range.
+ * @max:   Exclusive upper boundary.
+ *
+ * Same as range_end_overflows() but forcing the parameters to @type.
+ *
+ * Returns: true if the endpoint exceeds the boundary.
+ */
+#define range_end_overflows_t(type, start, size, max) \
+	range_end_overflows((type)(start), (type)(size), (type)(max))
+
 /**
  * castable_to_type - like __same_type(), but also allows for casted literals
  *
-- 
2.47.2

