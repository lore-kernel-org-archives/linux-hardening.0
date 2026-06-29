Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E33769EF
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725151; cv=none; b=HI8BGYtdvf2U0uEZgqU/Vw7mE/BR5ZXUHnFNywequWh0Z9y3wjZEnUbKJzd/iUmeyb2RI/sos27btxYzwBeaZYnfXY0UM/cOB5/1Tk248wYkPDj2Bb7quhw+Yj0/ktmq/K/EuTaV04koqf2uCA1e8hwPSTDIrLeGlZ8pYm/ZSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725151; c=relaxed/simple;
	bh=bwnmgqddSsR2yWJdg4y/ToBDVUT0ZwX4H8eihcGW/7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1Q9q7B8hjREwvCMwvZmOC+h61Ci6O+S/WesByIA8lJgJtgjtAb+YPmOu1OHEjsJ3sL2khdYwPM7tRsvgmUb2ZPLI1kpGfeNkgrj/Eeny2c4dfUEcThvILUfqKzf0LX4O/yvzB2Wv/gqWY9QHR+U7l1qHOxuaMmb+dPUSIrhH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=CavymvKe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="CavymvKe"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49319ebb3a9so11260435e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782725148; x=1783329948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCJ+3VriZa2HDxVFuhLXbhDbJmzauFoiNJi8rwd7lTU=;
        b=CavymvKe3FOe6BG/PaMybIL6ptrZOn7WEWqyqVeeuSmM98Oq5wbELprt2nNTO+1Av9
         GxWTIjildYjMhUFBYpch5NELjumKZRw2M07x2CD4rZDHgUnJjK0+hXstKH1RQsUYAlSQ
         uW75OrqX6u49quAcAhXUsDMja2NX+GLbWitnDb+xUIRAHWldcWZODQFATXH/B1gqTCx0
         b59xwBFPXSpVXTR2b+MTl8XJyWjinE7FkwCX/ehPX0lgcMbZ9gbfZeGShw1M1MG62T38
         3/KS2i0hX5zK5KMCav+llED7+3LjaLKQ5f2DYtgTzSH11xnPjyoSJqbFmmlIPWFiGklk
         ZTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782725148; x=1783329948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCJ+3VriZa2HDxVFuhLXbhDbJmzauFoiNJi8rwd7lTU=;
        b=KJsvL1D/SwPfMc/HjrTuQ1xXoEWtl3qTRUau+ssVg+ft21bSQhFKvP40eYkXc2HPph
         mN74bbJ5FmT3L3YHLHKpU2yWNmDdcF+WCdNLvcsJFUolqNQXoKiBkgievFMLWvINw4hk
         yJr2kAiMiGhbjL1AmdibUV26hA7hg/chVLoiPvcPc+amzYHYQ0Ak3VMANF9kEBS7AsBH
         qe4H5Tp/OJdlIkuLhOR8knwQng0bKwAj1dARClh1Yct4Wa+VKP84Bm4aTIJrTf3I2kUn
         hSjwTnopiuNrT4FtrT4WfQgUzbu64HJIo8xDamvZX0/MRIXM5myWk21kfZWh69PUmnbt
         vhBw==
X-Forwarded-Encrypted: i=1; AFNElJ+gxjhKmf951VEj8q4j6V26wUjrnjw1LcqgEQ5X9MmeKpiaUmKX8uFYJrZripxisRKWCjzWTq3G0gozXM0PRT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLC/IkoGaoPo5V0oQ/KIL6dvhUZtnJE00Q9GNDP+ANqVIB2zj
	MaIxux5AucWpi1fe/UXp1aWjYuvAHp/YGDdFHamvrCg8tBB4IbFwM36iBo0fFSDyGK8MPLlIc+9
	mQTjP6hg=
