Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47A3AA50A
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318873; cv=none; b=gp5yR6jz1oN1HXHbqCaNEG5+vYvY1VZOQjmVIMuRSV2DhR8Q8AJETJIeBKC72Z9v7TTRY+2UB3ciDvc+o0rrb6Cyqnfn8BFA40aMn4F79BdOkXaUrR9BIp3keKKvhYJvrc/XXPvoa1R3OHZ4JU9RycxvW4k7q4k7XLZxLJQ14VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318873; c=relaxed/simple;
	bh=jayCsNyrBnfBekfY0GztIpaMWngf/KsMUXs9yhFcuh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el+uz2RwDHdb+S6pkhU7ZdqfxHD+cHng4KITxyEwH/01tdVftm5/yY/eVj6ulg7cOJu4bpwBXCk5F9EImPsPlCe3ZuGSLEjXzlsXcUetGNwjAeEfnhtZE6YTi1s7qlgIF/FyqPCtK/2nh1VJadRiCx2Pmqiia022HK6APtKWMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XnAMfDET; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XnAMfDET"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=1YsI9ftuQYWnALYqVzcjMJ/Asp/D1VIcVn/Gm7naG8Q=; b=
	XnAMfDETz4eJ2CFJ26EbGfiafYTznNJQi4z1XqlnlzSIoyWMMf/GHLqADgwrXnSFMu3OqD4pQyfH2
	gzDivpa915G8lwiLPDIGz3EP8I3ygTTexDlwfL9YWprt0NsMPtyaMzeaWzDuCW5eVkl1QEdFkLt07
	qUKJE+jIDHMEdV0Jk4PIddr5RgmW5J7Bl3bt3E8gBmWohwfDLJpvBVmJNj13FKHDThji+fjwl0FqU
	lnW6ME6RPUogaX6HIjGmJ2swKCS7MeMW68BnpAybZAKJY9JCnqj8yVvqwY2xtYo13uDlmXllhQby8
	O3Q8P+DIKSxZk5UyiFbHVadoGTyMnsD7Ug==;
Received: from [187.90.178.110] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xEBrm-00DcK1-3M; Tue, 06 Oct 2026 22:34:26 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kees@kernel.org
Cc: tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net
Subject: [PATCH V2 2/2] pstore: Allow kmsg_bytes parameter to be written at runtime
Date: Tue,  6 Oct 2026 17:22:52 -0300
Message-ID: <20261006203412.175427-3-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261006203412.175427-1-gpiccoli@igalia.com>
References: <20261006203412.175427-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the kmsg_bytes parameter is read-only in sysfs, though
it can be changed both via command-line at boot time, and through
the pstore filesystem mount option, at runtime.

Add a module parameter callback in order for users to change kmsg_bytes
via the runtime sysfs interface, the same way they can do it using
the mount option.

Notice this exposes more potential races on reading / writing the
variable, since the parameter can now be written at any time through
sysfs, so annotate the concurrent accesses to kmsg_bytes with
{READ,WRITE}_ONCE to pair the readers with the writers.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V2:
- Add READ_ONCE() to missing places on inode.c, given that now,
  with the sysfs writing possibility, we increase the potential
  race on reading/writing kmsg_bytes from different CPUs.

 fs/pstore/inode.c    |  8 +++++---
 fs/pstore/platform.c | 20 +++++++++++++++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index cf499ba72702..233793b3f42f 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -267,8 +267,10 @@ static int pstore_parse_param(struct fs_context *fc, struct fs_parameter *param)
  */
 static int pstore_show_options(struct seq_file *m, struct dentry *root)
 {
-	if (kmsg_bytes != CONFIG_PSTORE_DEFAULT_KMSG_BYTES)
-		seq_printf(m, ",kmsg_bytes=%u", kmsg_bytes);
+	unsigned int bytes = READ_ONCE(kmsg_bytes);
+
+	if (bytes != CONFIG_PSTORE_DEFAULT_KMSG_BYTES)
+		seq_printf(m, ",kmsg_bytes=%u", bytes);
 	return 0;
 }
 
@@ -488,7 +490,7 @@ static int pstore_init_fs_context(struct fs_context *fc)
 	 * every time we (re)mount the single-sb filesystem with the
 	 * option specified.
 	 */
-	ctx->kmsg_bytes = kmsg_bytes;
+	ctx->kmsg_bytes = READ_ONCE(kmsg_bytes);
 
 	fc->fs_private = ctx;
 	fc->ops = &pstore_context_ops;
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 081c2134a60c..d0afb76ff18d 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -93,7 +93,25 @@ MODULE_PARM_DESC(compress, "compression to use (deflate/none)");
 
 /* How much of the kernel log to snapshot */
 unsigned int kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
-module_param(kmsg_bytes, uint, 0444);
+static int param_set_kmsg_bytes(const char *val, const struct kernel_param *kp)
+{
+	unsigned int num;
+
+	if (kstrtouint(val, 0, &num))
+		return -EINVAL;
+
+	WRITE_ONCE(kmsg_bytes, num);
+
+	return 0;
+}
+
+static const struct kernel_param_ops kmsg_bytes_ops = {
+	.set = param_set_kmsg_bytes,
+	.get = param_get_uint,
+};
+
+module_param_cb(kmsg_bytes, &kmsg_bytes_ops, &kmsg_bytes, 0644);
+__MODULE_PARM_TYPE(kmsg_bytes, "uint");
 MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 
 static void *compress_workspace;
-- 
2.50.1

