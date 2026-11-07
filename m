Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794023447;
	b=pbAlFoHtbFrNMk4j+fxp7ZSYurI9/HkeKh1ANhJrQsBhoIAZ8Di+JW50aJzh33uWelZV
	 k4Ngus8iQYFgxgKiZ2DbG5z4bawxOc3sAor2llWOF7EczU2Qhp4aGkw9SXymRei9vuDiU
	 0SETcS3iV7jqWNbKSdBCIECw+gkKzPjSYhrh0uaEUJJPxxHui9GIutgVpFkrz3docV5pL
	 fbbm0obHKFsNQsKzyINI6av7ehEGRmRepLTwwREVCu8sl6JepEjEII4c+CmzM16eQaq6v
	 vWck2W0Y9ooJn9oMzO4h9PnKkardMiqWtQUy6SYCdy++cZ7j9++IKH7/TyylpG5RRjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794023447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8DsBB/++J1ezqdBf8vyGFjxYITqM0+YluqzVccQohus=;
	b=OPEeSjPlsicTyDrAlX6OAL36tnXq3Yj2pjkiXwViwx1NPtvA2aP2NRAmRK4gMe5EaIOq
	 ViHMPx65aGpGqhLiM5A4mG76KcFvaLDafJ3JKhjB2nRuqYcMlWFvP7lvmcX97dl6FGqrp
	 /+Gp1/V5Gwqh+nYp9nVYAQbPH2XdSJ/FJXKkaKBSphH/VBdkefcfNWs79oOzDuVfEp0zy
	 cALI5o0cjiFIub98mpn9U01P1uLBw3Mri4rE3Pg5vy/xeh18A3pBWfOC3w+RPgdI/w/NP
	 rCzLYd7gUIud3X/mczvcNLY71T9Yv9FNQ0Ci2mPL2acskNjtnP7NbuBhS5AV44Zr+2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rE1ZTDNq;
	arc=fail smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF927606A32C
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 03:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF927606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rE1ZTDNq
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so12774855e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 19:50:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794023445; cv=none;
        d=google.com; s=arc-20260327;
        b=P+H38Q7H/bn+IGz4BkhQj+TRaoM3fPQytRJ4R2CCOAivowjCAZm7Hgj0VCrLZZmCP/
         Zfn8qDzkWFzGU5vHgd1Jwa+h/ZopgFWbrOwnG9zbWHG2/HH9xLRnMYbaavvOwAfmgNyB
         K4krAibGpfxomyoeFUAIdUxuUjknyonLigfSOZEPjPe0qew7mheaO1cONnUBFXtJoheb
         JE6k1S2aubUffd19JKAVGJZ2iYoBQtrgVE+9GQgP5iebNYN8Ox1koNmlxzJjlQJi8wRQ
         aHhUp2j14nvM7by9y7dXxvqPClGdSJEDVDbtzmPx+HZqT0V5kLBvQwgV/C9j5hT47sUJ
         rL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8DsBB/++J1ezqdBf8vyGFjxYITqM0+YluqzVccQohus=;
        fh=NVTpqmdD5HDkoziGzEi0TbG1AK7ufJpyUPwyTyn7ldE=;
        b=g01m9i80ZP2BkZo63tKWjSMdsST+F/fyhcfOXzVmP3KM4AvgAiZvwZeoviGwPECvNc
         gwjvXpIhak8rk4ne6inXEQZVHLsZrPjDHmxZeIFqzpFPnhnQoz49jHv4/Afm7pxcBr0A
         sqoDV+DY35M+JrOjIcYAM6M3o4OwQb+uvbh0AZ/5DCrtjQbdoUuqRZvWn2hGS4TJz7+K
         UzSzXktjOeenKa13Xu1ss8N5kRkOjGn19mGRPjD/shNLPKbtDf3x7GZOpwiZIVnPOSKE
         RFSskvlL/g35RFK8QaOxw1veXH61M5AAsDoZe1e57rwoJJicfT2Vd82lvy1dt13Khmx+
         Ngaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794023445; x=1794628245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8DsBB/++J1ezqdBf8vyGFjxYITqM0+YluqzVccQohus=;
        b=rE1ZTDNqUJ0IAulplsLTzvuxc6VvShh1uFVwvIMIimVxLj7CXPXCV3jyIvvVntz/FN
         10tvlHlbNHqAOult/EKnl/N1+30mKmmdX6dOaa2If7ydYpjxfnUa0jNheIGFwP+P8RH0
         x0A9nBiEGNe82RcBUrT6ANl6iV59DsEvpExnuZMDr6ZXGkoCY4QLXZ/sBmlGOcLZHBLm
         kpSJQoHdnknWtF92qQvml2mi9M3KZb/gKCEL6NMABIPLPQq7BBuvvUPgV4n03UmYzZ0g
         DQRGMZfgJIkqK6skEX4ZrKBv+/pc7GFDtdmllZtVkjuIMHZ2ckw66X4dZgGn8Wkn49Ue
         1tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794023445; x=1794628245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8DsBB/++J1ezqdBf8vyGFjxYITqM0+YluqzVccQohus=;
        b=1QPRG/zfEYCawoQunY+AVhW7aun+DHXU8smgIp8fZNA82iVYdI5Vz8K6lmLtF9SYnx
         shuvbjxM/l+aaVr+MfPcT0YXGVRzqmciRzwy87YGUrZbjXUNe/PqwXdkRvS3bWO53OXK
         GXSvvSHhxrWn+Mi0l1qQJSwq3of0Xlz0OX6FlvY62qMR4AAsF0BOrlmGwkgl6gA1TYzC
         MSTtVttXBXN3QEifCemEFwSlONB1QvBAAgMnAm7YWpCs7V25sTehPl5owkW8U5+9w3X3
         usvgdU8LOJ8K+rcSJf5DZB7peGKVxAHosCH20suWTKo2Oq+r1PpxuTqf/zc/IZpTOKxo
         oqag==
