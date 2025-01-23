Received: from mail12.out.titan.email (mail12.out.titan.email [18.198.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE151CD205;
	Thu, 23 Jan 2025 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670323; cv=none; b=jcMK+dnDMA6BRZTFRPpTYbqOnrTw6UcdeB9I+WsQl1kzCadtLUFBRCJQx0SRgKhl7DoIYKU73It2+JYQLb36cyYwz244EWoIXjMeNc+S0Wcq7aASzOqSeMVYlei+/OQfV7+TJyg5p1LNtvrCR8PzouTs5VBqRFHy7aR2Jc4cT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670323; c=relaxed/simple;
	bh=NmDNIslrbQ1hpZ/kK7MlMNwPpWf2dsldVIU9YB7wVNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiAs7nFTd0s0capbobTM4z3/c18tDf1hFUk1JNjNMgxyUKUjU+KYiyIp0brwopHsP+AwFyn63TjHfmUiIYMJv+2WkcB/c+vNF2/hhXlPen9O98G3SevG10/1Gf6k+FJty/1sGtdxNCQR89lfmlG4q9d2ZMRygPPHuUVTefDjj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=iTAmP+6D; arc=none smtp.client-ip=18.198.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="iTAmP+6D"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 3EA13A0015;
	Thu, 23 Jan 2025 22:11:59 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=BeyJBSn5Hh/oeJpBDKyeJyIArhFqMyBpnM+5KuJxZAI=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=in-reply-to:mime-version:message-id:subject:date:references:from:to:cc:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737670319; v=1;
	b=iTAmP+6DkuqUEn4XJWA56m6yiaklCpRFR3kthmW9ufn9wF8VFnvzf3okiLIb9dsmOiT00fJ9
	j4CLNN8UJ37nSL2dnLuZASHPurDV2GFHTz2XFUVZPeqfoDOcEv4tjR8xSEDgWYvMFF8AI6wNy+J
	gfJiIDzbFaw7fvaxcvXjSNCw=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id C5EFAA0044;
	Thu, 23 Jan 2025 22:11:58 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/4] mm: security: Check early if HARDENED_USERCOPY is enabled
Date: Thu, 23 Jan 2025 22:11:14 +0000
Message-ID: <20250123221115.19722-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123221115.19722-1-mgorman@techsingularity.net>
References: <20250123221115.19722-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1737670319143325168.9138.7788354316419647953@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=6792beaf
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8 a=R_Myd5XaAAAA:8
	a=4yXJT0XmbIIbJQ27IpEA:9 a=L2g4Dz8VuBQ37YGmWQah:22
X-Virus-Scanned: ClamAV using ClamSMTP

HARDENED_USERCOPY is checked within a function so even if disabled, the
function overhead still exists. Move the static check inline.

This is at best a micro-optimisation and any difference in performance
was within noise but it is relatively consistent with the init_on_*
implementations.

Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/thread_info.h |  8 +++++++-
 mm/usercopy.c               | 13 +++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index cf2446c9c30d..09fc241a45f7 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -221,11 +221,17 @@ static inline int arch_within_stack_frames(const void * const stack,
 extern void __check_object_size(const void *ptr, unsigned long n,
 					bool to_user);
 
+DECLARE_STATIC_KEY_MAYBE(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
+			   validate_usercopy_range);
+
 static __always_inline void check_object_size(const void *ptr, unsigned long n,
 					      bool to_user)
 {
-	if (!__builtin_constant_p(n))
+	if (!__builtin_constant_p(n) &&
+	    static_branch_maybe(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
+				&validate_usercopy_range)) {
 		__check_object_size(ptr, n, to_user);
+	}
 }
 #else
 static inline void check_object_size(const void *ptr, unsigned long n,
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 4cf33305347a..a1193bdabb16 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -201,7 +201,9 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	}
 }
 
-static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
+DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
+			   validate_usercopy_range);
+EXPORT_SYMBOL(validate_usercopy_range);
 
 /*
  * Validates that the given object is:
@@ -212,9 +214,6 @@ static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
  */
 void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 {
-	if (static_branch_unlikely(&bypass_usercopy_checks))
-		return;
-
 	/* Skip all tests if size is zero. */
 	if (!n)
 		return;
@@ -270,8 +269,10 @@ __setup("hardened_usercopy=", parse_hardened_usercopy);
 
 static int __init set_hardened_usercopy(void)
 {
-	if (enable_checks == false)
-		static_branch_enable(&bypass_usercopy_checks);
+	if (enable_checks)
+		static_branch_enable(&validate_usercopy_range);
+	else
+		static_branch_disable(&validate_usercopy_range);
 	return 1;
 }
 
-- 
2.43.0

