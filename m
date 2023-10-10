Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0523550B
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SRhYUedH"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D652199
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 16:09:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5c91bec75so42958965ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696979377; x=1697584177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9NRsBIuS7/t1xSzM4HVRP0dsTmAqJy+of1PCaXbcgM=;
        b=SRhYUedHEFcJqynHoSRhp9FvfE+588d7WSAI/0HLQv/vSfHjKUJzFZtWS6rFaX4K3P
         SREH1j8fR2cSdjNHbgSs3lEYC/efSJxmvxlD+kk+D7nU9Jwo6hjp2AZaCx7K3E9YTNUf
         o0KqFcXeRbX4mJRijg7jQy6SifEd7ZqAXRmdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696979377; x=1697584177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9NRsBIuS7/t1xSzM4HVRP0dsTmAqJy+of1PCaXbcgM=;
        b=A40kRksHB3PpOlQ06mYYIo0DFfcmvNFU/WwBAh+iJAmNb5E+HUTtZl4P8UajXJqFDE
         8YI7HMUm4VIx/bDWz9/0ZXk12B4aqnrMsNpBSDqhgq0DwUJmfS+Dmpl7X/kmT8KIFFWG
         1N1qsRzWPv23hbb8M4UQj80LT4Mk6ElZuciw0e8Ah5Qv/AD+PUWTEeWuKxKNjAIwX9bL
         QcdF0QgRTrxKIlBjNy4AZNllVv6MxTqQ5hoxhLb3Py34uk+75kKjoQ7WFIpw7TOCaDOw
         ceJujU7syKRXpkCA3qf7642l/7+dhXgS5+NNEVkEza8TDUwT/QrQJ6bu6n3NrR6NbY2X
         PzQA==
X-Gm-Message-State: AOJu0Yw16sBCLHHtGT6Oc9A62QKgavdZBOaankWSzFkJWeNMk6AI3GrY
	96IdMvLiTZ6374WU9bal+/3rUkk81psEKUB4J90=
X-Google-Smtp-Source: AGHT+IGgmzpC22sgiK9oMsgsREK3LFJzysUpnKl171CEVnXwEJGOya787Jhv0d5rIBgLPK6gEOlMUA==
X-Received: by 2002:a17:902:ab13:b0:1c3:eb95:2d27 with SMTP id ik19-20020a170902ab1300b001c3eb952d27mr17223508plb.48.1696979377307;
        Tue, 10 Oct 2023 16:09:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902a38900b001c9c5a1b477sm728016pla.169.2023.10.10.16.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:09:36 -0700 (PDT)
Date: Tue, 10 Oct 2023 16:09:35 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] atags_proc: Add __counted_by for struct buffer and
 use struct_size()
Message-ID: <202310101607.3D7ED0A@keescook>
References: <ZSVHurzo/4aFQcT3@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSVHurzo/4aFQcT3@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 06:46:50AM -0600, Gustavo A. R. Silva wrote:
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
> ---
>  arch/arm/kernel/atags_proc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
> index 3ec2afe78423..cd09f8ab93e3 100644
> --- a/arch/arm/kernel/atags_proc.c
> +++ b/arch/arm/kernel/atags_proc.c
> @@ -7,7 +7,7 @@
>  
>  struct buffer {
>  	size_t size;
> -	char data[];
> +	char data[] __counted_by(size);
>  };
>  
>  static ssize_t atags_read(struct file *file, char __user *buf,
> @@ -54,7 +54,7 @@ static int __init init_atags_procfs(void)
>  
>  	WARN_ON(tag->hdr.tag != ATAG_NONE);
>  
> -	b = kmalloc(sizeof(*b) + size, GFP_KERNEL);
> +	b = kmalloc(struct_size(b, data, size), GFP_KERNEL);
>  	if (!b)
>  		goto nomem;
>  

Yup, "size" is assigned before accessing "data".

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
