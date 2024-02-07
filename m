Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3C17BB4
	for <linux-hardening@vger.kernel.org>; Wed,  7 Feb 2024 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302566; cv=none; b=E/WDG2QgtFomCf1anDqIEK/5sf9x5JTbnEY8brMmMR0nfSRt2gLED8zQ0FQADEg9SenAObcKhiQccQnUFk15VmcKyzuJDB0D07wbHkKUz7UPUu3UpxabWlvXxme3IvKYhiDtS/mEA+14z/m1WPMPF3RYqm8biY8YiKNbBKXsaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302566; c=relaxed/simple;
	bh=qfsLy0hVGwKzPrnkw+4jzhgJbclF8ucq1TUc5eZptCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE4xW+TmHcGP/TpcfJ14VFFH8OYF6yEkC+Y29vLAmshaGe10RD3Mlc5fW3K6k07sui+lf+R1bGuExv+QbTmParNQ05gSOMaeDxnCm6xGbDShTIU0Elph0F9Jg5JSAC/FyBTS4mqLs5kZ1RG5g5iJn7+MqjrIqmcq9xNlm/O0hb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ug3UVReh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ug3UVReh"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7431e702dso4826355ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 07 Feb 2024 02:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707302564; x=1707907364; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=taLlJJFKKjXeiZCf5pE+xI1yoxTfeKphVpWOgqQieJ0=;
        b=Ug3UVRehy5wsGALuVZoLgZpEIvYrHXipschU09nNxrF93jSyLLVZgWTZ0Ox/7zuvGN
         BIfnrZigLjJSghL387qfpSMHhKYcl/LA1sM4oH36PJgzAHmeHB52PzbqUG5g3knOWPPI
         WoIgIR3K6JvX10zT3ll3F0+vUg7jvu4KBcCuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302564; x=1707907364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taLlJJFKKjXeiZCf5pE+xI1yoxTfeKphVpWOgqQieJ0=;
        b=KLxG896EBE0pml4SiXzA3UhXkfZrT8gAQ6tU6/ZcepQvQPLmvg9FDKYIlJ6iAlj8Ud
         0ZYdP0I20Uh12oT1f30tyGaCvNXgLiq2s1oO/mvwVrtbr8axX5TIonxhC8GNITaztPln
         j+NKcWc3hWJf3Izv3CKCNUxJh/QmD1fNUf6NtaOdBsGqtwVhUUAmVrOaqmC2HUpUk8OA
         lCQZ+hOG8AWxWhhDxSMdgOqviYYa1hOpDxesKk7SibTQCNgC7/02+9HjojhC7Y5GzZbx
         xp5++irIsRTstivA1Y2VnE+LmHU1YBEjK2HwysDO9RkFC9j8uGEDVdKLHYkd3C5JJ4UQ
         XaPQ==
X-Gm-Message-State: AOJu0YxXbEWnfycqja3V05zc41iCcO7d2ffL1643Ej59rRgyv16CPjIm
	yc8Gcuzox+LrMfQr3sprG7EnNh1bTa88PAUMcDZWFVAcCunET2/jPxTo6Hg6AA==
X-Google-Smtp-Source: AGHT+IGcqBnyCqUqdnANMHYt7Eh1Fhcfsr1n6hZQx/LknuAf/vrvb8y8pDKOVXVMm1pa4UwDyYA6Cg==
X-Received: by 2002:a17:902:ec86:b0:1d9:1b55:a37 with SMTP id x6-20020a170902ec8600b001d91b550a37mr5140051plg.50.1707302564007;
        Wed, 07 Feb 2024 02:42:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/Xq6Rw0I9P8/CdxpvfRVWPDp8TQ5TScBRkNyxdCa0MKz6PfFT1WcYn+mW7Sdwj/sSJaqkSPaho+UMiPF9lA9Z8OtSledd+/d8icFk2tHuuumlDRViuP9gCvEodOVp80qFBZ1BNjb9UfJ/FMlwctH2P4WiAJm3QW2JAypwrStCeuxqGrnOOM3E0peMDRejcESKuwS4kA5KPz5NZaRYx0RPuSsUnvPYfiGghnyXWXpoMXR+kPTyF0AoogtwATzqRI6G4wMob5eHAhNeiixH+c1JlkC16fD/z93ynacGZ5FotBYllp+FipCyZ05M8TagrCwy0B3LhleChA46mm8QBdy8Ybku/Rf0YtVg32h0Z/6IPanfC8+NDddv81xzsGwvJKx/Kn7at1sCZ/rs07o1aJR+juC/EdyopW3S++4B6cYA4/aii8LjUneBstCt0AFeURFPpckJAlVJV9OuP2e6qMDd
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b001d9daf742ccsm1099403plg.233.2024.02.07.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:42:43 -0800 (PST)
Date: Wed, 7 Feb 2024 02:42:42 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Richard Weinberger <richard@nod.at>,
	linux-um@lists.infradead.org, Justin Stitt <justinstitt@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Removing more str APIs (was Re: [PATCH v3 4/4] um: Convert strscpy()
 usage to 2-argument style)
Message-ID: <202402070234.79D2985585@keescook>
References: <20240206142027.make.107-kees@kernel.org>
 <20240206142221.2208763-4-keescook@chromium.org>
 <CAHp75Vf3c0Q7tV8ih5fRL6Bsjr6dhspFe+mxV7xUN=vZ1JdTKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf3c0Q7tV8ih5fRL6Bsjr6dhspFe+mxV7xUN=vZ1JdTKQ@mail.gmail.com>

On Tue, Feb 06, 2024 at 05:02:16PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 6, 2024 at 4:22 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The ARCH=um build has its own idea about strscpy()'s definition. Adjust
> > the callers to remove the redundant sizeof() arguments ahead of treewide
> > changes, since it needs a manual adjustment for the newly named
> > sized_strscpy() export.
> 
> ...
> 
> > -               strscpy(dir, home, sizeof(dir));
> > +               strscpy(dir, home);
> >                 uml_dir++;
> >         }
> >         strlcat(dir, uml_dir, sizeof(dir));
> 
> An (unrelated) side note: are we going to get rid of strlcat() as well
> (after strlcpy() is gone)?

I think it would be worthwhile to remove it, yes. Switching to seq_buf
in many cases seemed to be the clear solution, which is what triggered
my trying to improve the allocation ergonomics for seq_buf recently:
https://lore.kernel.org/linux-hardening/20231027155634.make.260-kees@kernel.org/

Its not in super common usage, so I think we can start chipping away at
it:

$ git grep '\bstrlcat(' | wc -l
480

It's more risky cases (using the return value) is relatively rare,
though, so I hadn't been prioritizing its removal:

$ git grep ' = strlcat(\b' | wc -l
13

(And almost all of it is in security/selinux/ima.c)


As a comparison, strncpy has even fewer currently, with Justin making a
dent on it recently:

$ git grep '\bstrncpy(' | wc -l
311


> 
> ...
> 
> >         if (*umid == '\0') {
> > -               strscpy(tmp, uml_dir, sizeof(tmp));
> > +               strscpy(tmp, uml_dir);
> >                 strlcat(tmp, "XXXXXX", sizeof(tmp));
> 
> This code is interesting... (Esp. taking into account making a
> temporary folder out of this...)

I have tried to avoid reading UML code too closely. ;)

-- 
Kees Cook
