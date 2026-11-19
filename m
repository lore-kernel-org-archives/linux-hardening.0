Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795127440;
	b=ThmD2vQsd4yp7zMPNbuLBwPyM9zcAq+F9XZtv+ggJdvRiz9EOkck43dcgJ+moT/xd6C4
	 COkqEn9BNgjL1d5IGaKM0BWwFo6vdBad/qMGJHeaxzArm6k9a+3jrjMfgfGQ5rAa/fcZN
	 nkwVYLCxILjC0NUMmGwWX0dJZnvZk+cKb6xmDQ9FTS67U4vc6ACjsveOU0eDpLE5Dre1G
	 FWGPUx/cWFPapNudEUoXnUuEuY2HXuhTa0omIXim2iNXj1VXU25s2G3t7QSyaPl+bCUWP
	 Ca2MOKKRN2/jl039HNHQJVVlPoxjbIGU0hNEGQLqwI+6tH/oi5vf45QU+jp7I4JT+Vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=I2d2DmRRVx5LZro47jpLhN3VDh+vWYS8zmDUFy6y03o=;
	b=C8VGsJH068YZaMWrGpPxY3kjPxFQAevljsLQYeF1ny2b3FSWrGN1sqCSc2C7z0KHBHiE
	 bFIirb7PrUeCy+DwsYsIsbBfK/S4Ji44reClhfIUIi6H7YX2A3ugavj68QYdhm5HioRS5
	 dTimLk87MRBIGFY/7yNhlFJSz+rO/RAmON2GbS/Yh1N6Jf8Tv7CvZha032QidDcLCB59P
	 HNxMGmi7Gv+SYnEWKO7dfOs2Ncm5fDHMIhO2acX9Ww1sPFP6J+yIX6851g0qdwobKJ7jm
	 CJtmje2prRYLEjebJoFVqs8OqCsytax80VAX20RrNYnyNFQ9uPcWFIJJ2izjBZ5O5NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BQ4xrwA1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855E606A326
	for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 22:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E855E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BQ4xrwA1
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso187723f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 14:30:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795127438; cv=none;
        d=google.com; s=arc-20260327;
        b=PjvqE/U+3b+EpVpMgLSBu7lKwusj3rKiowgin6hF9+ZKzyGHiPLCk1tUQH8JfT8HM3
         zb4pPSZzT7k9ogUoethkUykjhWPqpfkB1kynme91AHEhswz5SZj/yRcVVX8aSqXYAjRE
         4b5Gr++db3V11hy+ipxQ/+gSIu4UMyP8zCU2r9iY4UKyS0NZ9I8yFMoCCNzjYPn+Jxvl
         YK7SV2NX4Jj5DiVxMm2QX18qRZbfAdzI5MvhhC9qTKEnsXcv7fhncMw4yZXOVYOaEPgL
         1lOzO94gS/SP7MgJxknB/x4X+kY2r4LPCqvTr47JRSKa6RFQdV3FyDbt49rEzMWUt7Wc
         +mEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2d2DmRRVx5LZro47jpLhN3VDh+vWYS8zmDUFy6y03o=;
        fh=XjdIWycrJhgAoJcHdmIY7BmPPZQkut2/jCnOaY8k2C4=;
        b=n7XikYsbEFFjXlg6SzAITwV8ChBNGogG5Ojwpd3nzcDl/DzTCDUfchNqZp2/gHGOBv
         FwKfPD+Lchhb6xRRsZib1Gcz0TrQobmD2bC5cCFSpS8clXGztBTF3ZpwzZfGuhL9z2wb
         gl+miXtDoE9+cM7Sdv1QpJusPUelxSetaPazJ1tqULCMosAUex+vdwP2EsSrE/IIjk9i
         EUH2e9yQtqIhQgrQydaKlMKMvUnKYk+7GRs5VmNcmgt57DkyVx4udWqYkrxyNWjsg13n
         AQ4xgCq5oQmrZnm+LY2XsAqcQ2ni7Ce9ju49LPlzdUAaDALyLIWZjlgSn4m9EteFTA6/
         vZEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795127438; x=1795732238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I2d2DmRRVx5LZro47jpLhN3VDh+vWYS8zmDUFy6y03o=;
        b=BQ4xrwA1vRMLoekmeBRKLeZyKiWCOU9K5XDKaYDdXazTvJlfQ5jUIF9VFw3YnG5IbP
         KHMmM63D1zcPo+4XmSAC9cYuEjnCho8Kfvxgid+MMSIJZ2PQRPaRRb+S5BIctkU8F/4q
         cg1zSLSEbZdPrDHojmxg0BGOM5pC7MQ7rzRZHnu+JxQRbRfu0R7LupMmLoJmcJ8xF/72
         wq8X77MVHGjw8TKwglsYuGYAxkZv1KQ6cPts1lCKJSOABMqPzCYP6edFR6zr+C9b4MQi
         bP83bNH2HplFz3Ex1RnOR5uSQsk7qVShVEuMPO35YThv23LbAmDnkCC9otx3Olckkafl
         12IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795127438; x=1795732238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I2d2DmRRVx5LZro47jpLhN3VDh+vWYS8zmDUFy6y03o=;
        b=LjFroR6oiJZsCq75mEvVD0IMN1wayulYBqD8CTCgrao9hzW3koiR7P83qCKWDF4szf
         NSsWmB5zgGLweky1LEvtU3LOHm0ARE8p9C0LbomDlY2mQsacfgX6J5Be9rP6s4ufmitX
         92KT0TlJOWQdGH2Npt7PRlfQUvSmr9gLmmXvzsfEk2Flr49BdKofTjvmbJwMDtiaIEMF
         MKIgy9My00OVclYmNmWLBu9w+ayf3W3z49Lm8NuSwH/5bdFR5Jdhvzop5I0McB6n3Wzg
         E8ySpb8uuWwGYWZZepZ/qrrnapazwbsCv2KI72EPYmtAkUc92rRQDz9WxF26HNyceiLE
         EV3w==
