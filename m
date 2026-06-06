Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40593C3C0E;
	Sat,  6 Jun 2026 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777646; cv=none; b=gGPKkaucu25Lq0fdNWKRsWdxJ5y5VAQghaHj28cmyR/Mp35yJ/ST7PUuSUTTPLvIW1FXxHL59gARNmUy8AHsQIfYH35uY38HLr83GuM9OtsNrW8mWLihYkGjo/Ph7CNymuWGl6GQB6Nj51mWOoWLJhbgUfY5JLBiQ1C/0hyqavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777646; c=relaxed/simple;
	bh=1mFrbojz0PWOhUZtx3IzxM5Cw9QosOrwnDFFT7UZSQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GA9IfGLd0qjx8+1L3rGEfLjfmkMZj+UXXGzFx05YsRluy4eemuW0iAzIMj7IgELFiCfTc9UcRmfHU1WgHrEn8T66CVFdV5YqOuGxYilG8y3mGTRCVtPhVh0aA9RzVVIxxMiWpeNMabVe745KFI6N74b8yfJrNp71Vv5o14x5bZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=wijZ8IB/; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="wijZ8IB/"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxc1-007cKJ-2i; Sat, 06 Jun 2026 22:27:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=KhMKaOFxgwuQkIs6RKratwnTu2UWxE6iXhf6LBrZbME=; b=wijZ8I
	B/QKevvdt5kIs4TVg4CKUyWlfIY6hFuZoGTbwyBcRGJefE8nJXSzDZQnMHDT22na81QMzQdYStjzK
	++VhngaY9Y6RiQBpuxY5YSguSYB/Vsb5Cg35GjG00PPy/yxfQSDZ7uaRmK3mt5CGWxh585FcF5QyF
	j3eDufEe6oBZAdYJLmQzQSBof+PJiUvhteccBci/F1/MUAxF+IueUqX3LXMR53NyOG6pXpx1nyZht
	X7TXKgdYB28krBnMMlOGJHdw2dSNYM4bjfaQ+I3c2EPKSFpKBOTotX1Wgv5u8YrsKoOTIyKkeVLXy
	tNxywe0G8/cTyOuI0mNxbqsCkAwA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbv-0005DL-J6; Sat, 06 Jun 2026 22:27:15 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbk-006V18-65;
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
Subject: [PATCH net-next] net/ipv4/ipconfig: Use strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:21 +0100
Message-Id: <20260606202633.5018-27-david.laight.linux@gmail.com>
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

 net/ipv4/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index a35ffedacc7c..ec60e201ebe7 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -371,7 +371,7 @@ static int __init ic_setup_if(void)
 	int err;
 
 	memset(&ir, 0, sizeof(ir));
-	strcpy(ir.ifr_ifrn.ifrn_name, ic_dev->dev->name);
+	strscpy(ir.ifr_ifrn.ifrn_name, ic_dev->dev->name);
 	set_sockaddr(sin, ic_myaddr, 0);
 	if ((err = devinet_ioctl(&init_net, SIOCSIFADDR, &ir)) < 0) {
 		pr_err("IP-Config: Unable to set interface address (%d)\n",
-- 
2.39.5

