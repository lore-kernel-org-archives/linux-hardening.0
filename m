Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B42D8DD0
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777644; cv=none; b=a5B0dhYdVoqifjLPvXW+2ttq12rNwgHbFsc8wGupOI6IiOrmqd5am/M95ZCbB87HhVyq223gIzuHBmAF8hGZSNp9CMLq3FnREqsHttqdG5NdSNvIvG875hZTnTh+N2X63OGYsv75kCfN7k8wTckzfzjuJHYyeXVCvrFFVkiewOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777644; c=relaxed/simple;
	bh=oEhECJE2nTrPkYmbc0rF4i4oPLicCW4sGwGh2smDF0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m9izLfhMrzMcMmIzPDbKQ3cgIzCxDpqPE7cftKlGQgJHiFpvDF7te5LEnOMtPUiIEEAyaYpyDgn+XWIHek+nFduB8DRs0N4KXWJ1CJDgn71yd+flPNCwoDj4aGUejzfdOvzul4tKlJonObylRsdIa+QhpDSyBy0kU/5SQ/t+ErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=Uupf/7bd; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Uupf/7bd"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbs-007NQk-Si
	for linux-hardening@vger.kernel.org; Sat, 06 Jun 2026 22:27:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=0CGRm5wFpOmbDRSfMJmTuzZ0c+4o4lCALgnyk0jwkhw=; b=Uupf/7
	bdpLDrPOfhIolzKtgW82pzeC/ca3tSwYY/s3kQi57RDfZlbnxtLxze7wFr1MXUYCqfLMcwrzIOK4q
	BYdxXlmIIpU/kg2JQ4IvEnGIEKhKMoawiTgLzBsw7J0oitsa1YbcdyKG0mzn/WX/5A/upMpAB3Y74
	LejwjbAZ9FHc2zCQ5DcIa2a1i94UiUIqRlvs0Jv1zpLRyWzhT+4P3d5qZxuRjwqNbJOe90uRO45e1
	jCX9faOpI7ALLfbh5qBlkIn76pQkLq/Z27I16oUzVV5IT/+PyVaJuxrF7kyNDG5mD6BnkNPBC6pxx
	eX6WayuiYmNZmHQHwZMVBZy/mzcw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbs-0000te-KJ; Sat, 06 Jun 2026 22:27:12 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbb-006V18-My;
	Sat, 06 Jun 2026 22:26:55 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] param: Replace strcpy() with memcpy()
Date: Sat,  6 Jun 2026 21:26:01 +0100
Message-Id: <20260606202633.5018-7-david.laight.linux@gmail.com>
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

 kernel/params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/params.c b/kernel/params.c
index 74d620bc2521..a4ae0120457c 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -279,7 +279,7 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
 		*(char **)kp->arg = kmalloc_parameter(len + 1);
 		if (!*(char **)kp->arg)
 			return -ENOMEM;
-		strcpy(*(char **)kp->arg, val);
+		memcpy(*(char **)kp->arg, val, len + 1);
 	} else
 		*(const char **)kp->arg = val;
 
-- 
2.39.5

