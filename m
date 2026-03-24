Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92C3890F3
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363860; cv=pass; b=Siwq4ovqk3t/5kSaBvEZ9ati+hkBMsCfyZwhIG69pbVAbj88m221hPutYjhyLcN3KZN+HRZkFWcPT5wRAWS3LcZftRxvC5mcm00OpjJRyB7DBQHwRLqTe1KDR6mpD6eJoxzhHjFhErm7/uPNaDgNA8k5vYAFeuWCrr2EG9T0xmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363860; c=relaxed/simple;
	bh=3n66akwPL5aH75TB6OiseSZhlNEcpu5V8jrnFridO/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuWHV3Ern7hsKc9pYTA8JtMlENp+5YgUF5F4excFc7vVVF7taWAq2ai39da7eWVgtte2n21Xz+DOswkncVzJpwxEhnRjdInyiXlK4dHQq4roItJAgnmLQ/Yxi+cbSzDnDS38evGWmf2bzawQi93oCRBErVeo8nLr4atj1Fn7aww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3D7LOuS; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3D7LOuS"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b7ff8fe92so870148f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 07:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774363858; cv=none;
        d=google.com; s=arc-20240605;
        b=RHGFD3pMLabDJZ30p/mcyQuKagljXamjw4jK3fdrevhfzNwhspwX5ffSABOW0ToywT
         m9QT2AswkzcI/X218/NSqOBw0hjlkuEIsedaOlGaUDdcheHQb4YM+kjB+6Vb8KPXPM+s
         MenQ/qyMICW65M0X48Z3hDm/YUbHndHrKwVvYhR9O/JowgjMBUcuSWtEo+uskrfGIra9
         /jIgR0EexbsvI546vuvvf750zlRFeVSRARXf8CX1XJh6rC5G9rIY6vS5dKu5kTa1vYAn
         dTFow8wKQN9B/4lCmD7j1dsBcFVCep7qp1TtVXaywdlQ7LI6kp5TgRl0YEi//1/ygFmS
         yhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OVDnf3LS1Zy+J4cELDWzZkJKr0472zSbdgFTuK1Jc+I=;
        fh=hTj7xS8o6Xtu+rVgOYQtpFD2bGjFUxhnk7GcvC8V2NU=;
        b=aWTGfGZF/OCYfDIG+fhkPyPEVuHzJ+y2Wy70MctbMt7w4D0nbyo/0Fyb9cCRQgGBmW
         +iKXx2/ki8DmfDsqLu7HjUn5oxOl9wyDrmUXzqxTe3Vpinn75RdoluAnqODwir8T2RRZ
         y6Hr39z6AUxMH2bvWmhZ8CmapGgvkra1QVeyy/i3bpM4Cb6RyvsfikGjNPgvLGh9EvDX
         sI9q/fMSQ3BUE9r3dT9daDYtcWNmTsCOfLsIafUJSmsDL4MbRfU+pSOW2kYx90d8XdUj
         womPPFYrauLNJiCqf3CGTI0SCPhYOewMXotBUwPqbZaxJtiHCS9annquz54AhgzWTM19
         uOsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774363858; x=1774968658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVDnf3LS1Zy+J4cELDWzZkJKr0472zSbdgFTuK1Jc+I=;
        b=f3D7LOuSKSy/VLEGL33L2EmOjyTUGx4WEXmVEyf16nFhWUIi/PGwJKBKHLtCNjCDRH
         lBvH5bdjjWxKhn1iUCLnzS2ihSuw/oF9m83gStwk5B9hyaOm46pwabNo7SuICLF2xPUc
         +SOH48A+dodvp7CuDviU71KW1mfRpF5861gvQ3IYPje/ntpJBRg6N5h2GGCLM2wrj/vV
         +GezvMSCNSLoBc/EKL+B/oWlAxlp3rHUMkRyqd8bFlgp/azohQL1CYhZjWXE1NfRzaGM
         MnG6z8NHMOGagKHmvP35GRc3ATRKMyXZn9jaXSIpaaqVZpB+JYQL2CDbEm/PU9OAm6Uf
         sWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363858; x=1774968658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OVDnf3LS1Zy+J4cELDWzZkJKr0472zSbdgFTuK1Jc+I=;
        b=jyrs5vnHlEe2Tos0AwKFdhqs8DfDqQveWcIUhXPEH/FI54TWLa0vYfmcKylaOHwOWs
         yQ/XJ0wrRZpHhv76Iu07dB5p4PyUuuQzWZV6bp2KbPIjMOoyshqIIYMDvy1iOLchOflz
         HX33cyavBYpetVZ0p/9muT+rlUnYyeLbepJtgroTtSUPBY4CgVUyXRzYCe8/T3Fd+5hN
         TEJLMzuYi1s4TgNmqvR3nuukj6p1Mx5aWac958KvfomwuRjJH15Bo0FdGMRWwG8UbedQ
         K9daiGFE0cxj5F+lzAFpS7UbZw+YoU0FZioOlgv30d2NMloB7XgMTCg5MAusQAiio53S
         /z3w==
