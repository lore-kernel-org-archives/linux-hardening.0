Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2733B7B79
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912553; cv=none; b=OADUkob5ryA+YSdeql2WcLP8uXOFxrtBEdLLQIDYtcNUhajKNSdHTbUx83ZBrqZ5PKirphj7RTqQuTptgpEFQy3DkZOOZVSHc6MGavEXmZdLBuL4r5+kSlqig6jKlUtpk6bJ9E1N7nu8t9GQrCcf9pEOm3KockHZruJUyv0NIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912553; c=relaxed/simple;
	bh=QlrQ13G1F+9lpww8xM2frYtOZX9mBavar61JPcy7UPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JvzNyhjbaQDFTfBDULQPiIfGk12UjF/mYDqXsroagjIrX6XBm1qUQCeMMxE6HYh9Fpn3U37v6ywHZao2fi+cmW8cg4eF5rce8jqfAb+wCI6hr8G1hmWsoNcjSE+e1+lb1lOnlORNsgtdbFlX73cFklgnEjDwqGvN8MmiNihAzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=MXhfe5S5; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="MXhfe5S5"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhl-00Br6i-3m; Mon, 08 Jun 2026 11:55:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=LnMoB6A6dgjGgkHuIJdEdxIA2fNB7EBR/8I4VOjpr+Y=; b=MXhfe5
	S59A2zvUvNAIGVk9gqgTUO9ROsBZBOe3jfm0RAGg7bg1CzAJ79Lqdo4H8efF78EdGsksAR4ND/l8F
	WGlDyzdR6kFxfDTuHqjRzrx6qyRQpg62Se4UB2MK4lOLENWBjPmAQplg59tPqm00wlo3H9J/IZLqT
	qaGwsdra5cr0dotjaCDu4V9fYMj8d5KgcY1W8yzJ3tO8cV91fudYy4rl+afwi6+7YSG1mjczDxJEs
	/BpVJRYsQYEoLz8hvOHkeSO3pfl9SfYYTNATYAT4BgIBeM/J8VNwe4Kikp9aaX+XZ38ZD/eVx7La/
	/htDpfyiCzQzRMoBJsoS5l4qrPQA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhk-0003aq-GU; Mon, 08 Jun 2026 11:55:36 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhh-00Ag6G-WA;
	Mon, 08 Jun 2026 11:55:34 +0200
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
Subject: [PATCH next] drivers/mtd/ubi/block: Replace strcpy() with strscpy()
Date: Mon,  8 Jun 2026 10:55:05 +0100
Message-Id: <20260608095523.2606-21-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Use the result of the strscpy() that copies the parameter block
to save an extra strnlen() call

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

 drivers/mtd/ubi/block.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 8880a783c3bc..be9655b4a9e9 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -96,7 +96,7 @@ static int __init ubiblock_set_param(const char *val,
 				     const struct kernel_param *kp)
 {
 	int i, ret;
-	size_t len;
+	ssize_t len;
 	struct ubiblock_param *param;
 	char buf[UBIBLOCK_PARAM_LEN];
 	char *pbuf = &buf[0];
@@ -105,20 +105,18 @@ static int __init ubiblock_set_param(const char *val,
 	if (!val)
 		return -EINVAL;
 
-	len = strnlen(val, UBIBLOCK_PARAM_LEN);
+	len = strscpy(buf, val);
 	if (len == 0) {
 		pr_warn("UBI: block: empty 'block=' parameter - ignored\n");
 		return 0;
 	}
 
-	if (len == UBIBLOCK_PARAM_LEN) {
+	if (len < 0) {
 		pr_err("UBI: block: parameter \"%s\" is too long, max. is %d\n",
 		       val, UBIBLOCK_PARAM_LEN);
 		return -EINVAL;
 	}
 
-	strcpy(buf, val);
-
 	/* Get rid of the final newline */
 	if (buf[len - 1] == '\n')
 		buf[len - 1] = '\0';
@@ -137,12 +135,12 @@ static int __init ubiblock_set_param(const char *val,
 		ret = kstrtoint(tokens[1], 10, &param->vol_id);
 		if (ret < 0) {
 			param->vol_id = -1;
-			strcpy(param->name, tokens[1]);
+			strscpy(param->name, tokens[1]);
 		}
 
 	} else {
 		/* One parameter: must be device path */
-		strcpy(param->name, tokens[0]);
+		strscpy(param->name, tokens[0]);
 		param->ubi_num = -1;
 		param->vol_id = -1;
 	}
-- 
2.39.5

