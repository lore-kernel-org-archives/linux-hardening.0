Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F231C8633
	for <linux-hardening@vger.kernel.org>; Thu,  7 Aug 2025 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604740; cv=none; b=agtFRZdfmBus1Iw3jIGUz4vEIAQhApjiOCohTL0Y4VIvRG2goak8sd+fsX/mNe90XgFNooeSk4yiXgfcGffRBgJ5Rq98YiqM2/uh0pRLFNqfX2PULldhGhrN3aNVREyVRGIduDJF8BNlNMfouOe2nINqguFgjWieRQqw1yXEs4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604740; c=relaxed/simple;
	bh=qlVM8CkTZMg669S/Ns0vKD+hb/qHNknFkrDMmeEEhEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2L++5Oa81DlRPpn8vwOkyI25WL7Nj2RikdQNX+/OxcucE0wD9SrIuWwZztos3AtO/8lI2tkGO6LGupEqJR8K44X7RzNCZEWGwUosM6yy4a034qWohaZq830TupwXCHQ+Vg2lwN0qM9oNKnbiacLcmJqUw+oygv18DPCnrWeUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNiKtL1L; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNiKtL1L"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-88bd5f7e43cso451320241.1
        for <linux-hardening@vger.kernel.org>; Thu, 07 Aug 2025 15:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754604738; x=1755209538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTjFQN82cwVeM4ZQvGBqCFZVTMn8cacbLuxP2Do1hio=;
        b=KNiKtL1LuzwHGL7tOKFDoIACiAwSgY5P+r8dyGXqhggYJvuN+QuDKNQy9ViW6ZmyQ+
         Iuk7mgOebcTI9/IEUoeRTeAuFfiTfd5h8sgOWQmel7RJfMYNEx0FidsSAqEqfIbR2ojj
         JidrQ6N4pfDWADKY1/QUeaRIQahYSJISPDFdr8dZIMqlqJRmmxkSU9UvZhItExV6vQ2w
         45qYU6UBT3ngvPkdxWy9IXFwyJrivXJDcHk7rEVnK9kjoDovGEn+xEnPisSj88AUd4fr
         Tk/Uoyc3Dj+Z38t0sUFmBWUHyKsWlCkwxQTDMJxnsB55eUuEUaxwDI+KunrQ7cTSFPwu
         3KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604738; x=1755209538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTjFQN82cwVeM4ZQvGBqCFZVTMn8cacbLuxP2Do1hio=;
        b=GURft1muSqQbLEFE7La39AGx9ue4xChj7Y+3jgmq0SGW2oBBDYOxbKnczpEARNeION
         PxJWRlwcq1d9or/e4A8oApcEoIy45HOSb0RZR8mva7di0hnHhDKe1IEjJ9TsLAdfX0fE
         +h8lXMlUWbX0zHbKshW6Qj27opSf3cRMhlQkirPLKVCnkQjll2b2X6d33scCLXtCjlwH
         DDFcr3Xe6p/C8cQwtJhK/IgrmnUMMbWMVK9IDeWLMb6WRZ/caNODcZ/AoSb4qjTiQzvg
         pr7YmwRXWfimGsqwMXOsMFa272FpaAmvgAYXmE5nqG+Q6UPyNDa7Vr8uENVoUlJfvxEE
         2rqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFtjPnrcqXLNahdqRFQOkfsUXnOdLGEOx1eaK1cVrKXLtA/XZO02s//CTffpRJsgHaZfI7/Pi+IjfwGKH3kBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIUwBCDmru2uUVOrg1fZ3zDN8qT07u6XsL/nrBJ3Aq2ywWhgc
	tOybCr8xk+O+VJd0rR4+SmcDOqA72YlWjFX+DOr74mz0I2h38tJbC0yYaTQmwW4PYKvnKpVWO3N
	B8WVaQPFe1L6CoLON0kHcCS8bxMIYGbQ/GHAqm7BC
X-Gm-Gg: ASbGncumovKVp/DGy01Ig9HzEP5Ke227nF2OTRnKnvtGwzn1mNl2xtbFPBOgIxLXaLF
	gIii891OJNqZVyP+7BzT+Zgl4VW5QR7wtGf/4Pr+du4zr3DiTH04STjsho56/c5PNXnripXkqYz
	Lc/rFFHoNbfye26zDvkKLZPpCaFszm7CjMoykYut2wCNm+DSnCxPER7f1np7lEuv0xQx/k7xAbD
	HhuonkdAoMM8LddAjHzP/7sIiqOJavvtLE=
