Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.137.112.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147842;
	b=msm2JGQYVlXOJTGXh/iKkJCMAk23F82HWWyOCOYKzZcg5G+edBymVygqoIs0E22hzUMe
	 r5UDHvDq9ST5BaeXB3eBvB4WTIxQy+39YhIzFW6HUNIK55Td5TYuHbF7kFsDAQbdgUr0F
	 goyoLzIHoQ+1i2mpefG2S278GWKFiwBeKluKbwcmjwtVje6QwYBt4NmUhZ+H8ntvb8pUl
	 deMhZUIb8FRceHF3bCBGi97UyE6RBdJiRY9wWq7M1QZUpV+jxpOzByeSp9EIGINp0geJQ
	 3xVi9Zhg82BW5ZzQk1mx0q7k+9EkK9YAfEOFs7tbnJLc9WYj5GCxWmzGE8D4zJQ+K0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147842;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=tO9kSL/xN8Y10+a6avUg71v47JzAd9km3qSicQjl954=;
	b=FlWw4DcsywPg7PoRwhgXMcBx2aH3IXjg/ZD96DxCxc9K4TQjMODBgxIOGPSrkEJrVwFu
	 jx7O0y5PaiVFblEBzpvInMWvdHMGoGppbwoAHaoHCBSAQkEEhNkHhcLDlWQtlhF6HbkJm
	 NKUug49mIJk57DCe+JyyjsVm5Lxmz4M0oydIWMy5x2dhs469/01WvF2MnQGqql/aQfn+o
	 YvvRxZ4MQgNiCctC2J2qYXh+ErVpf01wLDUo6bizqJcXggz6BqVyh0AqFSJwWPPldHHfC
	 DbfwuISmcwgo1jUSGYy6dJ1TvLgdI+Tf/Sji1UIOS+XbrEFiQ1nQ1NppVyDVOz6EhnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vicb.net;
	spf=pass smtp.mailfrom=vicb.net;
	dkim=pass header.d=vicb.net header.i=@vicb.net header.a=rsa-sha256 header.s=f747d04263f05989 header.b=NuDrcowj;
	arc=none smtp.remote-ip=203.137.112.168
Received: from mx0.gmx.wtf (mx0.gmx.wtf [203.137.112.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0499606A320;
	Sun,  8 Nov 2026 14:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0499606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vicb.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vicb.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vicb.net header.i=@vicb.net header.a=rsa-sha256 header.s=f747d04263f05989 header.b=NuDrcowj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vicb.net;
	s=f747d04263f05989; t=1794147833;
	bh=tO9kSL/xN8Y10+a6avUg71v47JzAd9km3qSicQjl954=;
	h=Date:From:To:Subject:From;
	b=NuDrcowjLdNhnlvUmfjrfqfCOOO3fRkamqLxP+l5raLl12hQkN940qM4JvqE8uptD
	 5h2SCKEnql78bI1adTc6jU0j8DCT2Cos1H2IuVHzp0YgIBqg7D4cJ+xTDCoEae7Xts
	 fxOiJ1upmP1N4ZlxDrbacGS++KlXjSMNAUx0dGPIVfuQ70prCWdEAnMczcSyvgDzvN
	 2fmKtIayC31Rv8pvRYs7pJFGML40EIM5fOa3Vxxuk+dWBqB5d6J81r7BK0S9T2woxc
	 USOit4Qmw0UiaopeNCv+jTUQeMGS080cDB098lpMlrUHdK6uYkP42ZuAyMHKNn/WKE
	 qUFFIAIEdEsng==
Date: Sun, 8 Nov 2026 15:23:51 +0100
From: Vic B <linux@vicb.net>
To: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH] security: Restrict unprivileged access to /proc/config.gz
Message-ID: <avCF9zEHV48EHjgG@vicb.net>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When using CONFIG_IKCONFIG_PROC, the built-in configuration is
world-readable through /proc/config.gz, which somewhat weakens existing
address hiding defences, as it allows an unprivileged user to simply
read built-in config from the running kernel and build their own copy
with identical System.map.

This patch adds a configuration option to restrict access to
/proc/config.gz to superuser only.

Signed-off-by: Vic B <linux@vicb.net>
---
 kernel/configs.c |  8 +++++++-
 security/Kconfig | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/configs.c b/kernel/configs.c
index a28c79c5f713..11106164756f 100644
--- a/kernel/configs.c
+++ b/kernel/configs.c
@@ -37,6 +37,12 @@ asm (
 extern char kernel_config_data;
 extern char kernel_config_data_end;
 
+#ifdef CONFIG_SECURITY_IKCONFIG_RESTRICT
+#define IKCONFIG_MODE S_IRUSR
+#else
+#define IKCONFIG_MODE S_IRUGO
+#endif
+
 static ssize_t
 ikconfig_read_current(struct file *file, char __user *buf,
 		      size_t len, loff_t * offset)
@@ -57,7 +63,7 @@ static int __init ikconfig_init(void)
 	struct proc_dir_entry *entry;
 
 	/* create the current config file */
-	entry = proc_create("config.gz", S_IFREG | S_IRUGO, NULL,
+	entry = proc_create("config.gz", S_IFREG | IKCONFIG_MODE , NULL,
 			    &config_gz_proc_ops);
 	if (!entry)
 		return -ENOMEM;
diff --git a/security/Kconfig b/security/Kconfig
index f7bf6cdc6229..0e8b8947150a 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -19,6 +19,33 @@ config SECURITY_DMESG_RESTRICT
 
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_IKCONFIG_RESTRICT
+	bool "Restrict unprivileged access to /proc/config.gz"
+	depends on IKCONFIG_PROC
+	default n
+	help
+	  The built-in configuration of the running kernel may be used to build
+	  an identical kernel and expose information about kernel addresses,
+	  which can make exploiting easier.
+
+	  Selecting this option makes the built-in configuration in
+	  /proc/config.gz readable to superuser only.
+
+	  This is mostly useful with custom kernels, as distribution kernels
+	  tend to have their configuration and address maps available online.
+
+	  If you decide to restrict access to built-in config with this option
+	  for the above reasons, you should also make sure that access to the
+	  on-disk kernel image, configuration and System.map is restricted as
+	  well, e.g. by making the /boot directory accessible to superuser
+	  only.
+
+	  When using packaged kernels or image-based updaters, keep in mind
+	  that kernel packages or update images may also be accessible to
+	  unprivileged users via package manager or updater caches, or from
+	  network repositories. In such cases it's a good idea to restrict
+	  access to these as well.
+
 choice
 	prompt "Allow /proc/pid/mem access override"
 	default PROC_MEM_FORCE_PTRACE
-- 
2.47.3

