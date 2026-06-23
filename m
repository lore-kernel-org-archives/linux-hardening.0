Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74290346AF1
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240688; cv=pass; b=aju21fgvzqRvXgYf0BFgaC7reuA9fs0Zb7mHYi4YASJI+pYTHykAyDYbyGZveDSdXxpvv48EWR8HPA1pL4ZGutEkoI5k2GGQpPl23hf/76hI0kmdCWsu31ItyZXo2fY/awgiEre49/5rSyts2J1PJeGFq2bHhJjxZ+ZkCch9rvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240688; c=relaxed/simple;
	bh=Efr1OooVVeTRTisiJfG3vsg/+MXEtgRrVmeiLqYtGck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFDGGZQwzMdG2Wv0I5RG6u125moPguuNZMl0A93cg43fXLrxZE29ToSNviA8IuIs0ckZK5egZJVy5EfEX/7GBzzTbueZBWK7bW6E70JBiKbjrQlGVOCY6Nq3R9xm1cklDPMeE0PvaoB90xSVL3jFFzZisjTg6mPGD1yxCPkdw9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKg1qICd; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKg1qICd"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6611689dc10so183856d50.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 11:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782240686; cv=none;
        d=google.com; s=arc-20240605;
        b=fWCyzY+/IcT4KKjDPZ/1t2P012+ftm6UZKR9+IpfK7GXMMqrEuqILpLiJd07dP9GlX
         afbbwbeRd81VytULoFxVJImS6IPgFQxoy1wljew/NaMCu3h0v/NEjYVkaT6LZBkzJXKH
         XKOLcX+ybxvCArt118o+jdIMPow+uZlP0XVnCzefsYuWFDbVMz+mqmMs1/NoPr73a+HS
         EeofJNuThpZRKuBwRlqW56isusJ/ch2vZB0/DeRYwoj0Eo7lh2OIwUA8KyYkkc0n7O3Q
         YEkPiMOCmEoyCGTlzLnH9fE9iJTkNm0ObFiyWxaH3E8SitSbe8A1Ro6s9FBs5QWW+X1F
         h4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QGHdQke52quudoElH5DIY+sbZKk9j5FB05lJCBdajHM=;
        fh=K/1tWDjRIBfod7iqe0yJA7xyv7ahJ3lMTCqrNf0jWPs=;
        b=SzWpR8+y4zAO8ySb6SzImxHVNlxQutg3adh/VaerJc4c14ogwRqbHZMRGrj0pngzbS
         h2jtRs9SeR9qtUv2GHPGAx/0Ol9/2CkYV3XaZOhbOrkh2tbSMiHMBoBEdRQe37wHASIF
         mVs++5fhzkjD2toX+DbsHOvXva8+GasPu8ID2lwXV9f8REfAaoTCtwR7jXTICi/nU2P5
         EBwTlyYAkQWNnoK0KUZzAcLhO7EGCP9HjO2r5khIv6hdLkAAbm3n8GvTG2T6QydYwut4
         oCcoqqWJRwO7MT0OwLb40SMGiLRCdu6VpCPjxx/q6VllWe7eGceC/AO8DnRK3le7K8ux
         B7Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782240686; x=1782845486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGHdQke52quudoElH5DIY+sbZKk9j5FB05lJCBdajHM=;
        b=VKg1qICdpjOxcsGBBOa4HZh/J0a1Gkb0EZzxvAidRzTC9Dgp3FVJETu+voTIFXZxS9
         UYFdLjMqUKDF0mxBrllAHICDgZD+qQSKxnSxU9nkMI+B/Hj3biuRvkqYLxfxBOmEFxsu
         Freiwsq4CyIepsrOIqLrOgA3rbH6vsfofjT1UFSLlkucOdTkw9LaTqURfGeZtbNV+WcJ
         ZCEVFbQktuN1ovYuqx4WIcWMn6WFtRBznePqU8AhkFJtqZ38FY3fPJJGTqE6+8tqtsQD
         TAw/ScKHLKE81rwrUg3cUbxtLBu60RT20g7JqkAs9dZa+SzGX0pB98TwZMYP37yMrdB+
         tcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240686; x=1782845486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QGHdQke52quudoElH5DIY+sbZKk9j5FB05lJCBdajHM=;
        b=e0mjxQ89y7bS5Ugeu9ij7NIIXNWCWStVLw0+lOV9QgeY8zsdQjKkWCfwjVQCLCLgJS
         Bz9mt/6UAzrtZ/3mBx7KO80yjRZkILvBpCb51QhHjwR2crCrJkQ4peYlLH2jbsAE0pVa
         lbI2YOx0J4b8Tj/2FlgTXAlAmsl5PP6F2HO0dL7Us4/ZfbUIQ35Zb3lET8sQKHSsNwbd
         bbGDQXPMcY6xFIKEfo3sYuW3z9PI5sfAjRJN8T4SKaWs3gR4fdBdNzLzX0b3bOLLQORk
         7bAlouG52xhWavZWKMpQkgFjF3x/+Wy7lIMW+v5TmGXf/yvXKBGkbikKiHTey1QWsTAX
         zcUA==
