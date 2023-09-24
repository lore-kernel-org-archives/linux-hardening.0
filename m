Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976E654
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 03:43:11 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB71010D
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 20:43:09 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-57b5f0d658dso2276780eaf.0
        for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 20:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695526989; x=1696131789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=seBNO35I6t27+aW9cJIbrOKykhwY8CBfF73TPyxAkzU=;
        b=EDFXaiYkSd1bB8l0T5fa8bmSbpBIrk1zJeZoev6LOoy0s0jSOIXjiJtr+XPk517mCe
         vW8k3VAizHB85g+A8uuCFlJtOPhHO55Z3Ilsqw46eFFernrVTPXTQ42bEn6sS9HDganI
         5ZJxuRwCRizbTpOZ/jBfOfHyaA86KqFaUoNYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695526989; x=1696131789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seBNO35I6t27+aW9cJIbrOKykhwY8CBfF73TPyxAkzU=;
        b=cUIdrCqTlJ2Bm7gaSOuwaH+ijhhXF/Al7W8YKs8uZcxy3pY8XxSya5aQqxiDhODCSH
         Xmj606j+yo6FXoiqPqaaXoEsaD5lDhIfhTUD4af8b1//Do4Y1LT3qLyZPFsOYJJuDEvl
         /gq8sMCphYaIgLoeVb81GQA+jfH6s7r6AJBpWRbak+zg0bI7HzplRQk1i/nfdBNdp1Qu
         xaE6wydM31haawl3oc1euyIxHQXux7YcVDWXQurpCwFJItcKKGb5Is+Wm8aI1Qkus+yj
         1uwnRxm+11I3mIkLznK6sgFfC2Q248wd/VABqhLmp7qwUI3bF1UBrR5xANFx2i+uKWV8
         ek4w==
X-Gm-Message-State: AOJu0Yz1wVEe7feJ8fgSi8n3c3NF7JczTUo6EtAJI/UTL5xp6kx5GUPk
	Nik8VHMHnzqT3Cx6cy0fJG35IA==
X-Google-Smtp-Source: AGHT+IE2/HgUIEM6nD5lxm0qSmNTG5hyr9cbCU3gawGphubnH/fGhDM5TcuGczSqA2L3/1x/UlkG6A==
X-Received: by 2002:a05:6358:41a3:b0:143:9f18:d71a with SMTP id w35-20020a05635841a300b001439f18d71amr3868238rwc.14.1695526989027;
        Sat, 23 Sep 2023 20:43:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a199700b002694fee879csm8008047pji.36.2023.09.23.20.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:43:08 -0700 (PDT)
Date: Sat, 23 Sep 2023 20:43:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] leds: lp3952: replace deprecated strncpy with strscpy
Message-ID: <202309232039.979F3B4@keescook>
References: <20230922-strncpy-drivers-leds-leds-lp3952-c-v1-1-4941d6f60ca4@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-strncpy-drivers-leds-leds-lp3952-c-v1-1-4941d6f60ca4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 03:27:17PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `dest` to be NUL-terminated due to its use with dev_err.
> 
> lp3952_get_label()'s  dest argument is priv->leds[i].name:
> |    acpi_ret = lp3952_get_label(&priv->client->dev, led_name_hdl[i],
> |                                priv->leds[i].name);
> ... which is then assigned to:
> |    priv->leds[i].cdev.name = priv->leds[i].name;
> ... which is used with a format string
> |    dev_err(&priv->client->dev,
> |            "couldn't register LED %s\n",
> |            priv->leds[i].cdev.name);
> 
> There is no indication that NUL-padding is required but if it is let's
> opt for strscpy_pad.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/leds/leds-lp3952.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-lp3952.c b/drivers/leds/leds-lp3952.c
> index 3bd55652a706..62ade3f05a87 100644
> --- a/drivers/leds/leds-lp3952.c
> +++ b/drivers/leds/leds-lp3952.c
> @@ -101,7 +101,7 @@ static int lp3952_get_label(struct device *dev, const char *label, char *dest)
>  	if (ret)
>  		return ret;
>  
> -	strncpy(dest, str, LP3952_LABEL_MAX_LEN);
> +	strscpy(dest, str, LP3952_LABEL_MAX_LEN);

Given my desire to use sizeof(dest) for these things, I wonder if it'd
be nicer to pass more context here for the compiler as the only user of
this function is the immediately next function. Instead of passing in
"char *dest", it could pass "struct lp3952_led_array *priv", and
suddenly sizeof() would be possible.

But, since it's technically correct as-is:

struct lp3952_ctrl_hdl {
        struct led_classdev cdev;
        char name[LP3952_LABEL_MAX_LEN];

There's no pressing need to actually do the priv refactor. It's just a
comment on the coding style of the original code. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  	return 0;
>  }
>  
> 
> ---
> base-commit: 2cf0f715623872823a72e451243bbf555d10d032
> change-id: 20230922-strncpy-drivers-leds-leds-lp3952-c-666fcfabeebd
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
