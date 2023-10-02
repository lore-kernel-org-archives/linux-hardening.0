Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA61DA38
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 17:50:53 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768AE6
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 10:50:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso2386449b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Oct 2023 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696269050; x=1696873850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6LTVtBdQwyffDdkyOthmcLPzL+TcPsE+wXsu6L8tqo=;
        b=SNQ0jdC+l+/YKGbd0QCpphMZif0PHo7Tedsby7WYxws/JwMgLGLzUkf3t+tg3SbkMm
         8dngLvGkHGcegK8BGYT9v6aq1p2yGlLphmPnV+ZqClFwaDmzdVmU0ajbg3EyX3rM9Pb/
         GftevvByqhAOHjBqNkFTuulgedjk620zjwMgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269050; x=1696873850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6LTVtBdQwyffDdkyOthmcLPzL+TcPsE+wXsu6L8tqo=;
        b=AjLh8KHOnm67yq+GDKwtDejP9p5nYFT5nFrZmKUG7s/FHpALF+vY8tFs1jIngmyuUb
         SGgVePN3qXX7QZKqc90x5QDd9iczwKf5rgrKpciVbV1zhgViuDwiPK7i/TwtIhVYr6bt
         8ukoZdwC5KObJ7JRLkip68b9Ts07YMTIVAGkEq0M4dR05XBtZjws/UwazbOrGV68FyL4
         vmD/Go2X97fAxvE+TrbICVh7tskGDrYYAfm+pXIwPXwpENkqamszC3GLoC5kkYV8r3bK
         0JIjLK19MUIhQRSR9XfQccBdq/Oxp5ypBUMkmyFFbW3iUfABrETLo8v2p/qHXTr/fXWd
         4etw==
X-Gm-Message-State: AOJu0YyTrFgEOI4ogL3lh9I+JxMTI++2teNRLELTCxBM6ahuIaWO86k7
	mcsThso6Q7Kb1A0aFm472Jbl9w==
X-Google-Smtp-Source: AGHT+IHwyE5uceh2fKRq6zo0UrhOLBVICH0oGIR89K8eolqmFM72O6lmzJq3w8zwcNX60UAzD8wWrw==
X-Received: by 2002:a05:6a00:995:b0:693:43b5:aaf3 with SMTP id u21-20020a056a00099500b0069343b5aaf3mr437525pfg.13.1696269050426;
        Mon, 02 Oct 2023 10:50:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k9-20020aa78209000000b0069348918cfcsm7869876pfi.193.2023.10.02.10.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:50:49 -0700 (PDT)
Date: Mon, 2 Oct 2023 10:50:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] eeprom: idt_89hpesx: replace open-coded kmemdup_nul
Message-ID: <202310021050.B6A9651@keescook>
References: <20230927-strncpy-drivers-misc-eeprom-idt_89hpesx-c-v1-1-08e3d45b8c05@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-strncpy-drivers-misc-eeprom-idt_89hpesx-c-v1-1-08e3d45b8c05@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 05:37:06AM +0000, Justin Stitt wrote:
> A malloc + strncpy + manual NUL_termination is just kmemdup_nul. Let's use
> this interface as it is less error-prone and more readable.
> 
> Also drop `csraddr_len` as it is just used in a single place and we can
> just do the arithmetic in-line.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, this looks correct to me. Another good case of using kmemdup_nul().

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> Note: build-tested only.
> ---
>  drivers/misc/eeprom/idt_89hpesx.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> index 1d1f30b5c426..d807d08e2614 100644
> --- a/drivers/misc/eeprom/idt_89hpesx.c
> +++ b/drivers/misc/eeprom/idt_89hpesx.c
> @@ -905,7 +905,7 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
>  {
>  	struct idt_89hpesx_dev *pdev = filep->private_data;
>  	char *colon_ch, *csraddr_str, *csrval_str;
> -	int ret, csraddr_len;
> +	int ret;
>  	u32 csraddr, csrval;
>  	char *buf;
>  
> @@ -927,21 +927,16 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
>  	 * no new CSR value
>  	 */
>  	if (colon_ch != NULL) {
> -		csraddr_len = colon_ch - buf;
> -		csraddr_str =
> -			kmalloc(csraddr_len + 1, GFP_KERNEL);
> +		/* Copy the register address to the substring buffer */
> +		csraddr_str = kmemdup_nul(buf, colon_ch - buf, GFP_KERNEL);
>  		if (csraddr_str == NULL) {
>  			ret = -ENOMEM;
>  			goto free_buf;
>  		}
> -		/* Copy the register address to the substring buffer */
> -		strncpy(csraddr_str, buf, csraddr_len);
> -		csraddr_str[csraddr_len] = '\0';
>  		/* Register value must follow the colon */
>  		csrval_str = colon_ch + 1;
>  	} else /* if (str_colon == NULL) */ {
>  		csraddr_str = (char *)buf; /* Just to shut warning up */
> -		csraddr_len = strnlen(csraddr_str, count);
>  		csrval_str = NULL;
>  	}
>  
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230927-strncpy-drivers-misc-eeprom-idt_89hpesx-c-b09ed5507b7d
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
