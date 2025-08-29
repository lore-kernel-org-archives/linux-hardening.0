Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4C30CDA5;
	Fri, 29 Aug 2025 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489579; cv=none; b=UeSo2NB01kvM05TS3h8EcSeUkpuuuYf7/w9LXNpIdYSTXeaHv3XsQGHnW0nJdPDw5dnXTg0O/Ds1GgkbOSaH/yfdMtClyJ3QcnLhKux/NYLl1n1t20oMYR/jPCITmu1mGoknqNYGb/JGU3Nc1lwP3XER9QLipBEScknBsyelRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489579; c=relaxed/simple;
	bh=iINmr2KFYoSGsHTNTuQy3QPX4Iv/FtsHEayJdZ4JN8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXeoeqtfOL3UOuifgLRb4DFMRul3FNo5Or+S6PVwsDnirE03ypsmM3MZDLAIMjd89W9f0eQ0w9DO/MOnaNCFh6hAy5V0lzx/eEdScdlcxl95UEywmBBkSelIQbezuvVgiriK5s+bsx4OhNyEMdVzlXj4Trvy8cPfjSguAQR3f+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knNMQ2HH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knNMQ2HH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756489577; x=1788025577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iINmr2KFYoSGsHTNTuQy3QPX4Iv/FtsHEayJdZ4JN8Q=;
  b=knNMQ2HHPinjbQW1wky5YRh5O2ATdq3XjDESGA2r9e+iAf3V6EVXFguu
   U1sLJCsrV4uZc4Nr4Ik3q5C1IvcBacCAJutKbvl9EMJOeTfyVN8iimeeP
   9TEf9FmUsZZQUtytPG4Ivhl4J09Q6D0BAmVP0I1ygI4xZJkYTSkkQjz8m
   5p+6ycxgdBJXtRAFWqgkrxTfhPlS8jO6PDKW29iVU0fsne0emc3Uh88hA
   KT7QY97LObQzrEIDQfx/5+QQCnRQwiPTKQar4vg0vg+7QT/NGzRGRoTbP
   AbxQgSH2TmPhCNqgu+vjLJsFbJyxCkFjmME28TU0DQjqVJz1RB+/ayrQ5
   w==;
X-CSE-ConnectionGUID: 1DR4Uj7tTM2MRINbNkG/3w==
X-CSE-MsgGUID: jl/mC8n4RcqmGT1/HCoQ0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58851382"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58851382"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:46:16 -0700
X-CSE-ConnectionGUID: QVvqT+VwSzuYmS61GvWMGg==
X-CSE-MsgGUID: Zka0mUPyQ02fm5dlf3hXFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175716538"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.58])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:46:13 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	jani.nikula@intel.com,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] drm/i915: rename range_overflows_end() to range_end_overflows()
Date: Fri, 29 Aug 2025 20:45:59 +0300
Message-ID: <20250829174601.2163064-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Rename range_overflows_end() to range_end_overflows(), along with the _t
variant.

It's all rather subjective, but I think range_end_overflows() reads
better.

Cc: Kees Cook <kees@kernel.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_fbc.c | 4 ++--
 drivers/gpu/drm/i915/gt/intel_rc6.c      | 2 +-
 drivers/gpu/drm/i915/i915_utils.h        | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index d4c5deff9cbe..446e2ad28a70 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -383,11 +383,11 @@ static void i8xx_fbc_program_cfb(struct intel_fbc *fbc)
 	struct drm_i915_private *i915 = to_i915(display->drm);
 
 	drm_WARN_ON(display->drm,
-		    range_overflows_end_t(u64, i915_gem_stolen_area_address(i915),
+		    range_end_overflows_t(u64, i915_gem_stolen_area_address(i915),
 					  i915_gem_stolen_node_offset(&fbc->compressed_fb),
 					  U32_MAX));
 	drm_WARN_ON(display->drm,
-		    range_overflows_end_t(u64, i915_gem_stolen_area_address(i915),
+		    range_end_overflows_t(u64, i915_gem_stolen_area_address(i915),
 					  i915_gem_stolen_node_offset(&fbc->compressed_llb),
 					  U32_MAX));
 	intel_de_write(display, FBC_CFB_BASE,
diff --git a/drivers/gpu/drm/i915/gt/intel_rc6.c b/drivers/gpu/drm/i915/gt/intel_rc6.c
index 9ca42589da4d..bf38cc5fe872 100644
--- a/drivers/gpu/drm/i915/gt/intel_rc6.c
+++ b/drivers/gpu/drm/i915/gt/intel_rc6.c
@@ -341,7 +341,7 @@ static int vlv_rc6_init(struct intel_rc6 *rc6)
 		return PTR_ERR(pctx);
 	}
 
-	GEM_BUG_ON(range_overflows_end_t(u64,
+	GEM_BUG_ON(range_end_overflows_t(u64,
 					 i915->dsm.stolen.start,
 					 pctx->stolen->start,
 					 U32_MAX));
diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index 9cb40c2c4b12..fdac9a158b53 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -79,7 +79,7 @@ bool i915_error_injected(void);
 #define range_overflows_t(type, start, size, max) \
 	range_overflows((type)(start), (type)(size), (type)(max))
 
-#define range_overflows_end(start, size, max) ({ \
+#define range_end_overflows(start, size, max) ({ \
 	typeof(start) start__ = (start); \
 	typeof(size) size__ = (size); \
 	typeof(max) max__ = (max); \
@@ -88,8 +88,8 @@ bool i915_error_injected(void);
 	start__ > max__ || size__ > max__ - start__; \
 })
 
-#define range_overflows_end_t(type, start, size, max) \
-	range_overflows_end((type)(start), (type)(size), (type)(max))
+#define range_end_overflows_t(type, start, size, max) \
+	range_end_overflows((type)(start), (type)(size), (type)(max))
 
 #define ptr_mask_bits(ptr, n) ({					\
 	unsigned long __v = (unsigned long)(ptr);			\
-- 
2.47.2

