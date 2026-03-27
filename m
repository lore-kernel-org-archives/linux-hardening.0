Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCC35CB9B;
	Fri, 27 Mar 2026 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612265; cv=none; b=jLyJAX8Kesd+TTD0itE/CMG4cniP3DFKPEySNeIqcEFoRMk3GUOaYShKyQYBCECou+pDkmIPXArZ8fXWTzrmsFOjs3LOjQL1391qL4LqSNQRv23WrlFo34Mpa60jSr2nuErZtP/kX6EvNh03XhW/rqC8eweFztdMFF/kZXRGzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612265; c=relaxed/simple;
	bh=c47Np3ItykOmvwA2YBPjVWcBjYeHDT5Fbgfh2PkrDu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=G4f0dhiSCecaOJD78rcus+voLl7VAbU+87833A0ssOJOodQWDlOUApshJni8OySkOmL7eeiyOfZ9hDpoduv85I5urLGpeo8BSN8S9rrZenEFTQFH+QfnCJqtt0wDdCNOYIulGxd2Mz7ZoajqTgeM0y1y1n9/6VD0JYuVWvvHDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tbu+2wQ7; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tbu+2wQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774612243; x=1775217043; i=markus.elfring@web.de;
	bh=kuUt8Zgd1KdSLSIndFK+l5jlSHlVaYEbsEFIyhEkW9g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tbu+2wQ77d7oNJO2WQUSkra221vOSMEWW7S8ZocO3aPtqNerRjc0dGN2Qc6aviUF
	 uA/lWCguXAvC+tTWpxBElk4kEpA8Qr6mkGA2bwwODs3m9IYHDSQgqvgAL6D7GGNty
	 bew4xrcmqYNihHHFULVX3gjyWeR8HZvdHMWmeJ0cdaHqHunz3xpTC5eCfI1QjBlld
	 5035YXPi6F4dX0FeCUKvfdQuI6L3Idw2nR1QX0gYkgKNmw9gwfZbegFSVoB3CDJty
	 IBDFKshllHy08belXpZ3m9TX4l4pYgodUADb0kWYLPKsj+VZc4+v6zrZEw8QjjmXl
	 o4EIf0O52t58iDGykg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtyA4-1vGS232fgC-011h4O; Fri, 27
 Mar 2026 12:50:43 +0100
Message-ID: <e4c0b6a4-bde4-4c1f-ad56-aa05eb3229ac@web.de>
Date: Fri, 27 Mar 2026 12:50:42 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH] coccinelle: kmalloc_obj: Remove default
 GFP_KERNEL arg
To: Kees Cook <kees@kernel.org>, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20260320175113.work.016-kees@kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <20260320175113.work.016-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aj1If+SBYjMhzC6j7vKZdGr6D0nwReT/33NgqhPlBFUiWAK54/i
 qvefk+wQUEBZevShdAvS4fWPSRS70vVJKvNk7KgAdrD9P0F4wJwftYdTfEbriKeICea/sfW
 vz+kH+8SZuqpp21S36E0P8sTERmKhQgk+ZPjXvuexf1TseeIdLnrV9NgK7B9vnMwOYKnUNE
 Hj5rMewp0OI1/H1Jw/pRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kEHwjVHNdsc=;UiUYcfDWMrULnGpAkJlkv3WTAvj
 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

=E2=80=A6
> +++ b/scripts/coccinelle/api/kmalloc_objs.cocci
> @@ -122,3 +122,14 @@ fresh identifier ALLOC_OBJS =3D script:python(ALLOC=
_ARRAY) { alloc_array(ALLOC_ARR
>  -	ALLOC(struct_size_t(TYPE, FLEX, COUNT), GFP)
>  +	ALLOC_FLEX(TYPE, FLEX, COUNT, GFP)
>  )
> +
> +@drop_gfp_kernel depends on patch && !(file in "tools") && !(file in "s=
amples")@
> +identifier ALLOC =3D {kmalloc_obj,kmalloc_objs,kmalloc_flex,
> +		    kzalloc_obj,kzalloc_objs,kzalloc_flex,
> +		    kvmalloc_obj,kvmalloc_objs,kvmalloc_flex,
> +		    kvzalloc_obj,kvzalloc_objs,kvzalloc_flex};
> +@@
> +
> +	ALLOC(...
> +-		 , GFP_KERNEL
> +	     )

Would it become helpful to clarify the software run time characteristics a=
ny further
for the selection of mentioned identifiers?

* SmPL disjunction

* Regular expression


Regards,
Markus
