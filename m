Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB72DC344
	for <linux-hardening@vger.kernel.org>; Mon,  6 Apr 2026 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775443507; cv=pass; b=J2eISmN59Uow3OE9ccntkClqvE+KvNucoxKAKhe6rUrLC3vmpdPtxfDiM1HFr+PJ+8Iz2FQdC/LDDtQgwDPdMFGYUIwmecBt73TUiqX/WDYB5PLnnIMnIsTYU7VmauosZMwgZwx0Z1131iUIVaUDoGfEJ159vCGhMP6o20tc1M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775443507; c=relaxed/simple;
	bh=Y1f5TSat9qViDqAlLViPj1+ziJfijnBvdOp7c/4J24Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVknyC1peB+PmZkzapmMXDXD9o6jzRoPRxq943n39m9GP8aox/CWkGz9uFSWbc2m+KjX75TleotKr/eeFxKSDpxKO1WtsMotM+jYIBBQgb3IWWoApmKXn1zESKXt3bPPuOykrQk8UMy+xsRLUqyCczIwp5KKAhUZiMg0msVSGsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC2KsSi/; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC2KsSi/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4888375f735so31355535e9.3
        for <linux-hardening@vger.kernel.org>; Sun, 05 Apr 2026 19:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775443502; cv=none;
        d=google.com; s=arc-20240605;
        b=G2YhhHXJuw9sa0413lGnoM38PmptQv/I3XmXOZtvglkhAsQehl8SeIYbdWpMGwNYvR
         A4YwN4RHPEykCZUQnbG+fb1UHXtDEBJBAyC39ds5MTKBVIQzImLOa2w49X3ebDjJa1w8
         nW0BXBz7FlC+gcHOAC2qJZWsC3CeTlDw0YYdcD+EiMMIeKflWtixtG9Ik2Um7+bx2T7S
         660vg7IVbcoby5tBr2IuQSbeiMqIPLJG4oobi6FUnCv08MdpEasIwPIjJ35iUw8PLMBb
         PB2V00y6fU7XvPTFlIXb+IULwaWuwe+BQAIoK8mG+YZ/dKdLvs/SkBf1CC20g5IhtfG+
         81Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F+jIHjIf8Dil6huRx8IzDf657IaMj1INOhDj0G1F7So=;
        fh=iZ5uk/JlONEGlDWUTylpGCsLOPwom6zOBm9tIl8iNb8=;
        b=Ymueeqjko+RG8UG0eakyo9Pc7RcQTHtdf3Lvf7WpcyuCGbi4Irgu0YXxUBzsRkTINX
         NvyKbQXuAXO0Cc41AFcb81+lkBHxibUvingB8g+uCoGDuwkoTzqw5Z2r+fUGr7vQWjK3
         /iD603kyPHd3MSBB6+DGmIfVIPDGF2OUJw1qIVjG+rWyEnGICjCvcia/m34ie/uCKVbE
         /5Xyw3vLhLzLqJ7K05Usi/4n3JKqNJNGjT8YUrdCCHy1P6d1igoss6UowEComG4//P2o
         1r5GnMxZ2nifDlY2TQMatVeBXsMih8bVFBBENsDMCclRzgLUqQB89kcRUMAQ2p90NEwd
         0psQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775443502; x=1776048302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+jIHjIf8Dil6huRx8IzDf657IaMj1INOhDj0G1F7So=;
        b=EC2KsSi/Lj842QihB6lk4/2HK9a7DJKT76DLlSNHcJSWgi2RvWh0vN2lnBAAYBvF5m
         s4XRlKmhnFEKToGjL1ZGfp5YcZzw2LC0PX8BoslSqxD9Ya2rFWVGmyPpqCYs0ky4ZiUD
         h+7cWfMCnu9wO/KzyHM2ahgJkbSWGm3xKiWXUtF6zNTwT82uyxlcNQ3AuhGf4wWgICR+
         Yo+1AQY6OPyIUEwojFVaAoUfDxBkY6W+mtbzuQVulzDVyoWNvwpb3209luuLiiQ3LzPB
         LJhhngTUur4bekAK2wklPWnAnmeoT6f4/BPXCSD++TJKCL0MjH2oSEQDUbiq4PwJ9pK5
         xpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775443502; x=1776048302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+jIHjIf8Dil6huRx8IzDf657IaMj1INOhDj0G1F7So=;
        b=o6zXS380jhrHGKZctvjMuM2ZeJHL9UVxZrCEbA+XV5a7W5XFsMLGlGVu5IgHpK8zxt
         MLM49aUF5iVWVkffFcJNQbpRbNUHdBEyK202QLnx2ybxZXMgnK4o8BXrcJB8q/2TJeZ0
         2+M6OT4ei5CNpcExXQY0vPzktKrfxsyPZtI6uVMfk0saI0CN6HtFK5o2N81b6UhotqyE
         KxP6VdHQ9sotUn+5OSZPBMVEq/QGveXoEaNPz6xyFaM9o4k27DJ+YG71DBz4rP8fFWk/
         NCXD9acgsKQDkgE2Z4R0l73yf6jXBqY+fvNtUkMh5I2JclLvK+JKOrIvJOThoe/GY+2H
         yoIg==
