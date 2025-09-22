Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC834BA39
	for <linux-hardening@vger.kernel.org>; Mon, 22 Sep 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575139; cv=none; b=rspY8zsX5VRlbdB66I3zEhLaJdgVWpGO4lVNU/4DapYkn49sTATebwmnI8vFHRX66yk1tQW9upvFAXlpejnwf8aNfEqsXPqdTRXdzFaI0lb9wm3++RUky/m37WEDlXY30mlpv18AULdrBG4ivKlp1yw0col7wpl03Y/bLpkgCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575139; c=relaxed/simple;
	bh=wg4Bsmf0Cylq4UUguQCUREO3hf0XWyOAb0GAtzIkyC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeY7ENi9B8P+0FTno6+g1y+n5SL8KzDO/UAXaPmStohYD1PacZfBFzaAyXbjQ5CTEGg25zae6BuYf2yzCnn6uhiFF8PUqrdwSacyhyvgZL34HyUM3uedVLBa0wbDkGh1J788DphblkBOhaXQON3Cs1tGvUMZw/e73hPoduNSS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qKjYd5lD; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qKjYd5lD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758575134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zwtpTXeLXp7mAn4X5490IZLFcA3q3uDfFSgnxH9sIE=;
	b=qKjYd5lD21w25SEO1mnh/F3t8U4dFxmDnP7VEvvkR8jMjPOn5Ik5qDr5tDShNjQFQVMBHW
	pa89EW7pd7kAHWrkCQOrXIKE1OtRjPTF2YBU9+LDNSNG35gcMH6ZG+BQdvTdhS9l+yMaJv
	ZfYjvY+h6dEJ93zrZyqjEv5QhW95K94=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Helge Deller <deller@gmx.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] sparc: floppy: Replace deprecated strcpy with strscpy in sun_floppy_init
Date: Mon, 22 Sep 2025 23:03:52 +0200
Message-ID: <20250922210408.1723452-3-thorsten.blum@linux.dev>
In-Reply-To: <20250922210408.1723452-1-thorsten.blum@linux.dev>
References: <20250922210408.1723452-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/include/asm/floppy_64.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index b0f633ce3518..8d3ce6506607 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/dma-mapping.h>
+#include <linux/string.h>
 
 #include <asm/auxio.h>
 
@@ -618,7 +619,7 @@ static unsigned long __init sun_floppy_init(void)
 		sun_pci_fd_ebus_dma.callback = sun_pci_fd_dma_callback;
 		sun_pci_fd_ebus_dma.client_cookie = NULL;
 		sun_pci_fd_ebus_dma.irq = FLOPPY_IRQ;
-		strcpy(sun_pci_fd_ebus_dma.name, "floppy");
+		strscpy(sun_pci_fd_ebus_dma.name, "floppy");
 		if (ebus_dma_register(&sun_pci_fd_ebus_dma))
 			return 0;
 
-- 
2.51.0