X-Forwarded-Encrypted: i=1; AL+hErFaVejFbDbDxnDCDxtbC6xbEwRc+kM1vJW/vVRnuYLx82OSq6GXi1IHBCqwC12fIfgBt1ga+qoImBCdcSrnzPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UEbUd7B6boD+H6LmbR7uxQhirOKzfL4XMVjvNw9LVA37JZE6b
	bzvsfbC0VvqIqx2FUQXZkQbY98k7vu9sZhHPmVZYjLlCgQQAabOgUzwLpS0BqOLn0vCw4i5dejN
	r2jFJmge8wo6n7wxQEnkdBcEaHkgQw1+wJrHS3/1q
X-Gm-Gg: AZFdTZej0rkWSJZH5xlLe9cFpcMWVB3klgIyc1caf0LQ//C3seL+eiLkTDp0udufmYb
	eLs1dE/rcoPXT6zgsk3VASd+XHQFgk+Pusq5Tm7PM8jjnHdqIoQWN8ogc2GzTt0bfBkpPPaTvnE
	wN3sTB6dO49EclqgFUezfAgxF32pxEZJqScE+2WNscrjkgyKXY8+Urahmd6BcUUBW2JaAQXroVM
	mGxBjV8h2jU3IUIOk1Xs6I362wob8WX7Y5nY8rqyLrIeOoj3PjzdIyoeVlgCXMsE5ACetcAYSYh
	VbcPLgLvzxZZM5wOgvI+pRk7RscpikhV21OHC6WFhNTNUWH7QjHBYXvK61eU2c2PDE3LdjKpYbG
	I1N9lG2joLbaE4T7NAci/Rs6BN1Cm/a1nnukBbbGkyP679QoJDazVh7a4GXDxosslMMSdl9Zkx/
	a4XFnEqNk+lJ6MKfBEFeXXiX7KjpdKKwDhw+4k6C1Qb9SV3mIq7MJHctfx1CrmirYd4KHGegNTy
	T/9fhIApbQv35C0yxWdPMLUCoAol82u8T2+
