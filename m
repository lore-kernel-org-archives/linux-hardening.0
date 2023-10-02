Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518D21E53F
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 18:05:20 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC30B4
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 11:05:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-577e62e2adfso11244634a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 02 Oct 2023 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696269915; x=1696874715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzW0YVguzNw7sySoEGaMr3yWzidp8N0IwGPJ49IGe8U=;
        b=YRoYavZYeCPNp9Tp8RUruIaoht2DPbUFG5v5tuGTbBOnK9CUbJ3lKpdNRr6Sl93Nnp
         wbByOMHspc2cU1VbhiCYx8xlVZdqOdqajIa/W06wMWR8Cb8uZDdiAzaR0LoF13rNDbEL
         uuRe4XgUX3mGurXAEmFJbmmufH6er5Q3RW75U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269915; x=1696874715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzW0YVguzNw7sySoEGaMr3yWzidp8N0IwGPJ49IGe8U=;
        b=DYxs0eoSkkFx7blXkr6ra/pBtldQB+/8KNdnpWnHJH+0mg+Y382vVDb9BIu3SEZelA
         ovLLzyROEz73xg3sHlNV8cOo1G7KxVwRy1avswzh4eLkHWKnXHz1RL7hDaGI1WaSuTCC
         ItDG8BSwjiTgxrCXvMRx7uUc6aGrYgSbesfGrGtfU6ZqQtmoFBhnCW1RZNb33Cl+Zas8
         cEQcsaei5rGpvC5vw5KwQNYeHHUOgsn3EKpCC5p3sRExQZBHnCRbgEm1eRgv2GM1tnQR
         wRCpCOAHYld7SHaC1ZwCIF89vkX+laWhAivjPRu1XolV1BJHW6E3fcZh5k4YuopUpgSF
         j2rQ==
X-Gm-Message-State: AOJu0YyHhnbFi/6lWBFYlVmpYv0vrbfg0asKxz3RzYGPr8HwfQ6sjKUW
	ymLeSFDZuZUrbT6vyuWlEskpcA==
X-Google-Smtp-Source: AGHT+IH/MouaVnR9EdrEnIBcyIKUEno0+AsWLhGW19SNRxdiN+LbRG2ox56FkU8qF8Zj8mpmHLzHwA==
X-Received: by 2002:a05:6a20:560b:b0:163:ab2b:bddd with SMTP id ir11-20020a056a20560b00b00163ab2bbdddmr4702632pzc.27.1696269915513;
        Mon, 02 Oct 2023 11:05:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902740c00b001c62b9a51c0sm13314483pll.103.2023.10.02.11.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:05:15 -0700 (PDT)
Date: Mon, 2 Oct 2023 11:05:14 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drivers: misc: ti-st: replace deprecated strncpy with
 strscpy
Message-ID: <202310021104.30D14A206F@keescook>
References: <20230927-strncpy-drivers-misc-ti-st-st_kim-c-v1-1-29bbdeed1a2c@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-strncpy-drivers-misc-ti-st-st_kim-c-v1-1-29bbdeed1a2c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 06:17:34AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both `kim_data->dev_name` and `kim_gdata->dev_name` to be
> NUL-terminated.
> 
> `kim_data->dev_name` seems to not require NUL-padding.
> 
> `kim_gdata` is already zero-allocated and as such does not require
> NUL-padding:
> |       kim_gdata = kzalloc(sizeof(struct kim_data_s), GFP_KERNEL);
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
>  drivers/misc/ti-st/st_kim.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
> index fe682e0553b2..a034b5d8b585 100644
> --- a/drivers/misc/ti-st/st_kim.c
> +++ b/drivers/misc/ti-st/st_kim.c
> @@ -590,7 +590,7 @@ static ssize_t store_dev_name(struct device *dev,
>  {
>  	struct kim_data_s *kim_data = dev_get_drvdata(dev);
>  	pr_debug("storing dev name >%s<", buf);
> -	strncpy(kim_data->dev_name, buf, count);
> +	strscpy(kim_data->dev_name, buf, count);

This is again the early truncation issue. This should use
sizeof(kim_data->dev_name). "buf" will be %NUL terminated already.

>  	pr_debug("stored dev name >%s<", kim_data->dev_name);
>  	return count;
>  }
> @@ -751,7 +751,8 @@ static int kim_probe(struct platform_device *pdev)
>  	}
>  
>  	/* copying platform data */
> -	strncpy(kim_gdata->dev_name, pdata->dev_name, UART_DEV_NAME_LEN);
> +	strscpy(kim_gdata->dev_name, pdata->dev_name,
> +		sizeof(kim_gdata->dev_name));

This looks correct.

>  	kim_gdata->flow_cntrl = pdata->flow_cntrl;
>  	kim_gdata->baud_rate = pdata->baud_rate;
>  	pr_info("sysfs entries created\n");
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230927-strncpy-drivers-misc-ti-st-st_kim-c-e1663a211a0c
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
