Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495E1412C0F
	for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2026 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973781; cv=pass; b=SRfatzxzLygOfEVcDsq3YTCsE6elDVVvdk2s7Yif5RAX9JfLjpmNaDp4DoJG/FAcuAG3eVDroMCibkTQV+p4sgOhkcii5c+jeaWzsMIAIF2vbdSKQRgmyAq+dwvcX6TQjxmer2tzoTYeQOBse0trCMehokwMuL8/7vVNCUzxfAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973781; c=relaxed/simple;
	bh=O0oErUdvCGd0lNeKXzKbX7E7eK5xVZTCX98mTa3dJ6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyKUnpuPXLNE80+/OFRtcRpYuhwylYuo16bonQgHJQdhOWork6vQ+5iFEBNZk1OuXREOVFMu27LG8TfvnzTaQNLjtIlQ94RG7GpO1e3x8NIr6dyaSK3qtc6TqtXluWYIzd+BKssfma5jsiRxUGfdjQ1GZKN+GOetF1cEeXxxkKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2FArZdd; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2FArZdd"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a0280d4f56so1712595e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 13:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790973777; cv=none;
        d=google.com; s=arc-20260327;
        b=XJJpEs2ULKklf6jFW1pMRs1DEFI7hRdjlS8cyRFBUX8Kgy6/F4wviqWf1DmYB072gN
         21pL6NBKkGXLnJBvLpw3nL+maq6e1ekIMii7RsaMTPICk6kTwLuyIL6CXsBwr86EUtH4
         a7zS5zb7s4KOH94JJseLpSFg2N6bgl/0S4gJUw9dbsicyyRzZx5mSWkjaT/a2wGTdANd
         K7FtRWYPD3JgyPKoZ85fGKizyPcm351eRZrdABqoagYv8kX3V/x8vcjJYu25ygNfRa3U
         AEHN4Bx4K+m2jplQwH2R1Ok8gQGrDOhfno0U3cqHpfxalyikfWAJBusVtP17zphaDmUe
         6ftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2B52yACNSq43ABlpVzKEc+uObRnusBAROE8TzluhGEQ=;
        fh=BDTR0+TztlPaFesEuUVg6PLcCcoZpeXo7PtlxwWsbjY=;
        b=ovV74xLnCzSVUdiZOyFRmgrOfUOkVunhivH3i2LK6QWr6Fgj2naH0wa/rvUfwQHq6c
         qf19hcYCh1WJSTQXxUWA+vL1Ydd8oDba2KOULUcpyE2g8tEi708eysNGjz+7vwqcVvIA
         bxA9oxGxL90WzVoPwF+7WezisNaL763jGealqGJCWotiUjHbsNEKQNeXVM+li8WMwKKP
         uMG0lw8dIkNdRxQ1X3yZ4Oje1I1SsJcHdkHlfS6CUCKIvcaA1ROyq0pLwXtuUl6/G3JY
         UJvrwlJpDpUdwPRN7Y1PG6LENqTP5bWDxEmoU6lGpGBigcPw2MgtcU73vgsZGmUHsekt
         xTXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790973777; x=1791578577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2B52yACNSq43ABlpVzKEc+uObRnusBAROE8TzluhGEQ=;
        b=d2FArZddCvzzX4kGFZD/GcsWkEm07K7qUaqAHzs+JQ10c03/DY8JrDKmqEl2fDAm80
         z4oetGdhgfPtqX2Stf6uHwFmPns7GrbyueX6EsLB776UJA8Qe5yuzuD1tNqXjzvbN078
         QrTH0k6apZxgd7FYmnS9sZiF1Z7MN9Hfkn2KdewBCUv6VSn/8Ci4Wadvd2nhSRlGQdK3
         zuQmg8BYUdnNkeD82XjrE7tGoQqVBrted1FgefCdh+9kdZTfu3be2bWn1ajYFznwtEjy
         40teb/pvgeLJn9lxQ+wr8qKnEEX0xZeIT0oWmWUOo8oXCPPrzoD7jB1AxJt2ZSi7Zz58
         a1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790973777; x=1791578577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2B52yACNSq43ABlpVzKEc+uObRnusBAROE8TzluhGEQ=;
        b=afSc0c5wEdtzNH0qnym33uzxjRgd3GiWf43MWWrUzsh2XBqo2DwcS/90DSupD/Wa93
         Y8C+MssGei8FLI3/p0XRJUZSZR46cxDq3X+tb+gfDYXTU73rxSaaSvU52rtPrbfLskz5
         ZN5v7gaG/XE5fekiv2kA7ZqbC+2JMiRqmkwiOWVCT+FD8y0/oskva2B41qo2DMubJSMQ
         01Yji30GcOYziHZExzKvSNeIiMHVH9s1qyZbDvaLrtWMXt1QBg0tLbJP1/meD2w+KoOq
         Bynw/e+J+fVyiCItXpWvt2vSwyLu83N8+Lm9ExYrrLIrUZA493imTtczWxbnVzQYJ2/k
         dlbg==
