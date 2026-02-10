Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687C73191D3
	for <linux-hardening@vger.kernel.org>; Tue, 10 Feb 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722983; cv=pass; b=XL4HY8covfIAJ3pwbJ6yWZxzrCUKibgWISAA0yTK7JxRWcWi3V2+68Ih1F99X9dHkiKmFeCwgpgZy/owNSV0bqgle/mnsBVaKfSY2vI7puspSHwHJ1tYiL61T2FjD9iyPCQMzsrn90Kc9Ku3la4x/yImxpd1PlEbej5zZYxwGqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722983; c=relaxed/simple;
	bh=j3nx/ajXEqDdK9tPtrbxfG/uqfq2Fd5vN56+LqjmEiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6dqMoJUosUHPcdPg86JQRVkm3iWkwsmMMaSvSj+PtXYwoS3q9vLuFku+X7yxV0NWRy5THh5uy8to+cJry1oC6QnBfB8F+tqntAk/u7sXGIpOpuPOJjY2rwIuDd0YOJPFhTXVCO/AbMvvMOwQFAOH/AutRmkdidUERInTR640G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0b+JX9n; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0b+JX9n"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5eeaae02888so1354812137.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Feb 2026 03:29:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770722981; cv=none;
        d=google.com; s=arc-20240605;
        b=ILHbtTIEe3OXjctZ0X2ZpG4leLWt/sHFmKz3hbzAyGpAkeOExS5MerFUVbrLOOmijK
         LPmJzi1Jn0irtz81NULM7+jITM59qZyzAaeJlWorvRcYZgmX+Nde8rMT1cPCOGKn7Jie
         FkgcjZmTCB9Yxa+seIAhAAIKZjcwTpexoyuQv/DPwy61sYscNZotNmzz15mIwqPO5mHf
         iIkkmZqZPbSWzq40GCuv0AVjvGUeTYk4ItWwDNe5huAz8lrz5c7y6rErzxAd1kDdIl2x
         FFv0ANe9axL1pCQ39YYY7p5DIm3fFfLuUSmh4O0Taj151XVUnKIkZ6o/NaiOLSQd4heC
         WXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j3nx/ajXEqDdK9tPtrbxfG/uqfq2Fd5vN56+LqjmEiA=;
        fh=iDeserz5YiTss9wHeIn+ZGaY/lENx+tL4ky0QV5f2ks=;
        b=BR0LWNF4UPPCLTfn5tNWmIQj3P5xteOOAxXTyqzsJuW0vtSP4BAwbgnp1XMQSZqAVd
         rSxVkUefeJMvCMT8bCBUMrM8zj/xE7fPJpswpods3+cYTaoDdpckm9b0JaWoEIBNtHnU
         44IdEiC8cVqAG2OQAwEJFsDrP3xrAc/SUzQWY0dQ7het8+QQl7E/2LwhUVOJipz3yTBd
         u2KglVvHs+ZHZZfZxxJwYxKBK8kjBG5cvZFt8A41eq57Ru72NdB3ptTPvhcsGorz0Czy
         2xGcySMUuXPfDYwAxw2jqm7p0P4FpMx/qJu/EkOQXQsqQLwlihNrIeGQgKMTQB2JDscy
         uwww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770722981; x=1771327781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3nx/ajXEqDdK9tPtrbxfG/uqfq2Fd5vN56+LqjmEiA=;
        b=Z0b+JX9nTRsdURgs1/j3KQs9W3UWiQ0RGD7b581kUufveqe3f+tR+Mn464j3MfUqU0
         NHz5U8ACTTxR5hLWKp4H3OoTn4HkS5Wb55xg0kIANzHg82tZpJ/AvveZqV7si/qkht0a
         LI2gpjjy9ZlCbZM8987hZo65a5m7/dMXcJBtlRkpCN/Ic595kM1ttAmhcQiMJyqShr3L
         6qG3y+doCxdFsN/ZBr/SaOuP6DbflYneRzIMrsAV4sBFxDg5FC5nzm9NkkidsmNMLHVy
         eQgqr24/eh0KVjpBNHbMH+uKDdsAA4ai68fWbbjyuXmxE1WzViIONFxBefczgkNXQ/Xt
         VNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770722981; x=1771327781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j3nx/ajXEqDdK9tPtrbxfG/uqfq2Fd5vN56+LqjmEiA=;
        b=gL/vFipZorSBpjF5vNHA9QFURlh6hXbUPurKUfcIItzP6yN+VA2fwJRd4vsVJWLGQd
         v4mpKU5oYJTa/isTEYdNymWHLEjn1Vjkea5+go6QiRTXRnsd352xzubQCmdZ7KwQX/rR
         uT2geWToHufaNWUl2t4Tk98/rfAjh5VcazH9Yy+/Q039y9qw4y8mLJhV0xFaQM980JWB
         cIE1b8BbGU9fjV80KaKv0srg/7JOwS2aoBeFZO80BVGWjJ9Uzh6aj1RNWHmLLaMafjd+
         l241WPH9d4hwytaQM1W9gNUs4kei2dZh1Yj2Lh8+ZAEGRAK5dqniIIw8rfBwgVcmwlul
         kJIA==
