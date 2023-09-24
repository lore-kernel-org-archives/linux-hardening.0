Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61C654
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 03:32:09 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A25D10A
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 20:32:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2749c756bcaso3330151a91.0
        for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 20:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695526326; x=1696131126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRgGGd2oFdQdgfdMrAcM89UOLhTWeifEuFH+hmNRqxA=;
        b=Hz+/zvjLYQ3bxMa6fXjMWoQVKL8mSpLBhl7bwQ1XyJFri++lXs2um0ruQe2fu1x6W4
         qVh6lIm/t/U4CHW1L9M2zmt9bLEpWVo84SojbUZ9blIJoHCGLYXoUpBAqIGbxIvhJlDj
         3blhYKoX41fGSFKK/be4kDJpe4t8RHIfCgCAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695526326; x=1696131126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRgGGd2oFdQdgfdMrAcM89UOLhTWeifEuFH+hmNRqxA=;
        b=bO3i5RJoo3Y3K8ta2USfk8LG+bAystc2Yf9ww9a+qdEb/aB+9XreViXyqlLG+JjLiX
         s53K0dnzaecGb4/Q6clN3CriYZ7NDViAP1srCg/upqGbCgKl16Y386gtRCvNTId8miAO
         8Ti1LWo3S/6siWscDo564bYNyA84I/h20gLAP7TCD8Ymj4gnA6L41Raa6fJ2n7K+YvmX
         XoeFA5qpAQhmaQhOqReb/19uyh80UDWjnCWrRB9E7sXbrPr5by9miidp5fbKKaEF08oY
         ta4QlOUOm2DM+KVHxRcnE2ikx6QyB/CbliOm7+kl+yCHcmqXnKxdcPxuTubhaxeebJPv
         EUaA==
X-Gm-Message-State: AOJu0YyferSoVkH/4w3A0syPX8i2MzzfK+Rt3Qpa1txKNKzfzy2/X6Xv
	aIsqvd0DKGhdHhjJQSSa0yL1pcoEVbS3xietTKM=
X-Google-Smtp-Source: AGHT+IGeRMyCfMSQxP7SNhxW5avQLugsc2wOhhZpE0OgR1uzWQhv36a0isOgMIn5RDHVkw+TffC7aA==
X-Received: by 2002:a17:902:d507:b0:1c3:dafa:b1e9 with SMTP id b7-20020a170902d50700b001c3dafab1e9mr4244219plg.10.1695526326553;
        Sat, 23 Sep 2023 20:32:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v8-20020a170902b7c800b001b896d0eb3dsm6058929plz.8.2023.09.23.20.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:32:05 -0700 (PDT)
Date: Sat, 23 Sep 2023 20:32:05 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - replace deprecated strncpy
Message-ID: <202309232031.2131CF7@keescook>
References: <20230921-strncpy-drivers-input-rmi4-rmi_f34-c-v1-1-4aef2e84b8d2@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-strncpy-drivers-input-rmi4-rmi_f34-c-v1-1-4aef2e84b8d2@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 09:58:11AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1]
> 
> Let's use memcpy() as the bounds have already been checked and this
> decays into a simple byte copy from one buffer to another removing any
> ambiguity that strncpy has.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Similar to Kees' suggestion here [2]
> 
> [2]: https://lore.kernel.org/all/202309142045.7CBAE940E@keescook/

Agreed. This is best as memcpy.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/input/rmi4/rmi_f34.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> index 0d9a5756e3f5..3b3ac71e53dc 100644
> --- a/drivers/input/rmi4/rmi_f34.c
> +++ b/drivers/input/rmi4/rmi_f34.c
> @@ -471,7 +471,7 @@ static ssize_t rmi_driver_update_fw_store(struct device *dev,
>  	if (buf[count - 1] == '\0' || buf[count - 1] == '\n')
>  		copy_count -= 1;
>  
> -	strncpy(fw_name, buf, copy_count);
> +	memcpy(fw_name, buf, copy_count);
>  	fw_name[copy_count] = '\0';
>  
>  	ret = request_firmware(&fw, fw_name, dev);
> 
> ---
> base-commit: 2cf0f715623872823a72e451243bbf555d10d032
> change-id: 20230921-strncpy-drivers-input-rmi4-rmi_f34-c-4a6945316cea
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
