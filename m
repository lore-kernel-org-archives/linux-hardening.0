Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9A6C3DA7A
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 19:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjAET4m (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 14:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjAET4k (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 14:56:40 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E341705B
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 11:56:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b2so40443851pld.7
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNAHJWZl89mjOQvMEo1p1ZkgeOAkQHRiEhR4LV3lPIo=;
        b=XWxgk4fhvyjrFX+kOW/hwpg25LMFVema6lrLTHAEZOdEIBKXVQfSfCMpOlWUNyoFzp
         2sHz4fAA2ccBz8jPu4P6/YNTXLfNTQqVP4/vnTkzPQfKNjQQQSy2K4JVL/wkXRMqkaRi
         RXQ3QVZJ1i9mSz++toicGXt43a/E6BXVb6TVIHustJRCYfCAgqDGshKlZsd3ePDvmS4l
         iyQqe2RTOD0tG/fgCOoTz4JAzaApUMdSff6iSVwM0zql8EORtNFvC+7fhSyb3oRci2HB
         LmZ5dEPWOHuVIMACPEu5NmVX/xmuQkOkhVM2q9dXKiojrUAN/Aa9PpPbnfc6ZqlUB04R
         jpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNAHJWZl89mjOQvMEo1p1ZkgeOAkQHRiEhR4LV3lPIo=;
        b=4kwJqI1gFOTfNtHS3kzBxWxR2girdavqGmmgp1Sx+lRn4C/KzJKbMKbw0bpSy1UI60
         crOS7vNDLa10w2Wp5ia1WqaijJOaM6Ux5HNwA/KJATz7VFkuLrePsjfV7QF30WKi4YBy
         y+MvgbWEgn1eQ5Xumhsmt93cUQYEERF5SmiPR5qKIR2lI6T+WyJc1vC7+eUw8AvuiDb5
         oy1PVO7JxU3txUh51/BzO/BYJhIjnaJkz2PhlVZJLhumZvccSXp7XgeJKoFpG+UTCPPo
         kQ2Godkg+8n2ErHfIkU25OJV5J2G9B6Zl5fWsFCDY4eWfMiMUBAuj4DGFoUJLx4PBza5
         131w==
X-Gm-Message-State: AFqh2koRdLjx2+EZSynExkLRw/3N02aRBa3DPdhrwNbWPy7L7w0bJLiv
        PRdDu3jHvYr8/EZDt8JQ7AAQntl+y77ti4by6KPmzg==
X-Google-Smtp-Source: AMrXdXt/deeqnzR1Io5f9kfW03V+Vuh4Lk5Dqjvi7MLqBZJrvw9x6eEGf0u2ETJmx1CTV7PlraVgnAy1wUmS0dxi4BU=
X-Received: by 2002:a17:902:a506:b0:189:97e2:ab8b with SMTP id
 s6-20020a170902a50600b0018997e2ab8bmr5227749plq.131.1672948598236; Thu, 05
 Jan 2023 11:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20230105192646.never.154-kees@kernel.org>
In-Reply-To: <20230105192646.never.154-kees@kernel.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 5 Jan 2023 11:56:26 -0800
Message-ID: <CAKH8qBt7kfgYNxyqZFw3Fagfc7sm0r1pKGnwssv369W4_6Zzfg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Replace 0-length arrays with flexible arrays
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 5, 2023 at 11:26 AM Kees Cook <keescook@chromium.org> wrote:
>
> Zero-length arrays are deprecated[1]. Replace struct bpf_array's
> union of 0-length arrays with flexible arrays. (How are the
> sizes of these arrays verified?) Detected with GCC 13, using

Haven't looked closely, but these arrays should be produced somewhere
around kernel/bpf/arraymap.c (fd_array).

> -fstrict-flex-arrays=3:
>
> arch/x86/net/bpf_jit_comp.c: In function 'bpf_tail_call_direct_fixup':
> arch/x86/net/bpf_jit_comp.c:606:37: warning: array subscript <unknown> is outside array bounds of 'void *[0]' [-Warray-bounds=]
>   606 |                 target = array->ptrs[poke->tail_call.key];
>       |                          ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/filter.h:9,
>                  from arch/x86/net/bpf_jit_comp.c:9:
> include/linux/bpf.h:1527:23: note: while referencing 'ptrs'
>  1527 |                 void *ptrs[0] __aligned(8);
>       |                       ^~~~
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
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
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  include/linux/bpf.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3de24cfb7a3d..2131000f711e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1523,9 +1523,9 @@ struct bpf_array {
>         u32 index_mask;
>         struct bpf_array_aux *aux;
>         union {
> -               char value[0] __aligned(8);
> -               void *ptrs[0] __aligned(8);
> -               void __percpu *pptrs[0] __aligned(8);
> +               DECLARE_FLEX_ARRAY(char, value) __aligned(8);
> +               DECLARE_FLEX_ARRAY(void *, ptrs) __aligned(8);
> +               DECLARE_FLEX_ARRAY(void __percpu *, pptrs) __aligned(8);
>         };
>  };
>
> --
> 2.34.1
>
