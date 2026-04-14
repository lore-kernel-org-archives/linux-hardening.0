Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD126B0A9
	for <linux-hardening@vger.kernel.org>; Tue, 14 Apr 2026 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172211; cv=none; b=kNKxouUq00Wy2arhtKQNkI3JtmQTZrYo7be9gNYfX+cLC6peJ/0U9kdQlPOdTGHhz2s3yV0srvIh0WRpYDdpeCfkmc92apnndRU6qJnGNCfaM3dar5Er5hfG1MmeX6vbKFAW29NnfB1CiZHgRL7KmQTvjj+G4m/R/Isuy7TCQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172211; c=relaxed/simple;
	bh=JKCqT83R32AeBVtP0rk7Tc7NJh5jZKtfUmHDqiXenQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myCKVRnYzh1Vxui/nHvNQjNth7FHxvLsgna/qwdPxc89E4spn6S1J3kOCUCWvV0wWOEtmqRUsdffOKdTzencrDoYiTmxLzJP1dsDcfnVDIUHHUzlf17Cm37T6LHllUaeu3bX+yN1sAOhfSqih1hJtPpFg8sp5AvK93iZSLq9hMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pnhcnQav; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pnhcnQav"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776172197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0v9exPlAvak3HBmYFILCHDpP0vnB/q46W2JYWNgxR0g=;
	b=pnhcnQavAcMrPTFzb5r9XmzJUOb0jTviLS4rllX7aMykfgeM/m1Tuo1dMMl9M18Xoe/p8J
	28RTRHlcnLIChPMQiogEVT/cOGyGjw13NpXfdI4Naugx5U9bomook7uYMaZ6GO2oBh6hOn
	V9dKpb4bo6K6SwRY2cUEWP6ddbHi9TE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add kernel hardening keyword __counted_by_ptr
Date: Tue, 14 Apr 2026 15:09:28 +0200
Message-ID: <20260414130926.312094-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=664; i=thorsten.blum@linux.dev; h=from:subject; bh=JKCqT83R32AeBVtP0rk7Tc7NJh5jZKtfUmHDqiXenQM=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJn3bNoOX9p9VvRF0tkliuvX9Xc01/493sa+bdaDoroFh Yt2Lcz37ihlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJBIoxMjzxV/1Q8FCdh3PT voYXBd42iixBEa7F9R4evZ6nZtl1fmdkuNb3U7XHTZrvpdYhluh6yYPzI6ZZXrr4KjJrv9XmagU fFgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In addition to __counted_by, __counted_by_le, and __counted_by_be, also
match the keyword __counted_by_ptr.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1126fdd639ad..969460c85ad6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13889,7 +13889,7 @@ F:	scripts/Makefile.randstruct
 F:	security/Kconfig.hardening
 K:	\b(add|choose)_random_kstack_offset\b
 K:	\b__check_(object_size|heap_object)\b
-K:	\b__counted_by(_le|_be)?\b
+K:	\b__counted_by(_le|_be|_ptr)?\b
 
 KERNEL JANITORS
 L:	kernel-janitors@vger.kernel.org