X-Forwarded-Encrypted: i=1; AL+hErFkMR0pBHKkPKWLByleqgRtMane3gRzLxJ4npwkpyxnz88yvWXZE9jOo5GK8vHrZDEpj0YFiDWC1hTBg7LXvTc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8h4SbaV6XZP5kqExGR4IojxXRk7QaL8TVnu7W5z98QLeNylDal
	tSbibqNnJ/WHfRd+ZrZNZQgMBaNzN44JFyjSpoCkB+oCTbLTshnJz30b6nojxRpa86czBbJsVtH
	uru2FjuSfaemGrGKbVUgWUmcUS7RAbRM=
X-Gm-Gg: AYBFou06gD2F7uVctO6U7U0Yttc+t4JlcY2BXCuMxx13+zFriRgE6sECQtdGc8eJirZ
	ZQZZsOh+wJt5w10NTlOwKWXDDb/M3jvXgbIiiuwdHY4r1JnXyPA5qMfsryIDOoXAvFeU996rx/o
	6QU8oThcK2nR+ewOZoDVE7EqZux2YIm++iEEcap2fVNS0D9vB8jnH9YHdeX3mKXj6XJA5VGvYx0
	cP/eE5TwHhOmGe4OP+xe0x3Y5Doa+pcmk6SycBbFLu6vBaDA+SrSqbTmQhsl/D90spe0mUCNc8K
	9/2U1WWwkIMxr8QHYnU5Q9HSVp+byGfsd8gms5X9aqdRHOT2ZyrYwPO1doH3sJ/NZMtRE/w2xaq
	la+3FLIMmBtYvpMrTKWLXeAMzInTZN9s17LU+/ZU9n4q/feX8dnpSIfg2L91AttE0+IiCvs0=
X-Received: by 2002:a05:6000:2203:b0:48e:2a6c:153b with SMTP id
 ffacd0b85a97d-493cb334277mr2973714f8f.35.1794023444836; Fri, 06 Nov 2026
 19:50:44 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
 <ausVkYs1-3rJ5Fj0@devuan> <20261105113229.4126d872@pumpkin>
 <CAPDEY+X7q2yeWaa7J=Nre+pQqUa2C760Hh9NovdGNSQ=VsEr8w@mail.gmail.com>
 <20261106102723.1cc4d350@pumpkin> <1EAA42AE-92F8-4CB7-B490-CDB6DA9FFCE9@kernel.org>
