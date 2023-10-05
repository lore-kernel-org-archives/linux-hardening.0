Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2BD7E
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bGDwxioj"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C26A10CE
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 20:07:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c723f1c80fso3336295ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 04 Oct 2023 20:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696475276; x=1697080076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cbMRa4tTE64i0xTO+5SXlx3zeeEFmOFwZHGXQ8yJGw=;
        b=bGDwxiojuvXT33COYRAVZF1Af+0zxG4LkA/AI+q5445O0YhxxZPpwflNd4c2Ddk/Cr
         FpwfeExAPEZQII2KRUV1/1VJt8pXDzu/YrkAjZ6x8/OQZuB5LdOP7QFoEqEpiNZxXLOP
         F1C4n0HJ1eVwC+Ge2MBKhl1NTh4Mmu17U+NjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696475276; x=1697080076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cbMRa4tTE64i0xTO+5SXlx3zeeEFmOFwZHGXQ8yJGw=;
        b=WnpXUC9AcniASd4rIJXHox31Xi7d5uZAJTpBGG445ocPg90GlWJ3QHvHH+E6bSY6JK
         wCOZr3NbVlfjzqhIeoQlj2gHWmeacktnOGUtBlDVowA1A6tWbjWvcTnrVPGQ16Ti8H02
         RIbbb436nOClodCY6m7E3SCF6PLb/YsY6ys4Wg01hTg/XC+82CmX15LO7mGleHVtKWkB
         9FmDnNRVlVd6JfEA3+25qqlpY4/DBFu4f48cLuD9y5BJM8siINRFDGOPBWWwFZb+D0Yn
         S/kwuR4u8zdw09XGh9c1xMFBB0Gx7nGQDgblBu8ITwpVIkKalB3FOXRWbtN7SA0rTirc
         /eLg==
X-Gm-Message-State: AOJu0Yy+YkKv+UxnGK0RIDiFlfDCGvun6hPquNn+U3HodV7ddmDf+eTd
	b+0vw50cm+y3HPHvS1MRrz1AMQ==
X-Google-Smtp-Source: AGHT+IEHC/NcKdyXD51wauvGPZCWyuKTY3ZFBWWl9ZQ6W0PsxJMcaUSSelo/HFoKp6Dcs1geAWSGGQ==
X-Received: by 2002:a17:902:c112:b0:1c0:93b6:2e4b with SMTP id 18-20020a170902c11200b001c093b62e4bmr3934009pli.33.1696475276668;
        Wed, 04 Oct 2023 20:07:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jg4-20020a17090326c400b001bb0eebd90asm324227plb.245.2023.10.04.20.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 20:07:56 -0700 (PDT)
Date: Wed, 4 Oct 2023 20:07:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: lan9303: replace deprecated strncpy with memcpy
Message-ID: <202310041959.727EB5ED@keescook>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 12:30:18AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous
> interfaces.
> 
> Let's opt for memcpy as we are copying strings into slices of length
> `ETH_GSTRING_LEN` within the `data` buffer. Other similar get_strings()
> implementations [2] [3] use memcpy().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c#L167 [2]
> Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c#L137 [3]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/dsa/lan9303-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
> index ee67adeb2cdb..665d69384b62 100644
> --- a/drivers/net/dsa/lan9303-core.c
> +++ b/drivers/net/dsa/lan9303-core.c
> @@ -1013,8 +1013,8 @@ static void lan9303_get_strings(struct dsa_switch *ds, int port,
>  		return;
>  
>  	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
> -		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
> -			ETH_GSTRING_LEN);
> +		memcpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
> +		       ETH_GSTRING_LEN);

This won't work because lan9303_mib entries aren't ETH_GSTRING_LEN-long
strings; they're string pointers:

static const struct lan9303_mib_desc lan9303_mib[] = {
        { .offset = LAN9303_MAC_RX_BRDCST_CNT_0, .name = "RxBroad", },

So this really does need a strcpy-family function.

And, I think the vnic_gstrings_stats and ipoib_gstrings_stats examples
are actually buggy -- they're copying junk into userspace...

I am reminded of this patch, which correctly uses strscpy_pad():
https://lore.kernel.org/lkml/20230718-net-dsa-strncpy-v1-1-e84664747713@google.com/

I think you want to do the same here, and use strscpy_pad(). And perhaps
send some fixes for the other memcpy() users?

(Have I mentioned I really dislike the get_strings() API?)

-Kees

-- 
Kees Cook
