Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E717BB35
	for <linux-hardening@vger.kernel.org>; Fri, 14 Nov 2025 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763078552; cv=none; b=BDs+pjxTco/TnzzLMax1b0VpKWfmFesIci1EDggOhqHZqVkfWJ7Pm7BV37CoUOgb+2VVR3IdRb4THWMj3Bo8DIlKTXoxinOri/67XLsMWjyWqRscj2+ICojlAVdZLvWplRVhal+nr+YGdrpfmnuATQFad5DrbqZjEAB+Om1B6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763078552; c=relaxed/simple;
	bh=YYn1QNldg/j8f7MEluaOq/sfg3Ag5Ezy21dLuxoykPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1f2lTU7H5H1zkJyrYOJqYSytAiVC0akK3bKFtZOeVUCFdGfIMHaD0S4xJuFiWQMIeSboQBCjGsJ6jIaMmlqJaoBFGkuwq4RA0Kl3FSSYrNlslzstuZfsqhCiFbiIyi/+R/P+2uNx7rREO6xRnunSB2xrjGZhdzVEb2ETL6u3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vzuZzl2W; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vzuZzl2W"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763078539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DeLzK0AVkutEbiXaCDUp2PW5ApiEQmzw+19O+u5NMA4=;
	b=vzuZzl2WfOpzYa3td/eH5uIXhfkM5U7IpVHw9y+EhDfTQlRO/dVZeoQ8cgzb5dkpeLBJ7m
	p+qtK4928Nin00Wlnm72LdMq92/MJF3Wilr+ziaPp+SHGId24tF83zckbn5SgGKAwi1lJb
	GZ30caCzdqVTW7Ra5oFvlYpUr/62Hno=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] crypto: af_alg - Annotate struct af_alg_iv with __counted_by
Date: Fri, 14 Nov 2025 01:01:54 +0100
Message-ID: <20251114000155.163287-1-thorsten.blum@linux.dev>
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
2.51.1

