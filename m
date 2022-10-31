Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAADBECAAA1
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Oct 2022 20:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJaUQa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJaUQ3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Oct 2022 16:16:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7D60E7
        for <linux-hardening@vger.kernel.org>; Mon, 31 Oct 2022 13:16:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x2so19089493edd.2
        for <linux-hardening@vger.kernel.org>; Mon, 31 Oct 2022 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ci3+QoHQ25KB/iJMgmn6M3elbqhltdUkE8SPO6WZlmo=;
        b=CTq5gfsrME/R6gLnFUaqNt0aOVbT6FsZdc4Y79sVuG3Ei3LiCj1u1WpbqERv/iHI1M
         iqxNDtg5J9u3HoJ03UQzyZJf+xLFzk90PkvZjo55ZgpkQGiCsyoP/7HnGkk3E2ZI38vZ
         LcWSvxybIs+Xp/rXEFb3lkFepFH32VuGs28NjvTry1Adw289juuZZK0ZEJIgJQxtYuLl
         2aUYIUoFvjytKpnwCI1LD1X6Pr/8HFKhD3ZEk5R/W3TSRSoHxuhEB45kWJ/nrUByxN4Y
         FvRtgj2eEwIemS6gW+ubspkopG/c+k/qRMVBunNq8y7spIeIpRiKOtHpdjwppZ2EAdnl
         33Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci3+QoHQ25KB/iJMgmn6M3elbqhltdUkE8SPO6WZlmo=;
        b=s5myAOJp7dOA1f51FCxhnMb/AeNHBuvb+oOI3hKjzKJACY7hIwyvEGV1ibsODDTGOG
         C1WjCAK75FzQ5VBx9BESwS0ztl9rUhln/Obmn3lFEUNhjUZqv3LASARbI1EZj7g2gfjq
         ArrTMlDB8p1e3P7Kw2qU0IQtfFch8jfoRe0antH+o5ncUoezZPPkpH5E/wYMwzowCWEj
         mOqD5XXrn8g2e3eExRdORinBJ/D2zTV7iGoekPOjZ0umGWx2u3EohOi8i1X/T97xh64w
         KjSJV58meZkvfSCsinyA+u2P59cyGelyYZlgmgERrUnT7AVf4j3scgwdTCqyVvnVK9B6
         o8og==
X-Gm-Message-State: ACrzQf2BMaypfUEK0M5FapQFLj4z0mOy+kNnj7uRtpqiNh5PPGICCY3f
        CWlz4k/Dda+Uaq7WXZfEwCfFyInxhUV1xaxmgdUi
X-Google-Smtp-Source: AMsMyM7FRCcRFTFbl0DrxIU1Df1+CfE/Y1YzIBEFicyXXX8ZtMZF3eDdxV5jWU80lH6VSNcXEsdIz+04ZtO0WlJW7EY=
X-Received: by 2002:a05:6402:22a5:b0:462:b393:f281 with SMTP id
 cx5-20020a05640222a500b00462b393f281mr15555602edb.379.1667247386069; Mon, 31
 Oct 2022 13:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221029024444.gonna.633-kees@kernel.org> <20221029025433.2533810-1-keescook@chromium.org>
In-Reply-To: <20221029025433.2533810-1-keescook@chromium.org>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 31 Oct 2022 13:16:09 -0700
Message-ID: <CAGG=3QXYVwQ5pwARdGTenm-mDQn4Tcz6U-=EZ8BDcwBkM5bFfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf/verifier: Fix potential memory leak
 in array reallocation
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 28, 2022 at 7:55 PM Kees Cook <keescook@chromium.org> wrote:
>
> If an error (NULL) is returned by krealloc(), callers of realloc_array()
> were setting their allocation pointers to NULL, but on error krealloc()
> does not touch the original allocation. This would result in a memory
> resource leak. Instead, free the old allocation on the error handling
> path.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Bill Wendling <morbo@google.com>

> ---
>  kernel/bpf/verifier.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 014ee0953dbd..eb8c34db74c7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1027,12 +1027,17 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
>   */
>  static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
>  {
> +       void *new_arr;
> +
>         if (!new_n || old_n == new_n)
>                 goto out;
>
> -       arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
> -       if (!arr)
> +       new_arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
> +       if (!new_arr) {
> +               kfree(arr);
>                 return NULL;
> +       }
> +       arr = new_arr;
>
>         if (new_n > old_n)
>                 memset(arr + old_n * size, 0, (new_n - old_n) * size);
> --
> 2.34.1
>
