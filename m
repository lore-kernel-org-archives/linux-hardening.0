Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5E22E41D
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016943; cv=none; b=G1D8JU/f4Uzi8XVhoKOj1AvSdd+sAts9nDZcRwjo731vVD/QJBT3l5QtXw4k7WfoHq+HfvPbYOe2+QlCABOZNJ0y03uHDOXmTMjiMDc+ZilZeTT5SPLp5ZlkaqdAUDTWJf8h16e783U8Ky+IxU9YJu9bE7TIOakRGzaUI1tgzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016943; c=relaxed/simple;
	bh=otjyu1yK+Nmm0V/n4TFbCOpBPDznw9MHSZTLk3O0/70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulzRTsMCZMM0/ZHvAuKgPz19J/abTYL648xFojiMfP6lvuJq9hH6iWrr4Br8rFkvCGkpOtm7+1ZSYQW0kTrRGgqA5mB86pygjPgmnUHEJujzAFdHek2VRly1Qe96ndLNjeA9qq+MItIFs+VHO6bgC5t/2WmN/bZxtD4yJ6XLiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MbvvmloL; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MbvvmloL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744016929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PI2yBm7HedcIW7BHq6L6NdzgVKH2U6R6R99lyNbMjAI=;
	b=MbvvmloLqmACtwOASZdPBiiKhNS7Tlhx4oACe/gaRkdPZI2hpQlHnxYJ69k1YNPBbprgn+
	OnhuWeTjD6uv58h2y1q3E8rQkrhiVqQrCWRIN3Oew/L2smy1XWH5ksN1/c/r/UGqrKQgxD
	ZfiBcv9j0QkxIXd5CWOU2wxBIoqPcsY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: azt2320: Replace deprecated strcpy() with strscpy()
Date: Mon,  7 Apr 2025 11:08:29 +0200
Message-ID: <20250407090832.743255-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated, use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/isa/azt2320.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index b937c9138d12..588b9f0831d3 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -189,8 +189,8 @@ static int snd_card_azt2320_probe(int dev,
 	if (error < 0)
 		return error;
 
-	strcpy(card->driver, "AZT2320");
-	strcpy(card->shortname, "Aztech AZT2320");
+	strscpy(card->driver, "AZT2320");
+	strscpy(card->shortname, "Aztech AZT2320");
 	sprintf(card->longname, "%s, WSS at 0x%lx, irq %i, dma %i&%i",
 		card->shortname, chip->port, irq[dev], dma1[dev], dma2[dev]);
 
-- 
2.49.0

