Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103BB19B
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 02:53:43 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5621127
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 19:53:42 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3ae0b0e9a68so2620595b6e.0
        for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 19:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695524022; x=1696128822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/d9b/PeADBzIfI3pWZpLK3xrhqpPASs1Sf8duAT6F0E=;
        b=YLqJ6ECN2eQnUTmHlZCt/ErWq7nPAWXVCe/o4FVh/UpzZcaIDQBpgWB4c7gn1m9E9M
         3T7NJOBFoBPd7A7IjBOEbbaE1BEmesmgRKuNNlHE5BvHp7vvnnuyfAGrZBb/H4I+BGx+
         Xpc/Qu49XLGMk5rvPtHyOyEjutf8VcarmdMOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695524022; x=1696128822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d9b/PeADBzIfI3pWZpLK3xrhqpPASs1Sf8duAT6F0E=;
        b=bmf9nTCuLDKYBQ6uJJhBUykogaePH1pcu8B+p/OLm2JrZ/R+4mc5vr2LPGDrC7r6Tl
         WNegjvw4L7ToyY8mrfNeFrPBEB3GWN7/fFAXaiJ9hM5UZxhmMNQFGHJyy9/cAiOR7pNA
         zWfacqWlqdAGLY2AtuX8Mu9GeEzGyBU6riOXBkaqxvMUjgREQlqO5BfFyzYb5J3z7ZVT
         kiYIwlpWSyODbJyvlkuakf2RSIkOwCvg2BHHezzxn1kpOf9ffMks14g1BQmerc4MLVeD
         D9gje99Yaejd1HF2Jw94cocKuTzrbWlOzvhq/lgFbkryw78oIU/jdFcvzlYSEWAGWUZT
         AxKA==
X-Gm-Message-State: AOJu0Ywhk5JeuBR8USPfuJV99OFhbMH4Y2UQnwGQ0w3LKjTt8dAPdyU2
	kBqf+rjG3uJFmYORISbUW4BPWA==
X-Google-Smtp-Source: AGHT+IFC6DSYvUj9536i9d90/GS4ktpilI0BoWD5bQsotIoh2JHoAVTBOKOCB9AQfdY2ieUWLZZx9Q==
X-Received: by 2002:a05:6808:f8c:b0:3a7:366f:3b01 with SMTP id o12-20020a0568080f8c00b003a7366f3b01mr4444965oiw.33.1695524022174;
        Sat, 23 Sep 2023 19:53:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f54c00b001c55e13bf2asm6022710plf.283.2023.09.23.19.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 19:53:41 -0700 (PDT)
Date: Sat, 23 Sep 2023 19:53:41 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Bo YU <tsu.yubo@gmail.com>
Subject: Re: [PATCH v2] drm/etnaviv: refactor deprecated strncpy
Message-ID: <202309231952.6E01CF3589@keescook>
References: <20230918-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v2-1-8ae12071c138@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v2-1-8ae12071c138@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 01:34:08PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees NUL-termination on the destination buffer whilst maintaining
> the NUL-padding behavior that strncpy provides.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Bo YU <tsu.yubo@gmail.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good to me now. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

(Though again if you need a v3, making the Subject more specific would
be nice, "...: Replace strncpy with strscpy_pad"

-Kees

-- 
Kees Cook
