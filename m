Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623363B42F2
	for <linux-hardening@vger.kernel.org>; Thu,  8 Oct 2026 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791490729; cv=pass; b=Q93dQHXE2vuRriOvI9wXpKvSPVvRww/jJ3+FmgniLQ00mn8sOZKvGiHb8LuOOwo/MzW/bTdWILoLX1OwJEIT4+ypj4VHHIRGIifqHz0RWCU2dz0unJGx8dRjhHpiFNLBSiGKaIQWFxlGmkiJng/ADfZgSPxSjYkAaAO4VGNH6RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791490729; c=relaxed/simple;
	bh=z0YNlsqK8DlWZ011G3qdno2fBl/feavG0dTMz0RNBQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGGcOeKdcd/nEvnpm7SdAn3HuQ2jiPG7wGeM7Kgrsive+0ISHHuM3Q4U1R+Ek8sl/Aoj6vKUr3dAoCshesRhPKsuTYJwLfQnW5kj76pSXUbno+7A8AZo2mX1/D2pgvGiV5nmbZnWmrugeidgAteJll5ljkQJtjSriY5h9kQH+Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bsMOcwg/; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bsMOcwg/"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7c4818e4165so1122713137.0
        for <linux-hardening@vger.kernel.org>; Thu, 08 Oct 2026 13:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791490727; cv=none;
        d=google.com; s=arc-20260327;
        b=K54CE48r3RiY6M+aVv4Do4No5vOgzsEKG2hMJ7QyII+Zp3DuT2RANFYbSF/dhs4EO2
         0k6B+/ktTUrksPFo5OxUS5uDYSLnFrQNfSxoO85n+3BrOWFjVFYtZThz0kGkyV4X72Ro
         u8OdSGaWpGIm+u/w0Tr3gbK3VM2w8PH+g4PfEHE8jPHUO80BXXXnyqJNyDh3GWieuHuf
         KcmE3waQcJKtj2APSVZWtgxU7QIkR0vXNiblpVQH3xSEd7UhJcCsuXSenVKnf+BXKTcr
         oxp5WGfBDm7AiTumXA/+ioi1d+5W4V0nc9Us9JCiRBjO02bGOKpCYicPe7m6Np7Qhp22
         ygog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z0YNlsqK8DlWZ011G3qdno2fBl/feavG0dTMz0RNBQs=;
        fh=H5o4p8eCh25O4Rcg1kGyTlClt+cLtfNl537adnTsZcU=;
        b=X9JANWEvhKN9O7Qyrt8QmZ7t/r1nT1NVod761x5/lvFsYEsIs45Na+9VRXrYG3Y9cS
         JGqJgDBnkj8a2pTpXt//MhTC76ciF7VGsIbr7jEere74n5ZsJi0vrgmMmZrK/RTCnTCd
         HYB7u5vOFhKzxDpeOJAiN5ZrO1XO2rUT8YRqw/qjx1ib7PLRRjJDTnrqkehbz7K77hYN
         Ox1TwGCTYYSbvX1fWhQ2dNaocwrObN7zsUk65bXAQ+pOkdhBJaQm+9sg+qgsFud2KDeW
         hACNVDWdfCG915JTxlRaj5RhxV1Fj9WuQipQY/CceE3yBrsLq8OGTHdbSQqpzAyZgndv
         mf7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791490727; x=1792095527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z0YNlsqK8DlWZ011G3qdno2fBl/feavG0dTMz0RNBQs=;
        b=bsMOcwg/TqjNJt6mzjEnBVD5MgjWrM9hZc4gXZhHxG9gOqG3TyxHRnOByo/h5uk28M
         alY3fz61t0vsyxmrvvaVfugea1e57DWLOXJEoZQTesMdB4UUYdpdtzyUIKYen6GqeGpH
         /a2acJnDF3aArwA5kbFD6hBSmnZukFnJN2PYLAZ73Fkjtq5h1nhGObzTJbeyPR54f28d
         qUZBDsoWsOmtmUOEUQKqSXmPgtktKv54yc3QVJAOiq0iM0LpBD1MD18YQH2MzchwgNIP
         4UsiuF00dP6YTxLhR683n5mjeJbimuZwqTyb+rL/yoXcqkmuqZrn2R5eRtHCdG15nAZx
         9w5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791490727; x=1792095527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0YNlsqK8DlWZ011G3qdno2fBl/feavG0dTMz0RNBQs=;
        b=dpchiwCcnq3yR68kw8+2CAJXWqxSrrygdPRd/lcHkT6cNs5qYpmVYnFP1ozVG8vx/u
         pk6q83IuUyX21xMG8zp6COTDKfRggKr9enhu2iiNnRLz927wzqC2mcDQjuIfk/C5laWU
         EhtxUP7is9wT7WHpQ3R5R5GHS9nQy1wY/1aWeCh5IH/kj3m02whm/YaEdnnfZ4/ocDxD
         idVUwV9LCTbFLXdmaEUpRp3ebDHxfew8zJdsxuvdwewASqzoY0BcKWQ6w5fvnXeB+KDk
         ZzOVMhbltGawQqacvfbxBLXoRIWVaT6I9xDNHv2s0XXEpmoSvVgcNIpns0yGMFTryOO0
         4PCw==
