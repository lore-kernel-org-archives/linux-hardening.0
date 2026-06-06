Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F863B42C9;
	Sat,  6 Jun 2026 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777639; cv=none; b=mtzSjYeBJEqSe5mJq3RPkxC57VCGNxSJ8tzculTxd/JG7IzWYv2QgyQWdY1zdHEqwjjHiPVdC6GmLEDOohL+eoLohljcp59feaIf80u9Zt9Jlwuqezb9uNoVOicaOrcm0PQ2+JA/jTpgkrZ4a8CilTMHxA6RChTKUvyW5G228ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777639; c=relaxed/simple;
	bh=0twlcszx7ogrNsWsnN02kbWG9yvakgO2k234lQOOZLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aodT40zRW3Z0WHnehkR6gGGlo8SkyJEpOKYVT1CyGBtYIEWwImDZcNRn9m4uu8+8bCq9dmgMt8PPR7FKG26IKzt3kzXcreSGYa5cAkd54CLQ40htHSbGDTlgPavGQlVAdtJtpgknnsitbp1cXson7ABNvZRkR4SyMo2VO5av0C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ZrlJpXYD; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ZrlJpXYD"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbu-007cGj-38; Sat, 06 Jun 2026 22:27:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=KF1A9NgBM6yZdUL823mcD9+1iNU7rUmfqew4EMb2Ag0=; b=ZrlJpX
	YD2CDK+HeGVrsrhkqsn0i63v7w11AJv2i/8lQ67iYGvL9JaFMcZ3utITN79Y5jzOuBdEV2TCBwWIk
	3o6WMJVoAlun609PykG/M6MNKdTk/4vfra8aicCbm8HqRwUY0ZtWNHXTWuMeDfPFNZtzvhIUIXsWC
	MUs+7CFs5rCd7M2Sm2xHeRGj2wWxjZqrayD1UJauNIh/ECAepY9vn7aUH+/aY+6nc88UPfjmZoAP+
	uTx11mx0JihCQTv5uqqeBOGQYFydx0mGmCcLRJ9T8cHNdRETCJ5nfkshtvmJ0P+KjmPfxv+nm7cTg
	yuCpCI0CmzkVzFE3svbrLH6kHSaQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbt-0005Cp-Ea; Sat, 06 Jun 2026 22:27:13 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbe-006V18-6l;
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
Date: Sat,  6 Jun 2026 21:26:07 +0100
Message-Id: <20260606202633.5018-13-david.laight.linux@gmail.com>
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

 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index af82a3df2c5d..76ca61cad875 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1792,7 +1792,7 @@ static void bond_fill_ifbond(struct bonding *bond, struct ifbond *info)
 
 static void bond_fill_ifslave(struct slave *slave, struct ifslave *info)
 {
-	strcpy(info->slave_name, slave->dev->name);
+	strscpy(info->slave_name, slave->dev->name);
 	info->link = slave->link;
 	info->state = bond_slave_state(slave);
 	info->link_failure_count = slave->link_failure_count;
-- 
2.39.5

