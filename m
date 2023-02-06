Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71031C05027
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Feb 2023 17:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBFRwb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Feb 2023 12:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBFRwa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Feb 2023 12:52:30 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760E811165
        for <linux-hardening@vger.kernel.org>; Mon,  6 Feb 2023 09:52:29 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u9so8690595plf.3
        for <linux-hardening@vger.kernel.org>; Mon, 06 Feb 2023 09:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0zyweaVyiMqk4LHuNuzEqryLINLpiUARVWRIcVZa2lw=;
        b=Jl2YisgLdiqvhpCBOAhNrDu+USOFqPUBAMNQALaN99jC4eqrKpnaVmcdgUI9YgMhb/
         aE/stlsmeWlkXNJCUgbhkxMsUGClClfb5Za1b31fmi9dZq5NiRNcFC+H03SQxvVd9olz
         6zKxlpOrHVApTG9OGfoVYx1cN4JgH1yIzdH2ihtigTJub8FlVQAVQI3Eqpx5BEJmJ62a
         Q13DT/0Jp/lo3RTQISNRzwHFfVUvbugZv01Ym/FHDtp8zIwrNctMRrK33b4DmNrxhwk7
         ckLCC8si+AltsVqaM3L7xo2IK1ms8CzckQpKM7hj7gdPYMDUlJLr+KBfbjCccSVpOsAC
         qLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zyweaVyiMqk4LHuNuzEqryLINLpiUARVWRIcVZa2lw=;
        b=0Y0s9fa9uzdz38AiiSlqthK48J//nTWFykRAz/PyLe+thO0azjxkau3M+8ttLRhBaN
         opMBi1lTDGlDWKROxweIcmsUbuGwN+xhy9dccdEw2U/wMikE6/B4zgWIAvTASjPw99f1
         +tBX+E6yBM5qxtc3SE8HfIVNVGkLKbAKBGhN+gToF/e9koG+4BxxcWrPmletQ1BbjAdX
         XwKWG/kAH7MIbPMqP4p5qV2bKq7MNS40uL1o2AAaia/Z0Lr5qTe/PzDxdY3KuzFJsdQh
         kDCf1aH3802oubIIgKoJLIDApBg9eslTFDGi9gmrgYWD8xyrxrRJ7f7aqtZUt37/Pnwo
         yD+A==
X-Gm-Message-State: AO0yUKWNmw6g2SmB+VSZoiT1fohPqhNsrc88K1GkRE0eGSJh//xyhvHa
        8K+Jw28MzvOJ3A+/ZO08sI0wulqBdSHp49xU85+wZg==
X-Google-Smtp-Source: AK7set9V9OdoqOHwLvVsBSh6xMOnS76j0J/EJOguL3f2UWTtjvPiP0ISRA9SUhs+FJhcH6k42DfkTHAvGrK64PYZUa8=
X-Received: by 2002:a17:902:c215:b0:199:26b1:17a7 with SMTP id
 21-20020a170902c21500b0019926b117a7mr326393pll.10.1675705948668; Mon, 06 Feb
 2023 09:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20230204183241.never.481-kees@kernel.org>
In-Reply-To: <20230204183241.never.481-kees@kernel.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 6 Feb 2023 09:52:17 -0800
Message-ID: <CAKH8qBvqLeR3Wsbpb-v=EUY=Bw0jCP2OAaBn4tOqGmA1AqBZbA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Feb 4, 2023 at 10:32 AM Kees Cook <keescook@chromium.org> wrote:
>
> Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> flexible array. Found with GCC 13:
>
> ../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
>   207 |                                        *(__be16 *)&key->data[i]);
>       |                                                   ^~~~~~~~~~~~~
> ../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
>   102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>       |                                                      ^
> ../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
>    97 | #define be16_to_cpu __be16_to_cpu
>       |                     ^~~~~~~~~~~~~
> ../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
>   206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
> ^
>       |                            ^~~~~~~~~~~
> In file included from ../include/linux/bpf.h:7:
> ../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
>    82 |         __u8    data[0];        /* Arbitrary size */
>       |                 ^~~~
>
> This includes fixing the selftest which was incorrectly using a
> variable length struct as a header, identified earlier[1]. Avoid this
> by just explicitly including the prefixlen member instead of struct
> bpf_lpm_trie_key.
>
> [1] https://lore.kernel.org/all/202206281009.4332AA33@keescook/
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mykola Lysenko <mykolal@fb.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Haowen Bai <baihaowen@meizu.com>
> Cc: bpf@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/uapi/linux/bpf.h                         | 2 +-
>  tools/testing/selftests/bpf/progs/map_ptr_kern.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ba0f0cfb5e42..5930bc5c7e2c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -79,7 +79,7 @@ struct bpf_insn {
>  /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
>  struct bpf_lpm_trie_key {
>         __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
> -       __u8    data[0];        /* Arbitrary size */
> +       __u8    data[];         /* Arbitrary size */
>  };

That's a UAPI change, can we do it? The safest option is probably just
to remove this field if it's causing any problems (and not do the
map_ptr_kern.c change below).
The usual use-case (at least that's what we do) is to define some new
struct over it:

struct my_key {
  struct bpf_lpm_trie_key prefix;
  int a, b, c;
};

So I really doubt that the 'data' is ever touched by any programs at all..

>
>  struct bpf_cgroup_storage_key {
> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> index db388f593d0a..543012deb349 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -311,7 +311,7 @@ struct lpm_trie {
>  } __attribute__((preserve_access_index));
>
>  struct lpm_key {
> -       struct bpf_lpm_trie_key trie_key;
> +       __u32 prefixlen;
>         __u32 data;
>  };
> --
> 2.34.1
>
