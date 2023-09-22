Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BDB45F54
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 18:26:09 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B0CAC
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 11:26:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c382f23189so18565ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695407167; x=1696011967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gTBcxUPj0X2lw9PxD7x8qtI+1zxhKTtoMwvn6AN1X0=;
        b=LhJ38cCtOgvHG6IH54ubxK1km6+Yn6O+A+aL1sKPhBC8S86PBBwAQ6aTBowa1/riX/
         v5WFdxPINY6GrrFVCHf1jOpIcrBHjUJHUNjHoUfPqbl5C5WTcvAkZETJCfO8cDO17dHV
         YJNleMhbwkWwmNGwGgbdbT7KlCOgErfYQd7WmZygeQTnPhtZ/CWKe0ACpiVoubkNxdCf
         E0QbLY//jfsfJDB1a4OeiG99hQBXJvxfO7S8jlo4+xTk7/CXHnyJhDyDdjDnvMOWDyS9
         YtpSfHJ91ptaYk8TcmTxNMMUi72XAA6j3j1CEln2TUoMigfuJJ95ZvZSvTicJg6J9zA0
         O4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407167; x=1696011967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gTBcxUPj0X2lw9PxD7x8qtI+1zxhKTtoMwvn6AN1X0=;
        b=Ov/qnVQctSNaNRJhD+6n7hoIPN/ieu7b08s1cqcg7q++wBEnK096JGU1SKjlUlawlF
         IZey6DFHYxLQYZyiYKHgj8VP5HmIyXTmqZ/IZLpa89Nq61BB/3nyKIs5DHNCMVWLcvVX
         jsRs9rDg0uvS5mSRrRCiBDisy2Butn3W3FPFUgi4h4VAW8D/lFEpGWg4By4TLPjQjhPI
         JIENsS1XfUJhAFE69UHi/UNkWx5bVVQSuksCSySZWVnG7WXosebGekvd5gYHWXxuUyNK
         6j8EMcjKyIAhyMdR0f3u1VkcrT1G04uDkrNfF3tMcBqCr5kYXohkxz+O5laStNRj86kw
         YTMA==
X-Gm-Message-State: AOJu0YwwPYcq0xGbtstDjD4oTrI1wS9hXMEfcxa+QsBLKz9Zr9IJpQsg
	o4uXaY/iGmMuQAmGqcmIlicXwgT1Brnk1+PnMXnGpw==
X-Google-Smtp-Source: AGHT+IGCw9CUYrruZ8DWnXPsm6cBFUWlN4w3pKDLMImz87xku5Rhr1T3gOI8P3au2gBUTcXhqc2mXZkvm1C5hGrfVww=
X-Received: by 2002:a17:902:d2d2:b0:1c4:514c:8717 with SMTP id
 n18-20020a170902d2d200b001c4514c8717mr25128plc.3.1695407167411; Fri, 22 Sep
 2023 11:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922175327.work.985-kees@kernel.org>
In-Reply-To: <20230922175327.work.985-kees@kernel.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 22 Sep 2023 11:25:56 -0700
Message-ID: <CALvZod5xVhR_Feq7Wp_P9BLjYHJCxqvA6BmHmzwGzw34niDQ2g@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: Annotate struct mem_cgroup_threshold_ary with __counted_by
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 10:53=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct mem_cgroup_thres=
hold_ary.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/memcontrol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 45d0c10e86cc..e0cfab58ab71 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -143,7 +143,7 @@ struct mem_cgroup_threshold_ary {
>         /* Size of entries[] */
>         unsigned int size;
>         /* Array of thresholds */
> -       struct mem_cgroup_threshold entries[];
> +       struct mem_cgroup_threshold entries[] __counted_by(size);

Does 'size' here have to be a member of the same struct as entries? We
have nodeinfo[] in struct mem_cgroup whose size is nr_node_ids which
is global. Will __counted_by() work for that?
