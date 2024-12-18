Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A7C1EC01C;
	Wed, 18 Dec 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533946; cv=none; b=LH1Wd5m+KOMxVAITciwMP5JwO2r7N8+acvFxVfh/lM+138o7iXS+Jl7PQq5fOFBXieeqn9CKGPHVA0qjdYPNPgNlVToCd4EG1d3XmnydtYBQBil4/88pGtQfrXvg57WlseqCJfAsSyTTOwiJwKemMiEHV0Lrdo/ECbGhlj8D2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533946; c=relaxed/simple;
	bh=19Mj0lNClIw/H/Zaw903G4OaFHi5cfyhm/VkVJr/HE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=diQx/xhcZhJOwtPQpYbgsKpn0cjLEuOLvRWaPY7c1Ej3u7GgEk3sj7eGBsN37yym5Q5gk+wzVPBxWz2xtl4kQFndlrrYl9EW44o9zqwd65xAKH/nuNgufY38s+/LfodxiOxDkhS49FqdMbf1EUe2RdophA/MrQYq9hXrpeOV+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSTIRW8r; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSTIRW8r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734533945; x=1766069945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=19Mj0lNClIw/H/Zaw903G4OaFHi5cfyhm/VkVJr/HE4=;
  b=bSTIRW8rDf0xh+DoUKldbYMaXQOBw76X9M3nqvGysPzZk7l0oxdJI691
   9+p9pszzVr1to0lXcPYPOezBgSpcA3v8ybjaaYybqoLPitOcE8XL82RLv
   FCjeUaoAnzg0LMjVqfLhkgm3/RK5Wz78umxLxiyKyzkUZrUndLLPpM2xf
   2nwK99xFxDXhpzW10jCiEj2pxPq9fanPpvG6okUNjN2TGy1pze7/AtLPZ
   nMnGmWC0Pc5Ff3TRy1L/es4ZOSlT3yjuVZSumDdgxTo81nPapOPq0jP5p
   s44R5fkgqGcCZ2o3cmO8C78BEo2istLbUk1co9FoZtCPRFdJyZ9EYo8y1
   Q==;
X-CSE-ConnectionGUID: ZdlnMcTbQLKXrgcnVW09Rw==
X-CSE-MsgGUID: n+etVfj/Rii2BZdca0btNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="57488609"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="57488609"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:59:04 -0800
X-CSE-ConnectionGUID: yhQ1nsANQii37ldWXruOGQ==
X-CSE-MsgGUID: hqXBDnZdRZGu/KRR3JHsDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="128679139"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 18 Dec 2024 06:59:02 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Christopher Ferris <cferris@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@outlook.com>,
	Keith Packard <keithp@keithp.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] stddef: make __struct_group() UAPI C++-friendly
Date: Wed, 18 Dec 2024 15:57:58 +0100
Message-ID: <20241218145758.701008-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the most part of C++ history, it couldn't have type declarations
inside anonymous unions for different reasons. At the same time,
__struct_group() relies on the latters, so when the @TAG argument
is not empty, C++ code doesn't want to build (even under
`extern "C"`):

../linux/include/uapi/linux/pkt_cls.h:25:24: error:
'struct tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,' invalid;
an anonymous union may only have public non-static data members
[-fpermissive]

The safest way to fix this without trying to switch standards (which
is impossible in UAPI anyway) etc., is to disable tag declaration
for that language. This won't break anything since for now it's not
buildable at all.
Use a separate definition for __struct_group() when __cplusplus is
defined to mitigate the error, including the version from tools/.

Fixes: 50d7bd38c3aa ("stddef: Introduce struct_group() helper macro")
Reported-by: Christopher Ferris <cferris@google.com>
Closes: https://lore.kernel.org/linux-hardening/Z1HZpe3WE5As8UAz@google.com
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/uapi/linux/stddef.h       | 12 ++++++++++--
 tools/include/uapi/linux/stddef.h | 14 +++++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 58154117d9b0..ad51b1362bbb 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -20,14 +20,22 @@
  * and size: one anonymous and one named. The former's members can be used
  * normally without sub-struct naming, and the latter can be used to
  * reason about the start, end, and size of the group of struct members.
- * The named struct can also be explicitly tagged for layer reuse, as well
- * as both having struct attributes appended.
+ * The named struct can also be explicitly tagged for layer reuse (C only),
+ * as well as both having struct attributes appended.
  */
+#ifndef __cplusplus
 #define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
 	union { \
 		struct { MEMBERS } ATTRS; \
 		struct TAG { MEMBERS } ATTRS NAME; \
 	} ATTRS
+#else
+#define __struct_group(__IGNORED, NAME, ATTRS, MEMBERS...) \
+	union { \
+		struct { MEMBERS } ATTRS; \
+		struct { MEMBERS } ATTRS NAME; \
+	} ATTRS
+#endif
 
 #ifdef __cplusplus
 /* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
diff --git a/tools/include/uapi/linux/stddef.h b/tools/include/uapi/linux/stddef.h
index bb6ea517efb5..12b854ecc215 100644
--- a/tools/include/uapi/linux/stddef.h
+++ b/tools/include/uapi/linux/stddef.h
@@ -20,14 +20,22 @@
  * and size: one anonymous and one named. The former's members can be used
  * normally without sub-struct naming, and the latter can be used to
  * reason about the start, end, and size of the group of struct members.
- * The named struct can also be explicitly tagged for layer reuse, as well
- * as both having struct attributes appended.
+ * The named struct can also be explicitly tagged for layer reuse (C only),
+ * as well as both having struct attributes appended.
  */
+#ifndef __cplusplus
 #define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
 	union { \
 		struct { MEMBERS } ATTRS; \
 		struct TAG { MEMBERS } ATTRS NAME; \
-	}
+	} ATTRS
+#else
+#define __struct_group(__IGNORED, NAME, ATTRS, MEMBERS...) \
+	union { \
+		struct { MEMBERS } ATTRS; \
+		struct { MEMBERS } ATTRS NAME; \
+	} ATTRS
+#endif
 
 /**
  * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
-- 
2.47.1

