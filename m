Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F278F3FD139;
	Tue, 11 Aug 2026 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432415; cv=none; b=QChqdg8XYDhijYRMOjLMpcdelut1fMVwFCEEJK6HO/R/T5172S1bdbhBzu00yzbg2oaPI6uARKBvYZwHrS8ouRcIk2D1keyyKaWz/2kI7ldprloSfj7rg9PgpxXHJGdhwwyNDMslON6ATrBZ93aaaUvvTrZbfwj7pf8p4vjz0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432415; c=relaxed/simple;
	bh=dKEAzoTxrnJRUnozAVrRr9+kPAXymWDr63g8YhYfYFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqMkhws1NNR17PCqxZaRzLY73Mpl9EUB/3DJy96pDHPKVzZaHWp0N/oFaE4fpJNaqULlu24gNfSTaLsnx+0gQdIHaUPzWlfp+buev+TMT57J3Zf1D2S8km7Ky1tI8sYZa8soPZD6glvOChYWDdYjA8+A/2ExHwvlpf1O3FRdGpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPzKR31z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPzKR31z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786432408; x=1817968408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dKEAzoTxrnJRUnozAVrRr9+kPAXymWDr63g8YhYfYFo=;
  b=GPzKR31zB1eBpFVBQmx8DS3YL41xCLvajL+yEuAmQsfaVlonrZw1RRGR
   wBCVotMd4Z+U6JevNY1K1CFaeAY7+nhgFJP5lngdR6tpPq8t6H+/O4dJN
   TpfEdAKzdH0XEwvogWcPT2zhm7fxyvNSach1dW7KRpog+XwmEdFx5B7HU
   r44dr2xKf8+AvFi5MALLhUvYtmhkdI3w4eGjB2FL90YEA7ErD4ThGQpNb
   Eo0L9AaBg4gG9/XKyUSDEfyv+Hy7bQ3nOvYDsEMjDAjuZgbSLGZaF6HdD
   mj0YrDA0Edx4uMxoxmc9sdC+x7X+HoRLxhXO5k5z4sY65s7m4NxQMPXzW
   g==;
X-CSE-ConnectionGUID: gT5agpCGQcu1jWfppOWfoA==
X-CSE-MsgGUID: g1IKpkyURQapHrbHksjJaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90839126"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="90839126"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:13:24 -0700
X-CSE-ConnectionGUID: n8t36Em1SSy0gt+VvXxZkw==
X-CSE-MsgGUID: x1fqT4RqRUOFdhwHvdQzgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="286675044"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 11 Aug 2026 00:13:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 55A6599; Tue, 11 Aug 2026 09:13:21 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v1 1/1] string: Introduce __free(kfree_const)
Date: Tue, 11 Aug 2026 09:13:17 +0200
Message-ID: <20260811071319.1352016-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__free(kfree_const) may be used in the cases when one part of the code
relies on the constant string literals, while the other uses a heap
(via kasprintf(), for example).

Requested-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/CAGXv+5HGZwAKpGpyV4=QHfg7yBQPx-syc1Gma2qad_tzW_RLog@mail.gmail.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 75bfc194ad20..6f3501b56c11 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -294,8 +294,11 @@ static inline bool mem_is_zero(const void *s, size_t n)
 	return !memchr_inv(s, 0, n);
 }
 
+/* mm/util.c */
 extern void kfree_const(const void *x);
 
+DEFINE_FREE(kfree_const, void *, if (!IS_ERR_OR_NULL(_T)) kfree_const(_T))
+
 extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
 extern const char *kstrdup_const(const char *s, gfp_t gfp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
-- 
2.50.1

