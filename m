Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993B51E459
	for <linux-hardening@vger.kernel.org>; Fri,  4 Sep 2026 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545679; cv=pass; b=N3SrFQm4WJcFq9/flnOSoQXbqVTrJnfOMkLrs9vfDuxVkKK2fkTek+OouyHsh3e9yLqlRN1d0zUTtXQXIyetParQYD+kXBYu/QLt0fJpCWPhA1Dga4nYSTAh4GuZSvNkUMed3PB2H4TvKHoaxgGH2B+m0QzPAG39pcHUGfJ3tOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545679; c=relaxed/simple;
	bh=5m/pay81xmy/8S45ZPXzH94fItYQkJjMwnM4hRsn4PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CajR0lKA+ipuS7dqMOErWb/8gaGctK0nBfUcL1ASrNiI5Mf+yVOSKF3hHQ97HyZkY5pt/+WpWuG3fHSQaKs61nNKsGf+aViZI2NKnZLuCkKU4u8Ci/HB0nQF5+OzhNz2VBCL838j2fnVOEvu+xcXdcCeQZ/m8WDI4xON3a6jDpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tm4555GZ; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tm4555GZ"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c65d654c23so554749e0c.3
        for <linux-hardening@vger.kernel.org>; Fri, 04 Sep 2026 11:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788545676; cv=none;
        d=google.com; s=arc-20260327;
        b=ADhk1rvt330c7uK68eOJ5w0LwbKViEwYYChurtIYRh+IAM3CVg5SAyV48UaCZUkDSR
         WGJgpjK8x//4EqSf5L+SwYj8vTs+9SLICEJG9WiO7b6hll866iAJ+/gGwPkpd3egwbz7
         dMh5Vy/21pf5EhW+8zMGVVeru9Sffxb6m1QMHqefPlV7NSTGk1r+1mvHLx+QzNDucr20
         9CODieM3daTp9PIQy0EG+TgzWnVCQi1uiUDE/O9wUBs7/QXYt8dJ45oi20Bju2RsKmb4
         XxI5a99eN8Wg7YODHIgyl3CaSMxezn4lSCLBk3qTB7/5qsCs3njIuQ/7R1CUWDCcCXyD
         hrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5f1sSkMWsx0NynE5i1A0A1wBIJQk0ydoeFqLf0ZyvTY=;
        fh=ATWiClru+/zVWSOabXFdjlySe5KTBGobFPEN62uyxyQ=;
        b=oaPaEmQpF5akM7lSf6Yx5z4cF5ljEFUrRCa8yD7irYQ0URuT9kkG5GnPXcfbFaRn5w
         otXEVjX53SJQWLQgIB8/srpwMwzCnLIoSRREqiQo7fpUwYhfD3T9NG4A2zjqH8OL5U4N
         CM3s91FI84asW7ClvwgbjhOWenIJCln9m58nSLxh/OQesjqJvlo/FZI2qMrzeB00QDUt
         j5w123/VAcK9u7yahZtkTPRyJYOy6zn6jNUy25oyd3et+Nt0jlvr1HwqP2mLiTv71MwK
         Qxxef9BtM2vBtLy8yeBRmXv7om+G8Jl0JcCCSMYFs7nVByEFPEibHNQf87bXo4C8kfOs
         AssA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788545676; x=1789150476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5f1sSkMWsx0NynE5i1A0A1wBIJQk0ydoeFqLf0ZyvTY=;
        b=tm4555GZrmGJdnr2hCjcQSWWu8EgaJU6DCuJ95RGmpz0dKnYV9hOlGV7Yn72NAOokJ
         5pHA0HlGK+85VHiL9Qu0Wv3T6ydqdphE6rCFZZ87diy1REW6v7PRwLrvFxNiJ/e2MvI8
         5cVgO1TlLAhESrP+MxoUfBoMDm13EX5hd8seCujicR9At3MQh7/1h/fgDwcjR31ZwnZn
         b5VquPb/OL7+gYdJh/6IZp9FfOn2IZAe5ZQZwA0H2t7xTYe7mEHHdL9I2yBrTKrl5U3r
         gwAdVSy4IUepNwWnalpHRuViPJWvY9Q0oAcMX6YwEDdnAvGF8wpCxhrCn3ZwSPplNKHl
         lUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788545676; x=1789150476;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5f1sSkMWsx0NynE5i1A0A1wBIJQk0ydoeFqLf0ZyvTY=;
        b=NeDi1b66QkQHPpJ2RlzzIhqX2xeLB8e1DqaYdnoF5cB5TVokNkhS/fvE2Lzrg9hTSV
         Gu2/Zxf3T7xQD/AlAj/HkzU/oRooE5u4Canb+uQGSv12zlIpG+AsURCFpRUbcQcFixSG
         gWNyF/o47dTexkHf6NcJ/sbymhIlqLCAeWhXGX0f3g+cjjZowxSkvsixN/18GAdVhjeW
         lRK3kY3EyId52Ds1+Fik64C6XvKOSCdIl4Ptfglrqg4cgeE5+zry9M0b7Xv5vdjzNsmf
         KLUSWXcENiWdktewnOPlXDrr0VpMlHWE89bJDBwYEfkdj+HX2PDQh4LpsKUejfXEc4ut
         NcTg==
