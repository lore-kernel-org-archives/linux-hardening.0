Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB821A15
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 18:03:38 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29189B
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 11:03:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c44a25bd0bso59136025ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695665016; x=1696269816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9RYuMzpMZ1Kjw8xCG6ScZcw+CG8cVN4DnPu5iQzw9Q=;
        b=XX/e/H3v6DCN9Vgy20E6anYYfZ80MKrtKi66y6nPH5mLZn5MP4kPxXaCifsWpI4/jx
         SlgHdDGbR6X0+rF2z0uG8qiLYTogKqEGZ7os+hZ9KlzR3c6PUC3w0GybQmxX6tKfFnQ8
         T0PinL/S2Ax5MFRjLJQHnlepQsD7Kc8VltOjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695665016; x=1696269816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9RYuMzpMZ1Kjw8xCG6ScZcw+CG8cVN4DnPu5iQzw9Q=;
        b=TP3XIZXHpAeF4dVXD/f9OF8d6E5FD+qZB/y3NCQaaOfuofmv2iBrEt80n1CFbaMow7
         Wa2tG6B2mcurOHJ3f0qgnKNNHqJnxT/OxIVBeU1KyvXrZaFmDguzTqLV3Ae9dhPhhXVO
         23YqMHiryT03VQQW44BO04FP7G9ihyVpTH7lTzjzRlGvnu0smb1ChQJiRjAp1xoB0XSh
         4sWcpqrbS5b1eZDDWDzep4SA1uqUA0tyHcw/XI2l0sG242B2ZyrV9ne9yPJ23zYEzeY2
         S+YrOflzNUOYmyC7FnFyFTMLsA0uuCVZzi2UlzObJi9waoL2ow4+iiLnH8I/OMjqaCV4
         N+Xw==
X-Gm-Message-State: AOJu0YwL8JveqoA+MBh6G5+OZZ8tX0yMD4cd+eoonRjLl/htRBFC7u03
	JW/n3REjpe0p1jZTqiNoJp0Qiw==
X-Google-Smtp-Source: AGHT+IG74UKbEkY1JQiaqOtSpDzma/IThI+ed1OjvWcjV2tlvk545e9MyWcqQ9MZpxR309voDZttjg==
X-Received: by 2002:a17:902:ce8b:b0:1c5:7d49:570e with SMTP id f11-20020a170902ce8b00b001c57d49570emr558074plg.29.1695665016096;
        Mon, 25 Sep 2023 11:03:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001bb3beb2bc6sm9184421plb.65.2023.09.25.11.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:03:35 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:03:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm cache metadata: replace deprecated strncpy with
 strscpy
Message-ID: <202309251103.4FBC42C4@keescook>
References: <20230925-strncpy-drivers-md-dm-cache-metadata-c-v1-1-4b75c7db0cfe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-strncpy-drivers-md-dm-cache-metadata-c-v1-1-4b75c7db0cfe@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 06:13:12AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> It seems `cmd->policy_name` is intended to be NUL-terminated based on a
> now changed line of code from Commit (c6b4fcbad044e6ff "dm: add cache
> target"):
> |       if (strcmp(cmd->policy_name, policy_name)) { // ...
> 
> However, now a length-bounded strncmp is used:
> |       if (strncmp(cmd->policy_name, policy_name, sizeof(cmd->policy_name)))
> ... which means NUL-terminated may not strictly be required. However, I
> believe the intent of the code is clear and we should maintain
> NUL-termination of policy_names.
> 
> Moreover, __begin_transaction_flags() zero-allocates `cmd` before
> calling read_superblock_fields():
> |       cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
> 
> Also, `disk_super->policy_name` is zero-initialized
> |       memset(disk_super->policy_name, 0, sizeof(disk_super->policy_name));
> ... therefore any NUL-padding is redundant.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Agreed about the %NUL termination and padding assessment.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
