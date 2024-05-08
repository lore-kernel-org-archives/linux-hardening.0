Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4C83CBE
	for <linux-hardening@vger.kernel.org>; Wed,  8 May 2024 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170993; cv=none; b=r7MlpKHdI4NGpQsahEhtZC8ACNQnTDbHmMiBgOo9yhFIlHqYzSwe/0TvH3i+KJWH8ydH2Emf9yj+jJfPIakGLG9155JyFXPo9ztCPG28OmuSp2Fdk3W0tPGreLkfvB5adA+H/qTQcwJ0+t1ozY3fMKW3uDIZw1QBj3dIIs29SjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170993; c=relaxed/simple;
	bh=SCE5JWU4nqxphECUgDgRgi0LtZaDC5XX2+xe9FqzcBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=cSwSg5LfrfcN9yEqvJVfPg5cQ78z+bxLLwf0bAgebzJv73utPbodRoI4BECFjUjVfGIjwbtXjACp2Y4VUIUGZReHshjT28eFuvsa+KdQrzvMqTdu96fLg8rFVnWVf5TO+4meYfwpAInV8Cwt48CtnubpcYHEKK2Oo4uYkB4CWlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-172-HAljp3vRPtmBU0n87pTUDQ-1; Wed, 08 May 2024 13:23:09 +0100
X-MC-Unique: HAljp3vRPtmBU0n87pTUDQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 8 May
 2024 13:22:38 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 8 May 2024 13:22:38 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: Justin Stitt <justinstitt@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC] Mitigating unexpected arithmetic overflow
Thread-Topic: [RFC] Mitigating unexpected arithmetic overflow
Thread-Index: AQHaoNrkK91jQ1nmYEmzGISNIfAGlrGNP8bg
Date: Wed, 8 May 2024 12:22:38 +0000
Message-ID: <e777a057e8d246efbc90381c2988b9b2@AcuMS.aculab.com>
References: <202404291502.612E0A10@keescook>
In-Reply-To: <202404291502.612E0A10@keescook>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Kees Cook
> Sent: 08 May 2024 00:28
>=20
> Over the last decade or so, our work hardening against weaknesses
> in various kernel APIs and eliminating the ambiguities in C language
> semantics have traditionally been somewhat off in one corner or another
> of the Linux codebase. This topic is going to be much different as
> it is ultimately about the C type system, which is rather front and
> center. So, hold on to your hats while I try to explain what's desired
> here. Please try to reserve judgement until the end; as we've explored
> the topic we've found a lot of nuances, which I've tried to touch on
> below. I'm hoping folks can have an open mind about all this and not
> jump to any conclusions without first hearing me out. :)
>=20
>=20
> Problem to Solve
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The Linux kernel has consistently suffered from unexpected arithmetic
> overflow bugs. These lead to any number of exploitable conditions[0].
> Our continuing efforts to improve things (refcount_t, alloc_size(),
> etc) have helped in some specific areas, but on the whole, we've had a
> relatively unchanged count of serious arithmetic overflow flaws over the
> life of the project[1]. This is not tolerable, and we should, all of us,
> make the effort needed to put an end to it in a systematic way.

Is it April 1?

Have you estimated the performance cost of checking the result of
all integer arithmetic.

If you have a cpu with 'signed/unsigned add(etc) with trap on overflow'
instructions then maybe you could use them to panic the kernel.
But otherwise you'll need a conditional branch after pretty much
every arithmetic instruction.
As well as the code bloat there is likely to be a 50% chance they
are mis-predicted slowing things down a lot more.
IIRC at least some x86 cpu do not default to static prediction (eg
backwards taken forwards not) but always use data from the branch
prediction logic - so the first time a branch is seen it is predicted
randomly.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

