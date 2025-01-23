Received: from mail17.out.titan.email (mail17.out.titan.email [3.64.226.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8691CD1FD
	for <linux-hardening@vger.kernel.org>; Thu, 23 Jan 2025 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670318; cv=none; b=r94oSmMUPFf5PpKW0AJkdel8YM5ND68eG4ZertpP9hPtajMEzcGk9dNJq9hSVwQdLeQcgXRr6NzKR52xp58gNonVrENXMkwX75JeotbktbPwdaNaU0mKdv3fvRRp18IMGLh6RadpchwwW00Gd75w3d209JKLpBPsmCaRQtcWFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670318; c=relaxed/simple;
	bh=7F+5jvc+5P/sz5xc4yVqe1Jr3GI4/itvnxM8dwxDcPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz4ljIAr9PUh16KLPX3Xxr0UWUCxVKThMFRCdij0IJk9VfB+tiOOC8mMnL1RoPqz2GptTFLiFcQmKcGRJvFLbVfxeI5e2jOmOY6D8sAP2PFquHS+ZC8PEqjpwz1vxMOzuYXsSYR6KuikfNVuahciGOAgeNaVTGFbI0gmxy35HhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=CRUij8AZ; arc=none smtp.client-ip=3.64.226.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="CRUij8AZ"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id B641DA0015;
	Thu, 23 Jan 2025 22:11:48 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=LDgPNBesSofxnnV2IL91tTTGVUzCXnETfSmwHDCUeSU=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=in-reply-to:references:to:subject:message-id:from:cc:date:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737670308; v=1;
	b=CRUij8AZFPt0Exj3zpOfp3z8RqOCTxBGGzAHQlm722e38XuRDcnIEhEO8yoCho8zwEUQ6BmY
	mZFdCVp6Axzrsya4tUZFsaRw3nJqqwUzGcLx4ATZvAa52xgUwyr4E/PLxiV4soIAR/ieAwJVx6D
	Q6eUtXl7g/YuKhLdAyxH0N34=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 3FAE2A0010;
	Thu, 23 Jan 2025 22:11:48 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/4] mm: security: Allow default HARDENED_USERCOPY to be set at compile time
Date: Thu, 23 Jan 2025 22:11:13 +0000
Message-ID: <20250123221115.19722-3-mgorman@techsingularity.net>
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
X-Titan-Src-Out: 1737670308635311287.9138.9018554698350676250@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=6792bea4
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
index 9088d613d519..3a941cc45396 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -293,6 +293,14 @@ config HARDENED_USERCOPY
 	  or are part of the kernel text. This prevents entire classes
 	  of heap overflow exploits and similar kernel memory exposures.
 
+config HARDENED_USERCOPY_DEFAULT_ON
+	bool "Harden memory copies by default"
+	depends on HARDENED_USERCOPY
+	default HARDENED_USERCOPY
+	help
+	  This has the effect of setting "hardened_usercopy=on" on the kernel
+	  command line. This can be disabled with "hardened_usercopy=off".
+
 endmenu
 
 menu "Hardening of kernel data structures"
-- 
2.43.0

