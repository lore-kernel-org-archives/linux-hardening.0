Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F21386C09
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369930; cv=pass; b=g+iEhpuJ96jBfUw5O3ZubvHZP0a4HmalbfNYK4lrUpDf/SWGxCuoj92wSG0QtEKL+FESThZ/FyrauxsC9LFB7hV3o2inCygKXeE51YpptGhkecsqvOxJSzf7GlgKP3+lfxYygw94p61bi7KgggDdBY2dFM164/T9a98tust9d8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369930; c=relaxed/simple;
	bh=5ZUIycxrMKAOlvF8lXrqSJU3zKFIkqviMI18K5Zwmxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPA8DorlaNTPtIBCI5cXbeZKy46mJ6LLkDMfxaEf7A/XgV7JAAx9VSBaxSs9nEvhgfoDZYznbWalSMgLWxLTbGNW7R6m1tnb0gvuHPTMYWfn7Dcr2dgeGOntUvNcYMNi5UHtTMaTUixLlXBYpMVAnAadDPtMPGJOOfYjsDiPeqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSpCJFDp; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSpCJFDp"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so3051536a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 09:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774369926; cv=none;
        d=google.com; s=arc-20240605;
        b=V0nIXa+1Mc7KVmWzu3fTxf+xKN9toqR+YV+OJ7cDGFh6bkGiSGgjaTzDh8kCkti2pV
         LQwWg0PKx2AUK3I0oCOvzhz8ztr6Vfu4vMs9yBnJYsmB5IhddmK3yadAnCfv96HHyW1F
         CfIArsPCZTyXK18cqqeOVRRFCMFsDFXgvWDsDGIu6cgJFDXUBFHK5pnsmJbeeFTog8Tr
         G6U1dkschypqE1vWoOGbGSCYGnUtujgxWXy0hEr6Wlj5do5QGJ0/aDwdParIjrN6kwkC
         a2OH2zUJoNk8s1mkOKKBJBuMj2xrBOzOn/DjEFo9w1f4eC44jKnvqhYU1RwlUXltRpJh
         /RJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q/YQinh1RXyENEr5bN/5LCEqxUgVxBoV2ucPL3SO/bg=;
        fh=8RbrLFRg5HKNutYp6ozmZ8uKAno+9QtQyk+KQZDmmyU=;
        b=Sm2qiiJEfjSLHTrgAqeLKR1OkL4/HCFwavbF4QCv8y7OxbzizkzOSaydqO7SxrSQ9n
         y0+sovpWtpMa91RpwFRMIaud3QoZ1hlXu01u71khbIWpcJN29Dw3cu0/29zj9sPOq5uj
         LBkKa1IUnBNg0d5rabUs/jgZ1xM7XXz1QgdXy0wdiYZxdPfUxyZdpTPD/WsqW9MYaaCV
         LYFKtZ6njwQU1Xu2jZZYlbIhvAQ4Jk2/rsrEYJZNgxgNY8XDpymJvu32lVhW8Mg6C8Zb
         wayTDzmgLCw2yY7RMgWVc0V0e7XjL8WRLFcXFGwP4VUWZyhz1t0+MRe46vlIMEMdsWus
         nxVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774369926; x=1774974726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/YQinh1RXyENEr5bN/5LCEqxUgVxBoV2ucPL3SO/bg=;
        b=kSpCJFDpXzc6RPQceX1WsDKfa1TfwvU0fU5i1OosR52+n4UdJtk5i7zv8Sfv2M1vFF
         EPZtx9uhTb9J20fTaahmWrBalrZboxAr+CdRkLnAgVgpBRR26kG53cyNz9CIto+n3B5q
         yTZycibKgQHYu0e4/yHsxvPRzM39rojiX2emwJk999oz65zvpvTd6OWUcMgZiKKEOLHT
         /pgrBI7kjbgi6zN+6LZtoeJI356Hw2J6tKZw6xkWwVNX86T4yvVlPl0dA3D1LwOlc+IU
         ZtCI0XYUvhjbsHvCVGRv/mh+TGvZCjk2Pmtcpd5EMntcV/0CE3/80zTjPJYOn5jxCog6
         Fafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369926; x=1774974726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q/YQinh1RXyENEr5bN/5LCEqxUgVxBoV2ucPL3SO/bg=;
        b=oW3BvQZeSyRLWfv9X42wqMKaquTq0fCvBov/EPUfvJxA4KWXAAZC75ssGWmpL1yOl7
         bf2WZbuL3GGj+uScFIZTk2wRgPR2PCnm9DcS9CNDmdSn/4AzVvli7T2oh8CpyBgRUtmO
         Xcoh1IKedfuXhCwDDFPBV4ltWdSOcWGH/SZQCqUNtk1059gaq22YkeiBzpwcZ3Ac0Xq0
         9WAAuvPW8bYHrxg0YMX2SUjc80Gj1MdYHFVsl1kSGxpkoJ6aLG5sH2FuS0p7m4HpLKLa
         TvS5MWFncNC15z0dQTMIR7AsQpqhrCXS1ZznLbWh4O3H36gnxwCf4r+MUGz3vehdhH8I
         vHnA==
