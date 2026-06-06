Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD023BBFB0;
	Sat,  6 Jun 2026 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777642; cv=none; b=HBjwlCd4faMx/BPBmol8x+SFsIvAFkF8XTHufQ0GrghRIHYt/e8G2LxNWeFIjm3WkiDy5FI22Xizuqw6EWtXWjInUOlsYTEPgboq0mxoXr/4jhPgw/Dk8OI6f+4nbAV1IwFMA80dHa2GY74HiIvfof1pEmn6qEciIzgOtA65JUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777642; c=relaxed/simple;
	bh=2lhj5uM0KW4nqskZlNGldFlLJvvQSvpMeEDAXEyAZkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HSNC/SlRAoG51s6ifgjsEPzElB2m+R0ZdV3ill318SC4QcRgBaXzMSv4KnEuFoO4L2cbibxtRbFNajfaH4dz4xFCjWIwJFzGzExEikxMXj+wP07VbCfvqKhEu1inVFaQiooXYanhdHPU8eNKb2h4CrlgD2aL0AdFURzHv+R7ygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=OkNPSnU/; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="OkNPSnU/"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbx-007cIm-Mj; Sat, 06 Jun 2026 22:27:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=yyP8NAoYAttd3SQNxO8atzKfruOiB151NPRC2c56daA=; b=OkNPSn
	U/cYCt9K9SaJ86wPixlltHKtQYrSHXTC1klis+3pIXr5x0n91gkEswsY/CPGZ5jVyLECltYp1khx9
	b9U9nOKWVZNyZizj0uILJdR+ZAjy8Ry2kyNqYZDV6IVAXmnrSj4OCoZYPHPLJrboo2a0gTkRHM9bL
	0/2YKgtiLy3jWcQRoVjNJAZoBgEpbG1yXzGH92UkqJQw8xa1fbUY5Ak4MCdNJjw+9lyAX3/O8kkEX
	sQixnpkTLm3fbBqZTN9yiU0Or/hbpVFkVsrpH3TXFxMHIb8MXguB9Va4IEK4G+3vEWN17HZUuF3Yc
	ilsrMhGaVz7Nm7YlvDZV+IyOdnAA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbx-0005Dg-6L; Sat, 06 Jun 2026 22:27:17 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbm-006V18-1m;
	Sat, 06 Jun 2026 22:27:06 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/parport/probe: Use kstrdup() instead of kmalloc() and strcpy()
Date: Sat,  6 Jun 2026 21:26:25 +0100
Message-Id: <20260606202633.5018-31-david.laight.linux@gmail.com>
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

 drivers/parport/probe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/parport/probe.c b/drivers/parport/probe.c
index 5d1b9aacb130..bf9d81c0abaf 100644
--- a/drivers/parport/probe.c
+++ b/drivers/parport/probe.c
@@ -52,7 +52,7 @@ static void pretty_print(struct parport *port, int device)
 
 static void parse_data(struct parport *port, int device, char *str)
 {
-	char *txt = kmalloc(strlen(str)+1, GFP_KERNEL);
+	char *txt = kstrdup(str, GFP_KERNEL);
 	char *p = txt, *q;
 	int guessed_class = PARPORT_CLASS_UNSPEC;
 	struct parport_device_info *info = &port->probe_info[device + 1];
@@ -61,7 +61,6 @@ static void parse_data(struct parport *port, int device, char *str)
 		pr_warn("%s probe: memory squeeze\n", port->name);
 		return;
 	}
-	strcpy(txt, str);
 	while (p) {
 		char *sep;
 		q = strchr(p, ';');
-- 
2.39.5

