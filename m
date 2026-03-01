Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C22302753;
	Sun,  1 Mar 2026 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772393246; cv=none; b=oEZ+j0QJbT6LgwWJ2R2a/x35E9WjIERc3H2nME9LV5G6GtlKhLelWkpeWPHjn69HWRwWiBDdY4BHh4R0huvXSFtXnholy7bVU0Sn3HWgG0fIltE1mIA39J3/ZkWZZjm3ZubSFLFzyx63aTKSMqIPGXxKZW/Xb/YxkevVs6UTsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772393246; c=relaxed/simple;
	bh=MEwbLKWFsimb1MyI25+2xw/66Yv2czjPo3DKd7kYg6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rVbkE3ors8rXu7WEWb09e54CSbByaioSOEofSNmOGj0LNT8kK47x4r1HHM031KtE1yNT8kHSnSNUY3W2C8Cw/eX+q3ofOPgmZ+dVcam16P7uC2Gxonyt0OJme9wWhoFPWsa6vVVAqcVEHTTzvs5JGFr2JS3A+ECLwZMDeCB2xWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Pcd6Ak5Z; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Pcd6Ak5Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jgJt42CdD301UkKq4iXh3q2zJHSOZ0VDb4SnS26oOAA=; b=Pcd6Ak5ZyHtJi8FpaMHmNlVdD1
	h9Ukuf4v/C0+xqjHGNW39cI/BmrajDOVmdkHvgUWr3OJpIxldpmyIaKEE/qt5/nvl+H/9mpwEqCpX
	/XvEHLDdv21wyxf8kCRIEimp2TxArz+Fz3Xm+j1j5rUU+uskFeftQrEcIHr2nyj1c4pHqo7rOwKK4
	z5y+G4UnoI4YJOEqUgIpCGm1xBx1zSqM8EM6uFr7gyMliQKdicOEkUCZA6fsHINtRIbPdlEqjULvH
	xEiA4FyOU4hQKpWy/z5Mepi3sLVVvrnU/xT1TU75XFip7V+ha/KJcSYTBU/cI3i3ueX2h2gZb7o/n
	o4Q0DP3A==;
Received: from [187.90.181.146] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vwmRc-007czl-IY; Sun, 01 Mar 2026 20:27:12 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	tony.luck@intel.com,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [PATCH] pstore/ftrace: Keep ftrace module parameter and debugfs switch in sync
Date: Sun,  1 Mar 2026 16:26:36 -0300
Message-ID: <20260301192704.1263589-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit a5d05b07961a ("pstore/ftrace: Allow immediate recording")
introduced a kernel parameter to enable early-boot collection for
ftrace frontend. But then, if we enable the debugfs later, the
parameter remains set as N. This is not a biggie, things work fine;
but at the same time, why not have both in sync if possible, right?

Cc: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/pstore/ftrace.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 776cae20af4e..13db123beac1 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -62,13 +62,16 @@ static struct ftrace_ops pstore_ftrace_ops __read_mostly = {
 };
 
 static DEFINE_MUTEX(pstore_ftrace_lock);
-static bool pstore_ftrace_enabled;
+static bool record_ftrace;
+module_param(record_ftrace, bool, 0400);
+MODULE_PARM_DESC(record_ftrace,
+		 "enable ftrace recording immediately (default: off)");
 
 static int pstore_set_ftrace_enabled(bool on)
 {
 	ssize_t ret;
 
-	if (on == pstore_ftrace_enabled)
+	if (on == record_ftrace)
 		return 0;
 
 	if (on) {
@@ -82,7 +85,7 @@ static int pstore_set_ftrace_enabled(bool on)
 		pr_err("%s: unable to %sregister ftrace ops: %zd\n",
 		       __func__, on ? "" : "un", ret);
 	} else {
-		pstore_ftrace_enabled = on;
+		record_ftrace = on;
 	}
 
 	return ret;
@@ -111,7 +114,7 @@ static ssize_t pstore_ftrace_knob_write(struct file *f, const char __user *buf,
 static ssize_t pstore_ftrace_knob_read(struct file *f, char __user *buf,
 				       size_t count, loff_t *ppos)
 {
-	char val[] = { '0' + pstore_ftrace_enabled, '\n' };
+	char val[] = { '0' + record_ftrace, '\n' };
 
 	return simple_read_from_buffer(buf, count, ppos, val, sizeof(val));
 }
@@ -124,11 +127,6 @@ static const struct file_operations pstore_knob_fops = {
 
 static struct dentry *pstore_ftrace_dir;
 
-static bool record_ftrace;
-module_param(record_ftrace, bool, 0400);
-MODULE_PARM_DESC(record_ftrace,
-		 "enable ftrace recording immediately (default: off)");
-
 void pstore_register_ftrace(void)
 {
 	if (!psinfo->write)
@@ -145,9 +143,9 @@ void pstore_register_ftrace(void)
 void pstore_unregister_ftrace(void)
 {
 	mutex_lock(&pstore_ftrace_lock);
-	if (pstore_ftrace_enabled) {
+	if (record_ftrace) {
 		unregister_ftrace_function(&pstore_ftrace_ops);
-		pstore_ftrace_enabled = false;
+		record_ftrace = false;
 	}
 	mutex_unlock(&pstore_ftrace_lock);
 
-- 
2.50.1

