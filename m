Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9629433
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DM92OVe/"
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F8198
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:53:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c60f1a2652so2953975ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696978415; x=1697583215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sM2D1z73zi+5HYrcOqeqetxrp6E/x8mIV2xfN5N2igs=;
        b=DM92OVe/C6YiKLrtiL2N8KFHcGveutEPVbhbsoYAq2nse0Gy7k7dQfxjFlWDRNa3hm
         No3QxubAVLFg5Ygt4kf/s3slq3FsYMP+xa8uFN8Uizy372mas1041Z6Q6ZwOJ5EYQ+zx
         /8HAPQwsljYJZ2WWlQOjTH28PhubKfVem091E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978415; x=1697583215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sM2D1z73zi+5HYrcOqeqetxrp6E/x8mIV2xfN5N2igs=;
        b=w/xlzu5XOh1rEN1wUjJELoL7NZC84ywZJLIzTdhxgKOEFcr8hO3EVWztD4/t0KXzOT
         A2LtOmHRBakYE5259N7CM9zsGJRg6shbtqRrMqs5Fjt1x3/EVpPgUEiKeb7WyEbLYFaQ
         Gkp7D2UCfBGNdvXtyBgy6vCpBMChSrP2TXslG0I2OA6637s4013x1mqgppRDctCUNwsA
         Q9fysK8AVWk1XUY5l0tAzkBDj395NhzBPEFZIh+d0HWluFtVbiMMVIq/YF1l5d9Dcar7
         pkvWv0vP28RkoUFhNHqKOj1HngzofNUciS8j1ncFZNkPz2ChwWpZbwa5NrrDTcgtpu/+
         HRCQ==
X-Gm-Message-State: AOJu0Yy6KITiX6T9T9QwXFML3GzXWefmmvIHCY2gifaTRPM5MCu/k0tD
	n2AlDCOcnRRbyxYiXjzihsi9wA==
X-Google-Smtp-Source: AGHT+IF5qzcdrI8/uAq34pNGWTaPSCwg++M1k0mWJv9CMAIOsIQmhZyd+wlOKIN+dREI7d5oXJ4TwQ==
X-Received: by 2002:a17:903:493:b0:1c0:bcbc:d66 with SMTP id jj19-20020a170903049300b001c0bcbc0d66mr20932044plb.7.1696978415300;
        Tue, 10 Oct 2023 15:53:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001bde65894c8sm1782132pls.268.2023.10.10.15.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:53:34 -0700 (PDT)
Date: Tue, 10 Oct 2023 15:53:28 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] afs: Add __counted_by for struct afs_acl and use
 struct_size()
Message-ID: <202310101552.3578F46@keescook>
References: <ZSVKwBmxQ1amv47E@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSVKwBmxQ1amv47E@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 06:59:44AM -0600, Gustavo A. R. Silva wrote:
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
>  fs/afs/internal.h | 2 +-
>  fs/afs/xattr.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 469a717467a4..e263a58b82ba 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -1116,7 +1116,7 @@ extern void afs_fs_inline_bulk_status(struct afs_operation *);
>  
>  struct afs_acl {
>  	u32	size;
> -	u8	data[];
> +	u8	data[] __counted_by(size);
>  };

It's surprising how many of these 2-member structs we have in the kernel
that do the same basic thing. :)

And I see that "size" is assigned before using "data", good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
