Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A12DE717
	for <linux-hardening@vger.kernel.org>; Wed,  2 Jul 2025 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488391; cv=none; b=jwrYvfwm5GoqrB8HOKZWksBtRcVNMHGG6ehI7o20ncLejZOQRProxFIwy80a2SKSBb2cNG4dGjWBzS7SEXu+HwCIA3rZ+kxMSuHzRoUec5SbfNKwK1ikKPZhHqbQM8YseV6WhG8EMgLbVRcdIN8oWkDaMDs0bFrfO/ZOWT0NKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488391; c=relaxed/simple;
	bh=OM/N3vfyN38rYjqMt0HWdmQyhc3FJLqVHvmeWL7bwoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3LoCGWFpCGyL9Wh3jSCsRM7OQX0wkL7p8KfseC8Nhm6WYz0och9Vr7hLf9c5+b0URvglo49y3M9LWqiUEoE76bF+0fAF3Gi+qIqXU8HB7i5EFdQqteFO0q4/eBYiSwd4yHn4ckJgoMmRtubIgx+jfmPxscqKaN4eiarEkWMqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J4/uJYo3; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4/uJYo3"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-60ef850d590so1654440eaf.3
        for <linux-hardening@vger.kernel.org>; Wed, 02 Jul 2025 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751488389; x=1752093189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bL5BoIQSF4kEYcqDtH315fqcHVv64LYMw0cKskG8sFc=;
        b=J4/uJYo3Od5qyuoRZYBH1Z0EgZDS64JbyvC34GEJ0GaMIx06vNjFz5X3AY5CHloBT2
         8KoBvTYo3z8ccxTrjDDTyjIXuymlV9EJ80L2V78uosTygKKPxyhYUgxl8/gODKF3K1v3
         zoW1epB3JTZd9LkPGEXbG/7mof5+CuYSpjhNWjK7XNmk0Dj8rpubSPKWu+FNtJtzRLoT
         chUv7omp6UrjU8mBRAaKzy0774wDgJJQ8Eyi4fT+uJye+nJhhBlBEfesoSVEZynRSA03
         Y8/7UIut965TAGxFvLZ+fezf1dQJFfwOzbHwoWBp8PAX5bZofn0hfuXzbSerJE1Y6Ucu
         lsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751488389; x=1752093189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bL5BoIQSF4kEYcqDtH315fqcHVv64LYMw0cKskG8sFc=;
        b=ShTOWjDmxm8CgPJ+BnQMlASSzWj7Ce+GitmhGHh4AwfSyeo/52YhckqF3AB4rnDq86
         uCQtK3AnkmWcj9Jaz7JcnUzlwB1BWrSQXtz7eRFU0cN12EjbKkoo9spyqeGzl7y0HSLB
         4f5FzTMPJg0WgH0PMxJRt6AUGLqlz5levRkwERHnU/g5arR+Qfy3TjDQlHbnePYB9BSe
         aLE01NjnLYCS+ifXPM5S7tLK7nkfEq6xvIO3HDHIqZi7yq5zAG1m8uwBbx5a7RBB5CG1
         afi35iOwoWWOPSymBlUQesjiANc7KefXMWKniBXTVxIQdpctoMO1o5RFGYoyUK89aBVo
         LRKg==
X-Forwarded-Encrypted: i=1; AJvYcCV1APzQssBM1DxpGz2ZnDbvl49a30f/YYtvWz6pCP0EUvhQ+I1Xou3GuVZfgrTMIlUR6A0TI/lUZlbpf3LS0Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwubFajGzAvgB1oeejqr+0MHC9xPpSTD/9/0NoWUQWX+BpkRmbT
	GFl2upAEeHAhWaMLor8oZJZGdhg5kAwqbnF4esw+fEDj3rvn2Z50NxY03Myla5WyEE4=
