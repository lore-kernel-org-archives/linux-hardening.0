Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60C1C03
	for <linux-hardening@vger.kernel.org>; Sun, 15 Oct 2023 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Odi8MenD"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A8DA
	for <linux-hardening@vger.kernel.org>; Sat, 14 Oct 2023 19:29:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso901509b3a.1
        for <linux-hardening@vger.kernel.org>; Sat, 14 Oct 2023 19:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697336998; x=1697941798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dhN/OgC882rYGvnQvvtSIJopNEt0MUImMTuzjqZB2Xk=;
        b=Odi8MenDvKuf/AZcwNneuZFISXmSP4H8U2QnTOs9+tLcXMyrQNLcEq5oM1t0ELa5XI
         DPAWGPpjkHyon7/JTTZAgPY/HteOJpRDWphxmeF4BOphMAHqnt7RZBDW6IVJZGIoGDLr
         NPKv1l4UeDBU8qczVFi6AZfXG/jzFv++t1ilc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697336998; x=1697941798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhN/OgC882rYGvnQvvtSIJopNEt0MUImMTuzjqZB2Xk=;
        b=Ib+35EQZANIzeyb6Jlrn1Y7aP4bWpYGps228p2Po9lnwlvqdNyyWAx3NHniB90QcFD
         GxZr6mhqhJi7zQbSmwfOwBOYYdfyled3pQ4GVODNCxFoeaANLvorLs+o+vhg3ARRdKO4
         zDrNBT+KqXVrPG3ow5VsQ7W2F4kJEegsx5Vpw41sH7ldRVZRcigARlF/eikvyRcuDdK5
         8yex7mqRz30b9SjMd3Niu4nUypVjAMgOH3MiFqMkvZU46g0UpnwY4I+00JuBVrcAMJgW
         vT0khFAoay9h5xWkTWOZJ2iuPWesvmND/UoP6o8Dk0dhCzjAsn2sibMPHpFRadUDPeh5
         CiAQ==
X-Gm-Message-State: AOJu0YzbBr3Yw7y54g07C2s9wPJVQ4KZPYS0iWpghLuBap97ZdiZtsIu
	l6Oj5Q+QWeJ+TfL+rxv8mwc8aQ==
X-Google-Smtp-Source: AGHT+IHFveeRvUhPLEvQmB6YP6tVaXJOJXks9U+vR3El7JIrG5IcRyQop3DrOWjlCqDIVoZMvrQUcA==
X-Received: by 2002:a05:6a00:318c:b0:68f:cdb8:ae33 with SMTP id bj12-20020a056a00318c00b0068fcdb8ae33mr5233919pfb.10.1697336998549;
        Sat, 14 Oct 2023 19:29:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t1-20020a63b701000000b005776446f7cbsm4589302pgf.66.2023.10.14.19.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 19:29:57 -0700 (PDT)
Date: Sat, 14 Oct 2023 19:29:57 -0700
From: Kees Cook <keescook@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
	dev@openvswitch.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] net: openvswitch: Annotate struct mask_array with
 __counted_by
Message-ID: <202310141928.23985F1CA@keescook>
References: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>
 <ca5c8049f58bb933f231afd0816e30a5aaa0eddd.1697264974.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca5c8049f58bb933f231afd0816e30a5aaa0eddd.1697264974.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 08:34:53AM +0200, Christophe JAILLET wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Fix the subject  [Ilya Maximets]
>     fix the field name used with __counted_by  [Ilya Maximets]
> 
> v1: https://lore.kernel.org/all/f66ddcf1ef9328f10292ea75a17b584359b6cde3.1696156198.git.christophe.jaillet@wanadoo.fr/
> 
> 
> This patch is part of a work done in parallel of what is currently worked
> on by Kees Cook.
> 
> My patches are only related to corner cases that do NOT match the
> semantic of his Coccinelle script[1].
> 
> In this case, in tbl_mask_array_alloc(), several things are allocated with
> a single allocation. Then, some pointer arithmetic computes the address of
> the memory after the flex-array.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> ---
>  net/openvswitch/flow_table.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
> index 9e659db78c05..f524dc3e4862 100644
> --- a/net/openvswitch/flow_table.h
> +++ b/net/openvswitch/flow_table.h
> @@ -48,7 +48,7 @@ struct mask_array {
>  	int count, max;
>  	struct mask_array_stats __percpu *masks_usage_stats;
>  	u64 *masks_usage_zero_cntr;
> -	struct sw_flow_mask __rcu *masks[];
> +	struct sw_flow_mask __rcu *masks[] __counted_by(max);
>  };

Yup, this looks correct to me. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
