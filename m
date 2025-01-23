Received: from mail18.out.titan.email (mail18.out.titan.email [3.64.226.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416851CDA0B
	for <linux-hardening@vger.kernel.org>; Thu, 23 Jan 2025 22:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670340; cv=none; b=c35OfAxasS7Af0cuzCYS8/x4kKZZ5IBxmOyKHNy1vO653FfSe5w17J0VKahTHV3G9vAj42HLeNrBKZjORlrVULXwu0Q8BK641PYk1E3ogTYOQgQRZuPth8QlWuTwCGxzA8nX0BLp3tgnjeYq/dAjtbWXsWG148imnEjRLKIlgWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670340; c=relaxed/simple;
	bh=FXnGYN1HLA7oKl4oNnF5ibO9kW/y1hP4Ubr7zJXHLCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usFHl33xeOImRauObX96q7C5EZNTZ2U+VKMCIBNxN6A3CPcCBRn6ibfnAYTXcZGOmYQDiA7u+klQdalwYdZ4nlTr86ELlYiWmzdOWrA4XCTpSSkZ+52guM2AzlLTY6u8l0dIse9GEzji3qZ08ZH2QVqTcFXc4pwy1nmGJKJ2nvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=DG8o9ysz; arc=none smtp.client-ip=3.64.226.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="DG8o9ysz"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id BD949A0015;
	Thu, 23 Jan 2025 22:12:09 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=/ztBC38zol6aAkdXqs+b9CijeIaCMsYQyn8IPOdL8aY=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=to:cc:message-id:in-reply-to:mime-version:from:date:references:subject:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737670329; v=1;
	b=DG8o9yszbOff1vdwbaD31yZT3dsXx5iPurhZd0IhzZLVVFs1ZzvYkaUbjyCn2UahZCdc4pKT
	V1jrguBwYzSUvYvm+UVOl/9dkVqbdk3+dKnLE9cJ409oY3G8YDiLrTEqTH2RT70WWE8+iuT+NTy
	CLVzQpG6+ZuRySB4KTJJREik=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4D2D0A0010;
	Thu, 23 Jan 2025 22:12:09 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/4] fortify: Move FORTIFY_SOURCE under 'Kernel hardening options'
Date: Thu, 23 Jan 2025 22:11:15 +0000
Message-ID: <20250123221115.19722-5-mgorman@techsingularity.net>
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
X-Titan-Src-Out: 1737670329649399389.9138.4356779843527689844@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=6792beb9
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=CEWIc4RMnpUA:10 a=NEAV23lmAAAA:8 a=R_Myd5XaAAAA:8 a=xVhDTqbCAAAA:8
	a=is8aNrDapYGysjnIDgAA:9 a=L2g4Dz8VuBQ37YGmWQah:22
	a=GrmWmAYt4dzCMttCBZOh:22
X-Virus-Scanned: ClamAV using ClamSMTP

FORTIFY_SOURCE is a hardening option both at build and runtime. Move
it under 'Kernel hardening options'.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Paul Moore <paul@paul-moore.com>
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
index 3a941cc45396..1ce9009c3cc6 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -281,6 +281,15 @@ endmenu
 
 menu "Bounds checking"
 
+config FORTIFY_SOURCE
+	bool "Harden common str/mem functions against buffer overflows"
+	depends on ARCH_HAS_FORTIFY_SOURCE
+	# https://github.com/llvm/llvm-project/issues/53645
+	depends on !CC_IS_CLANG || !X86_32
+	help
+	  Detect overflows of buffers in common string and memory functions
+	  where the compiler can determine and validate the buffer sizes.
+
 config HARDENED_USERCOPY
 	bool "Harden memory copies between kernel and userspace"
 	imply STRICT_DEVMEM
-- 
2.43.0