X-Received: by 2002:a5d:5f42:0:b0:4a3:8b21:51c1 with SMTP id
 ffacd0b85a97d-4abb9de7e00mr1547177f8f.53.1795127437643; Thu, 19 Nov 2026
 14:30:37 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119213147.1094488-1-usama.arif@linux.dev> <20261119213147.1094488-2-usama.arif@linux.dev>
In-Reply-To: <20261119213147.1094488-2-usama.arif@linux.dev>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 19 Nov 2026 14:30:25 -0800
X-Gm-Features: Aa3M54rH-aa26JdIN-pUYW-8cMRdCYq4lpDC8en2IEgeQrnp1pYq2y4nekWn-HI
Message-ID: <CAKwvOdmCuYrdHX1ACVyC3BBo7V5vQ9HiqSx=+vVCYQ=9d17Kdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot/startup: Disable kernel stack depth tracking
To: Usama Arif <usama.arif@linux.dev>, Kees Cook <kees@kernel.org>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	gustavoars@kernel.org, ardb@kernel.org, hca@linux.ibm.com, nathan@kernel.org, 
	morbo@google.com, justinstitt@google.com, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, rkeilty@meta.com, 
	atish.patra@linux.dev, dgreid@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 1:31=E2=80=AFPM Usama Arif <usama.arif@linux.dev> w=
rote:
>
> Commit 57fbad15c2ee ("stackleak: Rename STACKLEAK to KSTACK_ERASE")
> renamed DISABLE_STACKLEAK_PLUGIN to DISABLE_KSTACK_ERASE everywhere
> except in arch/x86/boot/startup/Makefile. The old name now expands to
> nothing, so the startup code is built with stack depth tracking enabled.
>
> The startup code is linked with every symbol prefixed by __pi_, so that
> it cannot call into the rest of the kernel by accident. It has no alias
> for the tracking callback, and tracking stack depth there is of no use.
>
> At the default KSTACK_ERASE_TRACK_MIN_SIZE of 100 no startup function is
> large enough to be tracked, so this went unnoticed. With Clang,
> CONFIG_AMD_MEM_ENCRYPT=3Dy and a minimum below about 90 bytes,
> pvalidate_4k_page(), snp_cpuid() and do_vc_no_ghcb() get a call to
> __sanitizer_cov_stack_depth() and vmlinux fails to link:
>
>   ld.lld: error: undefined symbol: __pi___sanitizer_cov_stack_depth
>
> Use DISABLE_KSTACK_ERASE, which disables tracking with either compiler.
>
> Fixes: 57fbad15c2ee ("stackleak: Rename STACKLEAK to KSTACK_ERASE")

tsk tsk, Kees your `grep` might be borked!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  arch/x86/boot/startup/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makef=
ile
> index 5e499cfb29b5c0..0815105e7205c7 100644
> --- a/arch/x86/boot/startup/Makefile
> +++ b/arch/x86/boot/startup/Makefile
> @@ -3,7 +3,7 @@
>  KBUILD_AFLAGS          +=3D -D__DISABLE_EXPORTS
>  KBUILD_CFLAGS          +=3D -D__DISABLE_EXPORTS -mcmodel=3Dsmall -fPIC \
>                            -Os -DDISABLE_BRANCH_PROFILING \
> -                          $(DISABLE_STACKLEAK_PLUGIN) \
> +                          $(DISABLE_KSTACK_ERASE) \
>                            $(DISABLE_LATENT_ENTROPY_PLUGIN) \
>                            -fno-stack-protector -D__NO_FORTIFY \
>                            -fno-jump-tables \
> --
> 2.53.1-Meta
>


--=20
Thanks,
~Nick Desaulniers
