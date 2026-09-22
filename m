Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71643750DB
	for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112398; cv=none; b=mH9lbdDYBluxN6OvR6BaqI2axXX75yzNJq3EUrTDUDzOOLZ2jxBE2A2acvU52PsCO18JyynhUCKek/SOdNHnz3rdkiX/hudP9a4UNvxgdFWsGX4WozTlX2wlJNajHhrJ5hGG3NJLwwWBbo0lk4zpTl3LXqz3etVyEnJw5/X3mBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112398; c=relaxed/simple;
	bh=YNe3+avRKzeIlPbp5ejA8BZorboJYyUhrJ7xOs0EfAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vv3wfswoSIBPMMJRDiIxhFvC9oj/FsaE1L4E5iWpw1G/DyI9Cvl3gsOdA1zGlNJ+gYF/xknQKvkakWcDGcHD8CM1RxkfJmJ2kRL6OQ6Lnabrcx5ZutkFmrkkyIcwLflPNecbfDWS4BjfT/05KFMLt1/+QACD5zB7qRe1N/d+4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HBWnslYg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HBWnslYg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=J9NUyypPtFPDJ/MYPzJU9jSseSfrr2aV3N7JvbHr7JE=; b=
	HBWnslYgAAr4zUq+aN+/QhABskf2LDx94sGUB+GqSxayClLSITmpL1FeFlCKz6qaz4axAUP/4u6zf
	AVsJmebazggS+RcQ25mLVkfveVKSQkJq3X5AjZvJZwpbhDnIa6xROA6+RLXu67hJNJsJQ3ifY0poa
	dfQSKQCz8yC/x4KGcSW0prdfXt91pVhDCGSp0NKqHUg8IDtzZKSalhWmrz77QePPWVfKbIaQ8TY2g
	c67aiYW8+cziyxWv4hCAcfEKRgtO2hI3bs4n1cZqK3RnQexd/3glYhcWkG81DmcDK3iE1a3/1fXWY
	5/DI9tLCBZB5eyDdu4jkncLAZLUvu9hO3Q==;
Received: from [191.32.244.140] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x980H-005pqn-0M; Tue, 22 Sep 2026 23:26:17 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kees@kernel.org
Cc: tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net
Subject: [PATCH 2/2] pstore: Allow kmsg_bytes parameter to be written at runtime
Date: Tue, 22 Sep 2026 18:19:02 -0300
Message-ID: <20260922212532.98571-3-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922212532.98571-1-gpiccoli@igalia.com>
References: <20260922212532.98571-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the kmsg_bytes parameter is read-only in sysfs, though
it can be changed both via command-line at boot-time, and through
the pstore filesystem mount option, at runtime.

Add a module parameter callback in order for users to change kmsg_bytes
via the runtime sysfs interface, the same way they can do it using
the mount option.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/pstore/platform.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index f3a900cf2cfb..185afc3db1a4 100644
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

