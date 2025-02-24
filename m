Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF61E9917
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434210; cv=none; b=bE2lfuKpk+n4f3ZQnVfWUmLFii8qHKivK9IhvQJhvH9dF5gWRkNq9wKLdMAA2q+3740eqcFTJSSF0HNSgsUpnQeDb9Wzm4I+o7byE0Hl2mizswvlFJSvn2IDUG56N4i2S2zFuAZ7XMtaJFBG4o3u/GXeSqi1/F3GhLCj3CBi4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434210; c=relaxed/simple;
	bh=GUhgL6hS//UQepLQQDcUz5xENrHigAyZeokfv/kaliU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFJgqA6+qrunx+UFNgzysBh+qUAomFRORfj5DgIt79Q+6l6HUhSkoTIZbX3oVxAYm+UI8Kjr9N5WpfC0Elz5vrJRDUlH2HMKpH0op31FuVAOTWjwRtRHq/MpJgXNElEocuRl7uwQDZikckqoH0fQCmy60HVEQ45A9nyneS/weoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BbnVatbb; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BbnVatbb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740434197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rE+rorFgyeXZ3jXULEAJWqUQ+FDPOU0lGoqzwNbi0Hg=;
	b=BbnVatbbD75pCJ5aXM9CE4hD8I/VZ3Bq4IEAOG/fRm4EWsRqqK2dx+xXp6xMzwcTx/2aBE
	QJVXcVMlrDyD6KF/9vof3tvAgaJ5MqS6lPPtbxcKdwkP7zlvhfstLpft2dpbWcltkSwpy4
	naK89UHgiI2gwyaPVS//qs4R3ZxJWcw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH]  MIPS: Loongson2ef: Replace deprecated strncpy() with strscpy()
Date: Mon, 24 Feb 2025 22:54:50 +0100
Message-ID: <20250224215451.195727-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and remove the manual NUL-termination.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/mips/loongson2ef/common/machtype.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/loongson2ef/common/machtype.c b/arch/mips/loongson2ef/common/machtype.c
index 82f6de49f20f..e635e66d2e6c 100644
--- a/arch/mips/loongson2ef/common/machtype.c
+++ b/arch/mips/loongson2ef/common/machtype.c
@@ -48,8 +48,7 @@ void __init prom_init_machtype(void)
 		return;
 	}
 	p += strlen("machtype=");
-	strncpy(str, p, MACHTYPE_LEN);
-	str[MACHTYPE_LEN] = '\0';
+	strscpy(str, p);
 	p = strstr(str, " ");
 	if (p)
 		*p = '\0';
-- 
2.48.1

