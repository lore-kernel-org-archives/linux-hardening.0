Received: from mail12.out.titan.email (mail12.out.titan.email [18.198.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA951FFC4A
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121167; cv=none; b=il9taXxQmY89q5DXiPZ7MpqD/sTDFcLYVvEol5o7w8fmhM8YBJ4UskCxd9fqRR8EOzloPwc3g+DUpCYwMt1HS9NPhYK0lXr9oddwpYGya6rfG+EhPpZGgnSiIq3iKjIaJUBBKgVpyaBAzIKdxbVOeRd2ICvw1nXZ3SrFD/pGkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121167; c=relaxed/simple;
	bh=GoL8elr1g+v9QVwcLmr7gtwKfIKEgObjpBU6EDehYeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YM41NmSzZpcuLYPom6xm3f1OEBWg6u3IZ7HCCVDhY7RPJy33sPLOVzd4Zp6q8aELpSg0g8xXi6BHrzbErhi9iKOjs3EigHQwuZfWk2hT9xkpRVrUjc0ApY8vKF4kz4Hy/yeVTGwZcXCZK4elegAslUSOwoHUnQUL5uRG9U/PQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=Y6vlzjVM; arc=none smtp.client-ip=18.198.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="Y6vlzjVM"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 80932A009B;
	Fri, 17 Jan 2025 13:03:59 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=2rFrjKhCOLgXm9a/3DoxLHhn5CHHMWAoj6SakG580bw=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=to:cc:subject:from:message-id:date:in-reply-to:references:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737119039; v=1;
	b=Y6vlzjVMCJ3cZmPLJA88USrvWVVrM7jdpCl11/6uLbjj9qSHS6WUji2cl4FNKOyyMwZNzoEi
	zZf5HTTHVkHFGw6tg48WzdRCv0+S5dWi8U+Dj+llcrQqWc/jPg6PkMPu1BbliPUhs64+aq6J/RC
	NhaVEcqa5Lybqn7J1UlwZ748=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 20583A0049;
	Fri, 17 Jan 2025 13:03:59 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/3] mm: security: Move hardened usercopy under 'Kernel hardening options'
Date: Fri, 17 Jan 2025 13:03:35 +0000
Message-ID: <20250117130337.4716-2-mgorman@techsingularity.net>
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
X-Titan-Src-Out: 1737119039409530807.9138.3900322166364608842@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=678a553f
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8 a=KkbEisfxgXDdCi-76G0A:9
	a=L2g4Dz8VuBQ37YGmWQah:22
X-Virus-Scanned: ClamAV using ClamSMTP

There is a submenu for 'Kernel hardening options' under "Security".
Move HARDENED_USERCOPY under the hardening options as it is clearly
related.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
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
index c9d5ca3d8d08..00e6e2ed0c43 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -279,6 +279,22 @@ config ZERO_CALL_USED_REGS
 
 endmenu
 
+menu "String manipulation"
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

