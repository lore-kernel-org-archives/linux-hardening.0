Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6FA43693
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZSj0Dq7k"
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE8F2109
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 16:18:28 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57f02eeabcaso301211eaf.0
        for <linux-hardening@vger.kernel.org>; Thu, 05 Oct 2023 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696547907; x=1697152707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+MzswgELJWyE4HvVCrp29nzFh/L1Jc6Rtaa/JFCP/Q=;
        b=ZSj0Dq7kvdgnzBsKVyad1cLSdIJxqm3r3xIHtXTx2PfANEzLb3FSnJ6aTKwP9WvKI2
         /FB7noCbnYEMcjkmDb6dyPMQmQ0JkQGR0pylVWRBO3wZzNJfMAFqETJ0dsZ+46gSRykq
         lBXjAE9v2mlrnjq4MPIBfCT4hpMf6qfqSm9rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547907; x=1697152707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+MzswgELJWyE4HvVCrp29nzFh/L1Jc6Rtaa/JFCP/Q=;
        b=BxnMgGEiv0B2bChBq3HKUuJogGl9kKTnUp064hEuxPlBN3B0DLVVNeGnZpGzDdFN9t
         dgDop2JMrzpo4fi3e50LyMgOavUS0Uv6LhCzBlE0UHBAx06QB5dXVKAI8Sm5UNIMVmf2
         7vFu1olo4ZrIstM/vjbgEEYxIKQFbocG3TJ6JVAF6r7c/p8w0eg3F7sicPCu1MAtb2rn
         hWywCgzfP7lufH2fBzKw0WIO4t9iQp31tVR/cxc7zS3WXpTKUUQKgXxFfXuyyS6ycEho
         ALTXYkV1+1jGkJ1sMROUE3zr9qB4zbM5tLRXmtm1fquZo7Sv7CJRENAkWn5QFR7c5kdu
         AGSw==
X-Gm-Message-State: AOJu0YyUO1fZZv9OEG3YWjsgOn8NFqZycO+Qgspqld3yCcCiVWq5Otez
	SBlkpI9YXIgHnlvkk+LeTAGyIQ==
X-Google-Smtp-Source: AGHT+IHGoNiuevjMInyHI3QzyPLyVu1ZpjZXrQHOjn6YWfgQenTUDzLdtnZOe3kcEPnafe0ghnCLmQ==
X-Received: by 2002:a05:6358:7e87:b0:13f:e3eb:53a6 with SMTP id o7-20020a0563587e8700b0013fe3eb53a6mr5785371rwn.30.1696547907255;
        Thu, 05 Oct 2023 16:18:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a19ce00b00277371fd346sm4462196pjj.30.2023.10.05.16.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 16:18:26 -0700 (PDT)
Date: Thu, 5 Oct 2023 16:18:26 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Derek Chickles <dchickles@marvell.com>,
	Satanand Burla <sburla@marvell.com>,
	Felix Manlunas <fmanlunas@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] liquidio: replace deprecated strncpy with strscpy
Message-ID: <202310051617.3C4A40C5@keescook>
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-v1-1-92123a747780@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-v1-1-92123a747780@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 09:55:06PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required as rep_cfg is memset to 0:
> |       memset(&rep_cfg, 0, sizeof(rep_cfg));
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
> index 600de587d7a9..aa6c0dfb6f1c 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
> @@ -638,7 +638,8 @@ lio_vf_rep_netdev_event(struct notifier_block *nb,
>  	memset(&rep_cfg, 0, sizeof(rep_cfg));
>  	rep_cfg.req_type = LIO_VF_REP_REQ_DEVNAME;
>  	rep_cfg.ifidx = vf_rep->ifidx;
> -	strncpy(rep_cfg.rep_name.name, ndev->name, LIO_IF_NAME_SIZE);
> +	strscpy(rep_cfg.rep_name.name, ndev->name,
> +		sizeof(rep_cfg.rep_name.name));

struct lio_vf_rep_req {
	...
        union {
                struct lio_vf_rep_name {
                        char name[LIO_IF_NAME_SIZE];
                } rep_name;

Yup, sizeof(rep_cfg.rep_name.name) == LIO_IF_NAME_SIZE.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
