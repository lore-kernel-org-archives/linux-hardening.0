Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0112E6CB1
	for <linux-hardening@vger.kernel.org>; Mon,  1 Sep 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749491; cv=none; b=HqMtociYf6pIl912x5FQfLpbkFAc0uvAfP5s18ftXmYgeBl/pensGHzqLyyNbZ+7Ac2xj42GhORa+X7J0Kw0CrzZsNnaMSJcTxZNSYmjwlWWCmR25ztCW8ol8wUFrkXl71CkBVW1uqF1B7Lg5xj+0vGJeg2Mc9IV1ql6StwoC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749491; c=relaxed/simple;
	bh=3byL/Fj0HJ/ZBpYR43St9uLQGKkKDjP2v7oMiVkvnmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8/1DYAZYZrT9W8+a/SvgUlWajSp8mrgquX8FiiYyXoPZjpeMdwx/5fxoLr0PYDEh/s1LVS1yck2SmIii//ICF18fsquswa6KY18291gxF4seRdHUXbE+IQ60cuYZauiQAWXxOacPDOrSH8P16NkktTgIVeS3wlsn8UiSi37WmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZG1gY2ut; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZG1gY2ut"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ceb830dd58so2536915f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 01 Sep 2025 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756749488; x=1757354288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBrUlowGaoMISX9iJ5RVVV/ygG/eI+RUk2vTf+rH8qI=;
        b=ZG1gY2utY2Efkm9aWHKJRfTIui1Gpb1ubIUJp2PsMFnYGvHfo7FgdKlKFkMLwS12P6
         Q6tPJ+pQpOwa2CP4AkK9HSBhskatqOmM1ymsUHD7Dw0amPtUUIjwgMQ9MoHVxEX+yIN5
         X0oX1wTTonJmb5MYRiwHjaPuqmgRdmYXHvqhl2xG9iq8xc575YDtiKMqe3ID4VqlPQqA
         qNU28X+CUp8gUzVX3kXtoGHyYszGnLUu72AY4SuQhDun9NIKXM2Pjk3vTKE3eYDbFEjl
         xMP04CV710kMyP/EkIHiAzUJnsjg02lvE5fEkx/5CgAr5TGuwItnRkK30vUY7ILFnbHO
         pW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756749488; x=1757354288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBrUlowGaoMISX9iJ5RVVV/ygG/eI+RUk2vTf+rH8qI=;
        b=sBs5EsYOv5nZgWcGd4osMwX9VJLpyoTVUPLNFUgxKoA7HXxiAGTQxWeKkW6eUO9LSK
         TYceEv67aVfy0AF51XwnHV5TWPENy6wGzLQLKszAf27XSA7fQpzhzP0e0bZs/+3QoALH
         lIEo/B4kosCIwE38PqzrT1mBbwR7KpCEOdZ8hdKTdxSdjM2SN6IQCAvPz5hOBMgbbfZL
         tfw+vX2lrMSX+30pvjvcGl2uykSmDyAKPC8zZz8W9Vwv0B7rOG+D9GdgTIc5ytkkQpMY
         pGRp52qhhiQeyUHHOnKgtVi9XxrkTHWgRzNpxaWb5W8zsNe4Q5fSwEvEjaNoel1qL01P
         7LlA==
X-Forwarded-Encrypted: i=1; AJvYcCW14BJ4UqRYhqqBVE+B6TAmudikw5jQCym5OqNkI8rFHJiIZNFNJ6yMTvUpDgkpFtFA99WyItNxt+FJrxgVuqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JgtEzdcE7HmGLP/VtwDjiQ/KOADlf/NdNXBvEdDQPiqdKdeH
	JeWV2BlhrWB+42Vsf2uSL5IEXKjGsfh3Vm4CzkzQOr7u3V5odb4UUDX35V04M/7rC+Y=
