Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EBC31A579
	for <linux-hardening@vger.kernel.org>; Mon,  5 Jan 2026 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615889; cv=none; b=OgOvfLPy90JVRwDlidKhfhKd8aDFWAsKi6R7fFd3PjW8nbwtbjx0Kz+LUhouJRgcOkRtnQa6e7tFM3oOTBVggjFVWe9Obk0k5gmbqDCMpAURk9DWT0vHUf/s/t8gLtrNh/aFtEqXlmYj9D6tJ4JNNR19/PZ1foYHKRxT55Xt3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615889; c=relaxed/simple;
	bh=oZ5AzMH/4SQ2rr8CO+UbA1/Z7dMNLzHqH4V5aDT8458=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOJL8bVGqDQqY8r8Dq3/AQdtpGhlV5XhCB13YRBBbE3RuL8SNmsHDqTZhw4KcUXjMHX2eHTHSjq8CnVD9ivVemnQUcpG9A4UbBA1jglGlj79hj2QDHpdK3RqbrUSCuZ2RYp2rSjiYZZx2hE+txXs7iCsAF9zjgiYVnBXk5IXn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ghmWoHUm; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ghmWoHUm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767615884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w9gywOqf/A5KnJyxaaxeyqq24z/FBCXUgwq/3X0oLRE=;
	b=ghmWoHUmLLRU82B/witACEEheBIaSQpJbp356ROJclvS7Fhy8vzlasRCKOafTgMUsBKK8G
	2KID2wGrFPQZRWtIWGml4Rt+5Wrzf4vaBF3KssCq/hoKzVJdCw1eEl2HbkhbHHeLh4NgW3
	RQdxafOUeGISE52AsKW0b64nQCgt4d4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RESEND] crypto: af_alg - Annotate struct af_alg_iv with __counted_by
Date: Mon,  5 Jan 2026 13:24:03 +0100
Message-ID: <20260105122402.2685-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'iv' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/uapi/linux/if_alg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_alg.h b/include/uapi/linux/if_alg.h
index b35871cbeed7..4f51e198ac2e 100644
--- a/include/uapi/linux/if_alg.h
+++ b/include/uapi/linux/if_alg.h
@@ -42,7 +42,7 @@ struct sockaddr_alg_new {
 
 struct af_alg_iv {
 	__u32	ivlen;
-	__u8	iv[];
+	__u8	iv[] __counted_by(ivlen);
 };
 
 /* Socket options */
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

