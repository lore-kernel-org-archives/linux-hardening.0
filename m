Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B41C38
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C7d/yRC5"
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7D78F
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 17:01:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso5020839a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 17:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696982483; x=1697587283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zXwHFTTSHqHksZHyWZ3bFkL07EMOlYzNsZg2rCsLLcM=;
        b=C7d/yRC5Raip0nMfFJljMYPZuVOwrxYCRUe4z9sSsoYFSsYqcS2kS0sUXwh5r8TxEU
         LQnikAzpaJOvdDZDRbVIeUFUS8fZSlviJTGP/SJnQKoAkLUysfm/xq9HTYN1Inai9hNA
         9oHroh9cjqDL0M3UEJNqIxP+fOMIkbxuH1kcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982483; x=1697587283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXwHFTTSHqHksZHyWZ3bFkL07EMOlYzNsZg2rCsLLcM=;
        b=uKnDRw2TFVT4aDACYAKWx1Ccz/HYdu0D0qEPTTWFwqNKzr5oQXvk2/FVvKTks9HPwA
         wttlo6DmYT2Jyv4PGLf1ZTV6c7dYqqM/PqEE6pFTZcUHPW3bjP1ahzY+qsn9bDubwlDZ
         d4qxuNAqT81ggfJrXIBpeE753lc1gRvFYEmTg7xDXYa2IzTUvX0I9HjWEeZEsFAuwqiH
         I1ZIUnTCMRYEWQiXsY724Z77QU7EPFe9rCo38KwC3Q5auKRyphN2njS5qU7rwH5/5Wmt
         LmcFadcQKjbBOQ89BjcxulXIGEDGQYHcgxyDmxp06ZxiWb0fQ7SeagTOBoBWKIm6eiCn
         Ec0Q==
X-Gm-Message-State: AOJu0Yy43q72j6GLgsXdis673JYF+zOnRLwGrDsbfvbZqEyxNzTQnhd9
	NuINqvfl0Ta+CFBDJJetLrDfNA==
X-Google-Smtp-Source: AGHT+IHvnF1NY14+x1atCUXgwzdFEk0ZaADVkWvm44vtZyO7tNcwIEv+y9XR2Sh6iJ6MxunGIbRJhw==
X-Received: by 2002:a05:6a20:2590:b0:151:577:32d1 with SMTP id k16-20020a056a20259000b00151057732d1mr23567638pzd.22.1696982483550;
        Tue, 10 Oct 2023 17:01:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902868c00b001c625acfed0sm12371984plo.44.2023.10.10.17.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:01:23 -0700 (PDT)
Date: Tue, 10 Oct 2023 17:01:19 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: replace deprecated strncpy with strscpy
Message-ID: <202310101700.1BE3455BE6@keescook>
References: <20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-v1-1-a443e18f9de8@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-v1-1-a443e18f9de8@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 09:38:11PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We can see that linfo->lmac_type is expected to be NUL-terminated based
> on the `... - 1`'s present in the current code. Presumably making room
> for a NUL-byte at the end of the buffer.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also prefer the more idiomatic strscpy usage of (dest, src,
> sizeof(dest)) rather than (dest, src, SOME_LEN).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index e06f77ad6106..6c70c8498690 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -1218,8 +1218,6 @@ static inline void link_status_user_format(u64 lstat,
>  					   struct cgx_link_user_info *linfo,
>  					   struct cgx *cgx, u8 lmac_id)
>  {
> -	const char *lmac_string;
> -
>  	linfo->link_up = FIELD_GET(RESP_LINKSTAT_UP, lstat);
>  	linfo->full_duplex = FIELD_GET(RESP_LINKSTAT_FDUPLEX, lstat);
>  	linfo->speed = cgx_speed_mbps[FIELD_GET(RESP_LINKSTAT_SPEED, lstat)];
> @@ -1230,12 +1228,12 @@ static inline void link_status_user_format(u64 lstat,
>  	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
>  		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
>  			linfo->lmac_type_id, cgx->cgx_id, lmac_id);
> -		strncpy(linfo->lmac_type, "Unknown", LMACTYPE_STR_LEN - 1);
> +		strscpy(linfo->lmac_type, "Unknown", sizeof(linfo->lmac_type));
>  		return;
>  	}
>  
> -	lmac_string = cgx_lmactype_string[linfo->lmac_type_id];
> -	strncpy(linfo->lmac_type, lmac_string, LMACTYPE_STR_LEN - 1);
> +	strscpy(linfo->lmac_type, cgx_lmactype_string[linfo->lmac_type_id],
> +		sizeof(linfo->lmac_type));

Yup, sizes match. Good replacement and simplification.

drivers/net/ethernet/marvell/octeontx2/af/mbox.h:565:#define LMACTYPE_STR_LEN 16
drivers/net/ethernet/marvell/octeontx2/af/mbox.h:566:   char lmac_type[LMACTYPE_STR_LEN];

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
