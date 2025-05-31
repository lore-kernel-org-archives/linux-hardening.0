Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3128D824
	for <linux-hardening@vger.kernel.org>; Sat, 31 May 2025 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748666022; cv=none; b=YCq6brjA/fjlOQYFvZDPIYJFlyaR1pasltD74MiEeapzRdPsZYVqWnxZAHvVGPyhUXQy/v8lkN7skrl1u5ewXBSGApsz8N4JaKO7fbtqudwgOAbb4T4P9hfOvFzcZBiWYdnRuUIGjOGOsfuXIpZu0pDQKfoD+mUAsPhUH4s7IpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748666022; c=relaxed/simple;
	bh=HI2gTG2hl2pvZ/KehF8We4iETc1Rc/s1LqS1slee09s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VH5evixlGowLHAqX7VdTDxPUey3keAjJt4+VXKP5BXk0tYrHahW4HtLHA9KoIbGCwQPi1gy7dF2sI4heECyZfLEabnZWUB18m+WfzTD4CPUC5FSrUL3a/Ntj9cbGRFapNJq25U0/1A+YEEEkWoKdi4yG50rjOsou16RwDSLpO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgJSnE7k; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgJSnE7k"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e45d07d66fso795032137.3
        for <linux-hardening@vger.kernel.org>; Fri, 30 May 2025 21:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748666019; x=1749270819; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zqbrbMe3YXiRMwo9c+Rf5UBvsiBQDLSy82IcmZbu5Oc=;
        b=wgJSnE7k09IsFYN/7n1yxalLzXS06aaIk6RROi/cYBLbu6P7494EERp6zVYNds5Twq
         6yPTgchApkczT1rNGml55Z5dmlGssrqzRqcV0ygg1kwr7RpjhFYsLD+tWVPz7hbVlrDe
         GiM+hovNG0mIw4KQqP7y6sai2LI78gGpgsPyyj3zF8M3GVaspzdEqA40T6XUrJ4XYSOD
         BNi4z1gFxM7mhnpyFEujahD2UzBso7+DV2zQloP1XhCk9FHq9D9QE5OiZLdOr5bGYL9+
         9xeUgqVnerHmqEeel6i8BcbxsmlbvaT7U9D+EFICJt+Lxbe/qOBX8I5RIgKf7PWd1sDY
         sZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748666019; x=1749270819;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqbrbMe3YXiRMwo9c+Rf5UBvsiBQDLSy82IcmZbu5Oc=;
        b=T9k2byveKaC/JgLPpDx7Qa4QpU3qtmm/dmCfSdwpz2TffBOUM33wofZMb1rmhWu9OU
         SWG0f802qSJRsL0kGVPjqoIJNby7XpqWPzqrS+S2q+JXA1WXgboYDCYOhT+a8RPfxHfU
         Gn8fvksHPgAYtMtqYvYPHjecJAHFkrdZ8jrQVdPk+tjICxm+ckNqIvU6zgMLayu38IZQ
         ScxcidIGo29Z2H3wJXDjyg+LJxpTxH57EhoyyB9Ni45zmTQU44wv25vqkZVxbg9QsNv8
         9MUue6oHmcZi5uDJLM9jsfbqz+zh2b8RtzDxsWrbcqfQ1e/8k1VMDTXaqo/VwgbU6K9G
         4wxA==
X-Forwarded-Encrypted: i=1; AJvYcCXnGbfRpfIEr9Yjtidc0AUlggZex/L5vc6oxVJyrdI1RDXv8h4cetugozoMas8kX1LOLt1TZ+pTxog+LfEl1m0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IeLmFaUni0wFKPmCiaMdly9ioyZFEYfeTX7YHtPzQ5leUMS1
	SCj1XMNcBhK+mOh81o3Q7jkcjvwRKgAwurH8+5Y6IvIJbF4kUTWn+dzXmmSpW5I6Gzs=
