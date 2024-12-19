Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6611CBA;
	Thu, 19 Dec 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734616701; cv=none; b=Cnnqr4TFXWs1cxk3Hcjq85fWfme1/2VoNT9qRWdulm4s42021nV2xcK8FEr9P/P7bDMcouDQ2Ihhnofyy9oatsWnliNJHsNJonfKG1L69ZVY/ugmbG49QBfDzJ3AZ6sxYLQlV4x7vsAsk/le+4b0AmHAJyTBdMlJdb9ZPYye9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734616701; c=relaxed/simple;
	bh=lE+jJaLDzW+5ZhCrJSYH8OVzyytvYS4oRAAwBoAavUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ijnxsKWnpArUWVE3o3DRbqR9bMCxYUAAXctmlTcXD7FwUGXnrsU5ODpfI5GqVovtOXKl8UUrbrFIUFxihV7XudF2ddlyQPK+JNAKKR8EtLhymHLmYYzinUYNSOpgU/AhmWfa+LLTNoFLOgYv86hySAUvzq/c7RD46qpdQ8xlHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQ7bZP/H; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQ7bZP/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734616699; x=1766152699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lE+jJaLDzW+5ZhCrJSYH8OVzyytvYS4oRAAwBoAavUM=;
  b=EQ7bZP/HAxKxaZo0R/h4S3oQd4ewv6KSV49uS2n8LvSJfo88BX9XKzbF
   crFFJBeepZ2z2yBGVGT9YoJa17AsFgMF3NGdDW54lbikXtIomwVeowwgC
   YEIRmjhyB5FcAnz0VQUatUXN6U2vhETDZCPhrZ9EhAZibzxbN4/niGIIj
   B6L23VOMOw6o9MvOqe9Q+YPHRQQyS+vtM/SPkYQ4HFsTc8DnMkaJHgf+h
   tAsxz8RRmzIL+GYUMtTzs73+h2yBJuxXwtje7gft2Ra/ciQd3jNaC2oyW
   apTFqyoHc/AoJdxYIqp1go90MCasZWeInd4OhJnKlBRsZA0n5MbxwZM7A
   Q==;
X-CSE-ConnectionGUID: /zRWX54iTTGufxJGIcGEAw==
X-CSE-MsgGUID: 0W95iHy6TH+MGvIbg7b3WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="38802502"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="38802502"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:58:18 -0800
X-CSE-ConnectionGUID: pFHLcXodRxGj93SN/4NOyw==
X-CSE-MsgGUID: lfDagNbbQvW4IyUla2nQFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="103270018"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 19 Dec 2024 05:58:16 -0800
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
Subject: [PATCH v2] stddef: make __struct_group() UAPI C++-friendly
Date: Thu, 19 Dec 2024 14:57:34 +0100
Message-ID: <20241219135734.2130002-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the most part of the C++ history, it couldn't have type
declarations inside anonymous unions for different reasons. At the
same time, __struct_group() relies on the latters, so when the @TAG
argument is not empty, C++ code doesn't want to build (even under
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
Suggested-by: Kees Cook <kees@kernel.org> # __struct_group_tag()
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
From v1[0]:
* wrap @TAG into __struct_group_tag() (Kees).

[0] https://lore.kernel.org/linux-hardening/20241218145758.701008-1-aleksander.lobakin@intel.com
---
 include/uapi/linux/stddef.h       | 13 ++++++++++---
 tools/include/uapi/linux/stddef.h | 15 +++++++++++----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 58154117d9b0..a6fce46aeb37 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -8,6 +8,13 @@
 #define __always_inline inline
 #endif
 
+/* Not all C++ standards support type declarations inside an anonymous union */
+#ifndef __cplusplus
+#define __struct_group_tag(TAG)		TAG
+#else
+#define __struct_group_tag(TAG)
+#endif
+
 /**
  * __struct_group() - Create a mirrored named and anonyomous struct
  *
@@ -20,13 +27,13 @@
  * and size: one anonymous and one named. The former's members can be used
  * normally without sub-struct naming, and the latter can be used to
  * reason about the start, end, and size of the group of struct members.
- * The named struct can also be explicitly tagged for layer reuse, as well
- * as both having struct attributes appended.
+ * The named struct can also be explicitly tagged for layer reuse (C only),
+ * as well as both having struct attributes appended.
  */
 #define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
 	union { \
 		struct { MEMBERS } ATTRS; \
-		struct TAG { MEMBERS } ATTRS NAME; \
+		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
 	} ATTRS
 
 #ifdef __cplusplus
diff --git a/tools/include/uapi/linux/stddef.h b/tools/include/uapi/linux/stddef.h
index bb6ea517efb5..c53cde425406 100644
--- a/tools/include/uapi/linux/stddef.h
+++ b/tools/include/uapi/linux/stddef.h
@@ -8,6 +8,13 @@
 #define __always_inline __inline__
 #endif
 
+/* Not all C++ standards support type declarations inside an anonymous union */
+#ifndef __cplusplus
+#define __struct_group_tag(TAG)		TAG
+#else
+#define __struct_group_tag(TAG)
+#endif
+
 /**
  * __struct_group() - Create a mirrored named and anonyomous struct
  *
@@ -20,14 +27,14 @@
  * and size: one anonymous and one named. The former's members can be used
  * normally without sub-struct naming, and the latter can be used to
  * reason about the start, end, and size of the group of struct members.
- * The named struct can also be explicitly tagged for layer reuse, as well
- * as both having struct attributes appended.
+ * The named struct can also be explicitly tagged for layer reuse (C only),
+ * as well as both having struct attributes appended.
  */
 #define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
 	union { \
 		struct { MEMBERS } ATTRS; \
-		struct TAG { MEMBERS } ATTRS NAME; \
-	}
+		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
+	} ATTRS
 
 /**
  * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
-- 
2.47.1

