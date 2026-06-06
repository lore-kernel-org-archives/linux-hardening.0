Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920F30D408;
	Sat,  6 Jun 2026 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777635; cv=none; b=XVH2K9iOS1zBe18XOkwOqJsYtacA/u/raa/akD/WkbYEczHj4KHY1LMARGaffNLc04Gop+0iOsxWeRulvg5RF8UwYOjIE6mTeQOJfHyG/Tkd4uW9p7EeW/4WS4C7KuSG1kC+lXsc/tKUXKgyap8deh0ql4ze5rOmAXTItR+GOjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777635; c=relaxed/simple;
	bh=pyJmc7C/U0mqm4Ze7uT7vKZOI36O69ObMLxLffn4g0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HjvfXc3ctzfEWpuwu0ldLAi3ymug1u45eMWism3eFOx/GVc22vAq/YX/tZHq0ab0YjYl6tyEKGkdTKSIwTXG2XpvhVOG0ABnXfs/7AlgKa40TK9SyyUCLn0t7daXw1i2OHxM1+lEC0EnUTENLdNe1oqD40c/4rnxIkQWHYMYdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=reFlOnei; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="reFlOnei"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbp-007NNe-Sd; Sat, 06 Jun 2026 22:27:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=CwXvIfU1u+9teWmpgZjeDIlcEE0ECy4POx0M/C7CDvQ=; b=reFlOn
	eiPWa1Uk+nvc5vnGYEDPOT94Bat0BwTDHuw/+hncs6NkDxXJ3CkLrQ36ecbfBVgY3sE6iSsGufIjB
	c0qMAvnNr57M8lIBSSw6W8nPxGoIHAcjmcZg9w63bZ0oLr7KKfk1VZqzDOxiyQriCqhV4TMb8hM5Z
	KaG4H2wu94Dn/jHzxta5LBoD/8kuaklQUmSe0SISSXmqBFR7yqBKGT2PXhle9+YqWbSk9FG/44+A8
	DWd5WD55SaYS0TwqcqkSsDyBSCiyI8k0tGnCaFNGcgerYV4/1HJGJQKM1xrRz437lw3J0DBaRx3Vm
	Po3Xc3LmvDnjECfkWkcfqQEfgBfA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbp-0005C7-IA; Sat, 06 Jun 2026 22:27:09 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxba-006V18-OQ;
	Sat, 06 Jun 2026 22:26:54 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] nxen/xenbus: Replace strcpy() with memcpy()
Date: Sat,  6 Jun 2026 21:25:58 +0100
Message-Id: <20260606202633.5018-4-david.laight.linux@gmail.com>
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

 drivers/xen/xenbus/xenbus_probe.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index eb260eceb4d2..fafb2b84fa5c 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -514,7 +514,7 @@ int xenbus_probe_node(struct xen_bus_type *bus,
 	char devname[XEN_BUS_ID_SIZE];
 	int err;
 	struct xenbus_device *xendev;
-	size_t stringlen;
+	size_t name_len, type_len;
 	char *tmpstring;
 
 	enum xenbus_state state = xenbus_read_driver_state(NULL, nodename);
@@ -525,8 +525,9 @@ int xenbus_probe_node(struct xen_bus_type *bus,
 		return 0;
 	}
 
-	stringlen = strlen(nodename) + 1 + strlen(type) + 1;
-	xendev = kzalloc(sizeof(*xendev) + stringlen, GFP_KERNEL);
+	name_len = strlen(nodename);
+	type_len = strlen(type);
+	xendev = kzalloc(sizeof(*xendev) + name_len + 1 + type_len + 1, GFP_KERNEL);
 	if (!xendev)
 		return -ENOMEM;
 
@@ -535,11 +536,11 @@ int xenbus_probe_node(struct xen_bus_type *bus,
 	/* Copy the strings into the extra space. */
 
 	tmpstring = (char *)(xendev + 1);
-	strcpy(tmpstring, nodename);
+	memcpy(tmpstring, nodename, name_len);
 	xendev->nodename = tmpstring;
 
-	tmpstring += strlen(tmpstring) + 1;
-	strcpy(tmpstring, type);
+	tmpstring += name_len + 1;
+	memcpy(tmpstring, type, type_len);
 	xendev->devicetype = tmpstring;
 	init_completion(&xendev->down);
 
-- 
2.39.5

