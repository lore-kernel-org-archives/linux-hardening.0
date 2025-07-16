Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF982AE8E
	for <linux-hardening@vger.kernel.org>; Wed, 16 Jul 2025 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700696; cv=none; b=ncrQ9ygsU/EOmOQhCwaHZRlCoo0cF/nYXM/7evu+bqiqtCfXOGneqK8/gcgo5uVRByRiT46zEAnvtROfjeu/Ct1hN6aJQpD484YXpjrVzGyELV+hjPt5N+0Dlb3EUiyMvDbtEqjie7BNoLMH+oJY3vc148oRvzVQvGd8lqzfHMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700696; c=relaxed/simple;
	bh=wWqokGDMHBDhwGPIbUEwk+JQC46/td8MKpkyDnKaPFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFPLb9SSTzs1oJ7AhYTvCOSnYpY38Y+CjQ5bPzRxlISgnau6hCm1Ex+lqdpr90NtEy4jsqBKyIFmchmyQ46FMwMUalcF9E0x1QUg0HbWHAizu9s0IF3Eqo480HT70Qzh5LnLAX0fchfKMChfxYj4bm4SQHw39VbeYa026mCUNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MywjAst7; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MywjAst7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752700692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SIYYCveydZN/yS9B5/K7xi00iELlTOe8UHhKrMt4XvI=;
	b=MywjAst7w1SPwR+9c/oPuvPoK7/klNjKu1PzTWQLK1tM5GvbXyD7pQiyNY/GSAioLLwEVU
	9PO/OJbyjboPc5g1Uc6PdsY42S2GFuE6/yXXb15xiAwYNlAQsvEudiNWSGumpLAfkJNt1A
	7xSUBjWxLbZ1LQznJaqBlJgs7cKwQhE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] alpha: smp: Replace deprecated strcpy() with strscpy()
Date: Wed, 16 Jul 2025 23:17:22 +0200
Message-ID: <20250716211724.277212-2-thorsten.blum@linux.dev>
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

