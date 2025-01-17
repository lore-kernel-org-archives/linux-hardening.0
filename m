Received: from mail15.out.titan.email (mail15.out.titan.email [3.64.226.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A371FCFDA
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119063; cv=none; b=YnQGimTpDRKsiiqR2ZvUrETYC9soJM0U5C4Zn8Rk1Ps7LSLSf763Z+LV4tWHHX/PYLLneEmSugEBXKVHlejsGvDMqWEiecqm76K+eYx+mn4T8xRscxKJRLiTP+ZKjMQ/zGWv5/XYSilrgPh/lwBshMR43/XCiOs3JEkKh7AUXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119063; c=relaxed/simple;
	bh=JWxVpo51IRHFVSNtBf3Wmjv1JWsZY7WzUS0vwKR00ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxszLIjGqudXQL/NGbp99VBC7NjR36uofF3KRxS7qIsFGEuVFpshEMgd6NCokB1pi755cIY60Q/FgrzgrIqE8R16A0jZmYlaF9m+wU34UY3JPKIR8tN631e16r9b8QBXn2kmbSfBGBHtj7iFpYlH26DWj8hx+4blHSpxLiL37pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=Wo9ErUa6; arc=none smtp.client-ip=3.64.226.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="Wo9ErUa6"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 74593A0049;
	Fri, 17 Jan 2025 13:04:20 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=VRt5ySVbtyE/C8GSIvo3UXJKgyg0wAqCy+j1mZK4ExM=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=cc:date:message-id:from:to:subject:mime-version:in-reply-to:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737119060; v=1;
	b=Wo9ErUa68zJl79s6WtL753o+Ok/useI3YjFfh7DVAe+b3sIgiEPzjFuqJbDrM1XVRWHn88JJ
	8cbZcFGH8ia0oM3HRXFyzCkkRYCQ9uE8SmWyx2duydD9EIqcOHZP0NNuoTY38t74Dg+uTyu0GoH
	gRiyea3d3wNUarjH5OoqqIgg=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 0ECE3A00A9;
	Fri, 17 Jan 2025 13:04:20 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/3] fortify: Move FORTIFY_SOURCE under 'Kernel hardening options'
Date: Fri, 17 Jan 2025 13:03:37 +0000
Message-ID: <20250117130337.4716-4-mgorman@techsingularity.net>
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
X-Titan-Src-Out: 1737119060349003360.9138.2734723736871645562@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=678a5554
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=CEWIc4RMnpUA:10 a=NEAV23lmAAAA:8 a=R_Myd5XaAAAA:8
	a=Q9Z_rya5RYYz_BbIbTgA:9 a=L2g4Dz8VuBQ37YGmWQah:22
X-Virus-Scanned: ClamAV using ClamSMTP

FORTIFY_SOURCE is a hardening option both at build and runtime. Move
it under 'Kernel hardening options'.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 security/Kconfig           | 9 ---------
 security/Kconfig.hardening | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index fe7346dc4bc3..bca84f839fbe 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -159,15 +159,6 @@ config LSM_MMAP_MIN_ADDR
 	  this low address space will need the permission specific to the
 	  systems running LSM.
 
-config FORTIFY_SOURCE
-	bool "Harden common str/mem functions against buffer overflows"
-	depends on ARCH_HAS_FORTIFY_SOURCE
-	# https://github.com/llvm/llvm-project/issues/53645
-	depends on !CC_IS_CLANG || !X86_32
-	help
-	  Detect overflows of buffers in common string and memory functions
-	  where the compiler can determine and validate the buffer sizes.
-
 config STATIC_USERMODEHELPER
 	bool "Force all usermode helper calls through a single binary"
 	help
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 537a6431892e..8d005fe154ef 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -301,6 +301,15 @@ config HARDENED_USERCOPY_DEFAULT_ON
 	  This has the effect of setting "hardened_usercopy=on" on the kernel
 	  command line. This can be disabled with "hardened_usercopy=off".
 
+config FORTIFY_SOURCE
+	bool "Harden common str/mem functions against buffer overflows"
+	depends on ARCH_HAS_FORTIFY_SOURCE
+	# https://github.com/llvm/llvm-project/issues/53645
+	depends on !CC_IS_CLANG || !X86_32
+	help
+	  Detect overflows of buffers in common string and memory functions
+	  where the compiler can determine and validate the buffer sizes.
+
 endmenu
 
 menu "Hardening of kernel data structures"
-- 
2.43.0

