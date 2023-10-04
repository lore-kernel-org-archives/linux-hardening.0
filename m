Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3807E
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 00:24:02 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F90AF
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 17:24:01 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c72e235debso3360265ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Oct 2023 17:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696379041; x=1696983841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+5Ev8JWtX66U66pqJ0cubLluMVIrf54bZdgwJ7z1Ak=;
        b=R/HoyXxxAEP3kkZLfR3iS1pHFGv8S1VtXsck6cLhsWAX7OlcWwoSfrDvIfI1dl2P8F
         d5zKFM+hasB0Qx0Uw+WhVzSR/4McPloibAnCpKdOaLDupbgY4W++f8+XdAL8918V9b6q
         0jPIXcgMaB/vyokc155iZFt/gjXZLYl96U6enQatTeLqo8QKqV3HlcW/JA5NUgHBzJRc
         lec9ILki6Ctpc0iwzro7krpbR83Nhemc3m0pmmrJG4raw34aV4glr1IuMYYreNhyr2YO
         n8hLL8gZc/bvs7nTZ058S3OitX6CBsScXg1GbKHLGbRsvytwh1DooSsiJD6bwiNXdVk+
         zy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696379041; x=1696983841;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+5Ev8JWtX66U66pqJ0cubLluMVIrf54bZdgwJ7z1Ak=;
        b=knQmh2kulzqlMXziliMTo79UHotteRzlzZx8JMZjOGD+/mfgEIKcmK1S/eqDRG8O/X
         JpLZ9HIKZMu4qKEGhTH2LigVmagz33PBa+XIY4BdfFH+tKEGup8FThYoKNbAT6/zjGn6
         HiXi/47Q8tBXlZDhme13Qa6Umu5+wrJc9f4MX8q8I/ZCeUjsNlQyBP9tdkUNJaSOqyWf
         vUg8nodh4m1H5Ppmp2LA14dKoKZLdWKnBPGDimHIAx+y/ubRaL8/cbJhFTqS2vJr4vZw
         YpbPcXtyIccr5F+3Q4A0Xql7tJS+67H4EtpBH7Y/dHcnj26WPLX22WUY7xWzW5fjCyEx
         rw/Q==
X-Gm-Message-State: AOJu0YywwN8nvxGwCRDLZnKMZyJOQ9ZSLTjSjbZaTI3LGr+d5rIfDTRM
	EnN/o8wkhQ2NB3bGmJEpIWdrPze9vWEiR2odCAU=
X-Google-Smtp-Source: AGHT+IEvQwCu5KlFSVrIsyfFD4FEedBJjE5H3J5n5+KArZ9kYYzxcWis1JxMvNXNH05ayQypBqz28w==
X-Received: by 2002:a17:903:22cc:b0:1b8:2ba0:c9a8 with SMTP id y12-20020a17090322cc00b001b82ba0c9a8mr1114184plg.2.1696379040778;
        Tue, 03 Oct 2023 17:24:00 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id y20-20020a1709029b9400b001c0a414695dsm2241525plp.62.2023.10.03.17.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 17:24:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Justin Sanders <justin@coraid.com>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
 Xu Panda <xu.panda@zte.com.cn>, Yang Yang <yang.yang29@zte.com>
In-Reply-To: <20230919-strncpy-drivers-block-aoe-aoenet-c-v2-1-3d5d158410e9@google.com>
References: <20230919-strncpy-drivers-block-aoe-aoenet-c-v2-1-3d5d158410e9@google.com>
Subject: Re: [PATCH v2] aoe: replace strncpy with strscpy
Message-Id: <169637903951.2062263.17214636672785738003.b4-ty@kernel.dk>
Date: Tue, 03 Oct 2023 18:23:59 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Tue, 19 Sep 2023 05:27:45 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `aoe_iflist` is expected to be NUL-terminated which is evident by its
> use with string apis later on like `strspn`:
> | 	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);
> 
> It also seems `aoe_iflist` does not need to be NUL-padded which means
> `strscpy` [2] is a suitable replacement due to the fact that it
> guarantees NUL-termination on the destination buffer while not
> unnecessarily NUL-padding.
> 
> [...]

Applied, thanks!

[1/1] aoe: replace strncpy with strscpy
      commit: 5e9b7cfc209b84d135993b8cb75ea383f24b2bba

Best regards,
-- 
Jens Axboe



