Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436483AA507;
	Sat,  6 Jun 2026 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777680; cv=none; b=Sp6/fuE1D5LVNWMmf7ZKCz7scvjfWxRUh4pnoQJWANVxnt3EyIKipqLbZBRI09UXVtniDTIvRZz6xEyPH8TpQv5OS96FKqb00qzNjPvTJXO1VjjWdZBp1SOCm+YQ7zYST3Ldl9MS1Uam1/2TK8obyfkwnv4aex7t0UuLN3/2+Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777680; c=relaxed/simple;
	bh=UXuzxxCgyQ4c2natex5UqmAAgmQr+NKyxj/QCADg3Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nKu1E+owbx5vvSaIWJZs5r1IENFrki2DiRi+sNMGYbK5Fx17JZAoVvi7L7DnyygN4LgrvmWBmdHxkN09yqCHUSqhJRmD1E/PpW01//lU/e1qYWt1pxsmicYrWckra6NoQ+XQYBurZtnlGDB34pM43djoyINTVelKbfMAw8+SfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=IjHIrlXn; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="IjHIrlXn"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxcb-007cN3-F6; Sat, 06 Jun 2026 22:27:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=BqSj6sMMJtBKls1RZgnD1Em19FvNQq+nxXs2VMR7HV8=; b=IjHIrl
	XnoRoXcw9sXk0XizwbMyE0ZQeMZv4ohY60FUYhp5VkSFcJ+kD1V7GLPpviM+ss4nH0tjXD2M/My9H
	9xLEhY6Jp7VXULNQOyOTvn1r6pPRMQWJAz8gFiFnaagrtcplEMyoOQnhvM+Jmg6YJpH8reSgLY1C3
	9iECS6azYsDtQ7HQx30M1nDbqhU0E7EaneSdGeTfP4nTgkvnAn/6tmbzMg5xGX2YS/sIBlfjxzXvv
	1mdf+tLr+GJyqSN63DMYsJDVDAYkmnZirhv4JOfZJ3ir32mQqMqtBhMTrP6sEYU+2I5hyzOfVZMCi
	xaOvpnWsogZ386o2R4v2KQ76xShA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxca-0000vl-W5; Sat, 06 Jun 2026 22:27:57 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxcU-006elj-1q;
	Sat, 06 Jun 2026 22:27:50 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Joern Engel <joern@lazybastard.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/mtd/devices/phram: Replace strnlen() strcpy() pair with strscpy()
Date: Sat,  6 Jun 2026 21:27:40 +0100
Message-Id: <20260606202744.5113-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Use the result of strscpy() for the overflow check.

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

 drivers/mtd/devices/phram.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index b42cadcd76b1..7025d9bf5929 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -268,10 +268,8 @@ static int phram_setup(const char *val)
 	uint32_t rem;
 	int i, ret;
 
-	if (strnlen(val, sizeof(buf)) >= sizeof(buf))
+	if (strscpy(buf, val) < 0)
 		parse_err("parameter too long\n");
-
-	strcpy(str, val);
 	kill_final_newline(str);
 
 	for (i = 0; i < 4; i++)
-- 
2.39.5

