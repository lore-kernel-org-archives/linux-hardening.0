Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E93B7B8C;
	Mon,  8 Jun 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912551; cv=none; b=JhypXEcc8r3cSte8LtMImd8NTUudtNGmJtrA2DGbyRSOyoOM9php1upoKq/7sU+yi3x0RCbT+zcSO8iIoW7UwtmeX0CXz64dE34PqVooGr6+5qdIb4RjzrWpCSRmVaf9jl2wgUrWjfYeb6/4Jp4nW44rctvX+fJYD7dxxZYv0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912551; c=relaxed/simple;
	bh=kdpcD64Wt606sn4p4l0247CdH5ZRjcGdcHTwg28ZFJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aoxo4EbE4kbbioR1E+5IsrVL4nF4xNBYivxu3Np0uvx7cM2wKs9CSkd+y9BNWIKo9Cy7YR59Zm9LHoA2Doby4M2eIASibJb3mH0M4MyRZhqMALRhaegFdPvQBV72yjqrnV7bW90w13B28uJr24cEyZvfVuvvdxPLmtlrbSVqbLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ke69YIeT; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ke69YIeT"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhp-00BrAi-Br; Mon, 08 Jun 2026 11:55:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=LKq853q45XTjJr8Js5nMEClmJHAnc+sttA0kvETz1o0=; b=ke69YI
	eTX3OmgUOT/Gwj1MOew/9P04R1uNDXRao5A+637g9gsS/UDfDNe4v+oiOqFkj97sL8b5lHF70VCsx
	O7HpgPT2ZIRoE/lHujdSA9V4SZ8SaTRGeSeowDVTGsCOEBGjNQ/+ULpMxdjNGIUEvVsLhTclOXeT4
	udJgmw8iBSPEwr6TdRQ6hpPlbEA2jmEeVzKBtCijQWfAdr1lUkB8bi/5DDO8bWFlvPfkb0iMcaXvj
	NdEjSqa6LJM+sZs4HlUCu+PZgMP7ZV4GxI+JvTnkcn2Cx1UqUfMMCP+ad+craQ+JOpMBCXgLbYetv
	snfQVhMB7oNM/ed+sZOch5A3gdUg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWho-0000FS-UX; Mon, 08 Jun 2026 11:55:41 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWha-00Ag6G-8e;
	Mon, 08 Jun 2026 11:55:26 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/sfc/siena/ethtool_common: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:46 +0100
Message-Id: <20260608095523.2606-2-david.laight.linux@gmail.com>
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

 drivers/net/ethernet/sfc/siena/ethtool_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.c b/drivers/net/ethernet/sfc/siena/ethtool_common.c
index 76cbce2b9592..36b67a0fc912 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool_common.c
@@ -222,7 +222,7 @@ static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
 			snprintf(unit_str, sizeof(unit_str),
 				 unit_format, unit_id);
 		else
-			strcpy(unit_str, unit_format);
+			strscpy(unit_str, unit_format);
 		snprintf(test_str, sizeof(test_str), test_format, test_id);
 		snprintf(strings + test_index * ETH_GSTRING_LEN,
 			 ETH_GSTRING_LEN,
-- 
2.39.5

