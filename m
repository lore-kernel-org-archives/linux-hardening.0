Received: from mail19.out.titan.email (mail19.out.titan.email [3.64.226.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634791FF7C1
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119365; cv=none; b=tiM2p1MGIm7ZnGtPX+FnYAi8LDSoMLSg5AdIMGQ/n0KVGp2PVqT2w0mciWdnbvt/z8rM0Vv6gaC+xq3xrMvptCTPKyNnELZ5Oh2q/cDEfgJLbxY4IrY845CNf8rCk2HQAmHVNBFVmJWinUPmEREzln7Ddv9VsQy1c3SwNpAxnGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119365; c=relaxed/simple;
	bh=jEFAarDvKCkjLojOxE3J7BK+iGdPplGgn0ngGGJWdYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SyFHQBd4z5K/wI94r2ezXTCGjG6zi5QpEKPOwX2uWF5dD2dFEXyeSd6W4SyVDUnnh/ytN3+qW/PtJxWBXqe18uDc2ltApNZFN41nz8riSPwAJnHaHja6vcYjW/3KEGG3KKTyadlkRFDzB8+YYf2/x34MZKbzXXhhuJ/lhypoKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=SKSI/tYf; arc=none smtp.client-ip=3.64.226.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="SKSI/tYf"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 1AF3CA0009;
	Fri, 17 Jan 2025 13:03:49 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=wlPmWQ2sjZYr37/1H4jghTQZ3cuZZMKzFpXts3wxhBc=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=cc:mime-version:to:message-id:from:date:subject:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1737119029; v=1;
	b=SKSI/tYf+z7LqjbD77TvUIk1jngosiLc4t+DQxmwp8z5ydRL/20r/4GcFjcmrmimQkqL3puh
	gn1BjO8wY5qdr04ZzC39HL/vs2vGoP0L8dvBqt75qmDHRuRHCG8lYNsO73lvqgJ9BOiTIzqnLzh
	6yLi2JS8yGb+MP5hwFpiPymA=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id B10B5A003F;
	Fri, 17 Jan 2025 13:03:48 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/3] Allow default HARDENED_USERCOPY to be set at compile time
Date: Fri, 17 Jan 2025 13:03:34 +0000
Message-ID: <20250117130337.4716-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1737119028987406877.9138.6577504690906862126@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=678a5535
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=CEWIc4RMnpUA:10 a=F_ROk3OM8dyGBT-qa-4A:9
X-Virus-Scanned: ClamAV using ClamSMTP

Some hardening options like HARDENED_USERCOPY can be set at boot time
and have negligible cost when disabled. The default for options like
init_on_alloc= can be set at compile time but hardened usercopy is
enabled by default if built in. This incurs overhead when a kernel
wishes to provide optional hardening but the user does not necessarily
care.

Hardening is desirable in some environments but ideally they would be opt-in
by kernel command line as hardening is typically a deliberate decision
whereas the performance overhead is not always obvious to all users.
Patches 1 and 2 move HARDENED_USERCOPY to the Kconfig.hardening and
default it to disabled. Patch 3 moves FORTIFY_SOURCE to hardening only
because the option is related to hardening and happened to be declared
near HARDENED_USERCOPY.

Building HARDENED_USERCOPY but disabled at runtime has neligible effect
within the noise. Enabling the option by default generally incurs 2-10%
of overhead depending on the workload with some extreme outliers depending
on the exact CPU. While the benchmarks are somewhat synthetic, the overhead
IO-intensive and network-intensive is easily detectable but the root cause
may not be obvious (e.g. 2-14% overhead for netperf TCP_STREAM running
over localhost with different ranges depending on the CPU).


 .../admin-guide/kernel-parameters.txt         |  4 ++-
 mm/usercopy.c                                 |  3 +-
 security/Kconfig                              | 21 ------------
 security/Kconfig.hardening                    | 33 +++++++++++++++++++
 4 files changed, 38 insertions(+), 23 deletions(-)

-- 
2.43.0