X-Forwarded-Encrypted: i=1; AJvYcCUro/jjmh680pgMi6nEnQVbgDaPRN4iWpFnpe4w/CllsOgnt+zXfwmVvCXagO1RPcpcgdQGR8PozpPmTuyDxEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/d03EsiN33+HY5GT18iRe1gO0ssAUt2dN2+3/PrYf31qmvcdr
	0dsiOXG5CAxKaPkHp1KHcwHoE6xLHRjUj1UfZhLK2hOArMHN0h5SqHGdCGNZyji/ye/cuNC7Zaw
	8JlYUiPqQo+b/4AgVpI34HjCiybhf34A5ihxiZ7E=
X-Gm-Gg: AZuq6aKDGykEilpKGMgpE8eSx4vRtX7bA2Gb1QXL2YRYnrkfWKZ65lgmoU9HWxVUPGu
	Cfx5h87GEQ7SLrswznd++fFAJSTgcgcMaM+LNt9uPUN/mr6igLk4DiAxQLbuFLj7Gl4XIMYfPx8
	Dm2I7rWgc1SbpyK/G9jqEaq3baTulzTB6MGdUMLj4ZrW17XxUD5xeCj1UvT7CGqGxtsOCK5Yc+v
	pBLYPU4gZcTOOI6WR0ash4T5+FIoefClIJYt4/EQgUhbvu4xk1U7dyZCA7fQecXxjBMCBm9nK+d
	jHAq3HnuSQiSPc6ebXYS88Zp82FD3fYL6iTZLiANDos8jtRp1UKIPxGpw+I=
X-Received: by 2002:a05:6102:4187:b0:5de:93bb:c53f with SMTP id
 ada2fe7eead31-5fc48df6ff6mr403676137.25.1770722981155; Tue, 10 Feb 2026
 03:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121193957.1655580-1-morbo@google.com> <20251121193957.1655580-2-morbo@google.com>
 <d29ca795-ade3-454b-816e-46b5815a1444@app.fastmail.com> <CAGG=3QXC7EH18mhJq6egqE6bvo8_KchPD_N4PeZ7Z7tLOv26-A@mail.gmail.com>
 <a4c3494c-5444-4cc5-b847-4e1754bf3d20@app.fastmail.com>
In-Reply-To: <a4c3494c-5444-4cc5-b847-4e1754bf3d20@app.fastmail.com>
From: Bill Wendling <morbo@google.com>
Date: Tue, 10 Feb 2026 03:29:24 -0800
X-Gm-Features: AZwV_QhncrCadRnYVezoNaR1hRSbJWzPQVVig9dQWodD_Oj6H6DCBbQYrzvwC9g
Message-ID: <CAGG=3QW0Hs7DdNh9Zt1g3LgdrFGi9POKuhOETMPbe-a2=gvp0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: Add __counted_by_ptr macro
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Marc Herbert <Marc.Herbert@linux.intel.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Jan Hendrik Farr <kernel@jfarr.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 3:28=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Feb 10, 2026, at 12:00, Bill Wendling wrote:
> > On Tue, Feb 10, 2026 at 12:41=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
> >>
> >> This is every use of __counted_by_ptr() in linux-next at the moment.
> >>
> > I assume it's a git snapshot of GCC. :-) What does
> > `scripts/cc-version.sh` produce for it?
>
> It shows 'GCC 160000'
>
> I see my mistake now, I tried to build the lastest snapshot
> but accidentally checked out an older git commit on that
> branch, which didn't work.
>
> I retested with current HEAD now, and that does work.
>
> Sorry for the confusion.
>
*whew* I can go to sleep now. :-D

-bw
