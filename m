Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEC221A15
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 18:02:08 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF810D
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 11:02:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c5c91bec75so47357265ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695664926; x=1696269726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8eSsSBJ8Vq4Qi6ZMfaWUsInrqRpqyqKIrqUaEPasYuI=;
        b=BI5J06qjkQ7ljgnowfX42qKmMVLVqjKY9nFTkGMX+7kt2qyLHxaU8AHwc8CMMbQTHq
         EMkXck8eAHwtyetfitVwakO3E8PSKHpQ/NASXyVOj4TgzGVaeJlfZe1bE7oTHtmX9kCt
         /s5Zl8J292KOITX6AqFJbfYlWR2kjXivcBexo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664926; x=1696269726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eSsSBJ8Vq4Qi6ZMfaWUsInrqRpqyqKIrqUaEPasYuI=;
        b=fjQXhuhqny7p7tkB32OX1tHdGavN67uB4s5a/kKnwvRESWhTRc84w9T6lcpjxmIf4g
         D3iIXN2ibo7hDOEYd7YFaWlveSJ/ZOEQqr7n4ZvpgHmZikb4A5KAmoUZ8dAY1w5NZZFC
         asu4pbD5W8aZ7CqE/nQNgML6aBMeiCLugSoiZDGA2NsISUNrBH2OL4V/5l9o21ZOrHhJ
         IjxvXrKZoQkmUVGIs4HhGOuUekCsYUMip9cyvWyOIciW8Q2qDFpLCvI37O0n0QXY6AYa
         ymxRY5UCgE5KpYMp+361BcWCKWGGDPWq0vGPiBnh8xQUSUDYzgsopMDcNpQ6QSOuud0G
         8/zA==
X-Gm-Message-State: AOJu0Yy5y9BSFmUi2hXqondxPF86jJhIk7stePHVS2IXBqGXaMz9RLeQ
	2PxyCDBYfuvTbp8U9E+VUvTdMA==
X-Google-Smtp-Source: AGHT+IHld3ZFV0+XNf/j9xLn/Bc27rzyru1qiqAoZ2oWmrXp9wmOwRx86JiK/FA3B/MoWE1xxRrRCg==
X-Received: by 2002:a17:903:2308:b0:1c6:2acc:62ea with SMTP id d8-20020a170903230800b001c62acc62eamr1069374plh.57.1695664926254;
        Mon, 25 Sep 2023 11:02:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001bb28b9a40dsm9161300plh.11.2023.09.25.11.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:02:05 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:02:05 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: (acpi_power_meter) replace open-coded
 kmemdup_nul
Message-ID: <202309251101.1544F5F@keescook>
References: <20230925-strncpy-drivers-hwmon-acpi_power_meter-c-v4-1-3bac7534f10f@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-strncpy-drivers-hwmon-acpi_power_meter-c-v4-1-3bac7534f10f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 03:43:23AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which has
> more obvious behavior and is less error prone.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v4:
> - drop +1 from length arg (thanks Kees)
> - reword subject line (thanks Kees)
> - rebase onto 6465e260f4879080
> - Link to v3: https://lore.kernel.org/r/20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com
> 
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
> index fa28d447f0df..c13b5c8a0433 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -796,14 +796,13 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
>  			goto error;
>  		}
>  
> -		*str = kcalloc(element->string.length + 1, sizeof(u8),
> -			       GFP_KERNEL);
> +		*str = kmemdup_nul(element->string.pointer, element->string.length,
> +						 GFP_KERNEL);

This whitespace looks weird -- I'd expect this to line up with
"element", like this:

> +		*str = kmemdup_nul(element->string.pointer, element->string.length,
> +				   GFP_KERNEL);

Otherwise, yes, looks correct.

-- 
Kees Cook