X-Gm-Gg: ASbGncuzaiD/1GQWlMkCFjDhoFgHDYJKW7gy9/ppJlPh0ljGbYxiyoH5mr1sfVmhV+h
	muLp+d0Z7x9HGVtSFte2XoU1xvfFSmEuBNdsB2h/ssL1uupJr4EdAxnnudKN0UtXW7ontc2QpWB
	SMmF0az4LgZcGs7Il/kPurKx8NeiS1bIVaHHy6mESZ0V4ATOiGhHefdGGsy4cuL4NNPhlSlJHDb
	PNEXY6MI8AYFQ7nn6liVwFhoVaKAUt0tZO1rKWW5gkttznkZlwHG5zLLOF6kVNDZXRf+JMHkS+R
	AdIjJv94cFfGBhRqIYi4L62NeaS/mDRBsqJVua694ui6yirKYx48O/M56N7bmg==
X-Google-Smtp-Source: AGHT+IGv7Tb/KDlSqfX6d227HdrO3jMfr3OxdCnhGfg9ufIQMlxqL06v325RxiyNFVQEv6ylUk+//w==
X-Received: by 2002:a05:6102:50a6:b0:4e2:9b58:ed8c with SMTP id ada2fe7eead31-4e6ecd68c73mr4049536137.9.1748666019372;
        Fri, 30 May 2025 21:33:39 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:88d6:6a4e:54ba:b668:be6f])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a2c74easm3722422241.19.2025.05.30.21.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 21:33:38 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Kees Cook <kees@kernel.org>
Cc: Ingo Saitz <ingo@hannover.ccc.de>,  Nathan Chancellor
 <nathan@kernel.org>,  linux-hardening@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] randstruct: gcc-plugin: Fix attribute addition
In-Reply-To: <20250530221824.work.623-kees@kernel.org> (Kees Cook's message of
	"Fri, 30 May 2025 15:18:28 -0700")
References: <20250530221824.work.623-kees@kernel.org>
User-Agent: mu4e 1.12.11; emacs 29.4
Date: Sat, 31 May 2025 01:33:36 -0300
Message-ID: <87iklhjt5r.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello,

Kees Cook <kees@kernel.org> writes:

> Based on changes in the 2021 public version of the randstruct
> out-of-tree GCC plugin[1], more carefully update the attributes on
> resulting decls, to avoid tripping checks in GCC 15's
> comptypes_check_enum_int() when it has been configured with
> "--enable-checking=misc":
>
> arch/arm64/kernel/kexec_image.c:132:14: internal compiler error: in comptypes_check_enum_int, at c/c-typeck.cc:1519
>   132 | const struct kexec_file_ops kexec_image_ops = {
>       |              ^~~~~~~~~~~~~~
>  internal_error(char const*, ...), at gcc/gcc/diagnostic-global-context.cc:517
>  fancy_abort(char const*, int, char const*), at gcc/gcc/diagnostic.cc:1803
>  comptypes_check_enum_int(tree_node*, tree_node*, bool*), at gcc/gcc/c/c-typeck.cc:1519
>  ...

Great! Thank you.

> Link: https://archive.org/download/grsecurity/grsecurity-3.1-5.10.41-202105280954.patch.gz [1]
> Reported-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Closes: https://github.com/KSPP/linux/issues/367
> Closes: https://lore.kernel.org/lkml/20250530000646.104457-1-thiago.bauermann@linaro.org/
> Reported-by: Ingo Saitz <ingo@hannover.ccc.de>
> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1104745
> Fixes: 313dd1b62921 ("gcc-plugins: Add the randstruct plugin")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Cc: Ingo Saitz <ingo@hannover.ccc.de>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>  scripts/gcc-plugins/gcc-common.h              | 32 +++++++++++++++++++
>  scripts/gcc-plugins/randomize_layout_plugin.c | 22 ++++++-------
>  2 files changed, 43 insertions(+), 11 deletions(-)

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago
