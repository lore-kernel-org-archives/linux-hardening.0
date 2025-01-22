Received: from mail18.out.titan.email (mail18.out.titan.email [3.64.226.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F42153C6
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jan 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566412; cv=none; b=DcC/186H4zVbIgD3LLkCdNb7hcHwSWogvhX4hqwv8yM7D38Yl3ZCImbq/bLId8Sac08WHnmt3pArmcfL4/ScFKWhptWJvIHmiiPs3DC1kwDDw3rmx5fY2SlREg2csh4GP8O4449ijVIhLiKDBNuefy7W7iUmOSSqGI4fdrlB7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566412; c=relaxed/simple;
	bh=6su9UrgLxfeY+Y7fVw1qRBBhgcWMQoVDEU8h6Q2G298=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fs4o+Vc9W4YRKO9OPfpa4qiZ2WUnkUUrYv3v/eIPRtDWOsmTXi9duGAetVrsTqLmJx2adq3X3bUG4k4EgriPb+ZDYhFPG+4zRn9L+dkbnHNT14Z0WNEbE7Qqln8mQ4+1/JDm4DcJhchNABBHQgBYj410obeXyngtjhhv8e/rUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=Ey8CgysZ; arc=none smtp.client-ip=3.64.226.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="Ey8CgysZ"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 374A1A00D9;
	Wed, 22 Jan 2025 17:20:09 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=Y09jPq5GH+jLn+U5pAD6Zl5SbOMjMXu/OVlJSNYhum8=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=subject:from:date:message-id:in-reply-to:references:mime-version:cc:to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737566409; v=1;
	b=Ey8CgysZ9TAeWFDrjBCTOlZ7Wb1Knd7+3IimYe6w3M29wDeI+Io3YkM84i2YHyvXdCdd3NsL
	McJgYyTjl1Uccy6Wz6BRxz3e3hj/h+h62Z+qUDxn63VFdxAA/nDoe/ypDY/CSRqFwzBZtkCAmw0
	sWj0RjA7TMhhY1YJhtBRfhA8=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id B188FA0008;
	Wed, 22 Jan 2025 17:20:08 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/4] mm: security: Check early if HARDENED_USERCOPY is enabled
Date: Wed, 22 Jan 2025 17:19:24 +0000
Message-ID: <20250122171925.25472-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122171925.25472-1-mgorman@techsingularity.net>
References: <20250122171925.25472-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1737566409105785618.9138.6377992846655049101@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=679128c9
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
 include/linux/thread_info.h |  8 ++++++++
 mm/usercopy.c               | 11 ++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index cf2446c9c30d..832f6a97e64c 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -221,9 +221,17 @@ static inline int arch_within_stack_frames(const void * const stack,
 extern void __check_object_size(const void *ptr, unsigned long n,
 					bool to_user);
 
+DECLARE_STATIC_KEY_MAYBE(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
+			   validate_usercopy_range);
+
 static __always_inline void check_object_size(const void *ptr, unsigned long n,
 					      bool to_user)
 {
+	if (static_branch_maybe(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
+				&validate_usercopy_range)) {
+		return;
+	}
+
 	if (!__builtin_constant_p(n))
 		__check_object_size(ptr, n, to_user);
 }
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 4cf33305347a..2e86413ed244 100644
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
@@ -271,7 +270,9 @@ __setup("hardened_usercopy=", parse_hardened_usercopy);
 static int __init set_hardened_usercopy(void)
 {
 	if (enable_checks == false)
-		static_branch_enable(&bypass_usercopy_checks);
+		static_branch_enable(&validate_usercopy_range);
+	else
+		static_branch_disable(&validate_usercopy_range);
 	return 1;
 }
 
-- 
2.43.0

