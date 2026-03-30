Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764AB2FE56A
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913140; cv=pass; b=NuPv3Mw2v1PKymB/LVBwqTcOscLThpjra4N+2YB0hgzN9TKXOH1sj9WfGcUaAvj3CO16lD6aXVJxQaJKJPNAU1M0HmqCZVS/VRmgxP1PCOYQdP6a468edNHXrCrWsVkDGCsnt4q5SotH6DRd/oTqwBsCDr1+G+nnDIUHyGqoRt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913140; c=relaxed/simple;
	bh=U9Se4A611CkzIt14YY+anOFpHZCnBl92CIDU623h4BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpRmP0XdMr/Pq3ZqAYb263hmMoW0t6D+XQgYRmkeF54CNU5nPqvknjCEVWT072gFbHx7/YbLXnK51v0eAz34objuLNFZqncoeGI7aExKwSs3S5ZEF/4GC35YQlOuH0iWvEUP9mYjiLsVC9YGbHDPsVIAQP0cq+s2tMAysbVpecs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D69RRSJe; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D69RRSJe"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9358bc9c50so686167166b.1
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 16:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774913138; cv=none;
        d=google.com; s=arc-20240605;
        b=RxOPwmB9H8sAcB/QbOl7CHXRomEw0wSK0fmWNrlPQxjIFwjwyYrZ3AtHBkBct3OTEl
         JvsGRVJMo6M87iJnvpmfFWmG7nWvimJW3urwZpYtzDCAX2hLNq4KkqtF/0HBxehEOIKO
         G5nRfpTr+GdkvrnJEcRvfna2qS2vCsSdZm+iecE5uCdwLKxhs+IwY5HpT+16ECJLGSos
         TMhc1C6EBWPKwfZxJR5SzogxZlbCbl3kaY/3ltRkMDFWp1MNxYz/bCnLXFr8e0FnhNKU
         Ku0Y2HScL8GXGh8sLnqcxAgGKF0GId6iZzx8MFqL5Ur93MtRS+HovCLcfDZmQs3J6CfF
         kS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KQe7LIgffnJGhGXKGbh3dxofyfAx7h3GfdUWmKIcyI4=;
        fh=BJ++bCMcGqhsYEvzBJkDckbW0IXfXsNvhSwim0v5Q3w=;
        b=UAYBXbjCMf9+61kdLqdQuLvGyBp9xniQP6hAWuoBHdH5mhQ0kucNkAEpwCjBflGvVY
         wUu05G9hpheZ4nD1vXCRoIOJNwR6C+VYLyXi68g5RnpiOcIXiwls6CFsVcVmtx6q1hAm
         64HOjTFPvjsgdWm74zRjnfrz6mJzwHupXpgQQPzo7aWTheEe3o6+YP3MTYShKIA015pi
         +4uSl1YezFz9+tFZ8RepV3ZAv1bjRg4mJGs1Ue73Xsk+0B1Bq4Pd1eYl+7r+aoRLOQdO
         49el2Fw9N5WgxSOYnbK8b3L4U9rDH7a+za+/8h/w8JD0D4UidxD6iT78Uky64W7B/6h0
         5WKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774913138; x=1775517938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQe7LIgffnJGhGXKGbh3dxofyfAx7h3GfdUWmKIcyI4=;
        b=D69RRSJeMiuWuJLgct6spfSnGTFcLbwvkSJ1GnIKn1lUhNGnUU1qCexNDxBFLIypVN
         OpSuVc1cSdF4B5UOVc/35F792ucXl51KMGoFpqq7TonE8HybaiEXqnVRc9KS/0jOb06g
         3PbcUNWsSjNLfc+Sahaww7f6LE/prdh4sLFsKiR7YKoEkjI/9zzGIA5FzdPrkPMUTyFR
         6Az7e7wbosmlee1fTIXtQaPmZ+D6sGXnOOSy19OFLbGjLDDztcTwbr0YbYcDZzK9COOb
         uozo5ckHW+IOewLBJVI3mLri+/WPBnT1H8JiMbd1axiAYKqvnxbvqK9nsCSQD0Qi3cuS
         z1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774913138; x=1775517938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQe7LIgffnJGhGXKGbh3dxofyfAx7h3GfdUWmKIcyI4=;
        b=hkLKvAqqPykYwPCM53t9hqIqDXWpDRn4sKpc/PtNwogwyAg5jkU4zAlQJMmpkWq0hZ
         0jqHqi5ABPLO8dF/Lin7LiWld6/fhBAIRiXiNY3E3I+/KvemRAJSByQ8BNy0r8VDJ/oo
         vwQEWeDUADQuY7/Fd6iV1d1eNNTIHIH1YGROs+oZurFoj7dexXAHsXhdN2w66aC4J7yk
         rrncHOtpzRJ0Hio6CZsAwIFGrYzHo0epikbB9SK48ys8F4UyfnKxdMFBNwveXQw4eaNv
         2hj2qNu92MzThtjWNSJXSsZF2V1EEFLNYXpHp6hESYtef03JY/8A+SreSy01uJvUdGAp
         Wlgg==
