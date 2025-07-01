Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A92279DA6
	for <linux-hardening@vger.kernel.org>; Tue,  1 Jul 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383432; cv=none; b=iwrNG8JVznLDhm1s2II+Ab8D2AqYvDDp2cZ8YoPINsy4ZInFUrQ4swfbqgocLZVOoHmPR1mr7Tfz6nf/KAfgQbrEWf60pfyB8O6YKZJpxNNB16FaFIsAkQpKRQC9Vvcou78oPvFZ5qUZ+Xqmey4qlaKc5L4AKPDtjy1kuSlHDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383432; c=relaxed/simple;
	bh=LCVQVjjqOl+3CTMzxiEMyl3uNu6dQ8/SX8rI26RGaYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAQoSX0GPyUZ3d2YeeFzoaWdwkRU3zojO/tIAPgpYzLGFEHFk3ZODP2ShLHhW7eMIqZBZkj6EOLPWczpk9gZ7MAT9rjNlSqA5EDoyj5Cq6jz6waHPWuPPlQMqtGnS6p+qvyVJXNu9pziGwPCmGJkRYM+jrBnQ2nhDuQqvVc3KkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=umSpTv1M; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="umSpTv1M"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40a55314d06so1983401b6e.1
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jul 2025 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751383429; x=1751988229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MYwZ/k48BqyqbRLZtuPIBf9oEcqZvV0nNm/DOaSpvXc=;
        b=umSpTv1MFs7s4w72OCI3jVgH7Gh0XoyvtyJlNFpmNXRUxszAhtAH5zJf+RI30/wZtJ
         7OWTOYSWLndmGb96yRht1Iy0YAeBTHqKSwV59BRk11eIVCY34EPKGVFOkBl18UmOQ2PX
         8VO2bmBxXYbJIVQzfQo9oRW9ZORCv+/9dEmlVeYKCsgesxfRxd74J2GIiTGdx3rDHLeJ
         BOYq6vjBhUxpTf6vtiknH0iDcnUCInuFxs03UN1TAkBsh85m8nPRgi08ov8tPlPbJBPk
         D0rtsKr8M8lRKO71abydfLMVg9S6jB9HSQJb5arLXI3s6J6I5x8Oh8Puq4YsTnL9aPz7
         EFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383429; x=1751988229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYwZ/k48BqyqbRLZtuPIBf9oEcqZvV0nNm/DOaSpvXc=;
        b=iwxPUAEc4W23fq6XLwYqZ4+5LAuPX0PRkc24N80eeA49GPBMrBt8yMCKuZS5buOeSf
         Na2fBUE0gjcgE+nUn7irhjAAqSvtl4UInRTLOqJMuReadX3ZNF3LeTmJSDfcNd+oneOf
         TGw7iXNTLWIRepYZzwXdmAju1sqYd36jEulWbTbuMrhcyMq3pb9eEcN+ttjlwZD3dhZB
         aViI/rGCu2haPoyXyMSL59jw2Gg8/uo/O4SdtULo1LFgowW/FWn0AlfkdnsnUORUq59W
         jakoB1V9fnjKtRAusyj381EKN+3MBsKbtyMoX+NZHZLVon2vBCN0DYSXgqbpIERmUy95
         0Thg==
X-Forwarded-Encrypted: i=1; AJvYcCUWw7I7pPPb79rAL0s+61UW6WfWGUkhJiCNi+bBI0VnpB6Or3letHsXwK5lFUI/NDPDyysPc3pn6sMy2mhrX5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5L/o5Vd1APuM30c0uhgcD4J3df2PoDHZmXXpi4RT/KcV6iVaJ
	n3cHLQzpRGmi6nwc7pNkFOxBAcTzp9MZcBa+mbqw0VqoqnFKe8FfyvV0TK8oA9M9Df0=
X-Gm-Gg: ASbGnctm/M6LV9n5CZDg4OSSsXKcam6cZ7AoF98lZtinCpTtxws1ys4obeIgoRbC6fQ
	M1k5vIX7Zs8gun3Sove79jzH+FINagK2iVkPquXO+97I4/xM4x4WXdIgaSFQAw2qgpiuEEipd7k
	vTx4fH+gvZq/GOUC4XudBy1lzx2Ho8NPwoQLM76/GliHCcBDrUVD3p7gRxDaBux8C7RiIomavb9
	prDTfqosBc92sbs8k039+sKWbWel9MYZOlOZQKMJea01FdBHuKzdvGyGutfd/V74x1Wj0XwjgyH
	PPRJ7YNCg3cNBiNXaMiI+ZWo07cTGeGlMigPUMZVUJdGTu1B2R9TdhO7gGBllhBFyJzXonKEwTs
	Rj4Gp
X-Google-Smtp-Source: AGHT+IFO+NNLHeWQEJrtSbhkE62e5VspiAQMKYLVQsc66ekN4NjgU+Dq9Uciy8NrYTFOEmdFwYZUMw==
X-Received: by 2002:a05:6808:2201:b0:406:7cef:46a with SMTP id 5614622812f47-40b33e1407emr11563569b6e.19.1751383429231;
        Tue, 01 Jul 2025 08:23:49 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8ebc:82eb:65f7:565e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae48esm2129470b6e.13.2025.07.01.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:23:48 -0700 (PDT)
Date: Tue, 1 Jul 2025 18:23:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [bug report] printk: ringbuffer: Add KUnit test
Message-ID: <248e204a-b610-485a-9a3a-1c5e38d52d5e@suswa.mountain>
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

Let me add Nathan to the CC list.  He knows a lot about __counted_by().
The dat->text is __counted_by() dat->len so the line:

	if (dat->text[dat->len] != '\0')
		return false;

Should have generated a warning of some sort, right?  I'm including
the whole thread even though I assume you are huge fan of b4.

regards,
dan carpenter

On Thu, Jun 26, 2025 at 08:59:52AM +0200, Thomas Weißschuh wrote:
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
> 
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
