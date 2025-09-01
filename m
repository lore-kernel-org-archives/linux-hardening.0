Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E031DE2A0
	for <linux-hardening@vger.kernel.org>; Mon,  1 Sep 2025 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733880; cv=none; b=jDcbNqayl5fHE9/4lhLiIKMzHOBG3mmHsKAvo2sDysK5sObms+DRmVLacRIkZWHDHJ642w1K0UkvAegSvP28ZYhHvDdTcum0L99inOd5fq+lYXmAnBUz77LqbGBVBfYjO48YyO8OO4Hh7Eih6po+Qhd9XX9ZIQEQDlpULzf4OGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733880; c=relaxed/simple;
	bh=hrOpoT0rQITjPUp/2qofb8QBO/j7OL9xreW+ARhc3Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAoPyjCJggf/JGGBCg+78/Y/Q1i7QbDEOF1KD7+5f/Yf8a0Nfr6xpUNXpEou38xDFy5yGW+YSjLZx6sxtYSy+DrcUSjZaIBxDwkv/x5AN94CepNiZul3BzmnJC6lNPszPs0UxusWduHdBGgJIrEGoCDwVid7iMFuUfcfdF/9FE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a0ciY1zx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a0ciY1zx"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b7ebe667cso26403425e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 01 Sep 2025 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756733875; x=1757338675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJRnO5UD7YZuruV+flUIcQufYW0xYHWGkTcWe05GDI8=;
        b=a0ciY1zxZvtt/WTRQrkpZ2xf5oXOMfOlTiwfvACLXSAGR/ypY3zqx2OYdr+Nkwuwoo
         UYwd77JWurgCVqo7/h5Zcf8NPFVeEcYR5JSJdKp+VvDN8DpoyYcIvBWZlWsQLovDwv8a
         BF55yth5Z5k/xCgRsQepkF9ETQq0dxOPrOspOqWAzPXMPST4F6Gu35FsBDMEUv1nT6Ta
         /M6UN/k0I/ErkbtcOraMS9stzga5iFhvMDSP2vS0MC7tbqkkOoW5l4pzyJZUeLcIjxET
         OmSxAcifWkmBtTHjG0Bsa5H/4MosmdOwe4GuTGxORDoesghEbcFY9xXzOOLfrpdxB0bO
         EH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733875; x=1757338675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJRnO5UD7YZuruV+flUIcQufYW0xYHWGkTcWe05GDI8=;
        b=nP5A845AkHyGZ5Bx48247SOU4KnVOYAJTR3bIrSZ/7Ol1+AehXNiTPZ5PsocpLF0Vj
         VJFIsWPJf8mImjlZrCZMGlPppW+wMen1+b5kbCNRkSU8QydPh9zMB+ejxc2aEVIRo0N1
         x4kZTXi8zDCffr79xzIfVL5KKqQz5EYiKueJjDekOziYs2NHErYgYSMOuo1aQ8+/qJvM
         OS4SLdaNyg7949QUWpYcLh6SPmXwvh2ahhxIH4emHBoKt7yc/R8pUyMM5Fbpegmx/U24
         3r+3i79+Fc/NalIKlJz6+jIeROnFELVxvgUd5DVOYKMYbGCZt+zKZzDchxxbwYkErhvX
         /1eg==
X-Forwarded-Encrypted: i=1; AJvYcCVRTEz6BePTcV1v8lp2sO4l1jt5HxfpI7L15c3oUTvhNsXs4KtUuubICreg8NDMz59GtjIqL5i9fp0y0vmAN9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/LGchIKnGkeRsbBXrLTG7pgSl+pq8T9lW/WgnoVR4iu1Sot4
	wFpRA7HqucC7aECcknls7HCn9k3Cq6/y5dhZ+UpZ0/4intdoInKMleVuixk/RjcHodk=
X-Gm-Gg: ASbGncvUVKZUAlBxPaoiB5IgXafH0qa7NytkBe8daMq6Vt6o5vC5ixKWBJA6UO/yRc+
	kZMkOfxvaEbqdXIuoYBqBq/RnAHAokK09D/6iT+ztH9UlLTCx3N5rfGJCbdX6Oq+aRNpEa7ZwMJ
	VnK3Fi10bbuoQvFQG4/bdoSLR2x+CH0eMyvRfTUQU7+KBzdLtGtgbM+EpqY/pLFL//QOsMq+2Jz
	7yxyb5v0s4be7xRluzGAlFz5QgE3ON9rwRq2GXv2RjEFct6uQV41pyJHidR5GyZH3znOPIqfx48
	ofn752i8s9UrJKicH5wvDy0kLvVYqckK1+B4JpmOXwaYQ3aG4dekakFA1gKpB8I55r52VhuLqHZ
	aM+uIKaH5BTAiEpUO64feAwAhX/j+6Roma41yy9FfQ45gH1ZeiwdXZQ==
X-Google-Smtp-Source: AGHT+IFv2pHF60bsj9gEg82i475aoJnNBxx1riwOpUVOZgBEMlNs+m1YOElvTU1CshvLDpIwNvyw7w==
X-Received: by 2002:a05:600c:c1c8:10b0:456:1156:e5f5 with SMTP id 5b1f17b1804b1-45b85e42eebmr47046545e9.31.1756733875227;
        Mon, 01 Sep 2025 06:37:55 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33add504sm15216852f8f.30.2025.09.01.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:37:54 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:37:53 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Message-ID: <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ovh33ndv7ladsqzs"
Content-Disposition: inline
In-Reply-To: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>


--ovh33ndv7ladsqzs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

On Sat, Aug 30, 2025 at 03:30:11PM +0200, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> Based on the comments above, it seems that the original code was expecting
> cgrp->ancestors[0] and cgrp_ancestor_storage to share the same addres in
> memory.

Fortunately, it doesn't matter what the address of cgrp_ancestor_storage
is. The important effect is that cgroup_root::cgrp is followed by
sufficient space to store a pointer (accessed via cgroup::ancestors[0]).

> However when I take a look at the pahole output, I see that these two members
> are actually misaligned by 56 bytes. See below:

So the root cgroup's ancestry may be saved inside the padding instead of
the dedicated storage. I don't think it causes immediate issues but it'd
be better not to write to these bytes. (Note that the layout depends on
kernel config.) Thanks for the report Gustavo!


> So, one solution for this is to use the TRAILING_OVERLAP() helper and
> move these members at the end of `struct cgroup_root`. With this the
> misalignment disappears (together with the 14722 warnings :) ), and now
> both cgrp->ancestors[0] and cgrp_ancestor_storage share the same address
> in memory. See below:

I didn't know TRAILING_OVERLAP() but it sounds like the tool for such
situations.
Why do you move struct cgroup at the end of struct cgroup_root?

(Actually, as I look at the macro's implementation, it should be
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -110,7 +110,7 @@ enum {
                struct {                                                        \
                        unsigned char __offset_to_##FAM[offsetof(TYPE, FAM)];   \
                        MEMBERS                                                 \
-               };                                                              \
+               } __packed;                                                     \
        }

 #endif
in order to avoid similar issues, no?)

Thanks,
Michal

--ovh33ndv7ladsqzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLWhqxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Aiw5AD/WjNnIRij7kR4aDTHZCH7
vzJ6lYELo8G6AfXsjqYtUbcA/2ayENeSaMr743JSAr9CRnOqwlPR9lH/vzAo6qt1
c+UC
=BQTW
-----END PGP SIGNATURE-----

--ovh33ndv7ladsqzs--
