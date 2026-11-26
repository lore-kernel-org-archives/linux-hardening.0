Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656971;
	b=G2LqqeZKM5Jaq+B5H3gYA2wEcpF335YfrijGMG1eCyIb4H8Yp9T88tPyoCzMM3lFJUOu
	 LoOsWrJE08AaEPzGHGI4zUX+UnBIH4I/OpfE+fYyIZaabzeO8p7039Qaty2IzVNVMlUEL
	 OAMj5HbCl0vmXlzgbYY99tMQNq/gyZDyrJZuswOtLULW4oTyJmQdxLGxQsCr2c1V1mwha
	 6y5HRopVGPxPuPmcvOhKU/ng9q8DFvCP+Rk7etdbsdoge+wOByBTPrfzOOIQevJwWrGKe
	 nQTL7aUm8cJR6xLddSxkySnYcQcTkjZl2S4fQ/oOb7NgsDl4wMSPURHrDb6frp6DRjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5tMp4+nCkrdqMXbrytBsy8KUnTj5f9f9jbnW4fe3cDk=;
	b=n7H3dVHCHGRo8F8LdfWxJYdiVD2pVYTW1tFRSf6dOIoDzLi+0KWdyeQnRVZRKUjW8+b6
	 /FY55bRh2CrHXb63G7VL8jIAsleYmdkDks/iGFYyKgfzCEXmWCqPN10J1rgkQ40lqMucr
	 e9OrVmsh2tzQmSA3Ccu1HX/v7FCvIuFuxi/yvFy7Kn6bP6rKbGOOdrVkeP/B77Uhi1Zv5
	 nfM7dZ5bR/wpsyoS3FD8v2KcxFM1eEHiSgXBPfXFIGt+4P3J45XG90F3XnPAvJMwx19mf
	 M+ISdK3Ro5NPz149L2nOS/C6y58JzpvqqksU9CpdeFfD3i1UY3ekf4+4e4q1gIC6q0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=if6kqgG0;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138A8606A31E
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 01:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 138A8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=if6kqgG0
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso3647471a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 17:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795656970; x=1796261770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5tMp4+nCkrdqMXbrytBsy8KUnTj5f9f9jbnW4fe3cDk=;
        b=if6kqgG0b0+6/sY8VbrVQFAzpHTn0s/OAz0OUONut6y0pcwFsIzHguAiKdbwmWr6Vj
         unGhAOmLA4sWAMEmCPWt3gUMQXFNgOxBhlLvCNood6T9LCJc8qz7nxdJ0XknHS3dtrmX
         4B5eLSNZpA6BPgBCJAkX/EnyyS73NxwOyhxH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795656970; x=1796261770;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5tMp4+nCkrdqMXbrytBsy8KUnTj5f9f9jbnW4fe3cDk=;
        b=Pfm5dqN4Zi15pwOadyX3n8sYDuviQAR0IKncL4bElABnqj5epSoZogCJY8u/tmWiLC
         4n2FnyWHAa7QXu7/Fky6JMxE7wsgEWnnFxQSpjdU6VuFFf2AOtG1+6Y6kBfL5XkdCku7
         dQPjgFbn9dQsKK6GOljg+a6ikDC8Mkudp4OWtT5qHZatUmYoCHjBKhpEly6FYfM6ST91
         GgFmsnC9KBbPu9Fq8E9SsL86qn01qinQdQk/Ci8U3k4HPCS6CITaTn4S3nkomLWNtn5u
         h+MgM9l7/hXctS97my2nHGJn0CIJG1mwBbmJ+J8bdlI5j1oBScTBvrgzRB9fRALxPoIu
         iilw==
X-Forwarded-Encrypted: i=1; AL+hErHffvhUoFN4xIPWE/dgIUNAx79O3jhsRZ1wz8T4faZIhUGjJ7jd7Txj4QUySTYVtw8D7eSPZl5G205N5ZKs/jU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YrHo5Lq89vYCtwkIDENf48enZMdTNbo1aIeiQzz2W/7m7ZKH5
	stT8RmREzhpblprrxbKfzaHLgtcsySKaBHtCw40Shrszo7Uikto3xebXK1Sn9DrsQMet4VnL6uD
	9ofQ=
X-Gm-Gg: AZFdTZea09uAqSJTVeXBQhOzKu/rvcE63IUgDyhdUD1z2D5bCZyKWEPR85Zqcp7TDXp
	sjII/sWdYFlodKYux/TDCRFMglX+K+8m0wSlnzMA4cgbpz4udBxXh9iYgij4HZIuJO0IpmZLhfx
	hPyY4ol/DM5K8bolk45agjZydOW2onkiWvR1hrx+/zjk87H18SOcT83ZoXJuDLCz1KCgroy/gmv
	PnSGLqGrAxjmea6vGv9u/LM7ZFfbrqgnyHttETujZIsGMZQ5kyeyvkJw8+2HySVHr3e7tTYVDnx
	3QDMSyGmqxEu74zcnhXvvl4kBfrdwM/F3l2rNNuvS6nvuxlOGta93htiqnwxp9OiUihTjN63C+X
	DGT5C10S1ZgDEXGJGFvsSoh1NqjkojHBUAcA/KZUmE2FFeFgUE9MF/bxG0ReS8KJ6jrZ3dTd7Dv
	b+2htCNaEq0n86UUqd0SsIXHVqcIC1MNPk/Wzq998Y/+uXjQ4p4rfgBhGdo5fHSqSrBegy5JDM9
	5HOvwuzMk/+rMQ8rna2B/SocuSMNn87dicDwQ1yCxqSLHbPOZrwRt39kG2c3undgICrWDNGswaA
	M/e28lEZK9DDIidUzkvH0L+K4a1sXwS4V+EXXcyym2y7zQ3rV3fVcCEpaKpCMVt0sg==
