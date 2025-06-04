Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA225E823
	for <linux-hardening@vger.kernel.org>; Wed,  4 Jun 2025 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027553; cv=none; b=c8iZWqXMH+2R7hOcakdiOWvE3WmApvIqcpJofGxcm5ELevUX44ftM1Vp3TYsu7u9KCsh6je2d7nZYmqog3DIAkSlsQgw+DjrcN6LC+9B/QjCZy4LWQnu2+by7ZU9ChP8bleV6BBuYvv0XHzDIDdXv7+bzzACs0aE5GLaYtkjXEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027553; c=relaxed/simple;
	bh=544MV2IkCIgm0MxZu7bta16Lz/bw0OqCkBlg2eu3Zmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hr95gZS1S85RYCOD1+esTjLjG1xDcU9Qy5XQ4tJCyUvVPDLg2W4sp5OmelwkoxBPcwCvKvT+6Y1HoTYKmxOJFwFaL1430VCiSd9dF5WIFgm/BrlYp85Baq8k9kkxnGZaLMxFeiLZXMtnOsFtUZS6lKlg4WmDhkAaKHyal9kg2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0KAz2E3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0KAz2E3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749027552; x=1780563552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=544MV2IkCIgm0MxZu7bta16Lz/bw0OqCkBlg2eu3Zmk=;
  b=H0KAz2E3lnxxPxgXX6TXTOxxtHFv72+jqpTap8gn0Wl10tFPsKbhpUOT
   WMxKVSLgYusKxi8rspJ4bVGEmzB811qHMW2p2eaa2B3vsMsFVsI6uJJKG
   sA88bfRd+N0GywYjLn+2Nf8z+5kPf+ur+7bmBt7swPk2142rUnB/6FeFe
   acUou0/l51l2bHDgMtfhbkCh6bLb8EgWyxbdvgvhjA4jnPMOSpYndhhDr
   JUnywJ9366jj2KrAj+HJf7m63KuR96FxcMi9tGj7n1j/0hRZSpot37uxn
   SGM65bJELydsN+jlDo+TCCI7oAqdx1KttPcxpiJLbK7TtPG8iNvGLWKbQ
   A==;
X-CSE-ConnectionGUID: 0uYerT/uS+ewVF1mZBncPg==
X-CSE-MsgGUID: /QdqCWJ3QM+qGx5ZQ6SD+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62454702"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="62454702"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 01:59:11 -0700
X-CSE-ConnectionGUID: PSMjmsuGQ1yfsvJ80W2zSA==
X-CSE-MsgGUID: UiVpw59fT/Ggaex7KR+cmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="146096852"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.101])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 01:59:08 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Kees Cook <kees@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: [RFC] drm/i915/utils: document range_overflows*() macros
Date: Wed,  4 Jun 2025 11:59:00 +0300
Message-Id: <20250604085900.819259-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202506021119.8FD6339F@keescook>
References: <202506021119.8FD6339F@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

In preparation for moving the range check macros to
include/linux/overflow.h, document them properly.

Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

I can squash this into actually moving the macros, I just want to
solicit feedback for the documentation first.
---
 drivers/gpu/drm/i915/i915_utils.h | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index f7fb40cfdb70..79127f01f887 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -67,6 +67,19 @@ bool i915_error_injected(void);
 		drm_err(&(i915)->drm, fmt, ##__VA_ARGS__); \
 })
 
+
+/**
+ * range_overflows() - Check if @start + @size > @max
+ * @start: start offset
+ * @size: length of the range
+ * @max: valid upper limit
+ *
+ * Helper for the common @start + @size > @max range or buffer overflow
+ * check. Return true if the addition exceeds max or overflows. Also return true
+ * if @start == @max, even if @size == 0.
+ *
+ * Returns: %true if the range overflows.
+ */
 #define range_overflows(start, size, max) ({ \
 	typeof(start) start__ = (start); \
 	typeof(size) size__ = (size); \
@@ -76,9 +89,30 @@ bool i915_error_injected(void);
 	start__ >= max__ || size__ > max__ - start__; \
 })
 
+/**
+ * range_overflows_t() - Check if @start + @size > @max
+ * @type: data type to use
+ * @start: start offset
+ * @size: length of the range
+ * @max: valid upper limit
+ *
+ * Same as range_overflows(), but using the specified @type.
+ *
+ * Returns: %true if the range overflows.
+ */
 #define range_overflows_t(type, start, size, max) \
 	range_overflows((type)(start), (type)(size), (type)(max))
 
+/**
+ * range_overflows_end() - Check if @start + @size > @max
+ * @start: start offset
+ * @size: length of the range
+ * @max: valid upper limit
+ *
+ * Same as range_overflows(), but allow @start == @max when @size == 0.
+ *
+ * Returns: %true if the range overflows.
+ */
 #define range_overflows_end(start, size, max) ({ \
 	typeof(start) start__ = (start); \
 	typeof(size) size__ = (size); \
@@ -88,6 +122,17 @@ bool i915_error_injected(void);
 	start__ > max__ || size__ > max__ - start__; \
 })
 
+/**
+ * range_overflows_end_t() - Check if @start + @size > @max
+ * @type: data type to use
+ * @start: start offset
+ * @size: length of the range
+ * @max: valid upper limit
+ *
+ * Same as range_overflows_end(), but using the specified @type.
+ *
+ * Returns: %true if the range overflows.
+ */
 #define range_overflows_end_t(type, start, size, max) \
 	range_overflows_end((type)(start), (type)(size), (type)(max))
 
-- 
2.39.5

