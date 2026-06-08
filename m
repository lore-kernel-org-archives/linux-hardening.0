Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBFA3B3C1A;
	Mon,  8 Jun 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912553; cv=none; b=CVqakHCEFyjZib9hfavz/MhnQ0G8N9Mgf2pZP8xK5KxMfA3Z1EHxUbJnpqCFN6u0+OYADmMv0Tsaf8Tq3GR7AUpe2CO/zWeu8B09LfBrjNSvuso+IYyaPESkP57I27tAq06+ByZ6En8TmQrYOQkBbv7UM2iNMtbswoPJsBEF+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912553; c=relaxed/simple;
	bh=k51nktfc0kwELOXovhrqt1ceS+yMiXjkuaKyQ66/D+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fCDyVMW1tW8XcnO9tH9YPwt84kxi9rlnpaVfwYI45DQY2wWvWxTDAWlWMucbQxfOfasRorVf/UY/00lraLdHaKbeXQGjYu8JglxoaVwnaPdDXEvdAsxWMXwT1EE+SvDOhztjWWw/Fxas/Q5gGncoh4Axh6Ezgp1GoHJC5OntlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=Ay3BZyzF; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Ay3BZyzF"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhs-00BrDZ-Jy; Mon, 08 Jun 2026 11:55:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=pxrgU/QYIXYxzHkfdS8f9X+9QjMMvzjIRJ97Rx3zO4U=; b=Ay3BZy
	zFTyCoJ9pfuNQpOsxKI8diqPw7fyvfJXUo/kKFtOdCL+h+KbusvcdM5ZK+BDKa8Da5Scp1KD7pAct
	5NX7mJ/+YW5m6FZM/7lkcqANgBNdwRm0T291m9botRKF49OIY8mbk2U+ngyt7CYDg7wP+YFOuJobl
	+NB6+hkON7kXmyB1Fmc1SVXbW02Vt0K25T/IkB6HMkhufqhSS8C1NlxeuLwMjd76vFyCF4THkvnMa
	n+Vi7Is+P/OUMx97ADVzFQ8R51g/7cNQYcxPRez6xsJhtghM5p9CAco9wI74/A9LxW9e22PBumQpa
	YgKTbED5PLfkkuXAr2jBA2WXLnKQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhr-0003gr-Qm; Mon, 08 Jun 2026 11:55:44 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhg-00Ag6G-Sp;
	Mon, 08 Jun 2026 11:55:33 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/misc/enclosure: Replace strcpy() + strcat() with snprintf()
Date: Mon,  8 Jun 2026 10:55:02 +0100
Message-Id: <20260608095523.2606-18-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

While the sizeof the target buffer is (should be) ENCLOSURE_NAME_SIZE
and the copies should not overrrun this stops any static analysis objecting
to the unbounded strcpy() and strcat() calls

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

 drivers/misc/enclosure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index cf6382981777..de457378c501 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -184,8 +184,8 @@ EXPORT_SYMBOL_GPL(enclosure_unregister);
 
 static void enclosure_link_name(struct enclosure_component *cdev, char *name)
 {
-	strcpy(name, "enclosure_device:");
-	strcat(name, dev_name(&cdev->cdev));
+	snprintf(name, ENCLOSURE_NAME_SIZE, "enclosure_device:%s",
+		 dev_name(&cdev->cdev));
 }
 
 static void enclosure_remove_links(struct enclosure_component *cdev)
-- 
2.39.5

