Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754B3AD529
	for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063491; cv=pass; b=Rs6pLNZOSK9WKpe0Teu2hzirpSqFZgaqVDB4Nse6DIHUteZHHWRJSpVdU/lo+MH3xiIdVhFH0mtdZg1Ymc+HadULLm1kosmwH81aes4s362BGibLO6XIk18Z7OLHmGfulo7aJxGCCQTHooZH9mG3BHM2BP+8d9mtC2WYM4y7Qp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063491; c=relaxed/simple;
	bh=/JiSL9KtMYW39gs+t7l5GNFcMSkI1SwWlTIMXx+UrPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsWITzaOuCTItYN4W8z6rZe9bCLHsnbSxeBOXpinzEqMenjDYSqQyh/g93EUoZtzOQ2q0J8FQ+KifbXso+dDFTdqOCj6OxsN4g1ZApSXaA4Ja7iyJ1J/uWVYb3+Qhu0yc/wzCBfiapeZDnaczYtWjdlghYOpl7l+4Vs3voalCoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEskD115; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEskD115"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47de0093c42so11864f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 11:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789063487; cv=none;
        d=google.com; s=arc-20260327;
        b=eWL2XZalYwaKbudEyVzd4CPMAFfd9TUA9fxRPoo0Uu2Fs1HcBLOyWKrz2ZIzOI7d4c
         6LakFphZ+M+9LQXkWS5HhaK9i2QKkUdWY9b96V4wglWmPedxJlwG3VSv9pFhEdKANb2v
         xHrn9SVToFJHG9V82pqaYL9GWrsvFMp2ck3NDxmT122QMrHAvR1jxvp2rl7nLSBNVH5U
         /kO0r7eiH9ua5andKRXJEAF1s1LTJqkCSNO0pE3btupUM8k93i3PdBgDhtkW93uGkmHc
         hvMJP/LUHn2RbsBZIK7SpjhuIgGr32sI8JGJlFsBD8921a/oCBGms6E7bf+2bbpOPXn4
         hFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pmlSkBU7Yx6aRJKzEZrvFOirNAsuneJxXll9dWdAM0g=;
        fh=UKYOq+/J4C8c9eQVvm6651rYa9X4fF75BH/s/R4O3Ew=;
        b=m+hRwxr+/rziQRWnVkSq1oaeQMelJ2e6SCB4nTyo1oP7Jjev8yUsk3Ln16y3E3WRrr
         kEQM80JTjlS5ZwCW/nBlvtBihUBzsRJplDiQZTyAyJUhDK+eIB6KswZRIBuVB/LUwFqI
         nKDWV6j69rK0LEnXzgTfhAY8vdjnP1y9vMUTR/smZPIsCJNQfV5mJna3fbEG7RFfO7Fn
         RVodh0/9fM1TZqNSU2aKKTXBVL630KVHzgxO/Fxt3ZHxj6bOXqTERJ7hahta+42sCNEI
         dGEhloNmtWTPf+OkIYk++NsX1GsSlcY5vsTiYFwtxUnx8dZHkHYBmQEOR5rrwQf8pqtv
         rCpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789063487; x=1789668287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmlSkBU7Yx6aRJKzEZrvFOirNAsuneJxXll9dWdAM0g=;
        b=sEskD115CpRrijD4cFzDelRYsF8YWzl7654MOPwh89cY6gbyQnrSMlfZ8+AKtEU6a0
         yil0X+5Y03DWkpDho47+1NAYo+9/rc5Ntu4BGlZoQvY8681Czq/y3kop9p1YyDoICKUZ
         Bl/BuaEWMVrX0NR9l6hsA07pLxg3p/uiPEdDDl2wqmLdkocKj3cSuATuNlc55zMhRcXf
         Yw4XpXsR/QENFv0L1WtfkrnWaBxCIUkK6+UxPETdSNdHUYunrvWKe8sYpr5ECPlUovvX
         Y4p4bU4kQSYZV/cCZbtjmxVcaudKGD0f5mYvLJEO66Mf2Oe/LztwKisydDQ/AtaAusff
         op9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063487; x=1789668287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmlSkBU7Yx6aRJKzEZrvFOirNAsuneJxXll9dWdAM0g=;
        b=XHkuPufD2UkwfvCvbM/kOaiE9XMekwOUQpvWeRqg1lzNmMcRVpanUGP/2wF6TaVI4g
         sVjtbyWta7jFRF0t0yU26l2msFRdGstRbG4G+FcPr6sb+vfEwLyRrEgolRFlIgW88Lca
         5JL3qqhcar40q9csKeUpeU9cprzFz8wfv2ottVCgd6t9+xVJLzYkB8yYb6509yZVpHRw
         oEJoDdvN1c6d/SZOVBx/OG9TLsyH29seUfO0wc8ZmPXRDVfFPoE1CYkWi4KqfcNHPLaI
         o5IQwwLcgn2egQr8OJ57r94bfmmVj7q21nbNLlJB0O2vhgkmRTtSZnNoS+O4yeknF/LH
         oo5w==
