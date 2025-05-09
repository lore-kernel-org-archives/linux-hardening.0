Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39491DE4F3
	for <linux-hardening@vger.kernel.org>; Fri,  9 May 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808743; cv=none; b=FUUPIupyi1IH2mVPA1XcYrqaSTQ5a5SapjS8xs80kFuK7un4EE8Iif3UA1IbOIdnM9x8WL26q6P/yFpWViZBVUCduojN/Vs1aDLXeWRmTsGvWQqdSz/pPJ7gXzREiAz8271PwGN3x0BMRQuLT4aWo2yrSZiqEC1dQz7wGyoB+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808743; c=relaxed/simple;
	bh=9Iop83tVkN6TLPTJ48kV73FWPiLDox8v+XHK5UmF86Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJ8ODfJNciIS0UvO9PDC9HBxLsIrH51qCbS/iaA1Q6pj9XDE3pEm1ts6gHFk1f7cd2yTTkYnXIF2/NeYhEX3+Mh6uC/z+HKA5ZoCEt4bgpug2R9dusaD6WZduym8r7/r8WgxK58Tc/r+8xofrsz1Z2kQGBpPalGRj21Lw2eoEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cxs8fDwy; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cxs8fDwy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746808729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kM5Cn6zHq5ti+9ezEeBk+ms6OE/NRCXX5zfHP0XAkh8=;
	b=cxs8fDwyHGlZq892v+nWpGGWWwGEXLmeXP4/bozufOjUc2gtGUGb6SYJcTwouaKZPisffB
	57NwERaRVIcRUYkD3DeRF/Ot83sh30hAzPB8phyXflmAmZ/WDYK2T1GO3iUkFfuxjzL1F3
	ykIAEYbapW1BpPgBA42aZXwXNdv+Hhk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] nios2: Replace strcpy() with strscpy() and simplify setup_cpuinfo()
Date: Fri,  9 May 2025 18:38:37 +0200
Message-ID: <20250509163840.171521-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Since the destination buffer has a fixed length, strscpy() automatically
determines its size using sizeof() when the size argument is omitted.
This makes the explicit size argument unnecessary - remove it.

Now, combine both if-else branches using strscpy() and the same buffer
into a single statement to simplify the code.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Cc: linux-hardening@vger.kernel.org
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/nios2/kernel/cpuinfo.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/nios2/kernel/cpuinfo.c b/arch/nios2/kernel/cpuinfo.c
index 7b1e8f9128e9..55882feb6249 100644
--- a/arch/nios2/kernel/cpuinfo.c
+++ b/arch/nios2/kernel/cpuinfo.c
@@ -46,10 +46,7 @@ void __init setup_cpuinfo(void)
 	cpuinfo.cpu_clock_freq = fcpu(cpu, "clock-frequency");
 
 	str = of_get_property(cpu, "altr,implementation", &len);
-	if (str)
-		strscpy(cpuinfo.cpu_impl, str, sizeof(cpuinfo.cpu_impl));
-	else
-		strcpy(cpuinfo.cpu_impl, "<unknown>");
+	strscpy(cpuinfo.cpu_impl, str ?: "<unknown>");
 
 	cpuinfo.has_div = of_property_read_bool(cpu, "altr,has-div");
 	cpuinfo.has_mul = of_property_read_bool(cpu, "altr,has-mul");
-- 
2.49.0

