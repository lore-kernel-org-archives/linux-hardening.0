Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D283FB09
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 23:46:49 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBED6C4
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 16:46:47 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57bca5b9b0aso869220eaf.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Oct 2023 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696376807; x=1696981607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PPFPtgXKpDPjFV3QZDdRhVrKDYAKfhNMoOZnAYYIu54=;
        b=dMSf0fmkjXKzyUhCUD+39MmCtkSf7GOv33nC3LVWu6SHJyYFqx2PK0l6bg/xw0CGIo
         r1C4Z1UuD32Bt6HWZ4bxGHVw2DG5ga/JsfCx6Op1pcbOA+6OgBFWTTaEXXZdymVMNe1Y
         jt+TXutgbPeDvjdFV2Rka7ZhEG8VMVf+5LYUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376807; x=1696981607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPFPtgXKpDPjFV3QZDdRhVrKDYAKfhNMoOZnAYYIu54=;
        b=SBQ0SHWXp9T6Xnzki/FV5eH86NRa7rHFys1mvAlWsmzjuU8yqGpopQOdQQqDxMCZK9
         dP1fdgALcs/ZrZ+TlqVvK1mTaVVNVpfzI8cATA32KcfUvICWLnJKSucq6AQb+5i4It61
         wE3oodv6v3CnOd2hozg3yTmjbSRZz35Jbsm9xRybcwxkMAsaIuSpqNGJKhLjlzzFbVu0
         UTFrYK8XLkJfJcCZIqr9SrtSrq7/6XbeQ2ZZu1OL+Z36fxFTW1QSdcWJMyQGPEIH8lFB
         AKfdHEIO+4ahCkxdMfVcvX/4OSLce2+MXWHPlAX+KNHBxshyFdT5dZtVTcMOcKNfDYpn
         hZdw==
X-Gm-Message-State: AOJu0Ywbsq16ddlV3BN+VkBMExqFSNBo98WlFQXF9P86iSsj329AH97o
	W/nDlL0o5iY9ucc9wcmdAyhgyg==
X-Google-Smtp-Source: AGHT+IHbxAfwDk9rTDaWI6/sinLESFPC9XLXsSohZ3q/HHKFgdJUwD8aS1e0iHAM1k2HY5fFzEXS7w==
X-Received: by 2002:a05:6358:e4aa:b0:143:9b25:c029 with SMTP id by42-20020a056358e4aa00b001439b25c029mr898736rwb.2.1696376807010;
        Tue, 03 Oct 2023 16:46:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gl18-20020a17090b121200b002775281b9easm146149pjb.50.2023.10.03.16.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:46:46 -0700 (PDT)
Date: Tue, 3 Oct 2023 16:46:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] drivers: misc: ti-st: replace deprecated strncpy with
 strscpy
Message-ID: <202310031646.C94326A6@keescook>
References: <20231003-strncpy-drivers-misc-ti-st-st_kim-c-v2-1-79630447b0a1@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-strncpy-drivers-misc-ti-st-st_kim-c-v2-1-79630447b0a1@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 10:23:07PM +0000, Justin Stitt wrote:
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
> Let's also opt to use the more idiomatic strscpy usage of:
> strscpy(dest, src, sizeof(dest))
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the adjustment. This looks right to me now.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
