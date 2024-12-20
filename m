Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDEF2210F0
	for <linux-hardening@vger.kernel.org>; Fri, 20 Dec 2024 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722477; cv=none; b=iHf0H/snIavdzaZEM+lNcFX0p5IRgr/8+IrNPap/n5ZJgg7uK7qO3YWDXW4zeLFeU9IeVFtSQL3N86OOsNp3nAD+woXTFK9vQMvJ2HM/NqXZwo4MH7vvL1ab+JfLoN6h+cWeLi1SC+mXsMCduHJR5vRc+SplTRTSVP/K/LcEkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722477; c=relaxed/simple;
	bh=nBYB5Xg+BKjQqhoyzRiKH6a173lAGOtUAU2g7YLzwr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivObjKhkH64kubuBk9w2LQ5yU5gCnSw2YSbKUPn/m5YgxlC/8mPb5OFg63SfUGW1F3Qp20wTkLriftkay/R0ytbZCNEI5bnR2bhDoNsAoRXEsOamQhjdXXyPpiPopCicYmA+cuaAuBVkn7B1CWKOYPHnQabp2I/SsRVhGhjdXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NNo5vJYw; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NNo5vJYw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734722462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b0TCN20N6Jt0mRB8VQbmu+9cK5ofHCns5KRUsuZgT+A=;
	b=NNo5vJYwQHfQXJ0EVIABa2a9+2Trm5ECcMQiYrtTvMK+coptIkcy5sKKT5+FYyjJKV8UWU
	SyOa98u7UWl3xsst0btNdApPPeI+U3m8UqP/LRhXighikip2KafxqZ7QbCv9514kScuugl
	WVhOVWmYMjYsuVk6jAwEmZes4hNOR2k=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] alpha: Replace one-element array with flexible array member
Date: Fri, 20 Dec 2024 20:20:20 +0100
Message-ID: <20241220192020.1667-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct crb_struct.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/alpha/include/asm/hwrpb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/hwrpb.h b/arch/alpha/include/asm/hwrpb.h
index fc76f36265ad..db831cf8de10 100644
--- a/arch/alpha/include/asm/hwrpb.h
+++ b/arch/alpha/include/asm/hwrpb.h
@@ -135,7 +135,7 @@ struct crb_struct {
 	/* virtual->physical map */
 	unsigned long map_entries;
 	unsigned long map_pages;
-	struct vf_map_struct map[1];
+	struct vf_map_struct map[];
 };
 
 struct memclust_struct {
-- 
2.47.1

