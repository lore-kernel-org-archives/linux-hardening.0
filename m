Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0304F839FD
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427909; cv=none; b=HLzmFdVrWuxgjAV1IK+oNZmO9FMmkYN2qwnA4f8ENEwaI1lq2W8wRG4MYt+0MhYjeqiyKv+hRpgDz37VLJnOPOD2n7GC1z3eS9r1fsdZz3LATWWAnn5jnwnGgw8WZOLJLxuW6Oy69QzFXfm1KARozkPrJq8bWp0WqkSJ/DzHuHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427909; c=relaxed/simple;
	bh=i6lqpid3/ifH983zglzaRmJlc7nvZzdwdzL3SlBT1GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSDMls2euWv4SmRQ5T8Qi1hpKRb3WhzJAShFzx5MBi5oNIWNFCpvEueyYUNS1RSifJWrRvYyq79IJlXwpXgKdpPii2Mjczy9Hbz2gqmLj0W6U+kL9kfikvdnLiCPJ8BFgmLFUyggM5hExo0jHn1pWHBzXzZgUrEeAz9mlaT8Idg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZDD1p7Ek; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZDD1p7Ek"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed32341906so4628168b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714427906; x=1715032706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt4pmVDe1gHqk8GSYJUn0euBaNvq8Bf6JSXO1Xsdf5U=;
        b=ZDD1p7EkJ56UE59hBbkIXdaJny5SS7tlrgfC95duBrz9Jy/R1boGAkiR3UTX8rLp3l
         CD5bhyv129qrcu3CneUU2vuGss+Nj5M+f8MMPk3Cvu5PMnE4s1Y8FYNDfCgz2jlR1Gu6
         MQkbj65WMSZJ2GGDsfviDw40TgIDVVVQgynXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427906; x=1715032706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt4pmVDe1gHqk8GSYJUn0euBaNvq8Bf6JSXO1Xsdf5U=;
        b=cAAH+Ze6sb6LVRRmqJlLby4O/qtwLszftgQrUVvjEV5ATf08fg+oSpJoqtZGCrabEg
         vjVKb+jaPdeqGrac/CM2IWM3COdSavIh9ye8EYIVIGd62Lj0tFZnWeDOhsOL2B6+1eJF
         729y5NmX+opsgVT2ud8EhPrx/Kp+4EYf2/mqUcupHwVX3NaobmEte9uLjyQiAMpajYss
         aCEyR470ABg4ombGVsD2bWzAUN1dlyGuc1bsj0XFQidQJnYulFU7yhXz4mVkykBOtfvD
         L+YQbF0tvfBDJXGuau2byq8mhK3U/2EhJsQarf2dHosi/DWLYaXCfdIbsH6K4TjPRGfJ
         WX3g==
X-Forwarded-Encrypted: i=1; AJvYcCVbIirbpygSoHmXujB1gRl2DR9NCwJFW+ZgxMvS2s8FyaT0lMQscjtlavRHFIW3iobgfz2Q2iaokXOqDQErp1T7GHAwPEqk9G1Xuk5SjKh1
X-Gm-Message-State: AOJu0YxzqqDnZH15zJSBDeA+MiZL7oyIijj5G4X7rNx+ls5S6rARMFqg
	BxvXkyDoVnhhtKjvuxX2M8b267+9qszxXu1Ek2yqiB8bGQnn6HZybhr8XeRM/w==
X-Google-Smtp-Source: AGHT+IEsWmJgVhdteBNFpcp99zENVzWfPLc9Uvz/OFqNT+c1CKX09b/Qwv6MZ23E7a+08D6po9slVQ==
X-Received: by 2002:a05:6a00:2315:b0:6ec:ec8f:d588 with SMTP id h21-20020a056a00231500b006ecec8fd588mr13038861pfh.16.1714427906391;
        Mon, 29 Apr 2024 14:58:26 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ff3-20020a056a002f4300b006eab6f3d8a9sm19709557pfb.207.2024.04.29.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:58:25 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:58:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] PM: hibernate: replace deprecated strncpy with strscpy
Message-ID: <202404291457.8E79DC5@keescook>
References: <20240429-strncpy-kernel-power-hibernate-c-v1-1-8688f492d3e6@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-strncpy-kernel-power-hibernate-c-v1-1-8688f492d3e6@google.com>

On Mon, Apr 29, 2024 at 08:50:30PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This kernel config option is simply assigned with the resume_file
> buffer. It should be NUL-terminated but not necessarily NUL-padded as
> per its further usage with other string apis:
> |	static int __init find_resume_device(void)
> |	{
> |		if (!strlen(resume_file))
> |			return -ENOENT;
> |
> |		pm_pr_dbg("Checking hibernation image partition %s\n", resume_file);
> 
> Use strscpy [2] as it guarantees NUL-termination on the destination
> buffer. Specifically, use the new 2-argument version of strscpy()
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  kernel/power/hibernate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 43b1a82e800c..0a213f69a9e4 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1361,7 +1361,7 @@ static int __init resume_setup(char *str)
>  	if (noresume)
>  		return 1;
>  
> -	strncpy(resume_file, str, 255);
> +	strscpy(resume_file, str);
>  	return 1;
>  }
>  

Yup, this looks correct to me. resume_file is:

static char resume_file[256] = CONFIG_PM_STD_PARTITION;

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
