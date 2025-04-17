Received: from mail73.out.titan.email (mail73.out.titan.email [3.216.99.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5EE187553
	for <linux-hardening@vger.kernel.org>; Thu, 17 Apr 2025 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.216.99.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744863679; cv=none; b=arnzlQ1B2SjZQtMQ5B0jmXdqwnJIf6Jkb3G8rcW4EWpUBxZcy2/k5J+g8yoyzgwGr/kqhUvDq3RyNdeAiIkG0mNEGsNMpUK2c1794XRt8BIxjAUhA0IEvVXTe7K7mfkzzdSuGgd0xtNm6Wfk9XrvSI13wM2lK1fGhCqkY2r90Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744863679; c=relaxed/simple;
	bh=je5kHSSnufjqTKCgwgXuGoPvDg8Uz6nSgVL5zslmj6E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o3gtL1O5laxebKbRTKV/Mmb12Eg47VnxBl9qmkJhFlW8Hym2QoSiuf4ePu1pEqLixLXVs8Sz39479WxkorIAOeF2IlGHuj2djZnUT3OIMgZeztQO2/MNaFn80PrXRd339Z6crwBDVpWUQDt4H/LZzHkHBAc4RmvqHJOB9Wd04tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=HoNHf5di; arc=none smtp.client-ip=3.216.99.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="HoNHf5di"
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 7D2AF600FF;
	Thu, 17 Apr 2025 04:13:27 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=bonw2XKlbtQF6o1d2G05Q1zuohCV/u+ShQz20KaAxq0=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=date:subject:to:in-reply-to:cc:references:from:message-id:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1744863207; v=1;
	b=HoNHf5dig4nrUUVShSL+/oYC5WP0DwlrfLH8UAo0ggu4o0BSSBsgfSmMZlkoQcyyA34PlaTo
	c/HvT+FX2ejX0dOxCGAGFcfHt9huJqLHMsWvXFS7vHmXU+BCmJn65ChdWjaadmbxu5w59PxYX4n
	RDkGq00FOCJxZlanjE4MTdR0=
Received: from smtpclient.apple (unknown [141.11.218.23])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 22D556006D;
	Thu, 17 Apr 2025 04:13:24 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] md/bcache: Mark __nonstring look-up table
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <20250416220135.work.394-kees@kernel.org>
Date: Thu, 17 Apr 2025 12:13:12 +0800
Cc: Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 linux-bcache@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <24407A22-09EF-4A40-A624-181EBC28D35B@coly.li>
References: <20250416220135.work.394-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1744863207368998089.5242.1435551937388604544@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=O7TDvA9W c=1 sm=1 tr=0 ts=68007fe7
	a=USBFZE4A2Ag4MGBBroF6Xg==:117 a=USBFZE4A2Ag4MGBBroF6Xg==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=HI0Xfd1PG7h-CoJmVSkA:9 a=QEXdDO2ut3YA:10 a=dkNG5E8fUEMMZBEGMw6M:22



> 2025=E5=B9=B44=E6=9C=8817=E6=97=A5 06:01=EF=BC=8CKees Cook =
<kees@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> GCC 15's new -Wunterminated-string-initialization notices that the 16
> character lookup table "zero_uuid" (which is not used as a C-String)
> needs to be marked as "nonstring":
>=20
> drivers/md/bcache/super.c: In function 'uuid_find_empty':
> drivers/md/bcache/super.c:549:43: warning: initializer-string for =
array of 'char' truncates NUL terminator but destination lacks =
'nonstring' attribute (17 chars into 16 available) =
[-Wunterminated-string-initialization]
>  549 |         static const char zero_uuid[16] =3D =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
>      |                                           =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Add the annotation to silence the GCC warning.
>=20
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Coly Li <colyli@kernel.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: linux-bcache@vger.kernel.org <mailto:linux-bcache@vger.kernel.org> =
 =20

It looks good to me. Thanks for the fix up.


Coly Li



> ---
> drivers/md/bcache/super.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index e42f1400cea9..577d048170fe 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -546,7 +546,7 @@ static struct uuid_entry *uuid_find(struct =
cache_set *c, const char *uuid)
>=20
> static struct uuid_entry *uuid_find_empty(struct cache_set *c)
> {
> - static const char zero_uuid[16] =3D =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
> + static const char zero_uuid[] __nonstring =3D =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
>=20
> return uuid_find(c, zero_uuid);
> }
> --=20
> 2.34.1
>=20
>=20