X-Gm-Gg: ASbGncu8/gzSiyvWyF1k0dMBlmBzmFAujDrnzQNgX0/VVgZAyMiaAjgFAiKYZcVDvjI
	9/NOXYE0w2khIKy15X93cszMsyAKFMNy0fs/tgoS6x1UysWaomMgtWnLNGBGp2ExHn3+TpJJ9r1
	FSIiMyt7+DaqHzkRU1A0t2QpskxKuSj2/coXrx2UVbAkXJJd7G2GbJtTNjpneU2iHYEBtAcy/PZ
	1QjsnrO4Ts9gQSFpaQn0EGtrr5I1myyVrIHCtBCCE4LskxQZ0HERuWfhoE8SJ6G5eYqqwfTde+q
	83PWBuicJL839JIPAFmTzfz9sZ80ks8om+sFu7yrsHzYXtcNTVxbmIC1h4SBqpgZU318BA==
X-Google-Smtp-Source: AGHT+IFMTzbejqMD0cZgs5SByroCW7ZxVFlJ04bI5klIoRhLOikJrP7ipeBP4rLQw8DsXZZPLRBG2w==
X-Received: by 2002:a05:6870:514:b0:29e:43ce:a172 with SMTP id 586e51a60fabf-2f76c9fb610mr697401fac.28.1751488388997;
        Wed, 02 Jul 2025 13:33:08 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:7056:ddb5:3445:864f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afaff24a6sm2612291a34.5.2025.07.02.13.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:33:08 -0700 (PDT)
Date: Wed, 2 Jul 2025 23:33:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [bug report] printk: ringbuffer: Add KUnit test
Message-ID: <ad19157b-215d-435d-9b60-873d1cfffb04@suswa.mountain>
References: <eaea66b9-266a-46e7-980d-33f40ad4b215@sabinyo.mountain>
 <20250626082605-c5fbbb88-f6cc-4659-bea0-a283cdb58e81@linutronix.de>
 <20250702202203.GA3347226@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702202203.GA3347226@ax162>

On Wed, Jul 02, 2025 at 01:22:03PM -0700, Nathan Chancellor wrote:
> On Thu, Jun 26, 2025 at 08:59:52AM +0200, Thomas Weißschuh wrote:
> > On Wed, Jun 25, 2025 at 10:22:19AM -0500, Dan Carpenter wrote:
> > > Hello Thomas Weißschuh,
> > > 
> > > The patch 5ea2bcdfbf46: "printk: ringbuffer: Add KUnit test" from Jun
> > > 12, 2025, leads to the following static checker warning:
> > > 
> > > 	kernel/printk/printk_ringbuffer_kunit_test.c:91 prbtest_check_data()
> > > 	(unpublished script worries this an off by one)
> > > 
> > > kernel/printk/printk_ringbuffer_kunit_test.c
> > >     83 static bool prbtest_check_data(const struct prbtest_rbdata *dat)
> > >     84 {
> > >     85 	unsigned int len;
> > >     86 
> > >     87 	/* Sane length? */
> > >     88 	if (dat->len < 1 || dat->len > MAX_RBDATA_TEXT_SIZE)
> > >     89 		return false;
> > >     90 
> > > --> 91 	if (dat->text[dat->len] != '\0')
> > >     92 		return false;
> > >     93 
> > > 
> > > My question is that the prbtest_rbdata structure is declared like this:
> > > 
> > >     53  /* test data structure */
> > >     54  struct prbtest_rbdata {
> > >     55          unsigned int len;
> > >     56          char text[] __counted_by(len);
> > >     57  };
> > > 
> > > The size of text is not really counted by len, it's "MAX_RBDATA_TEXT_SIZE
> > > + 1".  The condition "if (dat->text[dat->len] != '\0')" is reading one
> > > element beyond the __counted_by() value so something should complain if
> > > we enable all the debugging, right?
> > 
> > You are right, we are reading past the __counted_by().
> > But I don't get any complains with CONFIG_FORTIFY_SOURCE=y and CONFIG_KASAN=y
> > on either clang or gcc.
> 
> You will need CONFIG_UBSAN_BOUNDS to see warnings from __counted_by()
> but they are present if I enable it with this test:
> 
>   [    0.507904] ------------[ cut here ]------------
>   [    0.507904] UBSAN: array-index-out-of-bounds in kernel/printk/printk_ringbuffer_kunit_test.c:132:4

Thanks, Nathan.  You are the best.

regards,
dan carpenter

