Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E7E3D301D
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912560; cv=none; b=HrhXqvXLcQqHJtLSs5/wsr8pjwMUqADRNeD+69cioM+ZQZGpcxc51ofBYrM8gMnkDEV/ZB1uds8sitdV5r0vNo1yqCYJNIm4xLMkst6/qOr6+EoZ3Nl4J9+H0VhTKThHuSuZ43ksozJiZy7DUiUuUssNPVK+Av2GOEdjJ3LRGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912560; c=relaxed/simple;
	bh=rRMG2vuq12hFBjsTJqEu7ppDeFJeqY/J0McyArkok+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OmnRpvWVJvQdn0bYTquSPkG+nj4xIa9ZwyU3fWz/GY5ZYvYvWOPMEQmkWcglH+O2lx7+ERPWq+BSsDN47MuCARAcvgDXvaVoDxdzHJXaf35pLWmE1anXq+1woX4lecDxeSXfV5nFaobckGg3JxHbkRS+JqFwYMW/9vmaV8mExaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=XJEdA+6B; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="XJEdA+6B"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWi4-00BrHj-9q; Mon, 08 Jun 2026 11:55:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=OQIEcgVq7NOd4JbQ00khnJw1hkKI1O/HpLwNwh7rtvM=; b=XJEdA+
	6BTl+Rv46D1xxPAR4/IVtdeWdl4DyeOoBiIQPraGm74ifHPlcrt7uCWYbnSG2gi9u0CdMgLLkJan7
	4qSlrtiixwRQo5qUeeIxf7XvcuHojxIBTDzRUnwvGaVwl72bjHjbXKow567NrVs3un5CTXpMP5Jxb
	IYxI+J0F5JxPJOP3zw2Kx09quCIbRZyxufwNW14i8DoSvYH1zNhQbgInd7wkME6yUMcT2kAHeAeKv
	p+Zn1CbvKP7U9A8PdiaqnummDad4aOeyd8vxucZpp1r+/JjawDHixGDvmXuzfaHqZd7CV1Ts3XWDU
	F+i1MBF/n0LvZRCyqdNVkEAHUKNg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWi4-0000L2-1u; Mon, 08 Jun 2026 11:55:56 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhl-00Ag6G-JZ;
	Mon, 08 Jun 2026 11:55:37 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Timur Tabi <timur@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/qualcomm/emac: Use strscpy() to copy the ethtool strings
Date: Mon,  8 Jun 2026 10:55:14 +0100
Message-Id: <20260608095523.2606-30-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

While the string is short it is still best to use strscpy()
with length ETH_GSTRING_LEN.
Should still get optimised to a memcpy().

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

 drivers/net/ethernet/qualcomm/emac/emac-ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
index f502db9cdea9..ffc300641aac 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
@@ -95,7 +95,7 @@ static void emac_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_PRIV_FLAGS:
-		strcpy(data, "single-pause-mode");
+		strscpy(data, "single-pause-mode", ETH_GSTRING_LEN);
 		break;
 
 	case ETH_SS_STATS:
-- 
2.39.5