X-Forwarded-Encrypted: i=1; AKwUvBwNTBZdSDj0vJXpPqX2L946wiRcTChzdLcfKdeDqALxfQefINMhuUhVQ9esN1sb1dTrgGh/2f9sv3lwpqlbs30=@vger.kernel.org
X-Gm-Message-State: AFuF++nlAgc/AlXXZJXEmMxRRfy/gPsmwTYJy6m65rVHZPvnSAkzITaR
	WTeCgEZUwK+QLbXbU9QMdRN2mWCneoKHXrJH7StiO4wciPvlibkXLK18T5e2x25zGI+l2EwJOIp
	IaDCzdqZ+f7X38LDTIRolA/qQQclAhEcThTmOxPM=
X-Gm-Gg: AYBFou1kUuvenlcOC2OHqLK68PaRWaYu0p+r+vlFD92FRGxhOEOUjCmMTTOI51bR/0E
	ik0sgvUWwQ7UfA/VfWE2jgjgn0+tS8qTAxK1KwXm2P+4OwZ4AFefpQbBMURv8qVfO9GIsptsd84
	Pg8+4Mohza9BfpYHI3gUVTS2hTFYe481Va2cTX+/3dCBhQ9djtfNMvWXSIqUcd3ZJmKfFmkSp7/
	PX99ENTjBBGMTrDyAlBQJ76mpORpCBt2krTphMM+Tj5Tmj3XuSe/bi1QQun0L2szJBRV4mchGWG
	vR3hLxz7trm5/2CWpmUVIwKM4mRz85XO7o7iZ7a5XKQxxNwSM/z47TfTeYV/Il5IHNwAHVaL+xj
	Wkdo+oVRJ37A26UTbFrd4Igii9sKXzhEcWGpaXfco3K1mw3iwlf2i
X-Received: by 2002:a05:6122:2890:b0:56f:6cc0:681e with SMTP id
 71dfb90a1353d-5c7ed2baa42mr3536633e0c.1.1788545675619; Fri, 04 Sep 2026
 11:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903232428.i.323-kees@kernel.org> <20260903232438.60394-2-kees@kernel.org>
In-Reply-To: <20260903232438.60394-2-kees@kernel.org>
From: Bill Wendling <morbo@google.com>
Date: Fri, 4 Sep 2026 11:14:19 -0700
X-Gm-Features: AcwNN1XbDAT0_I910Gdu5ymI8yT08JVoK5EGJlbHpxWo_G4-k7gg2DjgPv2W0vw
Message-ID: <CAGG=3QUHtqFVCEcnxXO9fan_RBT_jjWtBbA8ECpQeiC1dKMnvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] randstruct: report bad casts as warnings rather than notes
To: Kees Cook <kees@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Thu, Sep 3, 2026 at 4:24=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> find_bad_casts() reports a cast between two randomized structure pointer
> types with inform(), which renders as a "note:". It has done so since
> the plugin was originally added, while using error() freely for attribute
> misuse, UAPI structs, and version mismatches.
>
> Clang's implementation of the same check has always been stricter:
> it rejects such a cast as a full error. There is no reason for the GCC
> side to be effectively silent about the same problem.
>
> Build tested ARCH=3Dx86_64 with CONFIG_RANDSTRUCT_FULL=3Dy and GCC 14.2.0=
:
> allmodconfig clean, and defconfig clean under three different random
> seeds. A deliberate bad cast is still reported, now as a warning, at the
> correct line and column.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  scripts/gcc-plugins/randomize_layout_plugin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-=
plugins/randomize_layout_plugin.c
> index e2bd9ba08089..1e66f45fe29b 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -22,7 +22,7 @@
>  #define ORIG_TYPE_NAME(node) \
>         (TYPE_NAME(TYPE_MAIN_VARIANT(node)) !=3D NULL_TREE ? ((const unsi=
gned char *)IDENTIFIER_POINTER(TYPE_NAME(TYPE_MAIN_VARIANT(node)))) : (cons=
t unsigned char *)"anonymous")
>
> -#define INFORM(loc, msg, ...)  inform(loc, "randstruct: " msg, ##__VA_AR=
GS__)
> +#define INFORM(loc, msg, ...)  warning_at(loc, 0, "randstruct: " msg, ##=
__VA_ARGS__)

Why not make this an error instead of a warning?

-bw

>  #define MISMATCH(loc, how, ...)        INFORM(loc, "casting between rand=
omized structure pointer types (" how "): %qT and %qT\n", __VA_ARGS__)
>
>  __visible int plugin_is_GPL_compatible;
> --
> 2.34.1
>