X-Forwarded-Encrypted: i=1; AJvYcCXDK2maBh3E1cRylWj6u+VvvKS3WjFH0c7nUeRA0i0Sqwhck00afaOSVRqksadV9PHKMP8fXN4MBIYq+S0IzPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2/ywx8bYRLx9CACFCLt3g3N3jXBp/zRZ54loeQmtj12069GZ
	8pIZ9CKIL9Vbe7r+D+0P1Bp8VQsHFdEGtsceK7Nq2YRW5opF94H3ldU6jmpU11sBab8MQFVnWHS
	IZ6EB0crcY6N3we6LxIj0M6ynu5bJg3A=
X-Gm-Gg: ATEYQzwPYLgC14nPPi+pWgHwYfWd1862En9iwg2T2xRIoruA251B6lDQEy6UnB3anDO
	X6M/7Lx7DZ2sZIepXb+Q6DJgBThYNNttGLlsEoF7wrOWfjx/mhUypKfqffrU3I4vKAHmsGB2StF
	hmYQuuutaHjeDzkG7yQPkKtUSlEXEIyeUh+F+GlCmRV8XaqfcSZprBU6CGoNE2W/rfiTHGyZqg3
	QQILQW31Ksjh4j7mir6RLnpp24TxWsX+IzWs281J829+4I68pqQzZxGTuYHzwZuCnUXkpPIN/1v
	0EdvJYwX5e645JYsor53yIO1R8pgFuWxpx7XvM2WysLQBBdpO9o6P8qZxeFLNcOz1yEPYTBTb1r
	b6uotgNnOZisGB+AFwCsRWNvijg0yFzhzAdWB
X-Received: by 2002:a17:907:c15:b0:b97:ce8f:b9db with SMTP id
 a640c23a62f3a-b9a3f16ffe9mr5582166b.10.1774369926021; Tue, 24 Mar 2026
 09:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324161605.make.168-kees@kernel.org>
In-Reply-To: <20260324161605.make.168-kees@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 09:31:54 -0700
X-Gm-Features: AaiRm51a6uDGyTaXvEuCLyNLx57Mveqr_0gcySl4Ob9761Ht2CtD87CQ1CT8XDA
Message-ID: <CAADnVQJC8-GREm1FR4Aoj6KsTepFCxK-0O+ZKyxx6--zj4XiQA@mail.gmail.com>
Subject: Re: [PATCH v3] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, sun jian <sun.jian.kdev@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:16=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Replace the deprecated[1] strncpy() with strnlen() on the source
> followed by memcpy(). Normally strscpy() would be used in this case,
> but skel_internal.h is shared between kernel and userspace tools, and
> strscpy() is not available in the userspace build context.
>
> The source map_name is a NUL-terminated C string (the only caller
> passes the "__loader.map" 12 character string literal). The destination
> attr.map_name is char[BPF_OBJ_NAME_LEN] (16 bytes) in union bpf_attr,
> ultimately passed to the bpf() syscall.
>
> The bpf(BPF_MAP_CREATE) syscall, through bpf_obj_name_cpy(), requires a
> NUL terminator within this 16-byte array, rejecting names that use all 16
> bytes. Valid names are therefore at most 15 characters, but this wasn't
> being checked via the skel_map_create() path. Add a matching check and
> refuse 16+ character strings early, as they would be refused later by
> bpf_obj_name_cpy().
>
> The attr is pre-zeroed with memset() at the top of the function, so
> the last byte of attr.map_name is always NUL, meaning the memcpy()
> of just the non-NUL characters from the source will always produce a
> NUL-terminated destination string.
>
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v3: instead of truncation, refuse the long length (test appears to have =
been a flake)
>  v2: https://lore.kernel.org/lkml/20260324053036.it.906-kees@kernel.org/
>  v1: https://lore.kernel.org/lkml/20260324040535.work.851-kees@kernel.org=
/
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: sun jian <sun.jian.kdev@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hao Luo <haoluo@google.com>
> Cc: <bpf@vger.kernel.org>
> ---
>  tools/lib/bpf/skel_internal.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.=
h
> index 6a8f5c7a02eb..2d38c387f43c 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -236,6 +236,7 @@ static inline int skel_map_create(enum bpf_map_type m=
ap_type,
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, excl_prog_ha=
sh_size);
>         union bpf_attr attr;
> +       size_t map_name_len;
>
>         memset(&attr, 0, attr_sz);
>
> @@ -243,7 +244,12 @@ static inline int skel_map_create(enum bpf_map_type =
map_type,
>         attr.excl_prog_hash =3D (unsigned long) excl_prog_hash;
>         attr.excl_prog_hash_size =3D excl_prog_hash_sz;
>
> -       strncpy(attr.map_name, map_name, sizeof(attr.map_name));
> +       /* attr.map_name must be NUL-terminated, like bpf_obj_name_cpy() =
*/
> +       map_name_len =3D strnlen(map_name, sizeof(attr.map_name));
> +       if (map_name_len =3D=3D sizeof(attr.map_name))
> +               return -EINVAL;
> +       memcpy(attr.map_name, map_name, map_name_len);

and now you keep spamming without waiting for replies.
nack.

pw-bot: cr
