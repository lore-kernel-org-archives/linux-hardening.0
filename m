Received: from mail13.out.titan.email (mail13.out.titan.email [18.198.78.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F487215173
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jan 2025 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.78.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566965; cv=none; b=G92tsdEEd5h62I8SMONJiO9mJMmnVk0+nr1F0SgKKlPdpSK/Xi5EHIxQwS+axPGft2EVDlIxGa/XDSJ0hMoShiQpum9bPFtTZkyh4aEFG1pglDbSgyX7rs0e2lPWMOpbADSMgA6K+lXjvKgZtZgvugBDu0Di6inykwll3Jr9pbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566965; c=relaxed/simple;
	bh=AB+mmaXt7qGEW2WBJZAyCRpDhmRf7S/C4nkaGQVaxq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JitK53l2zJFw0LVSGnG0U3ZosWxp0+v3HCbqhwRbIiaopIWv06Xl3AWK+M7t3w+OZJz8OLNojSHPRRJ3yE9G/weY6/KGQHovKJ0vo3qAaSKbAfNPsHvSiLflbGbws4LqhmYFroBpsKCEUYceq4Zl1OXzR0hS7vEOkUJ9TsylQBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=XLhOb0vr; arc=none smtp.client-ip=18.198.78.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="XLhOb0vr"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 24322A0150;
	Wed, 22 Jan 2025 17:19:48 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=VWeq9rkukUyqf9ybH2ttB19u6OPJ/p54PCmlZ5v3Sl4=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=from:to:cc:date:references:mime-version:subject:message-id:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737566388; v=1;
	b=XLhOb0vrs4TMeU2TNsPr5AZQeARDCWVE2GbqaujkS+juHenwZyNyQvYHyz2KIkg6m0pac2w2
	vXGeKGmzbeVK0qZFX88ZBaSu18fiKoQTPDzP0XSh3IisDQJ95wUJZHOVS/pr3qYH78eQA7l/0Hl
	cz6SWIsAdvDs9mwZHnUlt2uA=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 8DB7BA0004;
	Wed, 22 Jan 2025 17:19:47 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/4] mm: security: Move hardened usercopy under 'Kernel hardening options'
Date: Wed, 22 Jan 2025 17:19:22 +0000
Message-ID: <20250122171925.25472-2-mgorman@techsingularity.net>
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
X-Titan-Src-Out: 1737566388028479881.9138.5572320255195962264@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=679128b4
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

