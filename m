Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F836B07
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HQo1KMnF"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F57919B
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 16:08:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5c91bece9so36563135ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696892937; x=1697497737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZEAbTE1jnX14hR8pCQlTibWlz5S6mt8A6dPfKwpsV8=;
        b=HQo1KMnFcNeDA8euGVYYMlvfqf5rjj/fmlwOEekOJc6WM9oRn2Aq6E9sKJWaAa8zrW
         XT1S3fhQQ8GLutCvzjCg6RDeFju2TS8OTg1zEGZWeN3O2jbFxvdpU7KmeVHaB2mcD4WN
         UCHuNDY0xtNAHbk9LKFL05VaHZ5auMzr89n3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892937; x=1697497737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZEAbTE1jnX14hR8pCQlTibWlz5S6mt8A6dPfKwpsV8=;
        b=qyI4dJfdWv9BNyJxUZ6OzxPdjnrtsLF8+43hmoRyd66qi/ngelbhp0615bwkytS7HJ
         bYaow9AcTf5vegdLpN180i2vSQP3s2v9ao31p+I7jRh5Eh+3ssGeIcpPvteugYrEOSAw
         XPqizc0Gc/8goH/Qi20QtJBRlYeBPaDeovpsriuBgLLcecI4sz2ShR70LFZdMVIZMvjy
         /7M7zr4KaypducVVAe4f0bk8Vjb2+wuveCfs4SkeAIuNVDV9kNNv83Cbiy1gOyA0zOyC
         1MAxRk+l/mv+WLin36iVfzMFqcOfRjITOVKvSvC/OtY9xSeZJt36TwLKHh5LRxSDY4Sk
         h9DA==
X-Gm-Message-State: AOJu0YyqqJqnntMRN2iHFWyIx580OaQmJVnrYooydafUML9kX0ZBvyIM
	njjna46Z94uXfnmTuaNs/0eLsA==
X-Google-Smtp-Source: AGHT+IE4bNEi4bN0RSOpbI1oO6kddrnbOzEwTunUzAyAEf4FA+FbGaK82D5lHzRVV9vr+ORb3iYMug==
X-Received: by 2002:a17:902:ec84:b0:1c5:d063:b72a with SMTP id x4-20020a170902ec8400b001c5d063b72amr16810663plg.27.1696892936571;
        Mon, 09 Oct 2023 16:08:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bh2-20020a170902a98200b001c43307f87asm10162365plb.91.2023.10.09.16.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:08:56 -0700 (PDT)
Date: Mon, 9 Oct 2023 16:08:52 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] staging: greybus: Add __counted_by for struct
 apr_rx_buf and use struct_size()
Message-ID: <202310091608.C892CFA@keescook>
References: <ZSR2O6zGyT/VX6ve@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSR2O6zGyT/VX6ve@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 03:52:59PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right, "len" is updated before accessing "data[]".

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