X-Forwarded-Encrypted: i=1; AKwUvBzR7DU64icmRsS/02LOC/C/dJsXlrnYw09GHIj2c0bDhaHQXAxWpBBg+9AtjPkqqo988oHtUQdwKehO6HbhsCM=@vger.kernel.org
X-Gm-Message-State: AFuF++nz1Q3MwexDskz380YKrPu6bGxjKAcIs3pCeTmjrlx8T+PEfHps
	FMZavTy1kxQ94a18nSZIkqEMS001cAqLTKZdJtw4N3l3Kpcmwe/kjZUIhK+cRahELMVPRKEf7jY
	eKM44KYpYjQCAT6mKYIx9bS4JW9UrC1A=
X-Gm-Gg: AYBFou3tvyklrLYUUul9mLETNYGku5Yzfuq5rXaSAv7oQIcu8paWqT9BawkbLVki2pY
	1Lm3IkFiXzdcWLjoVShXYWM1Gg8oo+wMIDCxMTs8JS6QmJa/YHMIxU9Sw4alDH2CG5l/JEwZ+J1
	ezEMf6r8pH1LAUMASbImLVIKtEMwA+Y75t/trsOyWXxrx8kfqOFm+cko7m9J191UF1eTvUJ4Z3t
	I6/EIpz8VMtqQZrcKAF+EiUjh2xakUh6xGd7ZSMjulri4eGcwGmH4z+lQzij+GxkX1Ra7PJF6vs
	tR+SSyloi5bvMOiy7px7fZbodA3OKgQWrkOGgDmLAKAy9hUjT2itsm0DWYNu58YKnEopSyGS0Um
	enanD130FjHFQP+4+Y60F6AFGTEOGgJR+3oo0Sg==
X-Received: by 2002:a5d:6f10:0:b0:485:8c16:5ef8 with SMTP id
 ffacd0b85a97d-486eb3104f1mr167913f8f.50.1789063487446; Thu, 10 Sep 2026
 11:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910022442.3594649-1-xmei5@asu.edu> <20260910022442.3594649-2-xmei5@asu.edu>
In-Reply-To: <20260910022442.3594649-2-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 10 Sep 2026 11:04:35 -0700
X-Gm-Features: AcwNN1UPtHpn5Ju1AbUXHO7M6POxnBVC4rOVn1G8Fc3LCftjvo7b6-mIt_6WkRg
Message-ID: <CAJnrk1b=WoRPqKLEex-WuTVxjjw95Aj77Azwzv=BeR9VTu4PSA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] fuse: return -E2BIG for an oversized SETXATTR over io-uring
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Baokun Li <libaokun@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 7:25=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> fuse_dev_do_read() answers a request that does not fit the server's
> buffer with -EIO, except for FUSE_SETXATTR, which gets -E2BIG since the
> value may legitimately be larger than the buffer and setxattr(2) reports
> that to userspace.
>
> Over io-uring the copy fails with -EIO for every opcode, so the two
> transports report different errnos for the same condition.  Map that
> -EIO to -E2BIG for SETXATTR.
>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev_uring.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index c6dd420c4034..6351f2470e09 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -893,6 +893,8 @@ static int fuse_uring_args_to_ring(struct fuse_req *r=
eq,
>         fuse_copy_finish(&cs);
>         if (err) {
>                 pr_info_ratelimited("%s fuse_copy_args failed\n", __func_=
_);
> +               if (err =3D=3D -EIO && args->opcode =3D=3D FUSE_SETXATTR)

nit: might be worth a comment above saying something like "fuse uring
doesn't use pipe buffers, so an -EIO err can only mean the in-args
didn't fit ent->payload"

Thanks,
Joanne

> +                       err =3D -E2BIG;
>                 return err;
>         }
>
> --
> 2.43.0
>
