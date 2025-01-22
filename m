Received: from mail13.out.titan.email (mail13.out.titan.email [18.198.78.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40DF21505F;
	Wed, 22 Jan 2025 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.78.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566408; cv=none; b=e66ls4YZ1fttG6UR/6iCZ0wX9OVaSB4Fe0E22ywogTGZ2A9WwN5KgUNEmRRKmh4ylj42ncHfRodTyYaeHkqCotBDlRAoSD8gVXZtAu9WHNj/xPseWledzUXORyV3N5lPiJ6A7M5LuhvuyczNjMcmH9Rqu7sXMvhjAPISBK21/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566408; c=relaxed/simple;
	bh=SuG5hvAQgjxhXm9LGjN9dYWNlAAqBwyJpF59KcRtkR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLHhrSYdzweam+Kgqe4Ix0NhfIC4ykOfbTPU9aKHICkIE6eicDhvhTLu7IrW88e28uIdqtWMK6RA0jEuT2LKG9m5FRG/JaEoheVP+ddZn8vENT+V+suxolAaHxfGlDVwo7fMThB4gLgUkSvg5Rlp8JHjGfU9cWw6pjfBKKKoNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=Bpnsrt+X; arc=none smtp.client-ip=18.198.78.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="Bpnsrt+X"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id A0C49A015A;
	Wed, 22 Jan 2025 17:19:58 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=Z2jYOWM8hUV6J3bzYS5e2M9sLIUUWbq7B6uKhS/GsCs=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=mime-version:from:to:cc:message-id:in-reply-to:subject:date:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737566398; v=1;
	b=Bpnsrt+XYCpXjb4LOgVfgwsOpx/9Q7ZydDgH4UuJRheEiW3AHJAIB4mclRxQbwCFWzYu9/E9
	LDApje3CjvtfkI2u0OXsR03GQyfT1EVJNCYQ1GFK0DiRF2s/Hz3JEDWgvcr5C6+2ZVFSxfFc4VE
	NgWkQ5xP5Bw789VU4DxEV+40=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 33020A0008;
	Wed, 22 Jan 2025 17:19:58 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/4] mm: security: Allow default HARDENED_USERCOPY to be set at compile time
Date: Wed, 22 Jan 2025 17:19:23 +0000
Message-ID: <20250122171925.25472-3-mgorman@techsingularity.net>
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
X-Titan-Src-Out: 1737566398543734204.9138.2594461423631213783@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=679128be
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
index 9088d613d519..adcc260839c7 100644
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

