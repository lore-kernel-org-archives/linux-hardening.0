Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6648304BA0
	for <linux-hardening@vger.kernel.org>; Sun, 17 Aug 2025 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755455902; cv=none; b=Glf8ZD33Q/8oMk0DcdJOD6BK0XNFpK38Q1SnDCnvX42wWjynhvGKAz1YvHm+J4B9WFBCS1c+Aim6dHjFHwanRkFjjE74IsBFhPkC+Z/0MIrjRw3Z0Eo0c8GWP5gZTh7IMQ7294KdYK8472HiAVF0DNVVfqWHcZG4gbI/AbLaFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755455902; c=relaxed/simple;
	bh=k8hw2Mq5iK4lhnKBCsE22+y+LTrgRBOTynjAoyj8GV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQ9w/RywbpWIbny1746Ui91qaH1p5CiEfmNVMMRgD8XQ5WPHn/ST0Z+0uGF6Yadtq4hzm/8fnuTx4jhDqdtfs13cinNGCXZwWz6D+PlYMEO5vQLSLx1g6elT55IUaeOwHwmodVsutLUQZa6XiQMHT+TOJdWQH82HYwHP3fgoi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b7S7OJxq; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b7S7OJxq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755455888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xFvn3En6LhswXX2FtnVX2Bgz4scDZPn0KaR2MGRe2Co=;
	b=b7S7OJxqWc/GUwMHBrHGizHki69LPKVdYFPkackfYryED+aG89g+dxYy9iqN92y+m5a/Jq
	PfRnV8AtWyRPwYIZpz31NPlEILZQeDQHveCzVXbedboMhqdcZEQ1jLfmtN3ohWEY/OrnJF
	uSMivOKfntNAjBlM7nPoxsC03+K+wnY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] MIPS: sgi-ip22: Replace deprecated strcpy() in plat_mem_setup()
Date: Sun, 17 Aug 2025 20:37:11 +0200
Message-ID: <20250817183728.612012-1-thorsten.blum@linux.dev>
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
 arch/mips/sgi-ip22/ip22-setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip22/ip22-setup.c b/arch/mips/sgi-ip22/ip22-setup.c
index e06a818fe792..f083b25be13b 100644
--- a/arch/mips/sgi-ip22/ip22-setup.c
+++ b/arch/mips/sgi-ip22/ip22-setup.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/console.h>
 #include <linux/sched.h>
+#include <linux/string.h>
 #include <linux/tty.h>
 
 #include <asm/addrspace.h>
@@ -65,7 +66,7 @@ void __init plat_mem_setup(void)
 		static char options[8] __initdata;
 		char *baud = ArcGetEnvironmentVariable("dbaud");
 		if (baud)
-			strcpy(options, baud);
+			strscpy(options, baud);
 		add_preferred_console("ttyS", *(ctype + 1) == '2' ? 1 : 0,
 				      baud ? options : NULL);
 	} else if (!ctype || *ctype != 'g') {
-- 
2.50.1

