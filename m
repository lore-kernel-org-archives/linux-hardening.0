Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60E13ADA
	for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zk7OdtCW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD11BE
	for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697196350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oETjfSu3gjSmeaayJgiKomX22px4/QpcSAQkJsgT+CY=;
	b=Zk7OdtCWojk5J9aoPwnRrpRS3wOrVDIPVY6XKDqw1jVC7ccCEDBxRBK5sYxDxxxtcyQiOC
	EFZlz1EnxJK/CXp8Fl17eaDUHCkTwTJSKCXNsXSNW1AggqywxndECiLy5jVSL56/PUSUpw
	qrp5Qo3VDqkEJZaxAW6ieS3occPLOPc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-lof-i1YDNreeVieXBXa0jA-1; Fri, 13 Oct 2023 07:25:49 -0400
X-MC-Unique: lof-i1YDNreeVieXBXa0jA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-66d026cae6eso22035496d6.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 04:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697196349; x=1697801149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oETjfSu3gjSmeaayJgiKomX22px4/QpcSAQkJsgT+CY=;
        b=iLi5FGc4rko0gCp+irsfpVmTF0Cb1wzoJHG08uShzpPTkO6c2vIrXNt3Oog5e94RB2
         WelwGiDz35c/GmgK4LvzCRLanEdmM68HKBwLNC3XKD60/VpX/np8uaR7HXRSt3pi9XWY
         IL76ktjqa1+24vESYbfhUBu6G3yGXSu9pU+b2sVwzXg8oNGpAzRIIjrNnczfi7QWKXoX
         VIOfr+WQ4P3Bp73kiCsZSKeSuWkEuCCA2PDzBelAFZXJ21fbQHVF3HnXByPQZdEgC5Er
         OWoJUJG4MfJ41tfuYpHOmNkN/RXB9vj5oVAjhf3fHClhKgPvWFg8s3aCfjbfFpBsybqZ
         S2og==
X-Gm-Message-State: AOJu0YzMfs372DGfxiZcJzmqDnpuLAi34SjFm9N02nbzMxRkkMQJMElw
	9bYaaf/sUlzxHEHyAIZxnN/0wqkZwg0RbGgNyPWsvxSNo5++7WUXkogNzXuOzUK8SVXGYhGdwvJ
	b8nWZIwfKv7osxsc0mDJUZhwKMahyJAjCp0sa
X-Received: by 2002:a05:6214:2e49:b0:656:3407:f45a with SMTP id my9-20020a0562142e4900b006563407f45amr28545147qvb.43.1697196348758;
        Fri, 13 Oct 2023 04:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLmRjrd0qLWu+HtByfYjY1jQcjwD2r7wPgexHNnbw6khk2VZUqmKPEM7i/QmQo0hoPHeXwIA==
X-Received: by 2002:a05:6214:2e49:b0:656:3407:f45a with SMTP id my9-20020a0562142e4900b006563407f45amr28545142qvb.43.1697196348558;
        Fri, 13 Oct 2023 04:25:48 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id v20-20020a05620a123400b0076f1d8b1c2dsm544841qkj.12.2023.10.13.04.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:25:47 -0700 (PDT)
Date: Fri, 13 Oct 2023 07:26:11 -0400
From: Brian Foster <bfoster@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Refactor bkey_i to use a flexible array
Message-ID: <ZSkpU0vdrCTfTxuZ@bfoster>
References: <20231010235609.work.594-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231010235609.work.594-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 04:56:12PM -0700, Kees Cook wrote:
> The memcpy() in bch2_bkey_append_ptr() is operating on an embedded
> fake flexible array. Instead, make it explicit, and convert the memcpy
> to target the flexible array instead. Fixes the W=1 warning seen for
> -Wstringop-overflow:
> 
>    In file included from include/linux/string.h:254,
>                     from include/linux/bitmap.h:11,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/smp.h:13,
>                     from include/linux/lockdep.h:14,
>                     from include/linux/radix-tree.h:14,
>                     from include/linux/backing-dev-defs.h:6,
>                     from fs/bcachefs/bcachefs.h:182:
>    fs/bcachefs/extents.c: In function 'bch2_bkey_append_ptr':
>    include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
>       57 | #define __underlying_memcpy     __builtin_memcpy
>          |                                 ^
>    include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
>      648 |         __underlying_##op(p, q, __fortify_size);                        \
>          |         ^~~~~~~~~~~~~
>    include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>      693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>          |                          ^~~~~~~~~~~~~~~~~~~~
>    fs/bcachefs/extents.c:235:17: note: in expansion of macro 'memcpy'
>      235 |                 memcpy((void *) &k->v + bkey_val_bytes(&k->k),
>          |                 ^~~~~~
>    fs/bcachefs/bcachefs_format.h:287:33: note: destination object 'v' of size 0
>      287 |                 struct bch_val  v;
>          |                                 ^
> 
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Brian Foster <bfoster@redhat.com>
> Cc: linux-bcachefs@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/bcachefs/bcachefs_format.h | 5 ++++-
>  fs/bcachefs/extents.h         | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
> index f0d130440baa..f5e8cb43697b 100644
> --- a/fs/bcachefs/bcachefs_format.h
> +++ b/fs/bcachefs/bcachefs_format.h
> @@ -300,7 +300,10 @@ struct bkey_i {
>  	__u64			_data[0];
>  
>  	struct bkey	k;
> -	struct bch_val	v;
> +	union {
> +		struct bch_val	v;
> +		DECLARE_FLEX_ARRAY(__u8, bytes);
> +	};
>  };

Hi Kees,

I'm curious if this is something that could be buried in bch_val given
it's already kind of a fake structure..? If not, my only nitty comment
is that memcpy(k->bytes[], ...) makes it kind of read like we're copying
in opaque key data rather than value data, so perhaps a slightly more
descriptive field name would be helpful. But regardless I'd wait until
Kent has a chance to comment before changing anything..

Brian

>  
>  #define KEY(_inode, _offset, _size)					\
> diff --git a/fs/bcachefs/extents.h b/fs/bcachefs/extents.h
> index 7ee8d031bb6c..6248e17bbac5 100644
> --- a/fs/bcachefs/extents.h
> +++ b/fs/bcachefs/extents.h
> @@ -642,7 +642,7 @@ static inline void bch2_bkey_append_ptr(struct bkey_i *k, struct bch_extent_ptr
>  
>  		ptr.type = 1 << BCH_EXTENT_ENTRY_ptr;
>  
> -		memcpy((void *) &k->v + bkey_val_bytes(&k->k),
> +		memcpy(&k->bytes[bkey_val_bytes(&k->k)],
>  		       &ptr,
>  		       sizeof(ptr));
>  		k->k.u64s++;
> -- 
> 2.34.1
> 

