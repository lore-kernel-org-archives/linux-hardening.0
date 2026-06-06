Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3983C2795
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777645; cv=none; b=DJTr6LFXXzm3oixCckAdV/3p9Q32C7gF6swb3nJj5LbPGZT86aaiq/LeRRFFU9XRJxtLQlNI4sZZzojpqcMylamW0W/AttbKaSzpU6tyt4VVQE6wkDC1hqhnr+/4neg9EPuOeOItvdMj6h0s5kU2jjCQykRIZW25jjl2U2M62Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777645; c=relaxed/simple;
	bh=SxzaNOPuRKvYNLVHaRZrGNPTvEna/tHYJItD78azQwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OMQ7wPM3cQx3Lgl2V6IV9qNENQK6bgFG77Z1hC+J8kPkzEmVkhnYWv3FRkhCw05Xta6qMFb/3V98ASzDqBtnRq/kyRvxrlLVSsbNaOIh4Nxc8hT72tB7yUzp4tnz7Hn9cMjGUvA/IlGVl5uVhY5jMwfFAphbUTdMyHwxFPj55Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=mjpZOoiP; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="mjpZOoiP"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbu-007cHD-U2; Sat, 06 Jun 2026 22:27:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=7lP0V/PmqS5w6KerRWcqIcU3V9iQKo1pwTjde744MY0=; b=mjpZOo
	iP4VjIuMbdQttdGmJCASaz05iyq0vYuvV/KCnS9a1/jEitNkyg/MfEuL1WcRBdyMGjJOXTZDzvGq6
	Y0NiVxxDcVJDy5N17xcPqY5RCmsMFNDFWpANMy8nCRXf9hO3oiXAygd4SH4uWv7AEV9IFAZ3qUPWK
	OKvCiMdiy1zkpXv5fe6Vxz4eHBDfgoqsKO9MgzyvhfYBNDj7mXy9JbQh7gKARO8wKEhbmcY+VqL0C
	AWs7g2WfwwNp1psKRlcxt9YRa+nlEYR3gOz/Ru6I9mHoU9yLAHgTTIbWPF/AgLd6RxcPpqhUbhFZf
	A616nkvHkx2Mup5sOwdbb+62yecQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbu-0000ty-JJ; Sat, 06 Jun 2026 22:27:14 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbg-006V18-Vp;
	Sat, 06 Jun 2026 22:27:01 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/sfc/falcon/efx: User strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:13 +0100
Message-Id: <20260606202633.5018-19-david.laight.linux@gmail.com>
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

 drivers/net/ethernet/sfc/falcon/efx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 0c197b448645..28ae767432f9 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -2212,7 +2212,7 @@ static const struct net_device_ops ef4_netdev_ops = {
 
 static void ef4_update_name(struct ef4_nic *efx)
 {
-	strcpy(efx->name, efx->net_dev->name);
+	strscpy(efx->name, efx->net_dev->name);
 	ef4_mtd_rename(efx);
 	ef4_set_channel_names(efx);
 }
-- 
2.39.5