X-Forwarded-Encrypted: i=1; AJvYcCVs4CMfBbrRfbGs7zXz6sO5Eqnxo4HFil5+91DxqFA9VPJZkczNFPiq7WiAzOR0ErnNchg6u4UFUqjE3RPN3LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjOjbFA8NIKANMefuvpaGBTeSvTIgns+xGrfWtjBVzMMmtc85y
	h8bqLuacGPAqaiA7v92w5B/ZrPfg16EuISpNXDKBMW2c1OfjDSiaSh/9p3/ObffZLh8CdbFLUfJ
	e0kmEdsCPN3kWr9tDfl5oVPY2FdY7jlk=
X-Gm-Gg: ATEYQzzUgy3ptG+SPx1TXFyyRBTykrPey9YPVPFxYRHoRNH9Bw2BDcR3bekBzDNM0ie
	sKl0qShn0nxWEnkhc/4O1upKg7fmb3XMtSKBtZxJ95PIwv2lkkynWVpHgnLVRbHV3MMjB0rs3aS
	gOzRsy9kikanlwNc6T6EXGx1kaPVG2/iWlTcaJlfXs3H6AluvKrDsZssE0o6XoIJ1cVsqs4o84B
	36mWjghSbFaw02RjQlh87P1qWa0Gg1eFMcZYXmt8YLLato1y512frsXE9Naj9RMbFbDiQB3eck4
	rSoZVRO65h9pXNrk6HKl9jiPM9zapvz6GkHnjlo5xb47/7ioHh5MygXehudXyYSsFj/9VCQItGF
	JcwrfqeTES1vz4zf52q8W5OJjQXj/WRkYlAib
X-Received: by 2002:a5d:5450:0:b0:43b:8023:8b2 with SMTP id
 ffacd0b85a97d-43b80232811mr4547485f8f.45.1774363857554; Tue, 24 Mar 2026
 07:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324053036.it.906-kees@kernel.org>
In-Reply-To: <20260324053036.it.906-kees@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 07:50:44 -0700
X-Gm-Features: AQROBzBrEbGkOPmrzb0Te4EzLdynK4wKlfwGXuHnnrrTxceVeo39F1XZrtWmaho
Message-ID: <CAADnVQ+XmbLJ2LCeBjun463V3CJriXsSiTrCTS55aikx06RNgg@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:30=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Replace the deprecated[1] strncpy() with strnlen() on the source
> followed by memcpy(). Normally strscpy() would be used in this case,
> but skel_internal.h is shared between kernel and userspace tools, and
> strscpy() is not available in the userspace build context.
>
> The source map_name is a NUL-terminated C string (the only caller
> passes a 12 character string literal). The destination attr.map_name is
> char[BPF_OBJ_NAME_LEN] (16 bytes) in union bpf_attr, passed to the bpf()
> syscall. The kernel's bpf_obj_name_cpy() requires a NUL terminator within
> the 16-byte field, rejecting names that use all 16 bytes. Valid names
> are therefore at most 15 characters.
>
> The attr is pre-zeroed with memset() at the top of the function,
> so the byte at position 15 is always NUL. The copy is bounded to
> sizeof(attr.map_name) - 1 (15 bytes) to guarantee NUL-termination is
> preserved. This is safe because the kernel would reject a 16-byte
> unterminated name anyway, and the only in-tree caller passes
> "__loader.map" (12 characters).
>
> While the original strncpy() would have copied a full 16 bytes from an
> overlong name (producing an unterminated field that the syscall rejects),
> but this shouldn't be a reachable state. Forcing truncation to 15 bytes,
> however, seemed to induce a (unrelated?) BPF selftest failure:
> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/683004=
40546
>
> Allow the literal to exceed 15 characters and exactly reproduce the
> original strncpy() behavior (potentially lacking a NUL termination).
>
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v2: don't force truncation
>  v1: https://lore.kernel.org/lkml/20260324040535.work.851-kees@kernel.org=
/
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  tools/lib/bpf/skel_internal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.=
h
> index 6a8f5c7a02eb..8702d6612978 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -243,7 +243,8 @@ static inline int skel_map_create(enum bpf_map_type m=
ap_type,
>         attr.excl_prog_hash =3D (unsigned long) excl_prog_hash;
>         attr.excl_prog_hash_size =3D excl_prog_hash_sz;
>
> -       strncpy(attr.map_name, map_name, sizeof(attr.map_name));
> +       memcpy(attr.map_name, map_name,
> +              strnlen(map_name, sizeof(attr.map_name)));

wont-fix.

pw-bot: cr
