Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AEB3C5528
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777646; cv=none; b=TwIIRLAsucsj2xd3kNvtpdl8lYOKtCy6kS/hJqt8luaJjOxJUhkJahtvOAWmdIuGWEKt8xCa8Ygm9LnnMu3btMZlzPhgWONlh7HfMt8zizvcrfKonhds9A/3XHf67hBbsTQdcHPOOLdPSSpik/ptemALEf+JpWr7EygZAnO0peo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777646; c=relaxed/simple;
	bh=tHQEQrPxlubWISHX02zXpkKqs7TtIMm13+hU8WYJMOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N8Im7psRFFWsXDt6YxoD9pNV5y3vRRMMstyNXcfVzkw+gaVfCIcukPEmhPyoo4kEdHKqHR8wuwY4Z2Cl0UmUACVgePLSA0myt95QipS1ctTaDtHUVyadDTT+ylCfrGueCrfMAZnrfpwY+6Zvk860C8QZwaSvkO8iU3z6oECOrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=tpzfK8sl; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="tpzfK8sl"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbw-007NRr-1N; Sat, 06 Jun 2026 22:27:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=9gIdnzM+dAgG4gvnmdxAjdZuQXK+gY/bR0bwUb0i+Fc=; b=tpzfK8
	slwFwN9KZk7UmXtXiSkmIv/ImS8D6SQXxDgt9/6Wmym7Zt76I+in+meuBEeJPsScpvXWdkhASAVqG
	ZYidEm1mIIrpCeKlrlqmFj5gJjw8h6cunogj2/C8mi3QzfkUbu2HJhaEWBiuFgWd0KXXucKLcLTe8
	l/BHby6tvnWXvCZHMJ/7kNR7h6KYG1yvcqX6M1uQOcjHvPHtnRHrc3Nppd8hk8Pt8wHyVSMML4b4f
	fOYqA2bAb6/ZvMHSNUJS/8GYDP/mRHvnrgmvQ6nCfYr2ydGEQLGYLqoVBIgfirHjC9RXCaehW3lbg
	If2eIrPkM/YmfMW7ik2DlQ5TlQBg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbt-0005Ct-SW; Sat, 06 Jun 2026 22:27:14 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbl-006V18-4d;
	Sat, 06 Jun 2026 22:27:05 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/ipv6/ip6_vti: Use strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:23 +0100
Message-Id: <20260606202633.5018-29-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

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

 net/ipv6/ip6_vti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4dd6..c6cb756a1091 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -186,7 +186,7 @@ static int vti6_tnl_create2(struct net_device *dev)
 	if (err < 0)
 		goto out;
 
-	strcpy(t->parms.name, dev->name);
+	strscpy(t->parms.name, dev->name);
 
 	vti6_tnl_link(ip6n, t);
 
@@ -1161,7 +1161,7 @@ static int __net_init vti6_init_net(struct net *net)
 
 	t = netdev_priv(ip6n->fb_tnl_dev);
 
-	strcpy(t->parms.name, ip6n->fb_tnl_dev->name);
+	strscpy(t->parms.name, ip6n->fb_tnl_dev->name);
 	return 0;
 
 err_register:
-- 
2.39.5

