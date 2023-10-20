Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0A369
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 00:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G5wVzMfl"
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B0DCF
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 17:16:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso2171105ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 17:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697761015; x=1698365815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXqB68dRwnEMiiJyZnk0HaHWGXtH4u6C3mPwBphJGJI=;
        b=G5wVzMflm6pjtAG2F4wxnwxKzMoJF4YRfJroGHEyKZFSVg2NGclIVpugZdvSD4wVMN
         +y0ueksEQN6T9Ob4H3ZrgrtvO33Z35WK8pGFguYozQY5cT3PxHfdWoZvUhP45MWnnVJ0
         TTw02fWltsIdYmSIBZ3lGPNckb4qBQFroPmtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697761015; x=1698365815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXqB68dRwnEMiiJyZnk0HaHWGXtH4u6C3mPwBphJGJI=;
        b=C88CtnwNqWIO2nLnAxXJ7qG7lLHAqGLCaAI0W11NvQMYqTQv1wstKVCMMYx2Rewzg1
         +bC+7JjGfLC9p2p72vNE6razOaBw7B4SsgBmAEUWKvawEglqwHwuaVzGz3WrAVNGNQrc
         XDxBsMW5j+5mOhxEl0JqchvnobBgcONCbAUJBNidZ5mLt921PNCFAEhyaVx6bGRffkR7
         BE+8Xr3wW1TOXzO6QxUdtByk/1q2RH9WNfT/Xazh8CFo16+5gnTRcTTgkuu7ZwmOV/tH
         /U4otsEy/1YzWYX2PxHANhBNOpC6vpi7Tw8tMtSGkyV/bLQ5pX081f14Lze5LSyBtL1s
         uMWg==
X-Gm-Message-State: AOJu0YztWx3ladAX++7pEeUcX25JKKaKKRGtjS+/32LnIu46LHHC1z3q
	QA1JgwgQkLwRuiVlhVkL/O+1kQ==
X-Google-Smtp-Source: AGHT+IFZ1Tr8OeFg/qk6qLnEbh1PqH3aRaYMRLi5/1KpjSSKoPCXfZM1fdYuLAT3Ykx57tGI6k5JUw==
X-Received: by 2002:a17:903:60d:b0:1c9:e6a0:edb6 with SMTP id kg13-20020a170903060d00b001c9e6a0edb6mr398026plb.2.1697761014744;
        Thu, 19 Oct 2023 17:16:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090300d200b001bd62419744sm290200plc.147.2023.10.19.17.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 17:16:54 -0700 (PDT)
Date: Thu, 19 Oct 2023 17:16:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Gregory Greenman <gregory.greenman@intel.com>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iwlwifi: fw: replace deprecated strncpy with
 strscpy_pad
Message-ID: <202310191716.242A205D@keescook>
References: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>

On Thu, Oct 19, 2023 at 05:44:59PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
> both dump_info->dev_human_readable and dump_info->bus_human_readable are
> intended to be NUL-terminated.
> 
> Moreover, since this seems to cross the file boundary let's NUL-pad to
> ensure no behavior change.
> 
> strscpy_pad() covers both the NUL-termination and NUL-padding, let's use
> it.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the respin!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
