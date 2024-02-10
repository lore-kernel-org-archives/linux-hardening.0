Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BAE25613
	for <linux-hardening@vger.kernel.org>; Sat, 10 Feb 2024 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707549562; cv=none; b=mJepw2vN2Vtkc9VqyjsieCGhw4vkdPppq3CBgHDCh4i5S594nRcsMhd/NCbjq+9o7RfQRa5O37gLzGBxnd0pxv+5vLX2TCHe77ZHVWj/Ca8J8w0h9uBO9shr9cVqzeqeRE5nv4TkZgnr4ZG/8zuDR75d+d/V7pNf4pS8I837d1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707549562; c=relaxed/simple;
	bh=Oc0EBRK9uqITwsszdT09901GM1Q/2u7GgM3/QDZCQZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d46AaSTTRzb+Zg7EW9VsTdJyM3v4M7G7Qcg4MTPcv/C4wFMIx/vNU0nvptEb2GTGeQjKK+js4J0CaR+WluikXiV0lOAxQMiB3TsN/d1F0gz7nX97av2vVZ7x9X2c09miRhbSasYRV1mc2kc//U+bO47I363l/rXFt9GDE2Omc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kN9mS19Q; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kN9mS19Q"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso908153b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 09 Feb 2024 23:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707549560; x=1708154360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yc89+WT2K9C7UzU3L+XR8z6YxT2I8PcZfmFzm/UVeHQ=;
        b=kN9mS19QNfK0XOgLxiNMjsXQiNNP+q1mo/8QJtAbmBbMLIidXxooCnK2dYpsI0Usic
         vXrHbE149J6jR3K0l9MyqlE75krsjkTAzK4TSM+5SReiFi0PzJHhCrqV7y2rHAA3nqI7
         HsBpCorg04R+UqE5GDumcw+Dl2UQTsTadapME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707549560; x=1708154360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc89+WT2K9C7UzU3L+XR8z6YxT2I8PcZfmFzm/UVeHQ=;
        b=SWplGJ5rWQt6chbXACOQkifP64gbP+nsPHt84Ei/pCMgXMDnyr1Yka5jadURw6Jv3X
         x2jvFdQh6RYbyiLmQywI336nQ4ej1ReHwGiSUG7asWWtdlp+2Pcb9wR+0vtbUfvS6LLU
         E0Lq7fJQm3hr04+qSkAoBbNClcyKqqmcl09BlRueZASb5qY0xgb04rfrtigdlAzrrkFn
         0SHvYQhsy9xoe0XuEXbHFwl525zEGKCWthuo+FVmAojcxf841p6ObW8SC5txjlHXE0LN
         gCTXK1IYzZxUQ+dw8WdKUck7G9fTwnBF499iBnmIIgQYAymknCvo2+PGnzff+EQotgGu
         PXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyAm1rh5Cou+dBtkW8uWMPi/s8g/0128QS0dFmlMwi3ivYgADAj83ZdDXKM36crHtulL4StQKmyHQ+6cVKbu9HB/68JD/FKOkcX7a5gq0L
X-Gm-Message-State: AOJu0YzEUmK7U6wswiCmWeWWAj+3NT2xiqTZRGhEXJEwZZvkXGezBKH7
	bThhep0IjDNkBkT05AFsIbGtN24PrkxxpsMqUnH7RyFWA0kYj6gEz4IVcWze/q0AfYm3bQlfYBw
	=
X-Google-Smtp-Source: AGHT+IEPQDd3yzqq7wHAkPwcR++Y0e11jkamn1vFUyjID4OpZ/pAXWdBEBT2rm0acRY6Obyw9cqZ8A==
X-Received: by 2002:a05:6a00:2d15:b0:6e0:a858:fd65 with SMTP id fa21-20020a056a002d1500b006e0a858fd65mr992866pfb.9.1707549560449;
        Fri, 09 Feb 2024 23:19:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgkLixkVIEesuTVj5IgZD9KSKNgHzC0ZsSGZur8TK9VNsdTuNu5uUrO6YwAxloZ+4r5VvZKjPf+1oxMDHVJXLjeoVN8D4iB3M3y9frd/iN10cxEZS6mpTy/Yk5O39X53fTkkwiRw4CrPhJDBi7uziDsUGBkpT6w2e40JGA5LssFipb/U1ZuF1OVGRjZIeL7yYFV8aBL8bGZ4v4fSgaXG+WfB2T5xqgY4Im5+CsNkwcP9vlLkba2HXjC03ENHUxFJro42dX6m9NosW9PbaQM8WPQvNS6A4iw+NMbFY1imIPEeASAr77X2SyyQezyb6fw+eAwVnD8w==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f32-20020a056a000b2000b006d9c0dd1b26sm1719746pfu.15.2024.02.09.23.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:19:19 -0800 (PST)
Date: Fri, 9 Feb 2024 23:19:18 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@black.fi.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Justin Stitt <justinstitt@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] x86/tdx: replace deprecated strncpy with strtomem_pad
Message-ID: <202402092318.F5C569D7C@keescook>
References: <20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com>
 <ZR0VJsgA6g0Wk4dq@gmail.com>
 <ZcONt_he_08batik@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcONt_he_08batik@black.fi.intel.com>

On Wed, Feb 07, 2024 at 04:03:35PM +0200, Andy Shevchenko wrote:
> On Wed, Oct 04, 2023 at 09:32:54AM +0200, Ingo Molnar wrote:
> 
> ...
> 
> > > Note: Ingo Molnar has some concerns about the comment being out of sync
> > > [1] but I believe the comment still has a place as we can still
> > > theoretically copy 64 bytes into our destination buffer without a
> > > NUL-byte. The extra information about the 65th byte being NUL may serve
> > > helpful to future travelers of this code. What do we think? I can drop
> > > the comment in a v3 if needed.
> > 
> > >  	/* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
> > > -	strncpy(message.str, msg, 64);
> > > +	strtomem_pad(message.str, msg, '\0');
> > 
> > My concern was that with the old code it was obvious that the size
> > of message.str was 64 bytes - but I judged this based on the
> > patch context alone, which seemingly lost context due to the change.
> > 
> > In reality it's easy to see it when reading the code, because the
> > length definition is right before the code:
> > 
> >         union {
> >                 /* Define register order according to the GHCI */
> >                 struct { u64 r14, r15, rbx, rdi, rsi, r8, r9, rdx; };
> > 
> >                 char str[64];
> >                 ^^^^^^^^^^^^^
> >         } message;
> > 
> >         /* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
> >         strtomem_pad(message.str, msg, '\0');
> 
> This comment and size of union seems not in agreement.

It does agree -- the comment could be more clear.

> How does the previous code work if message indeed takes 64 bytes?
> By luck?

It's saying "the non-existent 65th byte is assumed to be %NUL". As in,
this is treated as a C string, even if it uses all 64 bytes.

-- 
Kees Cook
