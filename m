Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCDA2AE97
	for <linux-hardening@vger.kernel.org>; Sun, 17 Aug 2025 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755472920; cv=none; b=P2E4sd1cFw3KW5vMsj+IEeAVaDnkpmejFPDtNH4SUcVh+UgH6Kd/vergOTIdkDdblXGLueczlx3NGIiCZxRQ1B7juEo+HjnacBstQIBc28/KhPeDf1gVxXtzld+yhLzwl4kNoPY2RkxharT3XOseS41zU88nn7CmKHBZIO80DXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755472920; c=relaxed/simple;
	bh=wWqokGDMHBDhwGPIbUEwk+JQC46/td8MKpkyDnKaPFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRhdli7tNU5fGd4dJXbFL8oymrPGcS4VH7WJjyaEC60A9pTJ2bTiDIllygAmqUWRPCZZOfeILy4xpO0QRm1xt4YbySv7T0UXNS+YAheC06DHB/kZJa+O05J0qvM5iPfa6Tr/aUtEoAF333tdvltbfG3SSQtxV/97uE0lvC/yzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JYac9BRa; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JYac9BRa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755472907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SIYYCveydZN/yS9B5/K7xi00iELlTOe8UHhKrMt4XvI=;
	b=JYac9BRaohmbqI7o2h8cKY89Fe6NDk4lV4wIt7FZEZBagZ3R0tkepWFNv/++gVZSlitMgS
	/FuG9V24sfu4Vc93IrA0ZIsW5r8qLwJwP8Y4D+85pcs6oeaZIurqxlUyBcKvGo0QT/i7E/
	QvcWxWkGl/xus08DpWc7lhI65QmoN7k=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] alpha: smp: Replace deprecated strcpy() with strscpy()
Date: Mon, 18 Aug 2025 01:21:36 +0200
Message-ID: <20250817232138.634361-1-thorsten.blum@linux.dev>
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
 arch/alpha/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index ed06367ece57..56155b988b9c 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -262,7 +262,7 @@ recv_secondary_console_msg(void)
 
 		cnt = cpu->ipc_buffer[0] >> 32;
 		if (cnt <= 0 || cnt >= 80)
-			strcpy(buf, "<<< BOGUS MSG >>>");
+			strscpy(buf, "<<< BOGUS MSG >>>");
 		else {
 			cp1 = (char *) &cpu->ipc_buffer[1];
 			cp2 = buf;
-- 
2.50.1

