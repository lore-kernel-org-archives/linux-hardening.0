Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83F19DFA2
	for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763812848; cv=none; b=Hp6kck5qOiToUmpb99GkIkznZMl4pokfQ9pWMgA3OOySWq/nQXUf7EdW3FjfGJCJ7D7yXsh+7Dt1+r9dFTePnch9nwZlur4E74hv++RL0UHMSf0tOGwd0z7YNIkBiZUvIGoUunLk4C1JM33rho+ZtutrQPTaB3urOS+SEKiOK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763812848; c=relaxed/simple;
	bh=m/MCNVl50WjERBMmUyU5NVnSoqI4WWGH2eZXKhY6sW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDZRBVQXIrJxEvuHbAB7Dcf3jYhz7twMRrCEeROwk9bFv/F/eqjFRRLTeNjGsD/tsIzG3mSjCwsRewXq7S1rwZhxeFCyzsn3l7+4ZybL/Jhzjyy9XS1pwnBaspWpgXM1NFrhTSt2fWo6r1BbjjhHxBahEBQRXIfzOqzPFjonnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CQdGN64K; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CQdGN64K"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763812843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1Ijs+0G20Q/bzOts/K2wob1RSAvzYuPBUCiEWsWfK+g=;
	b=CQdGN64Kls5UU+OBffD+lGlEoJjV7+FC9UVWRRNFgqUmrq6xzKgWhpZAY1QlB+dt9OedAS
	pqlzKhHzqh7ySXxuM0hcl+WmB/w23ba6UrmGA+/GDZEI/2bfLUlhgwRbUDDncn61zfoiqP
	8LwYiKjB1ulaLIt5iazzRZ32xBZdzo8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RESEND] fs/xattr: Annotate struct simple_xattr with __counted_by
Date: Sat, 22 Nov 2025 13:00:22 +0100
Message-ID: <20251122120028.448504-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'value' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/xattr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 64e9afe7d647..296b5ee5c979 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -114,7 +114,7 @@ struct simple_xattr {
 	struct rb_node rb_node;
 	char *name;
 	size_t size;
-	char value[];
+	char value[] __counted_by(size);
 };
 
 void simple_xattrs_init(struct simple_xattrs *xattrs);
-- 
2.51.1

