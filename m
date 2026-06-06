Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17953C0625;
	Sat,  6 Jun 2026 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777645; cv=none; b=WgbQG+bODU/AxEQD1baQE3sZH0SH10DuhPqTXJC8fVg7/iUt8YVNedcTxuiFwQc5ocD5+7klmWglmgsrRB/dJjsuKB2aDCk/KZt8SsZY+QktHslFJq+DFH25J48lZK5CFANipn5IoS2Vfha9h2FCb3/aQJB5Lcb2y18x9blVWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777645; c=relaxed/simple;
	bh=87gylCFSTNb8SP1XP1a9cGTXRxH34QgsLF29JF1xDKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L3IR2HrsiJudceez5p3m+lSQK3Czog8FUUe2ZNF0KGlYKYpf/QH5LVWjJBdK2IYU+ovwcvdQ/yP6JS9Q1CZoQQrwqpDrNcpxDzT1pgxJGsh/FLzzltxVcKOheHhIirG0wDRmrVoUAVK7DR5Z33gS5pEsPt+UfQPj380J6V9jGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=al5x+k/8; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="al5x+k/8"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbs-007NQM-1s; Sat, 06 Jun 2026 22:27:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=HBLevs8ravAMAmVYjyMTplN6eRrY/9SoSdwiNNMUH08=; b=al5x+k
	/833QFr+El/mWuBmz3VIRrmxZmufJ13mHCB//9OB0yg3vsoY3Dg9E7l8jQZtEW5qmUPnOVZZqoC13
	ALOybAC3nw1SflOrJLRJzC4DkonfPLqxA0Aq63hTAbJ2brQB7Sp0nNznrwEKTQwnyxxlDJDo/wTOO
	QqNeSlZTVAhqlr4w2021qWUzNprM6yn2LRqSSM5HQ1TPh1HBVwRGdtANULYLmdqpqvuUd5Ks9sfX5
	o4C5WIrEVjSEe4CvVm0svgDeZoobWJSsgmDpWufWUCtW9bXOrcPicRnYSR8HoTBpRzj2bhNHIjMVQ
	DdZ3EhkBYgml+M4eaTtDMGI+D9Zg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbr-0005CN-Fw; Sat, 06 Jun 2026 22:27:11 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbj-006V18-0S;
	Sat, 06 Jun 2026 22:27:03 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/video/fbdev/mmp/fb: Use strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:18 +0100
Message-Id: <20260606202633.5018-24-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

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

 drivers/video/fbdev/mmp/fb/mmpfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/fb/mmpfb.c b/drivers/video/fbdev/mmp/fb/mmpfb.c
index 694587256e06..fc09d3ec3487 100644
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@ -502,7 +502,7 @@ static int fb_info_setup(struct fb_info *info,
 	info->flags = FBINFO_PARTIAL_PAN_OK |
 		FBINFO_HWACCEL_XPAN | FBINFO_HWACCEL_YPAN;
 	info->node = -1;
-	strcpy(info->fix.id, fbi->name);
+	strscpy(info->fix.id, fbi->name);
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
 	info->fix.type_aux = 0;
 	info->fix.xpanstep = 0;
-- 
2.39.5

