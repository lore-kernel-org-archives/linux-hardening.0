Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3543B18A;
	Sat,  6 Jun 2026 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780778810; cv=none; b=ANK0w1RgBsyr2RFb+PDNH/y2mzR+ycL389xHTUFmjg0CtlCkweqyYDRAAUmJCb9/Y5AG7bk9boboD4v7hsvbqxbrhUVQFD0ElycI9a0pbB3Np3WDT6Sqeawn7FpX9T7MH5QcDnE9u25CRFmH1sXD/B7jZRohxJxWBNhgUtF5TVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780778810; c=relaxed/simple;
	bh=/OcoZiJiWCr4pvTzofGANdRUxEA1k0LfbIXSeQvtSqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dMex1GMfQQma2jpnR3gN4kiyHxE9P8DiR+o/en7gFpCNggJ9NpaQaMbDGK8p13TwucbxXE+E7O6aHfBVbfgY/NU+m/c0ccPdKEGQ13NOjLMakoFMtIYPZWf4PjOpr8StUTG/xiIRYXjshgkZm5z7iSUatfAcpQALVSVVCP+9yJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=B2VldlYr; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="B2VldlYr"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbV-007NJX-O0; Sat, 06 Jun 2026 22:26:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=OMfZOaaOtzLptKPrhdF2twX7AMe5ZC+9HNX6YGyz4D0=; b=B2Vldl
	Yrgonnw6FkliXLXtjQTlHzymlzTMNVwdqlB2zPnVj4Tdf8NrN2MTs/ZzqeWGBCk/XXKBEYVPqeNfL
	Fi5P4k62lJ8ULW/Nanm5eyR5I/+z/RhWxqM7FBuDLww6wrx1iPcYQzecfhmLJ7rNRr9133gEJW2HD
	o2Geth95QJTUIZbjOp0HNy4T/FUA9ZsEv2tv/JnXl4VJ6IJNuSM/akPswR+abVtMnXzE4a2msvawY
	BACiReOUosvxY0u3xhHFVjH9Adl4ifpmn/Xi6frxY7sCOYEdWWHHEparA1gRlhyH+t36Wk4oCK6HZ
	KGPKfpVODK1kp2gqKUJin1jxcmzg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbV-0000sY-Bn; Sat, 06 Jun 2026 22:26:49 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbT-006V18-9S;
	Sat, 06 Jun 2026 22:26:47 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] driver core: Replace strcpy() with memcpy()
Date: Sat,  6 Jun 2026 21:25:55 +0100
Message-Id: <20260606202633.5018-1-david.laight.linux@gmail.com>
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
sized memory block, use the same length to copy in the string.

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

 drivers/base/platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 75b4698d0e58..63fdfffe1a8c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -617,10 +617,11 @@ static void platform_device_release(struct device *dev)
 struct platform_device *platform_device_alloc(const char *name, int id)
 {
 	struct platform_object *pa;
+	size_t len = strlen(name);
 
-	pa = kzalloc(sizeof(*pa) + strlen(name) + 1, GFP_KERNEL);
+	pa = kzalloc(sizeof(*pa) + len + 1, GFP_KERNEL);
 	if (pa) {
-		strcpy(pa->name, name);
+		memcpy(pa->name, name, len);
 		pa->pdev.name = pa->name;
 		pa->pdev.id = id;
 		device_initialize(&pa->pdev.dev);
-- 
2.39.5