X-Gm-Gg: AfdE7cl7FuZa0B1TMDT6/URu7Ue+0niwUjjl+azk6Jw8yh/k1vOlZhUOhxTBqHDwzcL
	vmbZfAWbrGUg/hcrcnS8eZYOTIjIQibnTDEvJPPJJstFaqNDCt2XexQErmdfJqJPLP/PwBux0nN
	F6yMxhOCiYaoMg0kppTzAFAfsk6v/kAy2xjqOQ1MRpv7AveywaL8p1Q90gCZMjMIGuCnsRJ7FUF
	Zy4aR9N/3HQpk1bIB1Y3y7gfjGHzbj4f9+JcaonC30QCNsekcvsxpWo13GncHxrCOmSiP22aRd0
	Ip1bsRDUITuBs0fb9+jpkiEe0rL6ijMOcMnMScSgnz9jFRpwA6OVTlLQLlYQXkbzP/v7IAX+F3f
	Q+7Mgf2+USP2Zb+1G/O8o5PJV1mVbP5YnG8X7J5HSf+zGEqUZdIyh/p6LjLNrZ8AdnskdYGleOy
	mBPWkkXMf7FlIuSJRIh04XJoxLOxMVvhaHu6f/XdsKAH7wiem5nab3o54N9gVuBtKSYAhCvzAHV
	6IZotSswlDN5iMAGy96wKV4K8GzorJp52SoRHzS2KOekcfuXQV+N38vVQ4HrDTTs1tB3IG9lQ==
X-Received: by 2002:a05:600c:1392:b0:492:488c:f630 with SMTP id 5b1f17b1804b1-492668b6847mr266804345e9.34.1782725147829;
        Mon, 29 Jun 2026 02:25:47 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493adf3d98fsm69281375e9.8.2026.06.29.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:25:47 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:25:45 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Daniel Thompson <danielt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH v2 next] drivers/misc/kgdbts: Replace strlen() strcpy()
 pair with strscpy()
Message-ID: <akI6GewIobXk7RBs@aspen.lan>
References: <20260626083821.2981-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626083821.2981-1-david.laight.linux@gmail.com>

On Fri, Jun 26, 2026 at 09:38:21AM +0100, David Laight wrote:
> Use the result of strscpy() for the options overflow check,
> if too long delete the config string.

This still seems like very little information for future adventurers to
go on.

IIUC you are setting config[0] = 0 because that puts the string back as
it was before the strscpy() altered it by writing in a truncated value?
And that is based on the assumption that config is still zero-filled when
kgdbts_option_setup() runs?

If that's why this code was added then explain that rather than
explaining what it does.

Also, if that really is the rationale then would strlen()/memcpy() be
cleaner? That way you would never write a bad value into config in the
first place.


Daniel.



> Use two argument strscpy(config, kmessage) to ensure no overflow.
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>
> v2: Note that an overlong config string gets deleted.
>
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
>
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
>
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
>
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
>
> Note that all the changes are only compile tested.
>
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
>
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
>
>  drivers/misc/kgdbts.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
> index 9d3218330f0a..2c8f10b8ac74 100644
> --- a/drivers/misc/kgdbts.c
> +++ b/drivers/misc/kgdbts.c
> @@ -1069,11 +1069,10 @@ static void kgdbts_run_tests(void)
>
>  static int __init kgdbts_option_setup(char *opt)
>  {
> -	if (strlen(opt) >= MAX_CONFIG_LEN) {
> +	if (strscpy(config, opt) < 0) {
> +		config[0] = 0;
>  		printk(KERN_ERR "kgdbts: config string too long\n");
> -		return 1;
>  	}
> -	strcpy(config, opt);
>  	return 1;
>  }
>
> @@ -1144,7 +1143,7 @@ static int param_set_kgdbts_var(const char *kmessage,
>
>  	/* Only copy in the string if the init function has not run yet */
>  	if (configured < 0) {
> -		strcpy(config, kmessage);
> +		strscpy(config, kmessage);
>  		return 0;
>  	}
>
> @@ -1153,7 +1152,7 @@ static int param_set_kgdbts_var(const char *kmessage,
>  		return -EBUSY;
>  	}
>
> -	strcpy(config, kmessage);
> +	strscpy(config, kmessage);
>  	/* Chop out \n char as a result of echo */
>  	if (len && config[len - 1] == '\n')
>  		config[len - 1] = '\0';
> --
> 2.39.5
>
