Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9C4217737
	for <linux-hardening@vger.kernel.org>; Fri, 16 May 2025 06:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747375362; cv=none; b=EM1SWdzyymp+aenz277QZOZX37/lyFNI8B8ffOPch5Rqv8t9qwmffM9sm5P6us/reFKaEO2UH8NK7KU9MYHWl7HX4MEFwegZtbUULW0VOWQbfCl2sXEAoDtKwjvW+OjecR8bCF3Ntonj/gQlCoyUY/yQp8pecj+VhkVEwyzCMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747375362; c=relaxed/simple;
	bh=FFW0hqGTqpSSQEt0oM9VrJkvsbPrdiAwXszFH8NO5sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tebmnd6+l6pyOp88aCkIx4TMoqwFZv4LMnWw7P5IKgZttxBZFZYtCqTawlNScrorwJqPoNsqSqbKBhqqUITGIglQliK2qgibtAUV5qIcr/L1OQRK980KmDnCP4CPOJnMOIIhGWAavGk7ONtCz6Bp9GA0jny7cYa9SfpwPz0svwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dwOsgyFC; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dwOsgyFC"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3a108684f90so1100784f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 15 May 2025 23:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747375358; x=1747980158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRCpYLM2KigShkSCMx1Qo6LnPBeFu9CM55DsyR/vk34=;
        b=dwOsgyFCqUtAcxaArAly5u3HlrR0tZeCOZA5XgIZrvlgwqzqD8uisx2IOdMkXBU49w
         W1DzTjO/Hhg4Av5PY5hNm/SeQ1V5J6IH/7ZLOPBZJJ8g/2ZTcZuxIRqFOJW3J/Z/ZJH4
         ewH3fpXljxZToAHhvsKJ/AebACnS37CgT1HU8oJz7kNpDCpZF5MiYoJ2kTBkRn/VorzC
         0bQ0M+wUYBpa0WvNBbk8TJEGU2QItB0RNlqzb20EJ6wQ4dDrwQ5lTTgiWfUGZv0lN5Op
         ixN7sFbfiuQJONpzX9jtJegEwuserDLS6C233GiEx/Wh2F5fAjCE+IDslThlgd6QQScP
         HmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747375358; x=1747980158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRCpYLM2KigShkSCMx1Qo6LnPBeFu9CM55DsyR/vk34=;
        b=aM25xprLJSy4tslANn2EcCrgC4PM3EmS+I36CVHJuyuUScAbbW8t2KxpHBQclQUQF7
         uR6TiRY9e66OkdBAStLls/r3EFmHw2/3F0PvwCrp2DIxpTZa7ERnHBnmZ96WzOn+Vqxq
         fhoULBlX99c+Ov1LvkHld83GE5KX/Crwh1Be/eKlz9qnS8d436IX36FG/2rWS8lGDkaX
         3istdIOeBQLzs7a0VwathTFCDOz/qhSN0Hcx+Y+nhmvArBczTTAhH160yoL+v+H9RAmg
         F6Hr9HaThYnhIVHwB9Qmxl87AgeB3TTJ6V8i2KPrFQpLz7kwssEQAzcLNZBtw4x1MowO
         U4NA==
X-Forwarded-Encrypted: i=1; AJvYcCU9vGUKOu6qGhFFCiJBGhOPMoNslQJL8U3nu06kKCafLKR9SWslCeokUdUEiHDBXO5hDusSMwyZEqK/hxKNmBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Jce2KYAAqKK7r5LlriZEU27FR52gI3lph2YXPzsFThJx0Ncg
	CDQwKLO0iaYuKlvoWs3xURKUmHsXVA3g04HtCS/ngG1a5ZdZ5VwHOjIOwDD1yL4Ddig=
X-Gm-Gg: ASbGncvTP5dNhjfz4yDV/0lKiSiMDEl8H4fOIkz3BucCAmTsYZW5R4+FVtNycnmIvff
	xujlkl/iRfFT4wiGoN7rGBFsf+gEIrwfil7Npo+UjSpSqy5SHnnqOJPK70DUS42PoE8jIJ7Etfm
	bJ5JS3cdJG9to9v1Y4Db4TXaofavJ9udrVL+LzMfkn8jbetONRqQ0nqVHFBaAp1pICO9RDtJZJy
	pQILVinVubklpdFwRKLU3TIY8qn0WKbhKhIkJ/AU4z2iwfu2JMoHU4ubXsIkPTboYIuUtJwkSP/
	SOYTyLT2BOU6HpfKP0hVDR3KUro7pp5NSw3xwuMIXoTs8/INXS/Ibjlokkfqy9t53g5NCJE=
X-Google-Smtp-Source: AGHT+IExAX5L6jhpudxoopt/jOxKXl18l7eevqO0BjrQScjyjlt4zB8dW0pf982EIRtAZl2LOgjSqw==
X-Received: by 2002:a5d:4567:0:b0:391:4999:778b with SMTP id ffacd0b85a97d-3a35c84428fmr1663501f8f.28.1747375357714;
        Thu, 15 May 2025 23:02:37 -0700 (PDT)
Received: from u94a (27-51-34-195.adsl.fetnet.net. [27.51.34.195])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec12287esm1112560241.10.2025.05.15.23.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 23:02:37 -0700 (PDT)
Date: Fri, 16 May 2025 14:02:22 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Erhard Furtner <erhard_f@mailbox.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: vmalloc: Actually use the in-place vrealloc
 region
Message-ID: <yw7aumjfrefi5cdejjgtjfeusaihfh5yjuhry3xvetjld36fgi@ob4a6lwdlqt4>
References: <20250515214020.work.519-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515214020.work.519-kees@kernel.org>

On Thu, May 15, 2025 at 02:42:14PM -0700, Kees Cook wrote:
> Hi,
> 
> This fixes a performance regression[1] with vrealloc(). This needs to
> get into v6.15, which is where the regression originates, and then it'll
> get backport to the -stable releases as well.
> 
> Thanks!
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg/
> 
> Kees Cook (2):
>   mm: vmalloc: Actually use the in-place vrealloc region
>   mm: vmalloc: Only zero-init on vrealloc shrink

Thank you for the prompt fix! I'll remember to include a more thorough
note on reproducing the issue next time.

With the patchset applied, BPF selftests on both 6.15-rc6 and 6.14.7-rc2
passes successfully.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