X-Forwarded-Encrypted: i=1; AJvYcCUjQpBGgtsUBbaRHf7q8BR9b5BJJodNRWEe3VR4MXqkOsnM5+2Q1xNHNn6kedX3ALzRGP8vsn2VyjkIiccl62U=@vger.kernel.org
X-Gm-Message-State: AOJu0YydFIBW8tzplaMqJqIISAa134PeW3ltGm7rNuJjblEDUJg77CDb
	hwHf60hWlIgKo6bqCKkYmMjUNsgxac9OWwRN+Wet7l0zQlBWr3p0lbOAEnMztHrk9ckrBUbzgBi
	Z1xpz09+NadtCUKZZ0m/aIHJJ7CMCCOo=
X-Gm-Gg: ATEYQzyqMGpT/cZCO5nlYOd9Dn9b9AbFc2ZXPtyUxY3Sp0ZQ1muT+c4/yfJlqkjgoDa
	XS0W6hnSSkG9GuAj05apqR1Ln6wwcLuhVeJ2I2t2XcDl4Rq4Jwqalk6Cb5bMnKYcWxJpICPb+0v
	rdj+yWat8ZGscDHqiKIZuS1JG1YPtu2tZDuzc2qLX0EENqOjy4aZPG0sBFSuM02JWVUQ+yzbHrW
	R0/ekKxiLGP7v4owgD9meWPq2IobOIU+xapFbDA1iUruABESyj/o34R6hDV7PyS//G8Y4S6A+OJ
	E0lhYEGRcIW/ucPBXipXnXfPSfylAHGSxpmSoc8wfphFgWItRS0C3USaODK0kl+IN7oWe0K+210
	+3rf5DQ==
X-Received: by 2002:a17:906:598e:b0:b97:98b3:67ce with SMTP id
 a640c23a62f3a-b9b5090a95cmr623997966b.32.1774913137814; Mon, 30 Mar 2026
 16:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327024828.7377-1-rosenp@gmail.com> <20260330151536.GDacqTmBlWRznyeoMG@fat_crate.local>
 <CAKxU2N8HqFRT+qb5ctCVckC6c=viR7u+xyUaHgm-87C5=yo1ig@mail.gmail.com>
 <20260330211123.GHacrm-03xUU_3yX66@fat_crate.local> <CAKxU2N__gE-bWBU6EkJmEK2gR7VE=Va+oN6EB2hpJoHbUiYVxg@mail.gmail.com>
 <20260330223222.GJacr59uiTZzPRYbWX@fat_crate.local>
In-Reply-To: <20260330223222.GJacr59uiTZzPRYbWX@fat_crate.local>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 16:25:26 -0700
X-Gm-Features: AQROBzC_9X2S7WNOT7VfmLfjhKrAg914YdR58KojhKXZN9vQKNugt-S6dgcpwGw
Message-ID: <CAKxU2N_H4mvrJh+zgoikY8J9-u3nnWK-1dQwZanDNksoE75hvg@mail.gmail.com>
Subject: Re: [PATCHv3] EDAC/mc: Use kzalloc_flex()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:32=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Mar 30, 2026 at 02:26:10PM -0700, Rosen Penev wrote:
> > > Oh, hypothetical what-if. Yeah, pls drop all that gunk from commit me=
ssages
> > > pls and simply concentrate on why the patch exists.
> > Not sure what you mean.
>
> I mean this: a commit message should simply state why a patch exists. Her=
e's
> what I did with yours:
>
>     Convert struct mem_ctl_info to use flex array and use the new flex ar=
ray
>     helpers to enable runtime bounds checking, including annotating the a=
rray
>     length member with __counted_by() for extra runtime analysis when req=
uested.
>
>     Move counter assignment immediately after allocation as required by
>     __counted_by().
>
>     Move memcpy() after the counter assignment so that it is initialized =
before
>     the first reference to the flex array, as the new attribute requires.
Looks great.
>
> The idea is that when one reads the commit message months, or even years =
from
> now - something we all have to do on a daily basis - it should have all t=
he
> necessary information why the change was done.
>
> And nothing else. The emphasis being on the latter part. In this case, wh=
at
> this should have been and what some tools can do when lines are magically
> ordered doesn't really matter. The change must be worth to exist for itse=
lf.
> In this case, runtime bounds checking, which is something we all want.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
