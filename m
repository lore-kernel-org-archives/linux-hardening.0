Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF521FF35
	for <linux-hardening@vger.kernel.org>; Tue,  1 Jul 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385393; cv=none; b=SkwE5PHpUUCJMFAz/+Z/a8hof7BicqOUYNzx11P9G9/v9O9YPmDcP5lfHaSFl8pubqrRLZzzHlVzJHkWyxg24S5Ots+42S9OwtZtqcoViOIenBZSHJtIgmU0vfr4JL5miaL7bZ9Dv1SBF+wF2LGv2cT9IXBxaRipKaJf6I1Sg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385393; c=relaxed/simple;
	bh=qdDpUsdPRFTYRtz1Zfd+FoUnpi9pahuvtFmShTCynVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdlGgLrMglOqb+9HXm1jlJu5UIIbm/b7/hQSuMKqDJ2RoOqZD/aWHmFwXzu+lBP64nmbcf0TymCHo0NSAv4eGaKLVLxeR6J5E89RpvSSBCdKO/asX8PfUe0WOJhBVU2+PpKFaKHZgOhmxhgz9VDVn2QM1JW5SBb44FMXxydic5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W6YMxhou; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W6YMxhou"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so2315111f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jul 2025 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751385390; x=1751990190; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yfh6Yb2pjFZ2pvZ0AS6CJBmHfbVLNpjXWe1trIm1tjM=;
        b=W6YMxhouo9IEKCKVJ29oY9d4oJmNa4HkHjQw/vTdwWAAYnDg9aUANw1DNEzSTqJJig
         i80stZfN1IHmsBNMF3mZ8JeL+rBct0LUiFUg/uOjth8YIxYtaKNpcsAemhT1aXnnaJv2
         /qgaxkFzAw6NYdGWqmWaXLBOI+DUKSxFt8AnoYi5iaWLcyXQONAj+qeC9a8VjSJq1kXQ
         W6rHj0LQ1VNKGve29pkdCPF5irAJc/8A6rFDddDZ3GnsfiiSaryeSHpjJM31TkLHBAjJ
         BrC2bpwT2bxsgrkLHZsNIRB3IfG0PHMaB8YOa6w55+XtBbsmEnYJGj868/Xh+c1bdLDV
         ffVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385390; x=1751990190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yfh6Yb2pjFZ2pvZ0AS6CJBmHfbVLNpjXWe1trIm1tjM=;
        b=Btfu9pimewSPH0L2heVp17Km67sybJOSw/QmRuFMzR01a7vKlTqGz5NRnn+a6XyjKy
         0nW11LWF4EPgNcdTbvnhYvmamL94X9Epk34BDa0FE+9CWJKVkdb3WztDKOwCT/qmraDL
         Kvyf5E1joR/Rg7qm0MFspKyZgZkMPqEaeSB2soZaa62bdWMV36KxAXfwZeNzgCp+/rFZ
         hnhzggeYPF/tEBV1z0upe49r1aZIdnyN1X65z61k2CUVEOkwNy8g4GPXP+8dOdbTONWb
         PVu54a6nCqT61wsBEQEHTzG7j9ePsob6ZLF9KDITQk+m9tdkfrtG2h7KlDT6fFiyiyRA
         mdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWyyfaKG+SvPWIe5Exucssd0SIAYs2ib0kvMq5mVqUQ2ThV3GiEYaORoS6IHYHPPIb3Q/X8YwmDQBeaKi7w+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6VrlSXUXYfCcTuMmKdxrkEnBEvulvgHCMN1u48efLxoHXPzKs
	9AvhTGqFFh4VTlYINUMl/9vxqjoTI8VLXpaIHmqXzR7Nvb1krMGJJ2NzMmDnmpyQ3No=
X-Gm-Gg: ASbGncu3JHYU8AEk527BH5taXlYqTyEBY3rb/y5GCG9SOvPNz3+ZHVv6FyEAxmx7jV0
	2ji4afI3y/B4k0hiLiLTV33oWJSkpL6H0PxccZFCt7c0JtZIlMY1cC6X41pBtTq3+ythXyx4dl/
	qfEh0O4RZzK8I8f1jkra3za1xt/o4KZhH8sz00g51EK7myAgRKWO4HpdXCNogyrMxux5aM5dcXn
	IsXi89mBzLsQDawgy2FL/LXGR1btxTJrwOqvSay62r042RfPuSklAFvjrPIfHXjlmC3XGAGDFwf
	LDXBBh55P5m+NL35C/z3NDQZtcuNem8XFJgusrk+Hize3RFpZ93Z4+/wzD5gPg+L
X-Google-Smtp-Source: AGHT+IEDeGmz8lEkTX8V7MjBxJvMgDbocuUguww83CXuss84NT2qvK/XoiI2HrV0j86RRxfrka4lwQ==
X-Received: by 2002:adf:a193:0:b0:3a4:f6b7:8b07 with SMTP id ffacd0b85a97d-3a8ff52022fmr12799608f8f.48.1751385389956;
        Tue, 01 Jul 2025 08:56:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5409d62sm11508098b3a.27.2025.07.01.08.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:56:29 -0700 (PDT)
