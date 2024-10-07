Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245831D1F56
	for <linux-hardening@vger.kernel.org>; Mon,  7 Oct 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301794; cv=none; b=KfhOmW515SXNLRmkMBAwyvuJd8gDHRPNWbt3qY5qrLd9BYWXUfbj+RRbzHcd6gY92JhN56HPDXNKkO6ukpaYaEQdWqWRWMByAYJHtv3DUCR3rdf97N8PjkZIkpZKQx5Ad0KJ8rlwO9se+srTyGVJTLA0E0jLHkBualPTmVW4KvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301794; c=relaxed/simple;
	bh=9WjErrUIX7d0cadiFNejOLMGQ6ELJVrR3BMxgJdsy9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aja3zHl/80IXtPwwIiKhkcUUMy3toMBbIHGO6Qzb0nhlw1C43NKkDsYNVAN/W2MnDs2sgUI0ebfdYVWdy59OIz7kWTiEjVPJh7DA1P6orNNoTZrIAiQyz3r1dk3fwAQRxkSdle9xoRbGJqqecWs0wwYbt9+kLEqv/DjG9zGL+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f6vcUyjx; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f6vcUyjx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728301791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=18TJXg2TlHuFbWGH/bL8ydms2/p1De441dgZvSKyQIg=;
	b=f6vcUyjxKSnAm3Q/gKGwWWAbLqBrE3d2WhxQLfA4y0Tv7jIccXdD9QJDpTYPsIyXJdNJtc
	cOdmRwoFfraSQxt3SajQ8kmZyo8C1rP8CD0ycM3j9NYjSZ1UDv8Zx3TWWF5T2aWFj4DUlN
	NEae0Qn/s+LZI6YRL8jzu7tWQXx3Q5s=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH] MAINTAINERS: Add kernel hardening keywords __counted_by{_le|_be}
Date: Mon,  7 Oct 2024 13:49:36 +0200
Message-ID: <20241007114935.1647-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In addition to __counted_by, also match the keywords __counted_by_le and
__counted_by_be.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84086d47db69..475387503391 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12356,7 +12356,7 @@ F:	lib/usercopy_kunit.c
 F:	mm/usercopy.c
 K:	\b(add|choose)_random_kstack_offset\b
 K:	\b__check_(object_size|heap_object)\b
-K:	\b__counted_by\b
+K:	\b__counted_by(_le|_be)?\b
 
 KERNEL JANITORS
 L:	kernel-janitors@vger.kernel.org
-- 
2.46.2

