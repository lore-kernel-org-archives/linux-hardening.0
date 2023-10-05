Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2CA4E
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 04:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="la73IPiE"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC454683
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 21:53:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c60778a3bfso4306425ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 04 Oct 2023 21:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696481595; x=1697086395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+mWck7v12QS9sMNcIP6ZElr659qVny5ZQ2Hl7zbZIk=;
        b=la73IPiEFerrxyzwhklqTVr+a1cq4pxLymhtfuWrtn5PlnCjacz45UMFnHrhj+ORSS
         77/MliBxqE5qgx47BkMrKB6kn+JTKLtT32fGjnj5Q9bz8G70m4VBEKj7/lUrqABox6eK
         BefEvdC2uh+EQ+k1BMq/oh6bvA4/oCep80Vjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696481595; x=1697086395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+mWck7v12QS9sMNcIP6ZElr659qVny5ZQ2Hl7zbZIk=;
        b=J+r++EQuZut4LYOzVZ7Mj8ocNtTtspmYdMra6hDeliEZUOPtd6+Hubul72r1P2ORrI
         QKVmDGjGX/ZNp2ZVYLHLOmRCPv4kg/c8xfFJAoRtPK5tZ/tqCWP1LDGOjJ9gS+3xFUh4
         y5wNOUxjv3JULkX4KsnYF0eIATrD/3GUhd7JxJo5x7AlD5VWG+vDzlWxVWycQWgs/jjn
         uzJrGNBMjsdtmvZrrdWCJRgWgi592LLMKFRYatNkDy0h4GvRBon0EO+D/AWuIuKuGgF5
         EiSOEoGtfi4UoccWK+6zVYxYR7LspR7yQdwDWQNFwUrzDi8pPQqDAfqFAOn/P6G15RYb
         vw3w==
X-Gm-Message-State: AOJu0YxatNvuLzdhdcZtJEB1IFlOl2eKq7Ac3pPWDFzVspJeVnP6vEjM
	iQnWW3AbGpAfwjeEhuh560BGeQ==
X-Google-Smtp-Source: AGHT+IF8D7f4rBzgVUJZHbHOMvsNXjGH/tuXqi/djL/XOJwuyOeHRaztBPlrBZPkxcAZMJak/iP/zg==
X-Received: by 2002:a17:903:1c1:b0:1c0:c4be:62ca with SMTP id e1-20020a17090301c100b001c0c4be62camr4316265plh.17.1696481595327;
        Wed, 04 Oct 2023 21:53:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902d2ce00b001bf52834696sm486823plc.207.2023.10.04.21.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 21:53:14 -0700 (PDT)
Date: Wed, 4 Oct 2023 21:53:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ena: replace deprecated strncpy with strscpy
Message-ID: <202310042152.C8A84D30@keescook>
References: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 12:56:08AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not necessary as host_info is initialized to
> `ena_dev->host_attr.host_info` which is ultimately zero-initialized via
> alloc_etherdev_mq().
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

Looks right to me. Length nicely adjusted. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
