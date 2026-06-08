Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C83B4E94;
	Mon,  8 Jun 2026 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912534; cv=none; b=ZU5+Re1Dl3qHv0IWN1F4zchZgxRDOpwC82jnzJ0eS/DF12eQXVsyJjuFEBWYBs1gMyzdC0QZpkwo1X0V+PjSUZSAwf7a9Zje5QVoD49QQALF9GCo9axrYKBXzc4gScHj0axsZ8IZVL7vW003UEwQiWfFj9aUxMKqvuhNafwmP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912534; c=relaxed/simple;
	bh=kjgzlGkCqp1NC5w51WcCRLvPiI8hJDKE74lYbf8SGl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b7bZaeHANXSY1dhhcOFUOQLiOoMFIkc8CCSRVtm/y34MBPxYjUI/M+RcUKgPN3StaqWejhnCdqgkQFMqlT1js0E62DJwxaWVXAurEbt1V15WA0G0Vrz/tSd6P6Z7RTzQhhxOhuR6WUXWqq4WxS6YIBOH+0t5YhnDaflJOzAi6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=tX4WCsF6; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="tX4WCsF6"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWha-00Br5E-Sh; Mon, 08 Jun 2026 11:55:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=ph85ZDRTWov53bumdN4BhGhFsj9VkRRexE10g5yL/6o=; b=tX4WCs
	F66HH9Bh7fiprOEtpdwojmDpEB9IBYKVPLZaJ5xMKldw73K3oeFov+5ggDN30O3e3ZGHfzNBaO/ca
	vkRrpOaFLZ0cH3APoGF7q6xpsQyHtnWLt9yRTYWKFRu61ErDi52RcBJs6H2j6ugvQp++iBYnwCBnM
	OUlUFU7y07RJJYNNa9ubJ6AWtbqSPzYktH/do4lC8Y7lRpm6Cb4h+6tQOnX+RLPgz3OjL8c58YQl+
	dsd6gwjP+2pMjw0dYQZM2VCuV0cGYUiQh437xgcSKzaSWJ281/yVj/AQYUkKfnomt0vx+fC/0tbf9
	Yt6HhJubm2xflL3ACP38CLi51tcg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhQ-0003ZK-7j; Mon, 08 Jun 2026 11:55:16 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhG-00Afz8-0J;
	Mon, 08 Jun 2026 11:55:06 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/emulex/benet: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:59 +0100
Message-Id: <20260608095500.2567-4-david.laight.linux@gmail.com>
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

 drivers/net/ethernet/emulex/benet/be_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index eab81e073e1e..230c91559322 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -2508,7 +2508,7 @@ int lancer_cmd_read_object(struct be_adapter *adapter, struct be_dma_mem *cmd,
 
 	req->desired_read_len = cpu_to_le32(data_size);
 	req->read_offset = cpu_to_le32(data_offset);
-	strcpy(req->object_name, obj_name);
+	strscpy(req->object_name, obj_name);
 	req->descriptor_count = cpu_to_le32(1);
 	req->buf_len = cpu_to_le32(data_size);
 	req->addr_low = cpu_to_le32((cmd->dma & 0xFFFFFFFF));
-- 
2.39.5

