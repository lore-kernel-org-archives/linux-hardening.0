Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9043C1F57;
	Sat,  6 Jun 2026 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777647; cv=none; b=CBq9wQ5dN+z7rHGj8oEb+jMQjVuVh0VAQFMcjgS488eBrL36knnbKRTayyo6KLAZOqZOE8DSVKoMUJfnIJLqWORZV8QUv67PHfPaevdEfn8tqD2ggkCXm8H2e36noyszq7MOkdzGyTjcMB7AWDgBKcvVZSh2d3RI5oKzWiIW9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777647; c=relaxed/simple;
	bh=2fsk2za3j7BCpxRkGcfmii50BuoW7tHDyeFyfkxhoZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OBCyU7GpZHPJIr85wf/8Mpliw3Sr5BTpSbg3S/0AkGX7LzY+5C8vpZmcLDQ87f6AVt4SgtO78zDtlnmuxG7g6zxkJUB4dyyhMrrsYeTazg5JKI/IRDoEWBsLq6TBhMUA5Cku3TeUeTyTiMsPzr/8LQ1UaAOMsxI1vI8/3gCfUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=mchOOM7A; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="mchOOM7A"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbu-007NR3-57; Sat, 06 Jun 2026 22:27:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=meVKVuvbuLoiOIYokwUI0qVk2UW2KhPhUL6Bj3liMXY=; b=mchOOM
	7APt0CN9usyw4WmW8r9ArRfmvdvijSFMtcL5qw9/4bsgHSeNeC8BzAWcO5dPtHYWtiXTF/UBpt5hO
	A+zMaDqMG/LMKoQS74tTm2NirMW6KxyHdPS37gEi62GdKbBAeJjSxHyPbA1dww2XYSmaazRpFO84+
	VBt6rqhTBPZNglFdSpt5nvMvnJmVJJsLEFmENBiUNPBCWEpXsIjmy+wmXJhS7ieSyVG9eJsEvfZct
	bLtnQdzFOqBwX6mYImLPN4jtEsDYPCEFiUOZVQ5uduatVVIrJXFb8T5R9qBW4gA0L+rkzSggnjNZ5
	0wqk6XGac6xuP23XPoJIB13l50nw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbt-0000tm-9a; Sat, 06 Jun 2026 22:27:13 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbe-006V18-LF;
	Sat, 06 Jun 2026 22:26:58 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/bonding: User strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:08 +0100
Message-Id: <20260606202633.5018-14-david.laight.linux@gmail.com>
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

 drivers/net/bonding/bond_options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 7380cc4ee75a..c57b7d6af043 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1525,7 +1525,7 @@ static int bond_option_primary_set(struct bonding *bond,
 		if (strncmp(slave->dev->name, primary, IFNAMSIZ) == 0) {
 			slave_dbg(bond->dev, slave->dev, "Setting as primary slave\n");
 			rcu_assign_pointer(bond->primary_slave, slave);
-			strcpy(bond->params.primary, slave->dev->name);
+			strscpy(bond->params.primary, slave->dev->name);
 			bond->force_primary = true;
 			bond_select_active_slave(bond);
 			goto out;
-- 
2.39.5

