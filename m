Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8E3BB122;
	Mon,  8 Jun 2026 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912552; cv=none; b=Ciy9JIwkrCOJqePwmPCSlJFfQwouO8MD4s8hefWIB3YbubwCzGM/DUfb8RUEEH5PLCfnuu2ig/yPADU6/X5faC93+3X/K0+4+RX6s4+ijkDjRShXhcuxgm4BQLGHv7pzVCnLp9U4h6Sgcllu81+epQPrxYrXPScIWHBYpuf9tfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912552; c=relaxed/simple;
	bh=LYoFwE2QDO570WQw0HmVdZ1JnhvnA1vQFx/eUNLT10c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BHq2p5JmtkHMYeECYeWDIAoToXZ87KUOADiCYi72FwV8jkaUHFexIdHylTyxwtL8xhVKTMMEoPyb5NYc0d+oOaN4mMG0zD3Q1GmLE7ZXbcDvbWkQ497B9WJfoxhOQ4TLpDSgIrzRxk6zf6P6WrcygoHN3jDFAJ+iZVY1SP/WFaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=Ph/jUhV3; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Ph/jUhV3"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhs-00BrDt-TW; Mon, 08 Jun 2026 11:55:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=yWnzu3/GaR43JLPJlIjmAwAcfmNhsZcWT+nAyKXHQV4=; b=Ph/jUh
	V3Z/pUJdTgpXDxWFrQ4wjkDbU/P7tkM0n6saX33dCKQqUE/+f6qKs20ygVRMhvzw948Xcf6cUa8xE
	ppqKf2m6o/IzjVVe0R/a0nS+8zuBO9Q4HXunkMInzY6gk/fDgE/FtoXk2/rTHn2RAT+YK+iRLejnT
	RJcs6JM4lBNpIECDjq/R7zjFkQLCysbsjC60DdzRGa6cPHpxRE3YpR8EmDM9ZlhgMPUWzG51jSN2a
	kY7apn8O2n4m6fFW9Yr2v+ivEzMO98T3Y/EPDDFqkel7OHUrrYdIFC/h7ksZTny8rawlEpPZ2D3bU
	IxjmLWjCWUwafARbQAmBEVKPxRZQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhs-0000Ji-HZ; Mon, 08 Jun 2026 11:55:44 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhj-00Ag6G-NI;
	Mon, 08 Jun 2026 11:55:35 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Zack Rusin <zack.rusin@broadcom.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/gpu/drm/vmwgfx/vmwgfx_msg: Use strscpy() to copy mks-guest-stat names
Date: Mon,  8 Jun 2026 10:55:09 +0100
Message-Id: <20260608095523.2606-25-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Use the returned length to update the pointers.
Discard the parameter if there isnt room (shouldn not happen).

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index fd77ab6568cb..c7a8e5ad517b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -663,18 +663,26 @@ static inline void hypervisor_ppn_remove(PPN64 pfn)
  */
 
 static inline char *mksstat_init_record_time(mksstat_kern_stats_t stat_idx,
-	MKSGuestStatCounterTime *pstat, MKSGuestStatInfoEntry *pinfo, char *pstrs)
+	MKSGuestStatCounterTime *pstat, MKSGuestStatInfoEntry *pinfo, char *pstrs, char *lim)
 {
-	char *const pstrd = pstrs + strlen(mksstat_kern_name_desc[stat_idx][0]) + 1;
-	strcpy(pstrs, mksstat_kern_name_desc[stat_idx][0]);
-	strcpy(pstrd, mksstat_kern_name_desc[stat_idx][1]);
+	char *pstrd;
+	int len;
+
+	len = strscpy(pstrs, mksstat_kern_name_desc[stat_idx][0], lim - pstrs);
+	if (len < 0)
+		return pstrs;
+
+	pstrd = pstrs + len + 1;
+	len = strscpy(pstrd, mksstat_kern_name_desc[stat_idx][1], lim - pstrd);
+	if (len < 0)
+		return pstrs;
 
 	pinfo[stat_idx].name.s = pstrs;
 	pinfo[stat_idx].description.s = pstrd;
 	pinfo[stat_idx].flags = MKS_GUEST_STAT_FLAG_TIME;
 	pinfo[stat_idx].stat.counterTime = &pstat[stat_idx];
 
-	return pstrd + strlen(mksstat_kern_name_desc[stat_idx][1]) + 1;
+	return pstrd + len + 1;
 }
 
 /**
@@ -709,8 +717,8 @@ static int mksstat_init_kern_id(struct page **ppage)
 
 	/* Set up all kernel-internal counters and corresponding structures */
 	pstrs_acc = pstrs;
-	pstrs_acc = mksstat_init_record_time(MKSSTAT_KERN_EXECBUF, pstat, pinfo, pstrs_acc);
-	pstrs_acc = mksstat_init_record_time(MKSSTAT_KERN_COTABLE_RESIZE, pstat, pinfo, pstrs_acc);
+	pstrs_acc = mksstat_init_record_time(MKSSTAT_KERN_EXECBUF, pstat, pinfo, pstrs_acc, pstrs + PAGE_SIZE);
+	pstrs_acc = mksstat_init_record_time(MKSSTAT_KERN_COTABLE_RESIZE, pstat, pinfo, pstrs_acc, pstrs + PAGE_SIZE);
 
 	/* Add new counters above, in their order of appearance in mksstat_kern_stats_t */
 
-- 
2.39.5

