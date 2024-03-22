Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3A82C71
	for <linux-hardening@vger.kernel.org>; Fri, 22 Mar 2024 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150911; cv=none; b=ocOadycmnEK9+kwi5jvZPEUd9EevcWhyewKshPYpsZhbKDG9L4Y5HB+7D+DZb9ZCPr8o7lksouYnZg5inVd/kqy78wAEuzxvavRl+yMJHgHSzj+rsQo3TrvKD81Y4urHZJODvVwUsg+JY6yXBv751MQNhWtTLNx+W0RGNzHQyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150911; c=relaxed/simple;
	bh=lJRABkx7JKgfTpfDFlwBtapy9NQDTB4LixNc29bEaRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoX0nvhfMrtA5SFPOtdkJW5usAebJAH1SJ3gfHy45Ls74sz8cGVGiWJ66//Vrg+XKzJhIdmw1ovF8YM6v6YvjgAaLoQLdbv40zLmmX3zJit/C6by66mbvlTz6Y9488qke7FCshPmQtneHW2dQq3rgz+I+FxS4r3geSG1Vxd44DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aEiAqY4k; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aEiAqY4k"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e4f7975121so602737a34.1
        for <linux-hardening@vger.kernel.org>; Fri, 22 Mar 2024 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711150909; x=1711755709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rsTXOVXpkkyC9HWkCbSY/jPnYgNvZiLHHgDyE2l0ejs=;
        b=aEiAqY4kl+wmVzXmpm1DUosKBbpaZg14EET4UNwn1lUpYLdI1Ov2YOJ+Z99pMLTU3D
         XYQ4Ii6T44lB9r/TbhCayxmVTkAaxMc/S4dxT8FOQhClsWB6DPKQ7Y0nrySO8XaW4vpx
         R5whm8/51EkuIxpggCANVz43ukJSBfGV4OO38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711150909; x=1711755709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsTXOVXpkkyC9HWkCbSY/jPnYgNvZiLHHgDyE2l0ejs=;
        b=KPcjISbt8GltLVGREeDP8j2IUTeVpkCjeFiPiU2ungpVDuiD/ZBjBIdzijAL080qh5
         TH5HpPo2lcAjMG/9F4zsUhqNEUaVs/hSBSUufYWiF0i0ps7E+/+nq8dsVdFJNv47mHJL
         xPAKixnLE3OzZOImDIdSv9zZeOW++4eAIo/b+RG0/dXLo6rfLngyYTMx7AQipmWnABIJ
         U0iRtNamUd1TcOnVA+wtci2hK3gydeZ+0kh/5ageZfOaYQdV/W79iNQvGyCskYcm+wqa
         ZgRoK/XkxvRv9u53RkSqOVIoYTMb+4kFx3XJ6vyWU9Sx7Dcz/M56GcAuDg0abWcI/A/8
         /fzA==
X-Forwarded-Encrypted: i=1; AJvYcCXfzUpPZrLU0Ust6EzoIyCKXv+a3vsOmaYELAaV+4iovM5hlSgvCPHjxRZvmxQqTxljYfILW3j1Hl1OWrok0sQ33jRAyPnogyUrjN5dv2iV
X-Gm-Message-State: AOJu0YzOLbN5AVXuepBL3Ec10W6OuGyzNJYnpbH8UGc4/CcektlyNddW
	z8mXxAChHRIdF9hvHJuGebxbzkXZ/z1CURF0HoDIG9hZzxMY53QdC4GHVbTWxg==
X-Google-Smtp-Source: AGHT+IHA3bNW2guVAt+WMRI5NRH124+82O/xVoeDAMG0vKPa1dxUzMh1soFnVi7QK+ZGgh7BKAvEEg==
X-Received: by 2002:a05:6830:2017:b0:6e6:7adc:e4ed with SMTP id e23-20020a056830201700b006e67adce4edmr1116558otp.29.1711150909238;
        Fri, 22 Mar 2024 16:41:49 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v19-20020a634653000000b005ce998b9391sm2130532pgk.67.2024.03.22.16.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:41:48 -0700 (PDT)
Date: Fri, 22 Mar 2024 16:41:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, Guixiong Wei <weiguixiong@bytedance.com>,
	jgross@suse.com, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, gregkh@linuxfoundation.org,
	tony.luck@intel.com, adobriyan@gmail.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section on
 walk_relocs
Message-ID: <202403221640.27DC5CB09@keescook>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
 <Zf1FGI6E3wStJSQT@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf1FGI6E3wStJSQT@gmail.com>

On Fri, Mar 22, 2024 at 09:45:12AM +0100, Ingo Molnar wrote:
> 
> * Kees Cook <keescook@chromium.org> wrote:
> 
> > On Sun, 17 Mar 2024 23:05:47 +0800, Guixiong Wei wrote:
> > > The commit aaa8736370db ("x86, relocs: Ignore relocations in
> > > .notes section") only ignore .note section on print_absolute_relocs,
> > > but it also need to add on walk_relocs to avoid relocations in .note
> > > section.
> > > 
> > > 
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] x86, relocs: Ignore relocations in .notes section on walk_relocs
> >       https://git.kernel.org/kees/c/6ba438a29b5d
> 
> Please don't - these are x86 patches, plus it contains an eyesore - see 
> below ...

Dropped.

> 
> Thanks,
> 
> 	Ingo
> 
>  relocs.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> Index: tip/arch/x86/tools/relocs.c
> ===================================================================
> --- tip.orig/arch/x86/tools/relocs.c
> +++ tip/arch/x86/tools/relocs.c
> @@ -752,9 +752,8 @@ static void walk_relocs(int (*process)(s
>  		 * values there are meant for pre-boot consumption (e.g.
>  		 * startup_xen).
>  		 */
> -		if (sec_applies->shdr.sh_type == SHT_NOTE) {
> +		if (sec_applies->shdr.sh_type == SHT_NOTE)
>  			continue;
> -		}

I think the patch was trying to follow the existing code style in the
file. See line 733, for example:

 		if (sec->shdr.sh_type != SHT_REL_TYPE) {
 			continue;
 		}

But yes, agreed, your change is good. :)

-Kees

-- 
Kees Cook
