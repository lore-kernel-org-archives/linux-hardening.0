Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3313C1966
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777640; cv=none; b=EYxU5q4eA+AawmqNgkopvAX3+RVXPHOq2iUEGF/PJrNWhmX6mDZKqtezTNCRRB6xjXWrmlKCgJ9Zr296jgYTafpVtVIyvB7uhXw7zgSjtF43H8bsY3mztTymvrecRDVrBk11VB4/v1Q4Lig4GoH3f8ev2mMEYjA3SEgmit72iyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777640; c=relaxed/simple;
	bh=0I5zgAujTsEXonukzwo9QMCuSWWpWL/vQtUNYm4Kjac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=majQH/T/s/h7XaLz7i9pthLeFb7O8eB2o58P7+FDlkruTGwSIGsBzhTcx1LsRBrAm3Hzgv+3mpXHAQ2KwVwRgpPVX5e2Bi2Ky1QhANTWdo5B+zP9YtPPuRoGNHyTLLRvLVRfZBnALRKCrLXwwt+sJGc0LKkP1LgUDGlRcc+ztng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=FHEAYTlK; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="FHEAYTlK"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbt-007NQp-7c
	for linux-hardening@vger.kernel.org; Sat, 06 Jun 2026 22:27:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=zqF4TpCmiyOuQ/B6wO1RNposM4bibPGIMU5UN/VCRz0=; b=FHEAYT
	lK0onjr1lLXpORO2UXaW0qlb2iGAFSGKHKQ6fbjoibcwa86VSFyH8DVg09v0Zuf9LDtRqhQzdJOKb
	bYK1qD04SzmFVXiL2yJD7xdsXWkwcUNV4O2HJzWuAqAUNCVOKwflB7/mVGYewPZxYwuxIsOQTOLBY
	88GUH5UQ66SHAU3CURRD2e76C09EFXJUr54p8YbtpPUVVTnUDLhcVVJ+E5JCGr7ChqoLKRO8X6ee4
	7WnlaqK3y5XWxxYUHAy14VMrZFGpJxgkaVmMJ4mM5FB1/RwHMDjs+pWhYRDYyE8BHnclvmQZYoHOD
	fzMtT5y/P2/ymxq+zY6Jb4k6SQZg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbs-0005Cd-Pv; Sat, 06 Jun 2026 22:27:12 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbb-006V18-DO;
	Sat, 06 Jun 2026 22:26:55 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] kernfs: Replace strcpy(s, "../") with memcpy(s, "../", 4)
Date: Sat,  6 Jun 2026 21:26:00 +0100
Message-Id: <20260606202633.5018-6-david.laight.linux@gmail.com>
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

 fs/kernfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 0bd8a2143723..90e2b3221b83 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -73,7 +73,7 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 		if ((s - path) + 3 >= PATH_MAX)
 			return -ENAMETOOLONG;
 
-		strcpy(s, "../");
+		memcpy(s, "../", 4);
 		s += 3;
 		base = kernfs_parent(base);
 	}
-- 
2.39.5