X-Google-Smtp-Source: AGHT+IEYFGr//L1F66PSo/HzzBCZ90AvQWOXuRI6gktcJUFA02QiCFgkPiLDUKRHn6BALGhSzkBYiT/d+GRH+TAj6a8=
X-Received: by 2002:a67:e710:0:b0:4f9:d929:8558 with SMTP id
 ada2fe7eead31-5060d7b0262mr340444137.10.1754604737443; Thu, 07 Aug 2025
 15:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807-fix-counted_by-clang-19-v1-1-902c86c1d515@kernel.org>
In-Reply-To: <20250807-fix-counted_by-clang-19-v1-1-902c86c1d515@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 7 Aug 2025 15:12:06 -0700
X-Gm-Features: Ac12FXyAGlTv67GNm7hvR62c2Q7kwHSr8jwLhWy08UJpC4Mp2yOrNOga1MEvl64
Message-ID: <CAFhGd8pkSP9JTVnBzn7-Cm6JMtj-qBAgLMBP1JhLtt4unkruZQ@mail.gmail.com>
Subject: Re: [PATCH] hardening: Require clang 20.1.0 for __counted_by
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 7, 2025 at 2:36=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> After an innocuous change in -next that modified a structure that
> contains __counted_by, clang-19 start crashing when building certain
> files in drivers/gpu/drm/xe. When assertions are enabled, the more
> descriptive failure is:

Since this is just now breaking builds, it is OK to bump up the
minimum compiler version just in time.

For future travelers, the "innocuous change" popped up in -next as
Commit 535c445eb94c ("drm/xe: Add dependency scheduler for GT TLB
invalidations to bind queues"). I am not sure why the additional
struct member caused this crash but it seems like Bill's clang patch
solved it -- so I won't look into it any further.

>
>   clang: clang/lib/AST/RecordLayoutBuilder.cpp:3335: const ASTRecordLayou=
t &clang::ASTContext::getASTRecordLayout(const RecordDecl *) const: Asserti=
on `D && "Cannot get layout of forward declarations!"' failed.
>
> According to a reverse bisect, a tangential change to the LLVM IR
> generation phase of clang during the LLVM 20 development cycle [1]
> resolves this problem. Bump the version of clang that enables
> CONFIG_CC_HAS_COUNTED_BY to 20.1.0 to ensure that this issue cannot be
> hit.
>
> Link: https://github.com/llvm/llvm-project/commit/160fb1121cdf703c3ef5e61=
fb26c5659eb581489 [1]

Reviewed-by: Justin Stitt <justinstitt@google.com>

> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Should this be marked for stable? If this makes 6.17 final, I think we
> are fine for mainline and newer but I wonder if a patch that adds
> __counted_by to a structure would ever be backported and expose this
> problem there.
> ---
>  init/Kconfig | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index af4c2f085455..a2675ee1ef8c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -117,10 +117,11 @@ config CC_HAS_NO_PROFILE_FN_ATTR
>
>  config CC_HAS_COUNTED_BY
>         bool
> -       # clang needs to be at least 19.1.3 to avoid __bdos miscalculatio=
ns
> -       # https://github.com/llvm/llvm-project/pull/110497
> -       # https://github.com/llvm/llvm-project/pull/112636
> -       default y if CC_IS_CLANG && CLANG_VERSION >=3D 190103
> +       # clang needs to be at least 20.1.0 to avoid potential crashes
> +       # when building structures that contain __counted_by
> +       # https://github.com/ClangBuiltLinux/linux/issues/2114
> +       # https://github.com/llvm/llvm-project/commit/160fb1121cdf703c3ef=
5e61fb26c5659eb581489
> +       default y if CC_IS_CLANG && CLANG_VERSION >=3D 200100
>         # supported since gcc 15.1.0
>         # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D108896
>         default y if CC_IS_GCC && GCC_VERSION >=3D 150100
>
> ---
> base-commit: f627b51aaa041cba715b59026cf2d9cb1476c7ed
> change-id: 20250807-fix-counted_by-clang-19-470d53f93aa0
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