X-Received: by 2002:a17:90b:3b8f:b0:3ac:b3c7:de04 with SMTP id 98e67ed59e1d1-3b41c95f0e1mr13115867a91.34.1795656970314;
        Wed, 25 Nov 2026 17:36:10 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:59ac:90a:64:4bd7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm14278085a91.10.2026.11.25.17.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:36:09 -0800 (PST)
Date: Thu, 26 Nov 2026 10:36:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-hardening@vger.kernel.org
Subject: Re: Writing through const-qualified pointer in next_arg() from
 recomp_algorithm_store()
Message-ID: <aweJUDMS7yF3b7R2@google.com>
References: <awcpkJD6K1xtx_Pe@devuan>
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
In-Reply-To: <awcpkJD6K1xtx_Pe@devuan>

Hi,

On (26/11/25 20:08), Alejandro Colomar wrote:
> I'm working on preserving the const qualifier in some <linux/string.h>
> APIs.  That uncovered some places where we are currently discarding the
> const qualifier.
> 
> Here's one of the cases I've found:
> 
> 	$ grepc recomp_algorithm_store drivers/block/zram/zram_drv.c \
> 	| grep -e '^\S' -e '\<buf\>' -e '\<args\>';
> 	drivers/block/zram/zram_drv.c:static ssize_t recomp_algorithm_store(struct device *dev,
> 					      const char *buf,
> 	{
> 		char *args, *param, *val;
> 		args = skip_spaces(buf);
> 		while (*args) {
> 			args = next_arg(args, &param, &val);
> 	}

kernfs_fop_write_iter() gives us a kmalloc(len + 1, GFP_KERNEL) copy of
the user buffer, so it's "safe" to write to it, per se.  But I get the
correctness of the code point of view, so... probably another copy of
the buffer?  :/

---
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 96b135e3f727..ca12c1918aec 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1279,10 +1279,15 @@ static ssize_t writeback_store(struct device *dev,
 	unsigned long lo = 0, hi;
 	struct zram_pp_ctl *pp_ctl = NULL;
 	struct zram_wb_ctl *wb_ctl = NULL;
+	char *kbuf __free(kfree) = NULL;
 	char *args, *param, *val;
 	ssize_t ret = len;
 	int err, mode = 0;
 
+	kbuf = kstrndup(buf, len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
 	guard(rwsem_write)(&zram->dev_lock);
 	if (!init_done(zram))
 		return -EINVAL;
@@ -1303,7 +1308,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto out;
 	}
 
-	args = skip_spaces(buf);
+	args = skip_spaces(kbuf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
@@ -1779,12 +1784,17 @@ static ssize_t algorithm_params_store(struct device *dev,
 	char *args, *param, *val, *algo = NULL, *dict_path = NULL;
 	struct deflate_params deflate_params;
 	struct zram *zram = dev_to_zram(dev);
+	char *kbuf __free(kfree) = NULL;
 	bool prio_param = false;
 	int ret;
 
 	deflate_params.winbits = ZCOMP_PARAM_NOT_SET;
 
-	args = skip_spaces(buf);
+	kbuf = kstrndup(buf, len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	args = skip_spaces(kbuf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
@@ -1899,12 +1909,17 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 				      size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
+	char *kbuf __free(kfree) = NULL;
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
 	char *alg = NULL;
 	int ret;
 
-	args = skip_spaces(buf);
+	kbuf = kstrndup(buf, len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	args = skip_spaces(kbuf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
@@ -2578,6 +2593,7 @@ static ssize_t recompress_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val, *algo = NULL;
 	u64 num_recomp_pages = ULLONG_MAX;
+	char *kbuf __free(kfree) = NULL;
 	struct zram_pp_ctl *ctl = NULL;
 	s32 prio = ZRAM_SECONDARY_COMP;
 	u32 mode = 0, threshold = 0;
@@ -2586,7 +2602,11 @@ static ssize_t recompress_store(struct device *dev,
 	bool prio_param = false;
 	ssize_t ret;
 
-	args = skip_spaces(buf);
+	kbuf = kstrndup(buf, len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	args = skip_spaces(kbuf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
---

[..]
>
> Should we make the 'buf' parameter of recomp_algorithm_store() non-const?
>

device attr store requires a const chat *.
