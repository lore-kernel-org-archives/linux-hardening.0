Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4493C553B;
	Sat,  6 Jun 2026 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777681; cv=none; b=Rlp6BzYzUyswxU2Btu1ExrqsApp0fzAIGdSNEMZ1yxOpbSG5Xyy0hv013xFmOp00lJbZx5ff8RxhfZZN+qXE17ka0+nYvtirBcM8xC1Fr60jn1b406dCMPumcc0XQJXsYVS6I3S9Oi5Da9mYvZSzhKRGLSYDukZHAfS33MT97AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777681; c=relaxed/simple;
	bh=nzAXMyQtvONhOFol2DVk8uLXsudCxo9a1AXzAWb5ODI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DzNoziC278S/U2H9Nbw3cbOLQrWMOoN3N1Ssw/GalyVKZuOZfFVldw9C4PNabsOL29pw4/7rjiINgYwEV+PlhsEx+v4ycjWdgar/984ONI+eWikqpnzJPcj2uIvunUzCGPa8WAsk1Q/4hd6W4Bi3NYgfoUhKc5AHiW27vXpd1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ECi8Yru1; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ECi8Yru1"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxcb-007NWp-T5; Sat, 06 Jun 2026 22:27:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=yNltE5qiBWrLVbrV36NtLKHukaDNa2lljdTajRs9uEg=; b=ECi8Yr
	u1WgPxW/vKcUfMt6JBQEQzaDe2bi1CD2mcYh2FWr34G7mZr2UQRQP0HDbY26FJmByDzrjuAYuMvNH
	xhcchHJnEqgq4E0hZ496YiWlnU+5mQWve2SiyuUhiJbXgAYV0IZDkhAApNxi+Ui0Aax2U7JS75ZCH
	e1G0YI8YLnOF4aNByq9wj1D9+x1VBPvgtQWIAl5+BWroKHIj6eKr9pwh6TvKUkzCzYLXRCxSMyV/g
	WO/6luhUltlfrDh8zJ/VIOy2P+mrhpn7vWP7DNPEGFhfPoNt1r0xQVNp25dviMm6G/6+EAyGIO1D/
	ZJpr70z4xW6bd5kvWo2X5FI0xt3A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxcb-0000vs-8X; Sat, 06 Jun 2026 22:27:57 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxcU-006elj-Pm;
	Sat, 06 Jun 2026 22:27:50 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/9p: Replace strlen() strcpy() pair with strscpy()
Date: Sat,  6 Jun 2026 21:27:42 +0100
Message-Id: <20260606202744.5113-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Use the result of strscpy() for the overflow check.

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

 net/9p/trans_fd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index dbad3213ba84..eb685b52aeb2 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -940,14 +940,12 @@ p9_fd_create_unix(struct p9_client *client, struct fs_context *fc)
 	if (!addr || !strlen(addr))
 		return -EINVAL;
 
-	if (strlen(addr) >= UNIX_PATH_MAX) {
+	sun_server.sun_family = PF_UNIX;
+	if (strscpy(sun_server.sun_path, addr) < 0) {
 		pr_err("%s (%d): address too long: %s\n",
 		       __func__, task_pid_nr(current), addr);
 		return -ENAMETOOLONG;
 	}
-
-	sun_server.sun_family = PF_UNIX;
-	strcpy(sun_server.sun_path, addr);
 	err = __sock_create(current->nsproxy->net_ns, PF_UNIX,
 			    SOCK_STREAM, 0, &csocket, 1);
 	if (err < 0) {
-- 
2.39.5

