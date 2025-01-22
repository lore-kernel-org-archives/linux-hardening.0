Received: from mail18.out.titan.email (mail18.out.titan.email [3.64.226.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562242153C4
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jan 2025 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566387; cv=none; b=lnB+OYPL24c4sWyYXl/VdekVallYuOz29TuE3JS5SntAATHys3iNZ9yuChag2VZ15sJM2hEbKJi+i8geIUk4mpATKKxiS47/7v95ZgOj9QDH0ywyL3rXPef0s1anFqoRboeZOrxLdBsCrleNGVCVEnP6wWh6IIlKTlhDy18pEI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566387; c=relaxed/simple;
	bh=iK09qufNgJuDPPak6RhKr/1Xfb8f0RwJMff2E1K4Xjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a72LSAdhpJ6EnHoVaxHXTTiDIyyWQuw1IeBifc3X/qfEthZwF6zqO0XO2T1CeL7ksHEVmW/5DEcNsRa44bgqsKwkeGByikye0P5G0LB3WQFVVuxAA46rVVSzx6Njw64S+UVgGgc0SzcYQoFVupy4Kd+0mNp/Xv9uGIcQvEc9+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=Aa8faVMU; arc=none smtp.client-ip=3.64.226.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="Aa8faVMU"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 6B05BA004C;
	Wed, 22 Jan 2025 17:19:37 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=4djku+6EqFOgLL/qaKFUmPRsXvTJBcQLpvpQYtOF4ss=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=message-id:from:to:cc:subject:date:mime-version:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1737566377; v=1;
	b=Aa8faVMUJ6GqjC+lWfBwlVvvVGfw/KLW5fomE4y6IB060+mJ5/DcerLAiy3RahfLkyQzTqn/
	VCvwXYPlKJC0e9+9nA+qc810J/fNecX11FaYfaBxemVAYvz0Jo8IFi4Ms0jdJQ7OgykjRcdkV/W
	bGg6Ep/aV4hIGB2YAsZuPiRw=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id E5A4CA0004;
	Wed, 22 Jan 2025 17:19:36 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v2 0/4] Allow default HARDENED_USERCOPY to be set at compile time
Date: Wed, 22 Jan 2025 17:19:21 +0000
Message-ID: <20250122171925.25472-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1737566377314830560.9138.3654567428906523320@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=679128a9
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=CEWIc4RMnpUA:10 a=F_ROk3OM8dyGBT-qa-4A:9
X-Virus-Scanned: ClamAV using ClamSMTP

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
 include/linux/thread_info.h                   |  8 +++++
 mm/usercopy.c                                 | 14 ++++----
 security/Kconfig                              | 21 ------------
 security/Kconfig.hardening                    | 33 +++++++++++++++++++
 5 files changed, 52 insertions(+), 28 deletions(-)

-- 
2.43.0

