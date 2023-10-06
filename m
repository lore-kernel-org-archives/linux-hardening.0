Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58B44481
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bt2FpJdZ"
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE89BF
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 14:17:57 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-578137b42b7so2035733a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696627077; x=1697231877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8YyZNdSqKiy5DzZ/PIG6aNvb3OwzQTDwFSCpe0do0I=;
        b=bt2FpJdZTTkpV0o2fgOlBhJlhKkYnYl0azJN/W0gEHnbdldCA4g6/NLyP5cHGvrR3/
         wktjqaq7xf/F7gdR9gGltuzqzPICGfrhST7f0Tw3Yvm9JGswmvTosLOpyHsiI5Fj9nTV
         dVe9lQ5FqL+uBHGSkldsIJBSciEgtu6bIQzHabLxifAGbMh/mFLQlBtZmn+Q5znThak+
         sCf441UJZEfecvlDaFqAPWOHkeU/SBkPhsEzQ7XUe5Sd0ReDY+bfD4LV82H4EvMaCrGY
         wT2DY7dGyUbF6MTTLk43mwRmoVIyfHofMzLKqrpwOJEQtirSgbfFq55nMibXdpeduAsc
         xfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627077; x=1697231877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8YyZNdSqKiy5DzZ/PIG6aNvb3OwzQTDwFSCpe0do0I=;
        b=Kg81BWGaxiFApMzlB4vzm1jPIPLNKdVYlzCzl0it7IL6u72zE7pgaQqBGX2mqBdxWy
         aNuApBO4XYCXrUtyxiYxLwOJ9V1AdoKvWomzJ340L5YkZIumXFCXtQy4y8NCt4s/7rtF
         BQXj64RFICZvfY9EfVWvyp2wkqUl0jN0BBaSNjE1XNADnafamyeQqY7zXdGT54cR5+Zc
         et61Bnhdl3pgNbHrrqJJLI3zrviiJnkXkj43FAoHnsxTNSlVQcdv3b3qk7OAhdwtat24
         iE1NM+5Y0s/wHbjxmElf3eDu01/cPqnxOdF6+IoosmCCdyYNjyIs2JvVqg0HaJbhgmTr
         SuvQ==
X-Gm-Message-State: AOJu0YyF102g6YMch4qMs7hVVtt7xsLphUuzeJkUX2ACeN5QZ83kLYVS
	FOttVfjieEKgoTKDI9q+3WQfKVs=
X-Google-Smtp-Source: AGHT+IGnmD6XCIMe/EZKQtEqPeVmzgwcfi0GavAMqiLOd1teM7yDtIh3f0wNuZUWye4WBFumI9XzkvY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:4e4d:0:b0:589:86ae:2107 with SMTP id
 o13-20020a634e4d000000b0058986ae2107mr57778pgl.9.1696627076618; Fri, 06 Oct
 2023 14:17:56 -0700 (PDT)
Date: Fri, 6 Oct 2023 14:17:55 -0700
In-Reply-To: <20231006201657.work.531-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231006201657.work.531-kees@kernel.org>
Message-ID: <ZSB5g6CmpjS-l5nK@google.com>
Subject: Re: [PATCH] bpf: Annotate struct bpf_stack_map with __counted_by
From: Stanislav Fomichev <sdf@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, bpf@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/06, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct bpf_stack_map.
> 
> Cc: Song Liu <song@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

TIL about __counted_by :-)

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  kernel/bpf/stackmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 458bb80b14d5..d6b277482085 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -28,7 +28,7 @@ struct bpf_stack_map {
>  	void *elems;
>  	struct pcpu_freelist freelist;
>  	u32 n_buckets;
> -	struct stack_map_bucket *buckets[];
> +	struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>  };
>  
>  static inline bool stack_map_use_build_id(struct bpf_map *map)
> -- 
> 2.34.1
> 
