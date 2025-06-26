Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157E9226D18
	for <linux-hardening@vger.kernel.org>; Thu, 26 Jun 2025 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750921196; cv=none; b=Xe0p/zXSFMZfPXgzk4d/mBnauR/6i4asj0p4yt47KdiKRLlgPORrowpfpl0nf4kUjxiUtulBj40W3DNxPL+MyYM8dLJfGisP5Jb3zPhnGxij/tLzqgHbV90ohQo+iZvZaRLguhUPFw16qD3nsH/C0fHaUO7nYzXZZ9uByTSMDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750921196; c=relaxed/simple;
	bh=Df2t6dI0yXA+u2JLOle5YRdTs5uVp90RUa2n57rKCp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9bxIVw3Nxm4mzNCbZEnmx6n86DCaInIGPETWOHzp9ltVrO52Sfeart15UyO2SaMZamjHoLO/1TJBr6NXKZUuauhX0uyitvJ8sqPmXFegRDJ1Kp/FpsukfQ4ASeVcoFglV7Ht7GlxwLB8lJpqTa0mLiyw3DxaQl8PXFz/yd2Rv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XP6Ejshg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eO0fxoiT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XP6Ejshg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eO0fxoiT"
Date: Thu, 26 Jun 2025 08:59:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750921193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pILkcKC169tMv1/WdlI+0BK8bIn9N+SLKEEbygDwk6c=;
	b=XP6EjshgTKN5grWK6rr11uZahefl5ivqErdXBkgutD3g5EEEalNVOUzr/gmA8A/bnABZCT
	hGFQiu8Yv1w06a7utpHJ8p7LbRoXcE/eI7Q2xLNf+dK9DXhJrTkOV5Sta2kFaJUIwBvoi4
	ZutQyhvNj0O1yhGM7R9pPO2p2QxQUPYa8isWjgMvDit9qSapsjK2u6d7yLvkUVL2fBucuO
	QWjGtsYgarBVm8SleSRpdAcaBWInqltOZIx5jyJhmnqsriPSZyPAjQHDL9nQwD1Ja9k2bt
	/qUVn7G2QXDCQ290bD98dGHQR/rYqePVG1+0jq+gU9Kw+XLSElnd0wZtmYiSOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750921193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pILkcKC169tMv1/WdlI+0BK8bIn9N+SLKEEbygDwk6c=;
	b=eO0fxoiTa4Sw1bHhlHsmfqTG11LcvVOp4iI+s0cxG/nTiroUAdM5kp4VXjwxIztaSHBOgk
	hmY5EW1i6F5YZCAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: John Ogness <john.ogness@linutronix.de>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [bug report] printk: ringbuffer: Add KUnit test
Message-ID: <20250626082605-c5fbbb88-f6cc-4659-bea0-a283cdb58e81@linutronix.de>
References: <eaea66b9-266a-46e7-980d-33f40ad4b215@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaea66b9-266a-46e7-980d-33f40ad4b215@sabinyo.mountain>

On Wed, Jun 25, 2025 at 10:22:19AM -0500, Dan Carpenter wrote:
> Hello Thomas Weißschuh,
> 
> The patch 5ea2bcdfbf46: "printk: ringbuffer: Add KUnit test" from Jun
> 12, 2025, leads to the following static checker warning:
> 
> 	kernel/printk/printk_ringbuffer_kunit_test.c:91 prbtest_check_data()
> 	(unpublished script worries this an off by one)
> 
> kernel/printk/printk_ringbuffer_kunit_test.c
>     83 static bool prbtest_check_data(const struct prbtest_rbdata *dat)
>     84 {
>     85 	unsigned int len;
>     86 
>     87 	/* Sane length? */
>     88 	if (dat->len < 1 || dat->len > MAX_RBDATA_TEXT_SIZE)
>     89 		return false;
>     90 
> --> 91 	if (dat->text[dat->len] != '\0')
>     92 		return false;
>     93 
> 
> My question is that the prbtest_rbdata structure is declared like this:
> 
>     53  /* test data structure */
>     54  struct prbtest_rbdata {
>     55          unsigned int len;
>     56          char text[] __counted_by(len);
>     57  };
> 
> The size of text is not really counted by len, it's "MAX_RBDATA_TEXT_SIZE
> + 1".  The condition "if (dat->text[dat->len] != '\0')" is reading one
> element beyond the __counted_by() value so something should complain if
> we enable all the debugging, right?

You are right, we are reading past the __counted_by().
But I don't get any complains with CONFIG_FORTIFY_SOURCE=y and CONFIG_KASAN=y
on either clang or gcc.
We could remove the __counted_by, but I assume somebody will try to add it back
at some point.
Or we account for the terminator in dat->len:

diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
index ef4a2beea57a..106f4c7ffc86 100644
--- a/kernel/printk/printk_ringbuffer_kunit_test.c
+++ b/kernel/printk/printk_ringbuffer_kunit_test.c
@@ -85,14 +85,15 @@ static bool prbtest_check_data(const struct prbtest_rbdata *dat)
        unsigned int len;
 
        /* Sane length? */
-       if (dat->len < 1 || dat->len > MAX_RBDATA_TEXT_SIZE)
+       if (dat->len < 2 || dat->len > MAX_RBDATA_TEXT_SIZE + 1)
                return false;
 
-       if (dat->text[dat->len] != '\0')
+       len = dat->len - 1;
+
+       if (dat->text[len] != '\0')
                return false;
 
        /* String repeats with the same character? */
-       len = dat->len;
        while (len--) {
                if (dat->text[len] != dat->text[0])
                        return false;
@@ -114,10 +115,9 @@ static int prbtest_writer(void *data)
        kunit_info(tr->test_data->test, "start thread %03lu (writer)\n", tr->num);
 
        for (;;) {
-               /* ensure at least 1 character */
-               text_size = get_random_u32_inclusive(1, MAX_RBDATA_TEXT_SIZE);
-               /* +1 for terminator. */
-               record_size = sizeof(struct prbtest_rbdata) + text_size + 1;
+               /* ensure at least 1 character, +1 for terminator */
+               text_size = get_random_u32_inclusive(1, MAX_RBDATA_TEXT_SIZE) + 1;
+               record_size = sizeof(struct prbtest_rbdata) + text_size;
                WARN_ON_ONCE(record_size > MAX_PRB_RECORD_SIZE);
 
                /* specify the text sizes for reservation */
@@ -142,7 +142,7 @@ static int prbtest_writer(void *data)
                        dat = (struct prbtest_rbdata *)r.text_buf;
                        dat->len = text_size;
                        memset(dat->text, text_id, text_size);
-                       dat->text[text_size] = 0;
+                       dat->text[text_size - 1] = '\0';
 
                        prb_commit(&e);

