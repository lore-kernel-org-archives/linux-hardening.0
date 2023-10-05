Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659C7E
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i4L/3Aj8"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C344124
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 19:58:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c877f27e8fso3652275ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 04 Oct 2023 19:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696474723; x=1697079523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kNnoNX+VycKJxCFVsIPAbCtAe5boObmTDcjKlCDp2k=;
        b=i4L/3Aj8ygTjSUp9/p9XDWPSBBKIRjWIC5psTSo5nX3ZwidzXnhiCBlczgVVI2zjpZ
         9XWh+QJWSXuMiPpDWrlgZpJl/Z8tuZxCXx3YMi3JB62A4zXJlhkRATn11k3SCHNFLDbf
         Tk89LjB5wR/1YdxTpbiNiRU0F/Rvj9JM4j2NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696474723; x=1697079523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kNnoNX+VycKJxCFVsIPAbCtAe5boObmTDcjKlCDp2k=;
        b=hcpJGohQUu0dMNF2f+zVIjJqmcgXvCLhWdeA48rQXvUdrrSOcLOLg3Bn3+fd0JsSe4
         TjxxJkdzSAE39Pr6+gJNGkFS3U+ie8rSAlK0mCJgyqi49EdL8OZEOX6SKzjbHu2NP1MC
         8hNqy8zbnIedC8BRW3PloslqcqVcTvO2eyixzgZd/NOIplzTg/4lEmw7mhF0K/kLNjgM
         RB21SSg2zJFXzKk+he+/+9kFAUknsQ+lHSB947vwNjEABdl6qSLK87NGBoxIu4tF4sgc
         Vdf394Gc0b7rEUGcOI2ux/pRj1i7ZSQKAb/lVCVU/vno04+x57ZVD0zL1gGxOBeK12TW
         874A==
X-Gm-Message-State: AOJu0YxoeRI9uYphmwTRkyNnzRop/AyDAXbozmvmy09DmXy3EGDnBAkX
	DZ7EivhUXKn+D8dL2p4kYR+9hw==
X-Google-Smtp-Source: AGHT+IEuvtkB5cCQbgCWYrRd54NAG8rv4yhh7aSFHMbN97v3p48aULxm0ARxKFDY+QpqB2XuHsjBOg==
X-Received: by 2002:a17:903:1cc:b0:1c7:2661:91e1 with SMTP id e12-20020a17090301cc00b001c7266191e1mr3864559plh.15.1696474722969;
        Wed, 04 Oct 2023 19:58:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902eaca00b001b8a85489a3sm313410pld.262.2023.10.04.19.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 19:58:42 -0700 (PDT)
Date: Wed, 4 Oct 2023 19:58:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] can: peak_pci: replace deprecated strncpy with strscpy
Message-ID: <202310041958.12F8A261A@keescook>
References: <20231005-strncpy-drivers-net-can-sja1000-peak_pci-c-v1-1-c36e1702cd56@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-can-sja1000-peak_pci-c-v1-1-c36e1702cd56@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 12:05:35AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required since card is already zero-initialized:
> |       card = kzalloc(sizeof(*card), GFP_KERNEL);
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

Yup, this looks like a standard direct replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