X-Forwarded-Encrypted: i=1; AKwUvBwZF6UzlvpVJ2fPNQVLL+ELKNwsSWA2Tq0CXEf1lcXt+A8mnkXpnk/ZlYVTqcHKULCLoEUcwiyUmQpSMDj08+A=@vger.kernel.org
X-Gm-Message-State: AFuF++m8BlT737vpJqHf0KHpkjezGdK/eQmLtoRT2syXkVgriHhLvUgN
	9Du2K29MFyUWK90ZFD4VOt3HImGhxX240217l+ZOah5mZ7ndp28fnzoziJAuIoKQQ2dh8E8YtPG
	OqLLsgXPtg54dtNa8Fr9fDT0THXOsIX08eF8+jde8
X-Gm-Gg: AYBFou0Jf9MaJftGWiW2Bq5gDu//z0XJk/5Lks8b1XhibH4dG/H8VsnCM7WGQZ3Snpe
	XOYE4QcMaK20ikkecPfJWKYnMscsr56nY2H11f93V7mxqjz8QXo7cTDjYLsZFK/tb0emCLmOAMo
	Sydzfoz3izjVAdMIcKBcxl25spkp362TPaZ477sRagsWCPOC6haSfOJJQKGEh38LmkWCR6Fjy4f
	+l3mSRzYQo9Ia8mnGkoj6wvraG4bjI6JkgT/Q2cbyTUoxrWNJZpNHFIDvroZAeZ39Sc1ZlQtJAp
	bBBdybEDbPeXI2wgEn3fP0erjq/7YOJG8i//2ELJUaSGVOwFhWC+G0iTzZ+brWLSOyS9Xf4prBy
	S8ll5p4ptqsZ82rlXPMAhHNIJFG/IRFNvh6WRgdm+FprV9hRm7CE3MlqQ/NFpS8dFIYNZ4g==
X-Received: by 2002:a05:600c:a011:b0:49f:ce78:356f with SMTP id
 5b1f17b1804b1-4a0276b869fmr57980835e9.32.1790973776781; Fri, 02 Oct 2026
 13:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-maintainers-stackinit-v1-1-27112a221527@google.com>
In-Reply-To: <20261002-maintainers-stackinit-v1-1-27112a221527@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 2 Oct 2026 13:42:45 -0700
X-Gm-Features: AclHuK9GtaEMxub0C4cC2iFOReeGZtM2r5F_DDQMeKZ3U6WaUokmOoRrco02awg
Message-ID: <CAKwvOdkjLkKb1503q6HOnJG5ps3iZ3GdTxP5B6rOSPEfkJ-PBg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add stackinit KUnit test to HARDENING
To: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 12:27=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> From: Justin Stitt <justinstitt@google.com>
>
> Noticed while preparing a patch to lib/tests/stackinit_kunit.c: the file
> is not listed in MAINTAINERS, so get_maintainer.pl does not suggest Kees
> or linux-hardening for changes to it, only the catch-all list.
>
> before:
>   $ ./scripts/get_maintainer.pl -f lib/tests/stackinit_kunit.c
>   linux-kernel@vger.kernel.org (open list)
>
> after:
>   $ ./scripts/get_maintainer.pl -f lib/tests/stackinit_kunit.c
>   Kees Cook <kees@kernel.org> (maintainer:KERNEL HARDENING
>   "Gustavo A. R. Silva" <gustavoars@kernel.org> (reviewer:KERNEL HARDENIN=
G
>   linux-hardening@vger.kernel.org (open list:KERNEL HARDENING
>   linux-kernel@vger.kernel.org (open list)
>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4f72b4ac27ee..019f443af051 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14164,6 +14164,7 @@ F:      include/linux/ucopysize.h
>  F:     kernel/configs/hardening.config
>  F:     kernel/kstack_erase.c
>  F:     lib/tests/randstruct_kunit.c
> +F:     lib/tests/stackinit_kunit.c
>  F:     lib/tests/usercopy_kunit.c
>  F:     mm/usercopy.c
>  F:     scripts/Makefile.kstack_erase
>
> ---
> base-commit: 5e0f8396d4805a3e7f753fa58c8c55f1f3cc2160
> change-id: 20261002-maintainers-stackinit-230afe234e5a
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>


--=20
Thanks,
~Nick Desaulniers
