Received: from mail13.out.titan.email (mail13.out.titan.email [18.198.78.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABD921505C;
	Wed, 22 Jan 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.78.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566422; cv=none; b=GYmhhLcshkAXIkxWLlv5P150PNm83ZEpSMrosdWE6bPl3hxdXqoopVxkGsmtC+T8yoPPquR7wf4pKnqwboSEnmF6H2cN/p6cwnHSH3DB+IxQZslAwAnttObE+wD9BC2YhpliCor1dWIpXsoakIfJ5G1c0B7hWF2xQaSE3MdD8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566422; c=relaxed/simple;
	bh=KrjSVaIoP+BpwwMwb3WYVndUBetVLdni2EXBCUvc5sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJsdO9cwsVr6Cb9Q/tHOK5Nab1yB0w1OjgY/eAEaqqNY+HCer1/LfrSBAbkvAK8gJ05ra0g27nj3+NszNB40AOZj0C/sd86p0TxdJoWavib5D0xW2duWWYqGSDq2z2rboeNKA9dIzmiY533E/lLOE+rhYsfW6qXY0AABMBrU8yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=I1QCkv0E; arc=none smtp.client-ip=18.198.78.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="I1QCkv0E"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id B63F1A004C;
	Wed, 22 Jan 2025 17:20:19 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=BaW9mABtKsoIJb+CbhxfD7184LG2W72FFvHkaZBiFVw=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=in-reply-to:references:cc:date:mime-version:from:to:subject:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737566419; v=1;
	b=I1QCkv0Eg/MH2uGO1edQyJOOZM80Tehnol1UXOq6NcQv9m3kwdKrTIB+TA/Og00F/0Li4SH3
	7gxjKe3CwqiDmakweBlwVQ/EmXh1eNwpJcNbExbK9slad3OB2q/D/VKahpwyfsIKS0drRcn+MCK
	fJBlSSWA8C1/zq9zJUwb0Jao=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 47F13A00D9;
	Wed, 22 Jan 2025 17:20:19 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/4] fortify: Move FORTIFY_SOURCE under 'Kernel hardening options'
Date: Wed, 22 Jan 2025 17:19:25 +0000
Message-ID: <20250122171925.25472-5-mgorman@techsingularity.net>
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
X-Titan-Src-Out: 1737566419624532139.9138.5752076647353518555@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=679128d3
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
index adcc260839c7..e22dc1801bee 100644
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

