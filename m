Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16903B14A7
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912559; cv=none; b=noxYO4Q28V9ODdPsyV1gv/eSusUEZy4Th78dGjOPPaT1tSqCjYs15r9fkqIoOUwoaL1rQoI8FGo7IoROabg/JQxWW9/Ey9MrC+f+3HpTAapbkbiR8+uYKqPuKE6wofGngL1JZQ4khzw/1dx+LiAMZFY/khg++Cur/34rcq4dUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912559; c=relaxed/simple;
	bh=OXO4UafoEZ2Ih/xTeDrXTGvLO6KwKeF//NSwpSGd72k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4F6EkDJFRlEJYkmss318Ar1+0PhJcaI2x6I3361Vcib5o9nrxNw9VpxXK8u2Oeai7FschmcM+4lYuv9PXDt33/S3lEDJqt/Zz0nT/z4Q3mkuxAhN9TuLvBuvg3XrBlCNaipTjGv38zZdANKcEMioWd41lUI1TGow0OINHs2gnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=wahpY+s1; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="wahpY+s1"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWi4-00BrHf-4h
	for linux-hardening@vger.kernel.org; Mon, 08 Jun 2026 11:55:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=KRH0dd36shh1MPhsp/d388hfE9J1buYPGuD5qWYVUF4=; b=wahpY+
	s1Gq5qLALUlLCyUO4kfihM6Fq/im0hyR6Es0gnaXbJyaNdjxgDZerNvyJvGcvEgDPpWZSmjIM29az
	z16Jz7mRahF7+VIZx/Sz/EhiAU16/VvVOXxHwzMcI3LcuUhrt1bnmR69xf++yGYN5oV509wSTvtPt
	BZZHmZEHiLLCj54csCVYwC+R6SSuLVfwRh2AlLo2YvyuBZ/lKouiMpnwWZMblJJIKMsDZxZEqUJcy
	QiTLoB82FN//snM0qvOI+VHMd8uFMIJ+aQlSFv7RwrEge6IVrW0yG7+OdkPnMZ3+aP7B1mgw7Veu4
	3BwnEHHq0A/OwBJxcYABM1ppy/hw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWi3-0003ik-RG; Mon, 08 Jun 2026 11:55:55 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhl-00Ag6G-3d;
	Mon, 08 Jun 2026 11:55:37 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/qlogic/netxen: Change netxen_nic_get_brd_name_by_type() return the name
Date: Mon,  8 Jun 2026 10:55:13 +0100
Message-Id: <20260608095523.2606-29-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Instead of copying the name into a caller supplied buffer just return the address.
Return NULL is not found and change the caller to "Unknown" for brn_name
as well as serial_num.

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

 .../net/ethernet/qlogic/netxen/netxen_nic.h    | 18 +++++-------------
 .../ethernet/qlogic/netxen/netxen_nic_main.c   |  8 +++++---
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic.h b/drivers/net/ethernet/qlogic/netxen/netxen_nic.h
index 3d36d23df0c6..7c772008f93a 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic.h
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic.h
@@ -1833,23 +1833,15 @@ static const struct netxen_brdinfo netxen_boards[] = {
 
 #define NUM_SUPPORTED_BOARDS ARRAY_SIZE(netxen_boards)
 
-static inline int netxen_nic_get_brd_name_by_type(u32 type, char *name)
+static inline const char *netxen_nic_get_brd_name_by_type(u32 type)
 {
-	int i, found = 0;
+	int i;
 	for (i = 0; i < NUM_SUPPORTED_BOARDS; ++i) {
-		if (netxen_boards[i].brdtype == type) {
-			strcpy(name, netxen_boards[i].short_name);
-			found = 1;
-			break;
-		}
+		if (netxen_boards[i].brdtype == type)
+			return netxen_boards[i].short_name;
 	}
 
-	if (!found) {
-		strcpy(name, "Unknown");
-		return -EINVAL;
-	}
-
-	return 0;
+	return NULL;
 }
 
 static inline u32 netxen_tx_avail(struct nx_host_tx_ring *tx_ring)
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index 5ee2bd9d6886..969fb1b7da0d 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -812,7 +812,7 @@ static void
 netxen_check_options(struct netxen_adapter *adapter)
 {
 	u32 fw_major, fw_minor, fw_build, prev_fw_version;
-	char brd_name[NETXEN_MAX_SHORT_NAME];
+	const char *brd_name;
 	char serial_num[32];
 	int i, offset, val, err;
 	__le32 *ptr32;
@@ -853,9 +853,11 @@ netxen_check_options(struct netxen_adapter *adapter)
 	}
 
 	if (adapter->portnum == 0) {
-		if (netxen_nic_get_brd_name_by_type(adapter->ahw.board_type,
-						    brd_name))
+		brd_name = netxen_nic_get_brd_name_by_type(adapter->ahw.board_type);
+		if (!brd_name) {
+			brd_name = "Unknown";
 			strcpy(serial_num, "Unknown");
+		}
 
 		pr_info("%s: %s Board S/N %s  Chip rev 0x%x\n",
 				module_name(THIS_MODULE),
-- 
2.39.5