X-Forwarded-Encrypted: i=1; AJvYcCXSTzy+CDXuvoCIVyngTSCb/yUMmrCF+3xqDiOYHxZUdHZYnxbIBQcjBiI3DkR2FZuUJ6AfKxpVwNUEsBcdHOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyirB4CQ3rmhEK1R1m80gdhOdfUPjRDxce4ZP12YUM6LXIET3y6
	LBpCVD/i4o6v0lFFrewBOMHr6rinUwBLJPmyv10YLGAeyYjuVHo7inmlhfAzDofGJI5JdaE42Xi
	LTUhRnuXkjxCfNuOJDgIWOuViRGgmF3A=
X-Gm-Gg: AeBDietx6B6C9b1nDkPDIsnuaVmt7eSade4PF07HjQ6GNUKhd6CuBAO3cJbCUzLObcd
	IrGR86xHDG8xq+fv7CAy+ryWuX2AlvBdIdGohJeIRi5wNd6bq21fVqkbD5PHx+0F0WgtMk6cRW6
	Svf8qyM6tNA42p/MEy8K/Dxi7CrCuyZXdiKBuceKfwn6ChR6+99vLW9C6X64XHxc++Is03XB+PS
	fs3g6Hp3xFA42XOZ3R4I5cVmiX/1A/E38cfPV4YOrMShqkAThzcxzouHct2RyDP6jbOO4zUakT4
	KlA/VwsKbJhJLW60maA9/q8dhhIwGZxoyqDnGTjqBokAhRCw0SR+FFXrNRFzTN92AklKUMec2MI
	Yav1KfCCVtgcThcUub9wSvWnU9w==
X-Received: by 2002:a05:600c:4593:b0:488:7a24:9ddf with SMTP id
 5b1f17b1804b1-488997dfafbmr168712745e9.28.1775443502192; Sun, 05 Apr 2026
 19:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acr7Whmn0br3xeBP@kspp>
In-Reply-To: <acr7Whmn0br3xeBP@kspp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 5 Apr 2026 19:44:51 -0700
X-Gm-Features: AQROBzB8-Pn9Ichq-vOkmEF_VItHpDQnrFoCdbel0YalhiFhbK8zofuiLK6bVPk
Message-ID: <CAADnVQL1kaAZE0L2k6svR4FK8UZvw44WXp=g+Df+SseMkc7xGA@mail.gmail.com>
Subject: Re: [PATCH v2][next] bpf: Avoid thousands of -Wflex-array-members-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:39=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Apparently, struct bpf_empty_prog_array exists entirely to populate a
> single element of "items" in a global variable. "null_prog" is only
> used during the initializer.
>
> None of this is needed; globals will be correctly sized with an array
> initializer of a flexible-array member.
>
> So, remove struct bpf_empty_prog_array and adjust the rest of the code,
> accordingly.
>
> With these changes, fix the following warnings:
>
> 7659 ./include/linux/bpf.h:2369:31: warning: structure containing a flexi=
ble array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Remove struct bpf_empty_prog_array. (Kees)

Kees,

It really bothers me that you ask people to clean up
warnings for the sake of removing warnings.

This has to stop.

This patch adds a ticking time bomb.
See bpf_prog_run_array_cg() and think why it's an exploit
waiting to happen.

Fixing -Wflex-array-member-not-at-end warnings make the kernel more secure.=
..
It's the opposite!
Such crusade against warnings introduces subtle bugs.

Look, this patch was Acked. bpf CI is green.
No failing tests and I was about to apply it,
since it looked correct on the first glance,
but something felt wrong...
'null_prog' was there for a reason.

I so hate this "hardening" cleanups that introduce bugs.

pw-bot: cr
