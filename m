Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057C3B281
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DvQnqtbl"
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D5AB7
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 11:34:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c61bde0b4bso41226515ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696876469; x=1697481269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QzW61PmvMhB7wvidR/JyZKEPGFGfKZhJxFsTC+Jw3gA=;
        b=DvQnqtblCV35+DnVSWHtzRv1KZkI8ZK/i6++M8AnWOeeiYsk4hz60iI31+cMiRzXt7
         HBvfkNLiI2qg1dWv2Q+jAqY+PfSvuFE+qiP9wS1BJWQBM5eVOBweX7KjU9ucGKso4BKU
         pZ8fBQF9Vogq2kHkVmiZXrN8ZfHBA4xn/r7KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876469; x=1697481269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzW61PmvMhB7wvidR/JyZKEPGFGfKZhJxFsTC+Jw3gA=;
        b=keOKpY3O9XM/ahPRsIKZtXhACt/C2lmpSfmDn2Abv3iZxzVThG3bFovF6tIxlMkgUd
         YoRycyQ+XW/9/Xqy7/uSnTIYFLlvkyNMbSsisRRgm1o1yVrt8waJTlHr8E/Kmv/XHOv2
         55YfqRNLWKxKj1ZkUep7lTkhNEMYWrMUbDrSXXa+TaE7X+qWcTNbzaQ3XVp0P+tEtdGh
         Ue+/Pj7fvrD+SBfQIZ44zvVyDb1Fs5Bg73J/yv++IS8Q4wdxBEY7IHf80/XSNMRbJh8w
         o3v2EzyqrjeIieONXn86N+4c1f8eGNRNd9lsIVjmWp74C9Zf96YpQHCk4cMugYCMc8gE
         M5RA==
X-Gm-Message-State: AOJu0YwH5Aa+TbXZkn5hUr/uz7N9+7mbWFQm4Cwm14kbrNdT4jUNjO9n
	Xp4ZgFFv1LdcyehgLQziWsr0yA==
X-Google-Smtp-Source: AGHT+IGvGTYhLPh/cHOldPA5RcDXsoP6PZjpVjlGaNAhwj2EDrocQLkdaNWz/xlEAM8MOu1uGhoizw==
X-Received: by 2002:a17:903:2589:b0:1c7:2347:7777 with SMTP id jb9-20020a170903258900b001c723477777mr14962150plb.11.1696876469423;
        Mon, 09 Oct 2023 11:34:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902ed4500b001c78446d65fsm9980460plb.113.2023.10.09.11.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:34:28 -0700 (PDT)
Date: Mon, 9 Oct 2023 11:34:27 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: lantiq_gswip: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310091134.67A4236E@keescook>
References: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 06:24:20PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/dsa/lantiq_gswip.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> index 3c76a1a14aee..d60bc2e37701 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -1759,8 +1759,7 @@ static void gswip_get_strings(struct dsa_switch *ds, int port, u32 stringset,
>  		return;
>  
>  	for (i = 0; i < ARRAY_SIZE(gswip_rmon_cnt); i++)
> -		strncpy(data + i * ETH_GSTRING_LEN, gswip_rmon_cnt[i].name,
> -			ETH_GSTRING_LEN);
> +		ethtool_sprintf(&data, "%s", gswip_rmon_cnt[i].name);

Sorry, I read too fast: this should be "data", not "&data", yeah?

-Kees

>  }
>  
>  static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
> 
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231005-strncpy-drivers-net-dsa-lantiq_gswip-c-ece909a364f7
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook
