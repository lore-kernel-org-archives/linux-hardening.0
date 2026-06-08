Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64603B95EB
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912550; cv=none; b=CLdPGMiGfPjDui9ZhSOepwCcSdcel4MemzaNJPB7pWzM+t/2oBGPP5qp1K4+Hag0sOFpd4jbYsRLU/KxA+HllS+sDSVazllkihPS/pPomdd/hNGtM5YPRRx9J0HjelrNf6N6aH5GLT9+dzlgH2c1gtH7DyKhPDOUzAJUBpsJRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912550; c=relaxed/simple;
	bh=AG91LVFKrnjtOz/RM2dzsnum4L+mA8LSiQ7Vi+clvrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gPlIseBPmzTPGBSMLCe+6FahwC9s5FeO7j3pmrY8TJffqmEO6+75GqpdxXc41R78U6+xxMmZMOAw4DHQSP6nXcps7u/s41we7hVlPuGSyeVn6Pup5PIIIgf9iOeNWveF3A1F9SNkc5TOgDmd8YRkBy/H2tIazlLmG31nPU48TQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=atFgO1of; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="atFgO1of"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhs-00BrDC-0R; Mon, 08 Jun 2026 11:55:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=AhJnsDP0GCsdnC0Lo/DknR/Iko2rDvI1Tbhf06iuXdw=; b=atFgO1
	ofoaFoPpCIp/yQFM2WLiq5pAlIleWr1hBI2ni2edWlNYdsdTEsjQGOJQ6pogT78pG9IDVR0LeuAi7
	dVJ5VbI5ZNQ6t0cUhFo5ItuBmCVdF0A2siWQvSbRDOJ1T7JPeH/JCz1/Jiasu8Mkrf16fP/td5cfa
	xZPXtNUhkNOwWf0GXuL1biXVC5mNTW9kJaTatvt4DnuLUjpqJTo0sKnelKEa9oycx+7EdWFS2aOJb
	xIPG0mef0TJ/4mET2wRP1v7cVnjtlLCOLghsWFRyMGV8oxg6iMbpC1yoiMv/LhW1U/Pfp1mlI2rh2
	XKL+O6zO1fAaL0UQefuaiFYTRyBA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhr-0000I3-KM; Mon, 08 Jun 2026 11:55:43 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhg-00Ag6G-Ic;
	Mon, 08 Jun 2026 11:55:32 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: Arnd Bergmann <arnd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Maloy <jmaloy@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/tipc/bearer: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:55:01 +0100
Message-Id: <20260608095523.2606-17-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 net/tipc/bearer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index a3bd1ef17558..d68744e253e2 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -209,7 +209,7 @@ int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
 	if (!b)
 		return -EINVAL;
 
-	strcpy(name, b->name);
+	strscpy(name, b->name, TIPC_MAX_BEARER_NAME);
 	return 0;
 }
 
-- 
2.39.5

