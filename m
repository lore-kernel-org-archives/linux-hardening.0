Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9609D2877DA;
	Mon,  8 Jun 2026 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912529; cv=none; b=Y0UqXvaH3VLOcOYOFaKAFdEhVDooss1/DA2SLXRbHi8mMvgvwqmIv7EMbQm+EQ54FyeloyR+xz2+zuqAmqisilTexVX80XGK+jGfXXM+fFfIDd8YUXu+x/3urslIaQcHuHhkpwu6SUlA31bGd7TE7GFVHI8es7c6hlEjSCb1vjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912529; c=relaxed/simple;
	bh=l7qkO4YHz63BgAmYUiBcUsVgD7VmEwUqJTug9PGmbgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iv5gB8eTQJRKaYsc51z1BAWx5O2JBsxq9tx2zvh2zGLpS3Iur2QQnF8goisStzqvM68zqgx4zE3hD1egJXiaNIfcZeoA90nyhoL7JGAquDAfPVX8M9TMVzm7Hm/EV+VTHJFOLcJldSK/3bPwaI+KwGgascTb0+BLD+d5sY6opMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=S4ch9nmN; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="S4ch9nmN"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhS-00BRuF-0E; Mon, 08 Jun 2026 11:55:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=dvVQtq6KmzTF2DSPmceFBElb1g/eXFZc7duQz7yINc4=; b=S4ch9n
	mN82TLI48npOG95U+9sDywV9FBPTkUkEH33/D3/2YWCdF1sV8y+7hUAnZF6Kt3KxK9c7iF9QVdDE1
	TZNHOlWe4ve3x1b9RXOqmPSf4wt0wm8s3YMpUGjz5RTQ3T3BosxUKOitkinsvXUJ3NWMbaHyJ+M1O
	ncVkEzD0f8TgiQgnGrADDw8lgOaPT70NgXdFRRiLmhoNQLOy9hkHDaJTN9w/nKQmFufOlmFGctz4+
	f1qGlPRbTz/u5A4Ev+/fH0Hxkc2wsUQe2bB05b8V+uw+b81hl2P0v5E/4IbTPk59FJI/V/tLauIQH
	FbW6c39U4MHQL2ZiwMnNih1D06mQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhR-0000C7-Dm; Mon, 08 Jun 2026 11:55:17 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhF-00Afz8-Fp;
	Mon, 08 Jun 2026 11:55:05 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/mtd/ubi/build: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:58 +0100
Message-Id: <20260608095500.2567-3-david.laight.linux@gmail.com>
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

 drivers/mtd/ubi/build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 674ad87809df..e7097d85035c 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1497,7 +1497,7 @@ static int ubi_mtd_param_parse(const char *val, const struct kernel_param *kp)
 		return 0;
 	}
 
-	strcpy(buf, val);
+	strscpy(buf, val);
 
 	/* Get rid of the final newline */
 	if (buf[len - 1] == '\n')
@@ -1512,7 +1512,7 @@ static int ubi_mtd_param_parse(const char *val, const struct kernel_param *kp)
 	}
 
 	p = &mtd_dev_param[mtd_devs];
-	strcpy(&p->name[0], tokens[0]);
+	strscpy(p->name, tokens[0]);
 
 	token = tokens[1];
 	if (token) {
-- 
2.39.5