In-Reply-To: <1EAA42AE-92F8-4CB7-B490-CDB6DA9FFCE9@kernel.org>
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Date: Fri, 6 Nov 2026 19:50:33 -0800
X-Gm-Features: AclHuK8S23Z0xNdnv0TQ6fL-U428vp435ZwNqPtWkfKo8mNDXQ1VtJpE_Dhy960
Message-ID: <CAPDEY+UVqhg9R-Nk-vqie7kNoadr0JcXMKHsjShmWbHkWuexhA@mail.gmail.com>
Subject: Re: [PATCH] media: siano: Replace strlcat() with snprintf() in sms_ir_init()
To: Kees Cook <kees@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Alejandro Colomar <alx+linux-hardening@kernel.org>, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, justinstitt@google.com, morbo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 8:06=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On November 6, 2026 2:27:23 AM PST, David Laight <david.laight.linux@gmai=
l.com> wrote:
> >On Thu, 5 Nov 2026 17:44:00 -0800
> >Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:
> >
> >> On Thu, Nov 5, 2026 at 3:32=E2=80=AFAM David Laight <david.laight.linu=
x@gmail.com>
> >> wrote:
> >> >
> >> > On Wed, 4 Nov 2026 12:25:17 +0100
> >> > Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
> >> >
> >> > > Hi Mariia,
> >> > >
> >> > > > Date: 2026-11-04 01:02:39-0800
> >> > > > From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> >> > > >
> >> > > > In preparation for removing the deprecated strlcat() API[1],
> >> > > > replace the strscpy() and strlcat() calls with a single snprintf=
()
> >> > > > call to construct the IR device path.
> >> > > >
> >> > > > Both the source and destination buffers have the same capacity,
> >> > >
> >> > > The line above seems irrelevant, and potentially confusing.
> >> > > The size of the input is not important, because since we're append=
ing
> >> > > stuff after it, truncation may actually happen.
> >> >
> >> > And gcc's stupid format overflow check is going to complain.
> >>
> >> Thanks for pointing this out! I initially tested with Clang, but repro=
duced
> >> the warning with GCC. I've switched to seq_buf for v3.
> >
> >That is entirely OTT.
> >Currently scnprintf() doesn't complain.
>
>

Hi Kees,


> What does GCC say about it? Is it mad about src >=3D dest length but the =
format adds chars?

GCC 13 reported -Wformat-truncation:

error: =E2=80=98/ir0=E2=80=99 directive output may be truncated writing 4 b=
ytes
into a region of size between 1 and 32


note: =E2=80=98snprintf=E2=80=99 output between 5 and 36 bytes
into a destination of size 32

Both devpath and ir.phys are 32-byte buffers, so the suffix may not fit.


> I agree that seq_buf isn't needed here; that's really only for complicate=
d cases where the simpler solutions don't fit. (In this case, snprintf-like=
 is best.)

That makes sense.


> Both seq_buf and scnprintf avoid the warning because GCC just happens to =
not recognize the pattern when using those helpers, so this is just silenci=
ng the warning, much like strlcat() did too.
>
> Truncation was the norm already, so scnprintf is probably the best fit, b=
ut I think it may be worth looking at the surrounding code and conventions =
to decide if truncation should be communicated upward to the caller (i.e. f=
ail), or if the structures involved should be adjusted to avoid truncation =
chance, etc etc. If possible we should avoid the weakness, but if not, just=
 use the minimal solution here, which is scnprintf, though that kicks the w=
arning down the road...

I traced the USB/SDIO initialization paths and checked the caller's
error handling. The existing code permits truncation, so I kept v4
focused on preserving that behavior with scnprintf(). Any broader
changes to truncation handling could be addressed separately.

Thank you!

>
> -Kees
>
>

Mariia
> --
> Kees Cook
