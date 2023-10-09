Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F43374E2
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H41bVc++"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C3CF
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 15:03:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692c02adeefso3632828b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 15:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696889039; x=1697493839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ys7O5oFEmO1QCviYjPEYrUnc2jO2bomITSGGcdISQfo=;
        b=H41bVc++pRQxUSD3+HPGj9CapgckzkFj4jkAdPm1+DGXBZbpusDYBC46uK9GFNkqNn
         j1sh4axWxLNzu1/iAWtaru8sYZDbTIPbAgW5zKkqDjBVKxZLUcK7u1nIeOiTaj4VTOv0
         GR+Whk96oyvFM1uPoujx/244EYhlhg2R4e1E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696889039; x=1697493839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys7O5oFEmO1QCviYjPEYrUnc2jO2bomITSGGcdISQfo=;
        b=Yr0rvgXRr75Rx7/M/Q8gqB91qeLwgvTWyAntM81CjDz1bTumHQ4DL3hcng8ncSKFXV
         ye/O0835Pz2wEM3NkcwrweOyDsH3/DvQsZhnKqR/VvjkcvQ9rml8eMlOoqWYql/iM7aj
         0hkf6ENIqjWUKgfJYiYWiyVB5KgZzbcQ2immJvnVvvoqw9QM/KwJkwFMH39w2q8EofDk
         yXIJGRzOyTLRhkUg5RwABc49bMGxUGKRoLDyo4al1xeebexYcn/RIR22XuzOFmGB96YD
         m1tZrxrIFGTqHSdebm8xtPsT9UnKtqsh7yQakp6YJU5Rn13HjXvF6FbrnknBOf5zy/j5
         +vWg==
X-Gm-Message-State: AOJu0YzDraChzkTS2WkjqUDyoc/noLKhQh5kyeFivEpaoUvTyWhqXF2P
	VWwSm6+AdHS8Ep94pACGkeZ5wA==
X-Google-Smtp-Source: AGHT+IFjPnCNTHgmoj8ii2/P0s9nH6rj/IoWKH7/YKY4P8GJP1oGAXAR6Ca7aG9HVdB+DAVpWTaDCg==
X-Received: by 2002:a05:6a21:338c:b0:159:e0b9:bd25 with SMTP id yy12-20020a056a21338c00b00159e0b9bd25mr16823979pzb.57.1696889039248;
        Mon, 09 Oct 2023 15:03:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x5-20020a656aa5000000b0059b64b153fcsm120296pgu.17.2023.10.09.15.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 15:03:58 -0700 (PDT)
Date: Mon, 9 Oct 2023 15:03:56 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: sigmadsp: Add __counted_by for struct
 sigmadsp_data and use struct_size()
Message-ID: <202310091503.E59363D14@keescook>
References: <ZSRvh1j2MVVhuOUv@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRvh1j2MVVhuOUv@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 03:24:23PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() and size_sub() helpers, instead of the
> open-coded version, to calculate the size for the allocation of the
> whole flexible structure, including of course, the flexible-array
> member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  sound/soc/codecs/sigmadsp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
> index b93c078a8040..56546e2394ab 100644
> --- a/sound/soc/codecs/sigmadsp.c
> +++ b/sound/soc/codecs/sigmadsp.c
> @@ -43,7 +43,7 @@ struct sigmadsp_data {
>  	uint32_t samplerates;
>  	unsigned int addr;
>  	unsigned int length;
> -	uint8_t data[];
> +	uint8_t data[] __counted_by(length);
>  };
>  
>  struct sigma_fw_chunk {
> @@ -270,7 +270,7 @@ static int sigma_fw_load_data(struct sigmadsp *sigmadsp,
>  
>  	length -= sizeof(*data_chunk);
>  
> -	data = kzalloc(sizeof(*data) + length, GFP_KERNEL);
> +	data = kzalloc(struct_size(data, data, length), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> @@ -413,7 +413,8 @@ static int process_sigma_action(struct sigmadsp *sigmadsp,
>  		if (len < 3)
>  			return -EINVAL;
>  
> -		data = kzalloc(sizeof(*data) + len - 2, GFP_KERNEL);
> +		data = kzalloc(struct_size(data, data, size_sub(len, 2)),
> +			       GFP_KERNEL);

Since len was just size-checked before the alloc, size_sub() is a bit of
overkill, but it's not technically wrong. :P

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
