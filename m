Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8014667E
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fyH98DIr"
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B09121
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 22:30:02 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-45600aceffbso2938885137.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 22:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697693402; x=1698298202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0mvcPvIvt4s7DsmMbiMba2lJ7LM/I/Eni6xaPWBnwg=;
        b=fyH98DIrBmO5ZDaAUVbUO3nepKg84VxRukXgkwH3upZzmTgRAI+nfkI4/wZU+AQz5m
         fLmhgC5lUqHFZqpsMkUTOtIBDpfazTB7uG75IuOllfYyiJYrN6JxvCkiVyEmlyG1BkLy
         PD/UaT1BXnjN1RPcFOT07AD2GljWiWacq4O9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697693402; x=1698298202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0mvcPvIvt4s7DsmMbiMba2lJ7LM/I/Eni6xaPWBnwg=;
        b=dYxAzUeE+xU5c3Dw7fUNQgjL6AijlW1f+/WiwkF+Z4x3vIK6tOhAE2vlMapue6rCvD
         A1dwlOr7Ndd6YLJ9BQ/hinbXd3Y1sX3Avb/icvt0nQxoms+CtodkN6wBYDcQ+7IQy4X/
         JJJHGsog0do8o962WeSqwwh6Y0lXcyiIKqQIZw8tiFtDLbNYE4GopXNZ9tu8pznWFYEJ
         o+iVogEBdx0au8IS9WsX/nAOnXFvrgomRJUhjuD4nvXxO1lmUSGk6k4mpPXdaJSveQla
         6fhQvh/Rn0638SjPDxMpVAol9Rjfh4FwK/RJe1AWKkaIT4DYLlj/Q2/pyga+5UTV3sg1
         fJmQ==
X-Gm-Message-State: AOJu0Ywt6xGg/+6CAAheMH5l2/uzMpGaSMzT9CfYjpibuHklSaRWipCd
	+islu5gbqllSaH8NYoArkigrDA==
X-Google-Smtp-Source: AGHT+IEEkDzb7D/U1yKCTmLgjtdMAkT4JE/72BxAR6yv2XxWiTwygG4utrN5hEGATrT6E8W+/ziAAQ==
X-Received: by 2002:a67:e14c:0:b0:458:729b:4ebc with SMTP id o12-20020a67e14c000000b00458729b4ebcmr867223vsl.16.1697693401905;
        Wed, 18 Oct 2023 22:30:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n5-20020a6563c5000000b0056b6d1ac949sm2193974pgv.13.2023.10.18.22.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:30:00 -0700 (PDT)
Date: Wed, 18 Oct 2023 22:30:00 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: wl18xx: replace deprecated strncpy with strscpy
Message-ID: <202310182229.7B4E7394@keescook>
References: <20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com>

On Wed, Oct 18, 2023 at 09:18:24PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> wl->chip.phy_fw_ver_str is obviously intended to be NUL-terminated by
> the deliberate comment telling us as much. Furthermore, its only use is
> drivers/net/wireless/ti/wlcore/debugfs.c shows us it should be
> NUL-terminated since its used in scnprintf:
> 492 | DRIVER_STATE_PRINT_STR(chip.phy_fw_ver_str);
> which is defined as:
> | #define DRIVER_STATE_PRINT_STR(x)  DRIVER_STATE_PRINT(x, "%s")
> ...
> | #define DRIVER_STATE_PRINT(x, fmt)   \
> | 	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
> | 			  #x " = " fmt "\n", wl->x))
> 
> We can also see that NUL-padding is not required.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> The very fact that a plain-english comment had to be made alongside a
> manual NUL-byte assignment for such a simple purpose shows why strncpy
> is faulty. It has non-obvious behavior that has to be clarified every
> time it is used (and if it isn't then the reader suffers).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, a clear case for strscpy.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
