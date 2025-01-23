Received: from mail30.out.titan.email (mail30.out.titan.email [3.65.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EDA47A7E
	for <linux-hardening@vger.kernel.org>; Thu, 23 Jan 2025 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670300; cv=none; b=SDRJ9jHCfgTTc6bwlmRHu0BqbkRqrla0YeJzHlS/VNogSCHJJx4XYmMDVaLvgAH7fB1OqM018pzr7XKw0OhZobNAlwzf5M76/1l1Z+9QwfxhTAHHhj4+A8hkOF76R9xmKhxnoV9f2YlPbEoF2XWSZV/EiPc3Rx+wh8lZ7jKqaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670300; c=relaxed/simple;
	bh=ExUuP9fYdXI3iADLf1l3H3QitqRd1Cx2xy/LaPLvlt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jf2ovvLl3uetMncJQe4S1p8j8gpPIs54Ym8j3Bk6JmdNRq/pbiyAZ7PtjSwXClRmBSSniyUa6i4y8R20VKJb6jzwsyrjEiuJyzP0RUOccPaeSBlY+zdqN6GmFiVbiWCEn3PsyGzfWSMCJTryJSdlRGUAimdpnQSHdmdjzhq8/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=gLquWABK; arc=none smtp.client-ip=3.65.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="gLquWABK"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 83712A0042;
	Thu, 23 Jan 2025 22:11:27 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=5ihErW5LlgnjoV7OYA91DeimaknzoG2wQ0GHpfsmMRs=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=cc:mime-version:to:date:from:subject:message-id:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1737670287; v=1;
	b=gLquWABKFpK+ftUJHMs+NHnq4LukSqZ5+UlXf3/WG6/J+hW9C61zO4u9efYKjRAdmYR2PuVV
	0a4lWeALL1oE5dztq22nD6xfUiTegSHWXdRbTpm6QTFXjhsg7+EupKeV80N8+1oZIfg/OjyEOS/
	aijSHwYL17QwUtN5Pz3nxPlE=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 0D7D0A0015;
	Thu, 23 Jan 2025 22:11:26 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v3 0/4] Allow default HARDENED_USERCOPY to be set at compile time
Date: Thu, 23 Jan 2025 22:11:11 +0000
Message-ID: <20250123221115.19722-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1737670287424978316.9138.7511659934381177257@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=6792be8f
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=CEWIc4RMnpUA:10 a=F_ROk3OM8dyGBT-qa-4A:9
X-Virus-Scanned: ClamAV using ClamSMTP

Changelog since v2
o Default on
o Logic correction and simplification

Changelog since v1
o Menu section rename
o Make static branch usage similar to init_on_alloc
o Change ordering of menu options

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
default it to disabled. Patch 3 moves the static branch check to a fast
path similar to init_on_*. Patch 4 moves FORTIFY_SOURCE to hardening only
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
 include/linux/thread_info.h                   |  8 ++++-
 mm/usercopy.c                                 | 16 +++++----
 security/Kconfig                              | 21 ------------
 security/Kconfig.hardening                    | 33 +++++++++++++++++++
 5 files changed, 52 insertions(+), 30 deletions(-)

-- 
2.43.0

