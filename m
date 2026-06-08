Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BEF3BB670
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912552; cv=none; b=gPoFaPLiZFkuSwsXh830hy6+jDR/PAILaPD1y5oTQ9fQR7BTNily8oP5sns95qwTRmA6EHrIJbKv7vQbJMqlLKdV8+P1aKetqA673UXGsbK1TNRmS0JhqTlCOAM1jnuPw10NzPLnQN/qwlQ7ueznz/TtZtFnu5cJsx6UuhTqLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912552; c=relaxed/simple;
	bh=xO90JmKakdepCUKxFhx85/6OggmDDnxRrzebJ8DTiVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B6QytbQ3F5RSyFua33Zdf05wcO2FyX7PiGXJg3Xq42jIGz8pzEGnhiJ4/wtygM9f3suL5RCWk/NrcqA7HHC4moUlVC7aOCNY+oaOXUhHkbVf1QRv+50ly/+paI0bZrCbByl8g1yE/yu5jGYrYy3Nw0sZ1cbZbUZMNIbZWYRaUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=eXdoAy6n; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="eXdoAy6n"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWht-00BS2L-5a; Mon, 08 Jun 2026 11:55:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=YoyxEe3KgEEUQWybj40ebdMy/paksYt2/qsDvMcwxHM=; b=eXdoAy
	6ncGudOjvgOqA5DSxHrRcxM12wG5qosJEIgBeLpHcamDvyW23J4YBms0mxxSOOxYfKufsXf2egtTS
	OmMNhBKD/GFKY4MaKNYIxcG9a7riOwv3kJWf+ki0zMw+V7dTG6aWafeLZbHmGy3qHrN0nRCNq8m0o
	tY04g9nWTvHycnnLhkdWJisp+++mnPkwmEI8lP/NRE2P4WiUEh7GGUIWa23sApFoRMC97Vwdm228t
	7VSOlesBjhTRbmspPxozASKwIEKY2NBxQKLTdaa4guvuE9Zx6+dKSaVoL2IRiR93onlegb/0ml+md
	6jh8pHrt+O00C5T/jkBnVzfD82Bw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhs-0000Jb-C3; Mon, 08 Jun 2026 11:55:44 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhj-00Ag6G-8U;
	Mon, 08 Jun 2026 11:55:35 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/hwtracing/intel_th: Replace kzalloc(... strlen()...) with kzalloc_flex()
Date: Mon,  8 Jun 2026 10:55:08 +0100
Message-Id: <20260608095523.2606-24-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Save the result of the strlen() and use memcpy() instead of strcpy() to
copy the string.

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

 drivers/hwtracing/intel_th/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 3924e63e2eee..711a54e22e87 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -374,20 +374,21 @@ intel_th_device_alloc(struct intel_th *th, unsigned int type, const char *name,
 {
 	struct device *parent;
 	struct intel_th_device *thdev;
+	size_t name_len = strlen(name) + 1;
 
 	if (type == INTEL_TH_OUTPUT)
 		parent = &th->hub->dev;
 	else
 		parent = th->dev;
 
-	thdev = kzalloc(sizeof(*thdev) + strlen(name) + 1, GFP_KERNEL);
+	thdev = kzalloc_flex(*thdev, name, name_len);
 	if (!thdev)
 		return NULL;
 
 	thdev->id = id;
 	thdev->type = type;
 
-	strcpy(thdev->name, name);
+	memcpy(thdev->name, name, name_len);
 	device_initialize(&thdev->dev);
 	thdev->dev.bus = &intel_th_bus;
 	thdev->dev.type = intel_th_device_type[type];
-- 
2.39.5