Date: Tue, 1 Jul 2025 17:56:19 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [bug report] printk: ringbuffer: Add KUnit test
Message-ID: <aGQFIzXtyHw8FAeq@pathway.suse.cz>
References: <eaea66b9-266a-46e7-980d-33f40ad4b215@sabinyo.mountain>
 <20250626082605-c5fbbb88-f6cc-4659-bea0-a283cdb58e81@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626082605-c5fbbb88-f6cc-4659-bea0-a283cdb58e81@linutronix.de>

On Thu 2025-06-26 08:59:52, Thomas Weißschuh wrote:
> On Wed, Jun 25, 2025 at 10:22:19AM -0500, Dan Carpenter wrote:
> > Hello Thomas Weißschuh,
> > 
> > The patch 5ea2bcdfbf46: "printk: ringbuffer: Add KUnit test" from Jun
> > 12, 2025, leads to the following static checker warning:
> > 
> > 	kernel/printk/printk_ringbuffer_kunit_test.c:91 prbtest_check_data()
> > 	(unpublished script worries this an off by one)
> > 
> > kernel/printk/printk_ringbuffer_kunit_test.c
> >     83 static bool prbtest_check_data(const struct prbtest_rbdata *dat)
> >     84 {
> >     85 	unsigned int len;
> >     86 
> >     87 	/* Sane length? */
> >     88 	if (dat->len < 1 || dat->len > MAX_RBDATA_TEXT_SIZE)
> >     89 		return false;
> >     90 
> > --> 91 	if (dat->text[dat->len] != '\0')
> >     92 		return false;
> >     93 
> > 
> > My question is that the prbtest_rbdata structure is declared like this:
> > 
> >     53  /* test data structure */
> >     54  struct prbtest_rbdata {
> >     55          unsigned int len;
> >     56          char text[] __counted_by(len);
> >     57  };
> > 
> > The size of text is not really counted by len, it's "MAX_RBDATA_TEXT_SIZE
> > + 1".  The condition "if (dat->text[dat->len] != '\0')" is reading one
> > element beyond the __counted_by() value so something should complain if
> > we enable all the debugging, right?
> 
> You are right, we are reading past the __counted_by().
> But I don't get any complains with CONFIG_FORTIFY_SOURCE=y and CONFIG_KASAN=y
> on either clang or gcc.
> We could remove the __counted_by, but I assume somebody will try to add it back
> at some point.
> Or we account for the terminator in dat->len:

It means that the value will be the size occupied by the string
including the trailing '\0'.

It means that we need to rename it, for example, len -> size.
Because using "len" for size is confusing and error prone.
See below.

> diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
> index ef4a2beea57a..106f4c7ffc86 100644
> --- a/kernel/printk/printk_ringbuffer_kunit_test.c
> +++ b/kernel/printk/printk_ringbuffer_kunit_test.c
> @@ -85,14 +85,15 @@ static bool prbtest_check_data(const struct prbtest_rbdata *dat)
>         unsigned int len;
>  
>         /* Sane length? */
> -       if (dat->len < 1 || dat->len > MAX_RBDATA_TEXT_SIZE)
> +       if (dat->len < 2 || dat->len > MAX_RBDATA_TEXT_SIZE + 1)
>                 return false;
>  
> -       if (dat->text[dat->len] != '\0')
> +       len = dat->len - 1;

This is one example, where it just looks just ugly.

> +
> +       if (dat->text[len] != '\0')
>                 return false;
>  
>         /* String repeats with the same character? */
> -       len = dat->len;
>         while (len--) {
>                 if (dat->text[len] != dat->text[0])
>                         return false;
> @@ -114,10 +115,9 @@ static int prbtest_writer(void *data)
>         kunit_info(tr->test_data->test, "start thread %03lu (writer)\n", tr->num);
>  
>         for (;;) {
> -               /* ensure at least 1 character */
> -               text_size = get_random_u32_inclusive(1, MAX_RBDATA_TEXT_SIZE);
> -               /* +1 for terminator. */
> -               record_size = sizeof(struct prbtest_rbdata) + text_size + 1;
> +               /* ensure at least 1 character, +1 for terminator */
> +               text_size = get_random_u32_inclusive(1, MAX_RBDATA_TEXT_SIZE) + 1;

This is where the naming goes beyond sanity. We allow to break the
limit by setting "text_size" to MAX_RBDATA_TEXT_SIZE + 1.

It is because MAX_RBDATA_TEXT_SIZE is used to limit the length of
the string (without the trailing '\0'). Huh.

> +               record_size = sizeof(struct prbtest_rbdata) + text_size;
>                 WARN_ON_ONCE(record_size > MAX_PRB_RECORD_SIZE);
>  
>                 /* specify the text sizes for reservation */
> @@ -142,7 +142,7 @@ static int prbtest_writer(void *data)
>                         dat = (struct prbtest_rbdata *)r.text_buf;
>                         dat->len = text_size;
>                         memset(dat->text, text_id, text_size);
> -                       dat->text[text_size] = 0;
> +                       dat->text[text_size - 1] = '\0';
>  
>                         prb_commit(&e);

This patch forgot to update prbtest_fail_record(). It limits the
printed string by dat->len. But the value newly counts the trailing
'\0'.

OK, I am going to send a patch with sane names where all this
should be fixed.

Best Regards,
Petr
