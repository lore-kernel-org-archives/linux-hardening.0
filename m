Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCA1F4C98
	for <linux-hardening@vger.kernel.org>; Sun, 17 Aug 2025 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755455895; cv=none; b=LRTyetQby33r/aV8NmRSGCwDXwbsvzH8amlwckoUVB4yID5XhRPjTj+azqS7U0T3aare5UHEHgrV0mVwb2ej0cH3Xf+m9y38u6DDFXR7H3gpbGVBvWqKvdSoSQ49IXausi7cb5ZgLPImEmbtwarbh0Mb1gKCNvZJOtOhZXXGalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755455895; c=relaxed/simple;
	bh=INypzJZVvRsuZMPxXGFxZWyEOvHfFpJqjvibZjyXVjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx27wTWO6UNmFGqv6JgULiib6KMp1mSzuE7nY1BBw1fPFXCQ9fCHML1jPiElRlSVJRul192K6NJMWIemQBMAp73/bdEZILUERy7As1axoy6ARfk/l83Slu0xO/KLLtLkRNyv+Z6SPY282e00k33hlr2j9gCKOczQAScWo+sdD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DSbZzlu/; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DSbZzlu/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755455892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMC9qxl3+y8DjdiNV2tMfFu89w7Qwy8mTMvWDapM4CM=;
	b=DSbZzlu/aOEapMU14Je5BNwcLLKrDxTOgyQK4IiOv9DbY5tu+g1vQ6Xg9xW489Hm6KapGA
	xk7ia+HJo+4sGNssbDYrjuXlrFVUVNG9bZXajipf5Qz9YNT+fpNx9jLc7BjalU9tkcIC8S
	om3fMxp3zvpH/KCVR3PkI10wCk6oBFY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-hardening@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] MIPS: sni: Replace deprecated strcpy() in sni_console_setup()
Date: Sun, 17 Aug 2025 20:37:13 +0200
Message-ID: <20250817183728.612012-3-thorsten.blum@linux.dev>
In-Reply-To: <20250817183728.612012-1-thorsten.blum@linux.dev>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/mips/sni/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
index 03cb69937258..fc7da12284f5 100644
--- a/arch/mips/sni/setup.c
+++ b/arch/mips/sni/setup.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/console.h>
 #include <linux/screen_info.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_FW_ARC
 #include <asm/fw/arc/types.h>
@@ -80,7 +81,7 @@ static void __init sni_console_setup(void)
 			break;
 		}
 		if (baud)
-			strcpy(options, baud);
+			strscpy(options, baud);
 		if (strncmp(cdev, "tty552", 6) == 0)
 			add_preferred_console("ttyS", port,
 					      baud ? options : NULL);
-- 
2.50.1

