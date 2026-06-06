Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174BD3C4B64
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777688; cv=none; b=YOOxz6JxLgGUCDx4drJhKF294l8hb2KE61SPnxxHnZqeFnas3mLAIy9eWDQV9048u6ltG9CsxCTZ8E2PoMaHsfi8aqx5lMMLkCUztqhce3UQJm1bNll1BOPdvAyPGvkvqzMU2Rc4cIimBt14GMt6dtudGQko05wll+GwtDIk968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777688; c=relaxed/simple;
	bh=Uh/xHzZOnziz/jG3mIaHilZ0prkRGz8/pYegnAm0RVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hW0x2dbznjqBbh7FcRuxGeOx0oaFkhlfq0zGs5aZkL9QTxzpL/PMheDa8g3AEdSbaTtVOeNv10AaKpWl61PdijHKpZr5Mkryqg3aGP8vpyjN89+1cdbQcPT+tVLX1dy/cvevluU5A9i0EeMPpbZmJaZtGxR+Fr8Q8XEovg05+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=N2iayLhi; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="N2iayLhi"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxcc-007cNI-Av; Sat, 06 Jun 2026 22:27:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=Iw4HQYVrUBqe51ZVWEMZ2tnQ0UrxLulemejkj27UPRE=; b=N2iayL
	hikJ5QTM7epCVp/Rd/rS2zIem2fdnAhNttoEuTaKIDqC4aOworeWkNfy9FInL5DJ8MKUl1/zzmF5P
	Ruqp54WmKQha5FzWwLul0dopx+rNcsmNhp6necYWbueDiRTZvPQpxe+PUCo3//OhY1c9QW+z/fIk4
	8ZffpkLiVWACp80bxHn6AIdvAevRy0KaADYZk2XdxcDpEON17SeRQ67eR+ieY1i6MlEncSf6RjdUm
	AxfwSECnyzl6mkFTDWehpIOaj/Kfsui9z1GyvxpN0XUPX6K1uJgISNI/sDIOd3jdojbDJ8yKxOMi1
	M+nvfluVQdZTtUxdP0N3bqOQuB7A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxcb-0005FM-FT; Sat, 06 Jun 2026 22:27:57 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxcV-006elj-7Y;
	Sat, 06 Jun 2026 22:27:51 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Daniel Thompson <danielt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/misc/kgdbts: Replace strlen() strcpy() pair with strscpy()
Date: Sat,  6 Jun 2026 21:27:43 +0100
Message-Id: <20260606202744.5113-4-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Use the result of strscpy() for the options overflow check.
Use two argument strscpy(config, kmessage) to ensure no overflow.

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

 drivers/misc/kgdbts.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 9d3218330f0a..2c8f10b8ac74 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -1069,11 +1069,10 @@ static void kgdbts_run_tests(void)
 
 static int __init kgdbts_option_setup(char *opt)
 {
-	if (strlen(opt) >= MAX_CONFIG_LEN) {
+	if (strscpy(config, opt) < 0) {
+		config[0] = 0;
 		printk(KERN_ERR "kgdbts: config string too long\n");
-		return 1;
 	}
-	strcpy(config, opt);
 	return 1;
 }
 
@@ -1144,7 +1143,7 @@ static int param_set_kgdbts_var(const char *kmessage,
 
 	/* Only copy in the string if the init function has not run yet */
 	if (configured < 0) {
-		strcpy(config, kmessage);
+		strscpy(config, kmessage);
 		return 0;
 	}
 
@@ -1153,7 +1152,7 @@ static int param_set_kgdbts_var(const char *kmessage,
 		return -EBUSY;
 	}
 
-	strcpy(config, kmessage);
+	strscpy(config, kmessage);
 	/* Chop out \n char as a result of echo */
 	if (len && config[len - 1] == '\n')
 		config[len - 1] = '\0';
-- 
2.39.5

