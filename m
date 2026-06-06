Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195FC30D404;
	Sat,  6 Jun 2026 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777635; cv=none; b=Yg6H2yQRKfPmKSUncmB9hDvNalY5qiP5nwz9yOwt4t47OzVTNMV08K6NagVgpsPspTlsC5D8mMjuqWFbmWu7MGOYi2NiEw1dxNc3nMLLwXs+b4CSijNSsODusmdFg45+kzxgJqR2oCHJUaMLjIRrtXsO47W3xnN3pBetPVZBVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777635; c=relaxed/simple;
	bh=ThlmTVRTpgls/zpqbs2baMrvVYXlWA2xSjetlZkTQcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NXWMU8CEpHwISOD4cobnKVxPGyGyB/0cb3qquU73JCIn1p0fHz454aueCLjy8A8O9vvc1aS7BFJqsliTRL8wnyMxBWNyIlHHOKJvrCjLszL5rVeXhN3T69pHrbRjayzUQ0jPhJ48VJMP6u5AjgFGxmi53DSSf0QrrYz33lFdWF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=tPUypTBY; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="tPUypTBY"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbq-007cFI-BI; Sat, 06 Jun 2026 22:27:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=NYS7xLlj/dRRWDxwAJtYqK18NJ/VeWpGZ8STxTEVQ6Y=; b=tPUypT
	BY/567oJBTwgA65lUkDyAJ/FMERj8WJbTTYn+O11+Ufrz7CbAQSVXEsNinbxseplfpjzyfuv4C1eZ
	KEFgTlIbjpPiwo2EltE8j4QoP1MMyj5inXxeVtBpOurEc4yRMzRTFtXBFyE6EFg4JpcDALMqY7mUn
	k3is9/+PV1Vt+CJZq4krTxBoQs4cgrQaz3uRt9wXo8vkn7jWulesKoe06f32IZz7i0SBj+eYjxvpU
	frqc+UlDA0lvvnknOKvWNKgsJtsWrn2sryz64+VP6PqkYktl3AA1YYdRYu1AGkuZB2JW1a8nqJwJA
	jX84bbYpFYfTYBYSQVQm5Q0GtEhw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbp-0000su-Tt; Sat, 06 Jun 2026 22:27:10 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxba-006V18-2S;
	Sat, 06 Jun 2026 22:26:54 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] driver core: Replace strcpy() with memcpy()
Date: Sat,  6 Jun 2026 21:25:56 +0100
Message-Id: <20260606202633.5018-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The length of the string is calculated in order to allocate the correct
sized memory block, use the same length to copy the string.

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

 drivers/firmware/dmi_scan.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index a3f7dabd4955..870767142b53 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -80,7 +80,7 @@ static const char * __init dmi_string(const struct dmi_header *dm, u8 s)
 	len = strlen(bp) + 1;
 	str = dmi_alloc(len);
 	if (str != NULL)
-		strcpy(str, bp);
+		memcpy(str, bp, len);
 
 	return str;
 }
@@ -290,17 +290,19 @@ static void __init dmi_save_type(const struct dmi_header *dm, int slot,
 static void __init dmi_save_one_device(int type, const char *name)
 {
 	struct dmi_device *dev;
+	size_t len;
 
 	/* No duplicate device */
 	if (dmi_find_device(type, name, NULL))
 		return;
 
-	dev = dmi_alloc(sizeof(*dev) + strlen(name) + 1);
+	len = strlen(name) + 1;
+	dev = dmi_alloc(sizeof(*dev) + len);
 	if (!dev)
 		return;
 
 	dev->type = type;
-	strcpy((char *)(dev + 1), name);
+	memcpy((char *)(dev + 1), name, len);
 	dev->name = (char *)(dev + 1);
 	dev->device_data = NULL;
 	list_add(&dev->list, &dmi_devices);
@@ -374,13 +376,15 @@ static void __init dmi_save_dev_pciaddr(int instance, int segment, int bus,
 					int devfn, const char *name, int type)
 {
 	struct dmi_dev_onboard *dev;
+	size_t len;
 
 	/* Ignore invalid values */
 	if (type == DMI_DEV_TYPE_DEV_SLOT &&
 	    segment == 0xFFFF && bus == 0xFF && devfn == 0xFF)
 		return;
 
-	dev = dmi_alloc(sizeof(*dev) + strlen(name) + 1);
+	len = strlen(name) + 1;
+	dev = dmi_alloc(sizeof(*dev) + len);
 	if (!dev)
 		return;
 
@@ -389,7 +393,7 @@ static void __init dmi_save_dev_pciaddr(int instance, int segment, int bus,
 	dev->bus = bus;
 	dev->devfn = devfn;
 
-	strcpy((char *)&dev[1], name);
+	memcpy((char *)&dev[1], name, len);
 	dev->dev.type = type;
 	dev->dev.name = (char *)&dev[1];
 	dev->dev.device_data = dev;
-- 
2.39.5

