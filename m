Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70AA3C3447;
	Sat,  6 Jun 2026 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777641; cv=none; b=KdQspTudtD4wp9RqfjApk9FaJJ0oEVyoLuPSKzj7+qGBezym6UtuHyDJtjTQO6ylvwjSfULkFbOWBSwNiQ9bBmsokk43z9TEreJb2Pl2HV/HSUktlJYyJFbRGXUUExD50E8Js6ssXqfGSeDa9PJ4rtKU2c4hHTF0tG4yXlSv2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777641; c=relaxed/simple;
	bh=y2X1gNswKEzSmApgXEj1FeFkaEdnKF12GQz21LIbrug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MaRogC++dt3egJASVauZisBXJRJNUdu3/dsOxOnEnk5Auf7yiOY9Msfm4IudE1uIMPLrtp27XiTBs2mu+TupL9mBBwyAWWcQzPjzIe6b/hWCD6yxCmadD7TfF63aNQOZENs3L5wMe2S69ERirvEwc8dKLO55xiqwS1yc5d+4eXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ajDzZqq3; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ajDzZqq3"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbv-007NRk-U9; Sat, 06 Jun 2026 22:27:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=JyrZqO9It/HCXM7dfc0BLtmlywS5NxkYhDYmy8grXss=; b=ajDzZq
	q3uLMCeAri9S79cNHSq6S686OYVI+u7E35HGgACobklYh5IaA8pCHdcNZiVjI+lO69A4V3hsZ0GB0
	UwLzuL0wDm6fYpnkwlBhiRcmwRTzWgpLdnNayvvLxnBEeSAoh0M4OZ5as2+duXkjKQXpEZMT57hig
	4ALUpHQAHzrWD2UAr+PiL3qJC8MIz9bJcB2Sj3bxYIHi4ihhF6BF5RNasDIARf3pAsrkWE2sBLYPK
	I4pv2ZobltLXYq/Yqczb+RVdUcH9PL1UVB/wtkYl3h9x0omt/FrHUInBBo/QwiGuAHGquIRL8ORHf
	cnZqot/ZFbRvOtEARrjarbMXO13w==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbv-0005DH-D4; Sat, 06 Jun 2026 22:27:15 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbk-006V18-Km;
	Sat, 06 Jun 2026 22:27:04 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/ipv6/ip6_tunnel: Use strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:22 +0100
Message-Id: <20260606202633.5018-28-david.laight.linux@gmail.com>
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

 net/ipv6/ip6_tunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index c468c83af0f2..286944f6d923 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -261,7 +261,7 @@ static int ip6_tnl_create2(struct net_device *dev)
 	if (err < 0)
 		goto out;
 
-	strcpy(t->parms.name, dev->name);
+	strscpy(t->parms.name, dev->name);
 
 	ip6_tnl_link(ip6n, t);
 	return 0;
@@ -2345,7 +2345,7 @@ static int __net_init ip6_tnl_init_net(struct net *net)
 
 	t = netdev_priv(ip6n->fb_tnl_dev);
 
-	strcpy(t->parms.name, ip6n->fb_tnl_dev->name);
+	strscpy(t->parms.name, ip6n->fb_tnl_dev->name);
 	return 0;
 
 err_register:
-- 
2.39.5

