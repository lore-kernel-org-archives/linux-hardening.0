Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C83C13E5;
	Sat,  6 Jun 2026 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777641; cv=none; b=hYqi09T9DPJI924sj+54VPpGDZZSbrtMO94KBAlQ+ftWBWtewsDxMVpVqMDX3k5kRMH+f0anbvh4sXN6SaPaKKe0YmHRu//czsl9QrQSRZ5aIYNFeXzz1r9icds8Vwl+hYX5z41L/JJBcnN+9PZ77KICIQzQ2DeSC9PzrIGpeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777641; c=relaxed/simple;
	bh=OlXAackrqd35E1HrTIMbjiKHcKvxUZKzcuJcVfAbyNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AtVHiNfEU+GvoT8VvSKUHNARwLaR/yABk2sY41/wVEIY6rbOiEqk4XWSHuwY4KhpWJ978UGofkmHN4xGMfn8LdkFu9W69fKXYY+qOPaZ6/fkwPi6rzvO7MG+l1HScHvvv+aeHEPBzRnrhZ7PR+VJTmLf5D4sg36+LtHMbaU6lNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=VgP8itQX; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="VgP8itQX"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbt-007cGZ-Gp; Sat, 06 Jun 2026 22:27:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=Zl+vILRUQHMXaNPf+2MVG7OBLtY+1aR6EmzG6GmsP1c=; b=VgP8it
	QXR/ELymMc8lScM2AUpDnsoenY06Fofc3YkBm+MMuJZrWPu9l3ESEHCZYxhF4lmroWwDlxIT1Gsho
	SgaLJHCo2LL25lEsrm0ClMiys0BF/2XKFaDDB9N/9hvSaOvJH/60a8/P+K5zE1cP3Z3FGtMBW6TDX
	EH46BTEL2WTEZ5My66KV0KWX8/qzSSOfHF/aIewKTIIM2SxNLKsm/hF/kwcabzu5pn1T6EjnaN0R5
	aQHttZLRDfSN+5/w9mSEuXLkcdzu89XNE4ShOxEXGGml8IBIrj0GxX2q8QCgDb7W+UVFJ+o8K/mUU
	ygcHImnwWdZ4xnPE6DneyuaP3UNw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbt-0005Ch-09; Sat, 06 Jun 2026 22:27:13 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbb-006V18-21;
	Sat, 06 Jun 2026 22:26:55 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] fs: Replace strcpy(s, "../") with memcpy(s, "../", 4)
Date: Sat,  6 Jun 2026 21:25:59 +0100
Message-Id: <20260606202633.5018-5-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The code has already checked there is enough room.
Use memcpy() to avoid compiler warnings from possibly unbounded strcpy().

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

 fs/configfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index f3f79c67add5..9f36699e5922 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -67,7 +67,7 @@ static int configfs_get_target_path(struct config_item *item,
 	pr_debug("%s: depth = %d, size = %d\n", __func__, depth, size);
 
 	for (s = path; depth--; s += 3)
-		strcpy(s,"../");
+		memcpy(s, "../", 4);
 
 	fill_item_path(target, path, size);
 	pr_debug("%s: path = '%s'\n", __func__, path);
-- 
2.39.5

