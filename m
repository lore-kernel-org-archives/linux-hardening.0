Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F81E260C;
	Tue,  9 Jun 2026 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781045355; cv=none; b=Ninyi/IEaR7I8MJMyR7ZvP1WODUmoDW//ZH5RhOWsr4CaLKmJ2G0p/0mJzoC+kAOT8QWB3bOds/Drgp+swcKGBuGYbBhhXSy5/quOZlDxkshy9KpQZqSbZjyysP8rDqlEtbKbdPDsm0vsDqSOfmPD6hZq7/FYg/N6eSD6BG0kQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781045355; c=relaxed/simple;
	bh=ojXzxsaCG78mcw2mJT229q38WBPOtM9Oe8aaTMvfv4Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=P4DvQnDL+58WaraEow4q4+JjVg4alPhmtGgyLYvqGPD7HKS3FEclC+q8DNb6oCJ63pJlmk/v87/ylnakYZk1OrZgxlx4iOFV74Y0cDonwtCpIVGGeuNtLtNx9FPZ2rKFQOxwleC2yV7oEIcnv7SSac5vNflKb5Tr71rjOAWMvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is4/S0AR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is4/S0AR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F07D1F00893;
	Tue,  9 Jun 2026 22:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781045354;
	bh=DJM2TyoOZmu2GPCwNTCKg139MBSlphMJcq7NebEk6w0=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=Is4/S0ARKSAxgiP9YoHJqd6S+6crV7CHsEhibu1biFeOTpsQse6Gy1qx3gNCdCHXm
	 0goGlszamCs7myxYUrS/w/p3C7hW1suVUkG3WU7VMWHx4W+aDsix1ODy36pIzZezbF
	 4BB7EAEC1XxMSP+1IghOnugPtyMEHiz3YIbBQxR1qX9w5caulL86mWJLncAbO3jOYx
	 3DUn283r938gsl4XSfCIbd36Ct9C2810HRJPT6XgcH2iYOMbmJ9dALSD8Hw2jDcSBo
	 0jNsXzcYNPteDpxaSZpk+1rfC8sMKNP7dOUpOeYniiqHcUDsMoGYAlkbh+1V0spKd5
	 chOHLKdr491gA==
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 00:49:10 +0200
Message-Id: <DJ4VVUTU8GK2.22DI9BDCKGEUW@kernel.org>
To: "David Laight" <david.laight.linux@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH next] driver core: Replace strcpy() with memcpy()
Cc: "Kees Cook" <kees@kernel.org>, <linux-hardening@vger.kernel.org>, "Arnd
 Bergmann" <arnd@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20260606202633.5018-1-david.laight.linux@gmail.com>
 <DJ4KTIFM6YN7.3E07VW7CCJ19U@kernel.org> <20260609162258.5228eda2@pumpkin>
In-Reply-To: <20260609162258.5228eda2@pumpkin>

On Tue Jun 9, 2026 at 5:22 PM CEST, David Laight wrote:
> On Tue, 09 Jun 2026 16:08:55 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
>> On Sat Jun 6, 2026 at 10:25 PM CEST, david.laight.linux wrote:
>> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> > index 75b4698d0e58..63fdfffe1a8c 100644
>> > --- a/drivers/base/platform.c
>> > +++ b/drivers/base/platform.c
>> > @@ -617,10 +617,11 @@ static void platform_device_release(struct devic=
e *dev)
>> >  struct platform_device *platform_device_alloc(const char *name, int i=
d)
>> >  {
>> >  	struct platform_object *pa;
>> > +	size_t len =3D strlen(name); =20
>>=20
>> This could be strlen(name) + 1 right away, which would also avoid the me=
mcpy()
>> to implicitly rely on kzalloc() zeroing the memory, where strcpy() was
>> self-contained before.
>
> I tried not to do that 'optimisation'.
> Here the kzalloc() is almost certainly needed for other reasons.

This is true, it is needed for other reasons anyway. My point is that curre=
ntly
it is self-contained and it doesn't matter if the preconditions ever change=
, so
I'd rather we have strlen(name) + 1 right away.

> There is also the issue that, in principle (but probably not in practise)=
,
> the input string might change between the strlen() and the copy.

This is not a concern for this function, but let's assume it was, then your
proposed patch wouldn't prevent anything bad either.

For instance, if the string would change to be shorter than what strlen()
measured, the memcpy() becomes invalid either way.

Also, in that case the strcpy() would be more robust and vice versa with a
longer one. But again, this is not a realistic scenario anyway.

> So it is probably best practise to not rely on the '\0' still being
> there when the copy is done.
>
>>=20
>> > =20
>> > -	pa =3D kzalloc(sizeof(*pa) + strlen(name) + 1, GFP_KERNEL);
>> > +	pa =3D kzalloc(sizeof(*pa) + len + 1, GFP_KERNEL);
>> >  	if (pa) {
>> > -		strcpy(pa->name, name);
>> > +		memcpy(pa->name, name, len); =20
>>=20
>> But in general, what's the improvement? strlen() still operates on a pot=
entially
>> unbounded string?
>>=20
>> It removes the redundant strlen() calculation that is implied by the cur=
rent
>> code, though this may be eliminated by CSE optimization.
>
> CSE won't eliminate it.

Ok, but in the context of platform_device_alloc() not a huge benefit either=
.

Is there any other reason for this change? Am I missing something?
