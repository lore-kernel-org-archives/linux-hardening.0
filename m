Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A26019B
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 03:18:32 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA910A
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 20:18:30 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3ae1916ba69so2005602b6e.2
        for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 20:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695525510; x=1696130310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/AAy6PIqi8JA3SHRERLqm80k0JlOd55TNJFXlfS2oUI=;
        b=cQRKnkvKqAcSOxrzVTzpuX1OW1olQi4qtyFfDQJ2NOkgjZz5mZtiS8AjbSeNtQpAnH
         ns30oW41LWWtF9+TkxVPbaggze7+De9BppNUgKVAJ4e3R1C5VT2T/eMcCl/D//M5V2pr
         hOzOOBl0nq4GXkTBkk8FS4TDctBsrJ3nvEM7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695525510; x=1696130310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AAy6PIqi8JA3SHRERLqm80k0JlOd55TNJFXlfS2oUI=;
        b=X7ggGmBRRtNnah97oQ6Jl53odQwn+6LMCnocTbHian0cNPQJkLSHDRj7cNwByPkPjw
         D7+/0UmbnMEteBpp+hGzYYNRbwk8Owb41ym/m9VW9NR/OtDNT9g/YFTUkX4dBtzYm9oX
         l3eH1tBO8kXvime9zN/CrMq7ZTKyD1yoemsK8ppT3C5aGh4PTNeKXUmbLM5PFJeBUerf
         AFMLmBOr7QSj47dxVkkVozSSkhF42g1+E6y08tfPkwE4zfiXtBvwwwBdgAz+gng2VzFq
         q+ZLeV4sBvDxjojwZ9hARyb/y0dMwXvJsgSUULiGbmfL3N+nC8O/hKcFg3l3IhRp805y
         oHEQ==
X-Gm-Message-State: AOJu0YyJ5so36aR1ecluAkJCGocY4dgVHO3FZjkQGnQhiNvFLmKLBhZr
	dbnzb+P1hwHRwd/VhYxcsJ48QaLljqnpR7KawDM=
X-Google-Smtp-Source: AGHT+IHxl8ow6piO8ZdhDMa7DDNx9sc75pSwTQukBg+zX/9NFg883HTo7pR+R2tuQSXm/f8dneJfjA==
X-Received: by 2002:a05:6808:bd0:b0:3a4:633:44d2 with SMTP id o16-20020a0568080bd000b003a4063344d2mr6364418oik.18.1695525510212;
        Sat, 23 Sep 2023 20:18:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001b86492d724sm6053970plg.223.2023.09.23.20.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:18:29 -0700 (PDT)
Date: Sat, 23 Sep 2023 20:18:29 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: refactor deprecated strncpy
Message-ID: <202309232016.6D6E70983B@keescook>
References: <20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 05:41:46AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which has
> more obvious behavior and is less error prone.
> 
> To avoid truncating the last byte supply `...length + 1` to
> kmemdup_nul() as `element->string.length` does not account for the
> trailing null as made obvious from it's definition (and associated
> comment):
> |       u32 length;	/* # of bytes in string, excluding trailing null */
> 
> ... this is precisely what the original kcalloc invocation did as well.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v3:
> - refactor to use kmemdup_nul() (thanks Thomas and Kees)
> - change commit msg to reflect ^
> - rebase onto 2cf0f71562387282
> - Link to v2: https://lore.kernel.org/r/20230919-strncpy-drivers-hwmon-acpi_power_meter-c-v2-1-8348432d6442@google.com
> 
> Changes in v2:
> - use memcpy over strscpy (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-hwmon-acpi_power_meter-c-v1-1-905297479fe8@google.com
> ---
>  drivers/hwmon/acpi_power_meter.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index fa28d447f0df..146c4f09c897 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -796,14 +796,13 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
>  			goto error;
>  		}
>  
> -		*str = kcalloc(element->string.length + 1, sizeof(u8),
> -			       GFP_KERNEL);
> +		*str = kmemdup_nul(element->string.pointer, element->string.length + 1,
> +						 GFP_KERNEL);

kmemdup_nul() already adds the "+ 1", so it's not needed here.

For v4, please improve the Subject along the lines of "...: Replace
open-coded kmemdup_nul"

-Kees

>  		if (!*str) {
>  			res = -ENOMEM;
>  			goto error;
>  		}
>  
> -		strncpy(*str, element->string.pointer, element->string.length);
>  		str++;
>  	}
>  
> 
> ---
> base-commit: 2cf0f715623872823a72e451243bbf555d10d032
> change-id: 20230914-strncpy-drivers-hwmon-acpi_power_meter-c-c9f2d8053bef
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
