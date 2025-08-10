Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127038DD3
	for <linux-hardening@vger.kernel.org>; Sun, 10 Aug 2025 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754862840; cv=none; b=rT0gWISzbZHy4B+kEIGa9tWA4cQwrJsjouIEIvS7rmb+JA98ALNuUX0+Exb2Sy1hT5kvgTFFol9fYaFXfo7HPqwyv1HuU36InLaA5c6JEr1PlC8pM2bIV9vrGIfRYOad8FXmfCAzdS5oVYsAS35Gba5D0PU1wc25e1InuY2XGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754862840; c=relaxed/simple;
	bh=vSsSMn/9fqoTxHujBDUpBLFjebEiHOOZRkvaVIYfVn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/7cwIIrapKoKC5LljRoO3tDb/ElpFfv43bjkinuHDE+tq3KzGWpTiN5tTBBHJw4TmuGRym1+COLM2241J0EyOfYJxYIgbAKrhGWdj+aYqy4ZnGo2zBfQzSsyaVzszoWBv4P2TtMCo8W9pfRcIicI2/EGNvb1ykkJW+qXxddygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O9d+Ajgz; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O9d+Ajgz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754862835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EV2BWPFCHA/5r+SQ5/78lZ/eRjTiq2HMm+8pHdqqWPc=;
	b=O9d+AjgzxdqIL094+cWBPrSdagjbrk3RJCGN6XJ63TFuhFxdM3+9N/nY3R3eAexVxOTR/W
	oOfykWWqm+IbRMffpSHCkDdTyYOp9BS9vdzn/il4pUZCH0XCN5QYK1Qo3laKiltuOn4Yha
	iU6u0mYWDSKmmeRlcYAxSpRlC+ihAFw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Bluetooth: Annotate struct hci_drv_rp_read_info with __counted_by_le()
Date: Sun, 10 Aug 2025 23:53:20 +0200
Message-ID: <20250810215319.2629-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by_le() compiler attribute to the flexible array
member 'supported_commands' to improve access bounds-checking via
CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/net/bluetooth/hci_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_drv.h b/include/net/bluetooth/hci_drv.h
index 2f01c44f05ec..3fd6fdbdb02e 100644
--- a/include/net/bluetooth/hci_drv.h
+++ b/include/net/bluetooth/hci_drv.h
@@ -47,7 +47,7 @@ struct hci_drv_ev_cmd_complete {
 struct hci_drv_rp_read_info {
 	__u8	driver_name[HCI_DRV_MAX_DRIVER_NAME_LENGTH];
 	__le16	num_supported_commands;
-	__le16	supported_commands[];
+	__le16	supported_commands[] __counted_by_le(num_supported_commands);
 } __packed;
 
 /* Driver specific OGF (Opcode Group Field)
-- 
2.50.1