X-Forwarded-Encrypted: i=1; AHgh+RofXxF5yJkxgSIHCQT6AWpcu3yfus7YUBRcmS7Te21o494U2pckz2icoYqsbVyspjaBnivrRpMqvE6TBBdLEWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/1qaCzHwJwNBTP6tf/YU7C+58wKXxeGHKsjKwD0GSaDlst9q
	HB4uDXloQOxfH0b7fKJgU70gBARv82jScKt/YVb0mUS45M4VlhPpdqmrwa0UzxcL5CKesUF73+c
	NwqVT5cFLvbqoW0/Ic7UYZucQS1WB2Vc=
X-Gm-Gg: AfdE7clsB9xwwOssXTrM4RO+BlFqLccxr5vDta4JqUYODJxqtzRUqVinJJ/mX5P6/i+
	nNoLbmCT27yLI9BRqi6RoD7PpsUyb4qhh+H08ugtFrG7NL/pXauQGeooB7T1PG1c5+KDaVS3sKU
	iq9yv25kY7HzBwbh+ua9yTbuMMIoCqOL6QY9p1u11XXJpNk0TcIh8HNEorEMBgdGkyIeZZM/vBy
	Vxfu2rws79rvwzSNjW/maA/MYzJ2y4BAWwoIPBqtbIu9t3MJUMwuU6Y3elNwzAjm12QGbh8QjL7
	OqE8X/odby/hcBTHNWOIV6qWeQj9Ys3sxB4DyMY4IykzIa6iNw4JgtMwuXI=
X-Received: by 2002:a05:690e:e87:b0:662:f2d1:f27 with SMTP id
 956f58d0204a3-66359ece524mr3827196d50.27.1782240686326; Tue, 23 Jun 2026
 11:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622234803.6982-1-ebiggers@kernel.org> <CABBYNZ+QLvkYkn_EcBZ4+GopyhKqJLcfCoABYcw1VamavbSvhg@mail.gmail.com>
 <20260623165208.GB1793@sol> <20260623180502.GC1850517@google.com>
In-Reply-To: <20260623180502.GC1850517@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Jun 2026 14:51:13 -0400
X-Gm-Features: AVVi8CfbI5Vx_0h2Ev3jl-1KL9OujVxy8AaPvUK9sScHwsY8ABVyPNIyPnDwcl8
Message-ID: <CABBYNZKdd2-S9C1z0vtUB5yMVTWxLHi+Ta0_aUrahDYAq5rpxg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, Jun 23, 2026 at 2:05=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Tue, Jun 23, 2026 at 09:52:08AM -0700, Eric Biggers wrote:
> > On Tue, Jun 23, 2026 at 11:04:14AM -0400, Luiz Augusto von Dentz wrote:
> > > > +=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +0    AF_ALG is unrestricted.
> > > > +
> > > > +1    AF_ALG is supported with a limited list of algorithms. The li=
st
> > > > +     is designed for compatibility with known users such as iwd an=
d
> > > > +     bluez that haven't yet been fixed to use userspace crypto cod=
e.
> > >
> > > Is the expectation that we go shopping for userspace crypto here?
> >
> > Yes, same as what 99% of userspace already does.  Probably you'll just
> > want to link to OpenSSL, but it could be something else if you want.
> >
> > - Eric
>
> By the way you do know that bluez already has a local implementation of
> ECDH, right?  See src/shared/ecc.c.

It's never been audited; it's only used for hardware emulation, I
didn't even remember we had that thingy. What we really use is
src/shared/crypto.c, and I'm not looking forward to having it changed.
With something like Zephyr, changing crypto libraries every so often
just because one didn't fit on a platform wasn't a great experience,
and that is a much bigger project. In the end it seems they are using
a forked mbedtls:

https://github.com/zephyrproject-rtos/mbedtls

I'm quite sure whatever choice we make will be the wrong choice for
someone. Then someone will have the brilliant idea to add some sort of
backend support to let everyone plug in their preferred crypto
library, possibly adding even more code to audit.

> - Eric



--=20
Luiz Augusto von Dentz