X-Forwarded-Encrypted: i=1; AKwUvBy42GPz4HwgqI2WjPr85e+CgCXVx9q08zADTobCwqjiEj6kGXt4nmaAS6vasrK/o7TGk7wseFVAS/NDcsXYgyw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEQ5cy+2p464Xf0Dcx31LahPLG19gJYKPJi+4GNMKIaeXl3zJE
	FNFDeHCebKSVx3LfjXJpmiSaAmx5Pn2d+K3Q8KUHMMv3+DWjVAsdJqXqZoLsMNR0EQs0thIPdDP
	AI3/SKqgvr65DH8c9TUQd02nBXFXKi46LNi4VxxQ=
X-Gm-Gg: AYBFou3yZ+NzUiP68UP5ehqiTOksl5NIKTtDiUQkE3qVrMJ/O/VregAeG4qiMtob25n
	AoB9GN9ri3o7GNHTWyITv3AZ1qw30jOkOgk+lHDM8Mw9hZK8GTl3CxnwlxAIwDCK+x+Gw4yLBak
	ucivO4EaYXIpA6kINM8sOrnmOU+zHP57T1yoS63ezTA5J410TyjxJV1gL04PVZAhAw7HAtUK721
	t1l0ujp5b0nZlprg+6KeBBxN6eXLZG/4aMdlBYuRDO894PlxDMUMvwmSs+Sl045KABYJr76otc3
	X0obfg89CRsOphjW6HAXUkvvFlN5DZ89QkJm+1rjp20it3TuocD3qmz6jdR40YarWjttjuXfXAB
	J1IcMgf+PHEdfuyvbArZF
X-Received: by 2002:a05:6102:6b09:b0:7ba:b5ea:c4b8 with SMTP id
 ada2fe7eead31-7cb36a8c674mr1668137.1.1791490726658; Thu, 08 Oct 2026 13:18:46
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com> <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
 <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
 <CAGG=3QV2k-nsZHNSuKEixZb+-LcxvhQsG379ghgyOpiDLTJWzw@mail.gmail.com>
 <asNuMzqz3G-gmIiD@google.com> <CAGG=3QV1eLy-eAfi3Q49qwMw_Yw-BJ1tmd3J=SLJB_qWrx4bNg@mail.gmail.com>
 <CAD++jLmR3hmEYN+-YCAcNq_0Zk0=PijS9jhGaMppkNhvbs90JQ@mail.gmail.com>
In-Reply-To: <CAD++jLmR3hmEYN+-YCAcNq_0Zk0=PijS9jhGaMppkNhvbs90JQ@mail.gmail.com>
From: Bill Wendling <morbo@google.com>
Date: Thu, 8 Oct 2026 13:18:30 -0700
X-Gm-Features: AclHuK92jAkOpDGnAzk73p0KSvQJ46QvtFBZiCrror6Oc7PBOFNeUEbwDIK5rPw
Message-ID: <CAGG=3QXRPh=3rYyEHT0kTzDZ4omeHOjmN3OZGy=5hupday7jyg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
To: Linus Walleij <linusw@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>, Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 4:19=E2=80=AFAM Linus Walleij <linusw@kernel.org> wr=
ote:
>
> On Mon, Oct 5, 2026 at 12:26=E2=80=AFPM Bill Wendling <morbo@google.com> =
wrote:
>
> > I sent a patch to add `__NO_COUNTED_BY` AND `__NO_COUNTED_BY_PTR`
> > macros to prevent this. They're similar to `__NO_FORTIFY`.
> >
> > https://lore.kernel.org/all/20261005102518.2400984-1-morbo@google.com/
>
> I see you are hashing this out with the right people, thanks for
> going the extra mile and fixing this properly!
>
Always! :-)

I'll ping this thread once we get the problem solved.

-bw
