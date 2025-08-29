Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2ED30CDA5;
	Fri, 29 Aug 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489584; cv=none; b=EkCKU87JMRWEFsbsmslWtp1r5UEtChN+r2CMeslJcZOHwWdrizGuj9diym6dDf9vDisLgQLLX3df3YG71hbz7JUVCriK3XP79k5kGwA2Rm1MOmej2DmadPP/rvaS1+YLYcmzc5WXB/+k5AETUXr4enPHfZAjxagu9NM1Y0+gFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489584; c=relaxed/simple;
	bh=F+vDjpHX0nPQPXfZIZXWFZn3sfiMw9Otqkj/ZFDb4Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=De7ufMEfaKLePmhvw3VI4iCBWVNyK+1MLrmaABN27F2DqF4ndr1prw4DoBfly/LRyprR29zZD/S4TJoQR9H+W8DsiI4sl6MllRDBWaRqWqieAfzV1LP9zsaCIBCvcYftAoAaBcJjdsb6DgunQP7C/MQ8r1OhYt7Ndb5/8PVixSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkvWDz1i; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkvWDz1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756489582; x=1788025582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F+vDjpHX0nPQPXfZIZXWFZn3sfiMw9Otqkj/ZFDb4Yc=;
  b=jkvWDz1iw8v2PKr4t49vgTwXI30KCOVO1RraiTkPhsstzgZRkI9OSd0K
   mWIw8mW+ijO5lkF8WMmUaXBc0/ym52dQsw6/bAjhBnrzsiOcADl3WYobd
   81rnxb7lk1Pvo4/fzXj8pW5KulGmeVTOM5qTF6fm0rdK4KuzyoVi/F9pg
   6CaR5ALcxQmHKInE1MHPiC/avC/GQHvi5vlwxW5cpcTlztwdGh2sUn2ty
   cQElLu3PSn1Lm0Fo9vjH96ekwlFrfDrTo3ytsq2W02u+/Hg9ktsPdTVil
   2azpv8TrAjCBoSSLdKPRRA3Rm4fS4VpgBnEIeyDC9jVds3zbxTXpTR+sD
   A==;
X-CSE-ConnectionGUID: g5nOwtc8TdaXPxbW+8/QWQ==
X-CSE-MsgGUID: q2UYg82cR0q9r3p6I/gHhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58851394"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58851394"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:46:22 -0700
X-CSE-ConnectionGUID: Ww1TxfqpSsWhnAjfT7raRg==
X-CSE-MsgGUID: OKPQqQP+Td2CnAwwDdpsrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175716541"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.58])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:46:19 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	jani.nikula@intel.com,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] drm/i915: document range_overflows() and range_end_overflows() macros
Date: Fri, 29 Aug 2025 20:46:00 +0300
Message-ID: <20250829174601.2163064-2-jani.nikula@intel.com>
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

Document the macros in preparation for making them more generally
available.

Cc: Kees Cook <kees@kernel.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/i915_utils.h | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index fdac9a158b53..968dae941532 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -67,6 +67,18 @@ bool i915_error_injected(void);
 		drm_err(&(i915)->drm, fmt, ##__VA_ARGS__); \
 })
 
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
 #define range_overflows(start, size, max) ({ \
 	typeof(start) start__ = (start); \
 	typeof(size) size__ = (size); \
@@ -76,9 +88,32 @@ bool i915_error_injected(void);
 	start__ >= max__ || size__ > max__ - start__; \
 })
 
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
 #define range_overflows_t(type, start, size, max) \
 	range_overflows((type)(start), (type)(size), (type)(max))
 
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
 #define range_end_overflows(start, size, max) ({ \
 	typeof(start) start__ = (start); \
 	typeof(size) size__ = (size); \
@@ -88,6 +123,17 @@ bool i915_error_injected(void);
 	start__ > max__ || size__ > max__ - start__; \
 })
 
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
 #define range_end_overflows_t(type, start, size, max) \
 	range_end_overflows((type)(start), (type)(size), (type)(max))
 
-- 
2.47.2