X-Gm-Gg: ASbGnctlHOxsm2jP9KaOCEZUfLgM8ZUeO1vsYeXvW/8qJd1H1/aXa09utlvjLRW8x2w
	3iG0m/wkbtbrCR0eOSuqw0zCZkRvPEi9IqDUMYYeqXba+tcGA63jRx4/qUkoIKDIzZLrEn/QTaz
	PR8h1FMfSfva9BCAIyCGF1HvygqFGuqnGVgzZIFNudJd/omdqqWF8JHx45RBHOaTsEexqwcY2ag
	S1Si3epeo6CpE9IuRYVMpRexR0YtXUdTQLKsVuVk6G07SucLwu2/0ppaKt0Kh1S5lh5bBuse2OM
	EsgJcJbAVJLmko47D1Uy1h+RJ7vrRuKRVnmEyXSrNiuNifeR7r2+0FD5RbJmiaZVLDmvJngjqK2
	3QLoo9qDhSDS2f9XhshDx9ldxtX+fH2gfgFGzxCawMdsQzf3l8oWP+Q==
X-Google-Smtp-Source: AGHT+IEKDAoZsVvcs49zoW6IewZ0iCEshtHwmKL7QaW26/0FEP2utdDdAE4fZYnG+d5xmXCXfom+zA==
X-Received: by 2002:a05:6000:1ac8:b0:3c7:244:a4be with SMTP id ffacd0b85a97d-3d1dd04e24bmr7849050f8f.10.1756749487957;
        Mon, 01 Sep 2025 10:58:07 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34491a5asm15994104f8f.55.2025.09.01.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:58:07 -0700 (PDT)
Date: Mon, 1 Sep 2025 19:58:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Message-ID: <y7nqc4bwovxmef3r6kd62t45w3xwi2ikxfmjmi2zxhkweezjbi@ytenccffmgql>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
 <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lkdsthcjr73q7k4e"
Content-Disposition: inline
In-Reply-To: <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>


--lkdsthcjr73q7k4e
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

On Mon, Sep 01, 2025 at 05:21:22PM +0200, "Gustavo A. R. Silva" <gustavo@em=
beddedor.com> wrote:
> Because struct cgroup ends in a flexible-array member `ancestors`.
> This triggers the -Wflex-array-member-not-at-end warns about. So,
> while `ancestors` is indeed a flexible array, any instance of
> cgroup embedded in another struct should be placed at the end.

Oh, so TRAILING_OVERLAP() won't work like that?
(I thought that it'd hide the FAM from the end of the union and thus it
could embedded when wrapped like this. On second thought, I realize
that's exclusive with the static validations.)

> However, if we change it to something like this (and of course
> updating any related code, accordingly):
>=20
> -       struct cgroup *ancestors[];
> +       struct cgroup **ancestors;
>=20
> Then the flex in the middle issue goes away, and we can have
> struct cgroup embedded in another struct anywhere.
>=20
> The question is if this would be an acceptable solution?
>=20
> I'd probably prefer this to remain a flexible-array member,
> but I'd like to hear people's opinions and feedback. :)

I'd prefer if cgroup_create could still work with one allocation only
both for struct cgroup and its ancestors array. (Cgroup allocation
happens many times in a day.)

The increase in struct cgroup_root size is IMO not that problematic.
(There are typically at most CGROUP_SUBSYS_COUNT roots with gradual
trend to only the single cgrp_dfl_root.)

Note that it'd be good to keep it enclosed within struct cgroup_root
(cgroup1_root_to_use could use struct_size()), however, the
cgrp_dfl_root would still need the storage somewhere.

HTH,
Michal

--lkdsthcjr73q7k4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLXeqxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhNuAEAjKx0omIrhaMBlA3ec6KY
kqg6f5iLg7LyrRkia3U31fMBALYGUaC9K1uFILkO5S/s3uVVR4mEqpN44csiQoP0
Y/kP
=jkIf
-----END PGP SIGNATURE-----

--lkdsthcjr73q7k4e--
