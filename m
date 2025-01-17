Received: from mail18.out.titan.email (mail18.out.titan.email [3.64.226.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD341FF7B7
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119366; cv=none; b=o5A3YZQIgCDIi0DQei54crrleoLLBvRg0iDZE0ykVYtc+ESGwgPoijcipFf723cfct01TW92jCyyMeaDSl/xTx71ONrXTH3lIqIl2nvbx8ZeCo7JYIbtHPaQluFW5AX3Zc0bhY57vewfOShezappQdyhPWsvYMYvTM+3o7AC5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119366; c=relaxed/simple;
	bh=S8aAvA4WXylpoHYDraXmDyFyKQB1xkjAujdcxdVXe5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0lL+2ILEFPTgFii4hWXVSsZJOFVPUWSD30l0uirsBm4jbjBntXp0Y4VXJAWzHCE1aV8m6UzM3wNMiRaJHFIKkAAvMvSEWBaCDeMhoeCesU5cQNpYKEyYZ9C53fMM90sv/rgf5HZ0EfGtuJhwfbwRR7VLyyWaAbyr5wJOF80ORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=gJ4NSDNA; arc=none smtp.client-ip=3.64.226.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="gJ4NSDNA"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 05F57A003F;
	Fri, 17 Jan 2025 13:04:10 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=zkWsMh2rOl4BCLRjhpJXqDH/Wyon9reMiWbC/Z8CYjo=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=subject:date:message-id:in-reply-to:mime-version:to:from:cc:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737119049; v=1;
	b=gJ4NSDNA8Zj9CqrlCbMMh+GrCxMXoHfjo9Sn6aHshF6F6tS0qJdApsHUAfA1jQCwVgw3GWOm
	Drb6lGWzQE70Z+vig5dzVpxEMV/QMWjBU4GT4egKG0ezptlGy1bTQ6x0eKHZxaqk0j4LhzfjnzC
	aqrFBkpBWiLoI2ITlKpsE1bs=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 8A489A0049;
	Fri, 17 Jan 2025 13:04:09 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/3] mm: security: Allow default HARDENED_USERCOPY to be set at compile time
Date: Fri, 17 Jan 2025 13:03:36 +0000
Message-ID: <20250117130337.4716-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117130337.4716-1-mgorman@techsingularity.net>
References: <20250117130337.4716-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1737119049859662939.9138.8876070193937651565@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=678a5549
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8 a=0z80O7jHjOjBg2F2ajAA:9
	a=L2g4Dz8VuBQ37YGmWQah:22
X-Virus-Scanned: ClamAV using ClamSMTP

HARDENED_USERCOPY defaults to on if enabled at compile time. Allow
hardened_usercopy= default to be set at compile time similar to
init_on_alloc= and init_on_free=. The intent is that hardening
options that can be disabled at runtime can set their default at
build time.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 mm/usercopy.c                                   | 3 ++-
 security/Kconfig.hardening                      | 8 ++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3872bc6ec49d..5d759b20540a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1773,7 +1773,9 @@
 			allocation boundaries as a proactive defense
 			against bounds-checking flaws in the kernel's
 			copy_to_user()/copy_from_user() interface.
-		on	Perform hardened usercopy checks (default).
+			The default is determined by
+			CONFIG_HARDENED_USERCOPY_DEFAULT_ON.
+		on	Perform hardened usercopy checks.
 		off	Disable hardened usercopy checks.
 
 	hardlockup_all_cpu_backtrace=
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 83c164aba6e0..4cf33305347a 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -255,7 +255,8 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 }
 EXPORT_SYMBOL(__check_object_size);
 
-static bool enable_checks __initdata = true;
+static bool enable_checks __initdata =
+		IS_ENABLED(CONFIG_HARDENED_USERCOPY_DEFAULT_ON);
 
 static int __init parse_hardened_usercopy(char *str)
 {
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 00e6e2ed0c43..537a6431892e 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -293,6 +293,14 @@ config HARDENED_USERCOPY
 	  or are part of the kernel text. This prevents entire classes
 	  of heap overflow exploits and similar kernel memory exposures.
 
+config HARDENED_USERCOPY_DEFAULT_ON
+	bool "Harden memory copies by default"
+	depends on HARDENED_USERCOPY
+	default n
+	help
+	  This has the effect of setting "hardened_usercopy=on" on the kernel
+	  command line. This can be disabled with "hardened_usercopy=off".
+
 endmenu
 
 menu "Hardening of kernel data structures"
-- 
2.43.0

