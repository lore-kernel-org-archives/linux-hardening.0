Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F302199
	for <linux-hardening@vger.kernel.org>; Wed, 25 Oct 2023 00:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="elW45zfK"
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD7FD7D
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 17:27:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso4150965b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698193664; x=1698798464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TH/bxJhzk4YBMuPvj5C/RXj2mSj5ZNHWKAEzVgv6LAI=;
        b=elW45zfKHiHj1TAULAWxgVgKeQv8BHQRj+pr3j0026rN6lz4+0DpEhpKyKnvC0eu8/
         de577vi3jiMu5qa0zKFPdyk7mBVQk02BCZv26IFxhvihrhiA7I1pB3C4RAXDZcW6zw82
         nFWL5L/7QyvvV9nxYxtAFXnRON+6aDbPvTmZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698193664; x=1698798464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH/bxJhzk4YBMuPvj5C/RXj2mSj5ZNHWKAEzVgv6LAI=;
        b=IQxaI+rocp3/GWWAk+elfnH7PXHHhpbjsby+YLRhsmDPGY48iH4QN1JmmveZuFYHqZ
         rEWOovJp6D+Rha2Zx07546YiWUvOE6rGSj3HRltO8+av3VZ32E0GOrhzfeNAMbCRDQPN
         Q+Gqj9WeDAA8OBhYr+WSEqxe601B96qZuYTbYLqFEtCRaJc8Aiyls8RDiEdTgfMzlLtG
         XUX8s3V/eMEetOhrf1VW81lTh8lf696kjH6dECcvVnuRTEhHCRU9HxND10wa333plGKw
         hIARQxombiXaclWaDtv9i4aKLGt6FY/TIU/zxJ9prxyP4OiSevtgLEeOnFjb5hpFehI3
         Wnow==
X-Gm-Message-State: AOJu0Yyczeusjn5art6qSVGGldgnF/6JC0I3cSa6GsH5X3YXEVui7Idq
	F3klbCDzL+7SRnA2Ph13xS0oPQ==
X-Google-Smtp-Source: AGHT+IET7rqMR9OH/w3FWw9AK/oAQKufGhWIN9o/TsoD1Nk8vYc1Kzw4/JZETEyaQhasjAiYaaCKcw==
X-Received: by 2002:a05:6a21:a583:b0:155:5c28:ea67 with SMTP id gd3-20020a056a21a58300b001555c28ea67mr5196136pzc.38.1698193664123;
        Tue, 24 Oct 2023 17:27:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t22-20020aa79476000000b0068e49cb1692sm8139544pfq.1.2023.10.24.17.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:27:43 -0700 (PDT)
Date: Tue, 24 Oct 2023 17:27:42 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Adam Radford <aradford@gmail.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-sas: replace deprecated strncpy with strscpy
Message-ID: <202310241727.A4EB83D8@keescook>
References: <20231023-strncpy-drivers-scsi-3w-sas-c-v1-1-4c40a1e99dfc@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-scsi-3w-sas-c-v1-1-4c40a1e99dfc@google.com>

On Mon, Oct 23, 2023 at 07:50:57PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This pattern of strncpy(dest, src, strlen(src)) is extremely bug-prone.
> This pattern basically never results in NUL-terminated destination
> strings unless `dest` was zero-initialized. The current implementation
> may be accidentally correct as tw_dev is zero-allocated via:
> 
> 	host = scsi_host_alloc(&driver_template, sizeof(TW_Device_Extension));
>         ...
> 	tw_dev = shost_priv(host);
> 
> ... wherein scsi_host_alloc zero-allocates host:
> 
>         shost = kzalloc(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL);
> 
> Also, further suggesting this change is worthwhile is another strscpy()
> usage in 32-9xxx.c:
> 
> 	strscpy(tw_dev->tw_compat_info.driver_version, TW_DRIVER_VERSION,
> 		sizeof(tw_dev->tw_compat_info.driver_version));
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's not be accidentally correct, let's be definitely correct.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks legit.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
