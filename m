Received: from mail19.out.titan.email (mail19.out.titan.email [3.64.226.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEB1CBE95
	for <linux-hardening@vger.kernel.org>; Thu, 23 Jan 2025 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670308; cv=none; b=GTEXK41JKkCcEJGgF1NsXQEcyevj47srnfNT8Ye0hmesRd1wJAlQKakm7vwhpK2QuFDJKDRWj913NTaMsytDViQucxiE6nE2F2mf7OSRbSResBy5ZzhQFa8RZYhpyDa9iirtetBuU/tGDfWLjAzQOZbAla/XVbTGTDlrJGnpkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670308; c=relaxed/simple;
	bh=AB+mmaXt7qGEW2WBJZAyCRpDhmRf7S/C4nkaGQVaxq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGguPX1IK2H+yaCAOw9r/psGPB5EbIYex3vjtGx/bqXDkUsk7zxdBdFHoHqSrtOwRCNBhPFdYAM3xpEUTWJcm9LtblX0EZiXEv9KasIsG+J4k3sUMn/AEhXnP1HJvceL908tQhnSwt4T2UqQpE0YbFAEO8qhQaLKlFwyqQW9ZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=aq/s7EYj; arc=none smtp.client-ip=3.64.226.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="aq/s7EYj"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 2D8A7A003D;
	Thu, 23 Jan 2025 22:11:38 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=VWeq9rkukUyqf9ybH2ttB19u6OPJ/p54PCmlZ5v3Sl4=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=from:references:to:message-id:cc:subject:date:in-reply-to:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737670298; v=1;
	b=aq/s7EYjyVGhjPTYAQhId0qrGoKCDOZciZuVD+HniiGOeudil6YrzrwYAuMASZU8EIEBlrzP
	aktjqsOnhXD5RVHNhENa+eW/XfgZ2La509sPuZ6/Tx7mEU1bNvrSCci0IJe4XltVjiHyNue2x0z
	NDJJ1tEEAyg8KraHqGP2hlvk=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 9AEE2A0015;
	Thu, 23 Jan 2025 22:11:37 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/4] mm: security: Move hardened usercopy under 'Kernel hardening options'
Date: Thu, 23 Jan 2025 22:11:12 +0000
Message-ID: <20250123221115.19722-2-mgorman@techsingularity.net>
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
X-Titan-Src-Out: 1737670298075006878.9138.5320540698317593988@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=6792be9a
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8 a=xVhDTqbCAAAA:8
	a=KkbEisfxgXDdCi-76G0A:9 a=L2g4Dz8VuBQ37YGmWQah:22
	a=GrmWmAYt4dzCMttCBZOh:22
X-Virus-Scanned: ClamAV using ClamSMTP

There is a submenu for 'Kernel hardening options' under "Security".
Move HARDENED_USERCOPY under the hardening options as it is clearly
related.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 security/Kconfig           | 12 ------------
 security/Kconfig.hardening | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 28e685f53bd1..fe7346dc4bc3 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -159,18 +159,6 @@ config LSM_MMAP_MIN_ADDR
 	  this low address space will need the permission specific to the
 	  systems running LSM.
 
-config HARDENED_USERCOPY
-	bool "Harden memory copies between kernel and userspace"
-	imply STRICT_DEVMEM
-	help
-	  This option checks for obviously wrong memory regions when
-	  copying memory to/from the kernel (via copy_to_user() and
-	  copy_from_user() functions) by rejecting memory ranges that
-	  are larger than the specified heap object, span multiple
-	  separately allocated pages, are not on the process stack,
-	  or are part of the kernel text. This prevents entire classes
-	  of heap overflow exploits and similar kernel memory exposures.
-
 config FORTIFY_SOURCE
 	bool "Harden common str/mem functions against buffer overflows"
 	depends on ARCH_HAS_FORTIFY_SOURCE
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index c9d5ca3d8d08..9088d613d519 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -279,6 +279,22 @@ config ZERO_CALL_USED_REGS
 
 endmenu
 
+menu "Bounds checking"
+
+config HARDENED_USERCOPY
+	bool "Harden memory copies between kernel and userspace"
+	imply STRICT_DEVMEM
+	help
+	  This option checks for obviously wrong memory regions when
+	  copying memory to/from the kernel (via copy_to_user() and
+	  copy_from_user() functions) by rejecting memory ranges that
+	  are larger than the specified heap object, span multiple
+	  separately allocated pages, are not on the process stack,
+	  or are part of the kernel text. This prevents entire classes
+	  of heap overflow exploits and similar kernel memory exposures.
+
+endmenu
+
 menu "Hardening of kernel data structures"
 
 config LIST_HARDENED
-- 
2.43.0

