Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377796;
	b=F3/Z956cYBiQDZArHXCNeBX9b9DJZWlH0UDceYaSsoDo+y88AcENQhNWzaNVQBSwh3yt
	 3rrEkXbh7FVp9S0iHXTiVsXsBJUbLltMmhaQoRcMQZyNjjj8n5JwfvX6qZaMnec/Gjxov
	 +aLqxE9AIxNVGtiLadPIlq0yTynCxqR9PvAOEXXV90+tlxo9d+o5Zphdrr5zdP8msp8rQ
	 Ru0H27BoblJ0iC272vZeYYE7AdQx0JMF5vXJXQKX+1rOfmCOPBXQ5R6mI7i7RTn2Vblv7
	 O/mgEJc4of9pyJXj/XWsu1mcHz5zDi5KkyKlvGnKOAOLnFauw9ryhXcmVjyRlu7eFOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377796;
	h=Received:DKIM-Signature:Date:From:List-Id:To:CC:Subject:User-Agent:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Qu78FHGqGzCy9kiZsR796AchEGjJ1aDtpmSuOaJRBEc=;
	b=T/1Heqha2fceFRPPVpacXzfkg2wOnSa0CNOagg/52ak3dSe0YZTm3XOasKR7KQPsaYtC
	 S3S5pjlrCFTu2WxLLQLeTucCaiwUvMkyfYnwe74OprSnf5nYgnLxhupOYiBK/q7rXaRs2
	 yped64RjO1VwNcrIVYHrg4UkYubzeJXDe2w33eDPW2PDua3yFpzgu9P3vF+7Ei9KH7Ttc
	 92KiZzZDdtyaqJc1TYVRaq43TDARu1c2WGQzfHnNa8r1wBEOXzM1Dl50CPtBQYnMSf8/Q
	 nGqoDJUoXOtJ18H0IKsp/4Qr0HJ8Tfg/iorlurbXzc/WjInsMsGzKs4HPBzsGJTvx4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2zV3zes;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35910606A32A;
	Wed, 11 Nov 2026 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2zV3zes
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2951F00A06;
	Wed, 11 Nov 2026 06:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377796;
	bh=Qu78FHGqGzCy9kiZsR796AchEGjJ1aDtpmSuOaJRBEc=;
	h=Date:From:List-Id:To:CC:Subject:In-Reply-To:References;
	b=l2zV3zespxEVaHnYx3H3e8i9v5VSPe/xvy9Z/dy+2X+7XIO+BlF5V60QUyQxTOi8s
	 ebRr88szY5D30RJiuNXPYtYjkiyo/eZCY/ErZiHN8RVh6GOZ58map2SJSL3xMi4bjp
	 EmE86YfN5wCtU8DDvHiQaC5JMDmckXFVdj+4Cp1+0MjqSKwvVJAdBG3zlziERytifh
	 yNTQCKIHRvpkM75XlGsgwxjPg3Qx2mnQFsqwgDt6kRpWfTQVh45ktstxPd1FT9UxbL
	 X4XrmZEvjcZCLGZBerlAPkw6+khfjgpJJo/DlVuIsAXAs3iQ+jMEARmME9JDW1NzhL
	 wMWnY1DipXlOQ==
Date: Tue, 10 Nov 2026 22:16:35 -0800
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org,
 Alejandro Colomar <alx+linux-hardening@kernel.org>
CC: Alejandro Colomar <alx@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_seq=5Fbuf=3A_Mark_a_seq=5Fbuf_ov?=
 =?US-ASCII?Q?erflowed_when_terminating_it_loses_a_byte?=
User-Agent: K-9 Mail for Android
In-Reply-To: <avOp9udFzahnsmN_@devuan>
References: <20261104033110.out.418-kees@kernel.org> <ausWlN1oWc0Utnxb@devuan> <20261110220716.37bfac-kees@kernel.org> <avOp9udFzahnsmN_@devuan>
Message-ID: <84CE5129-3519-4B33-856A-5304C17596F2@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 10, 2026 3:35:30 PM PST, Alejandro Colomar <alx+linux-hardenin=
g@kernel=2Eorg> wrote:
>Hi Kees,
>
>> Date: 2026-11-10 14:07:24-0800
>> From: Kees Cook <kees@kernel=2Eorg>
>>
>> On Wed, Nov 04, 2026 at 12:28:27PM +0100, Alejandro Colomar wrote:
>> > Please include:
>> >
>> > Cc: Alejandro Colomar <alx@kernel=2Eorg>
>> > (or perhaps a second Reported-by=2E)
>>=20
>> You were Cc'd=2E :)
>
>Yup; what I meant is please store my name in the patch body, since
>I want to be CCd if anyone looks at this patch in the future=2E  :)

Ah! In that case, you might want to look at using lei to deliver arbitrary=
 queries to your inbox, which doesn't require depending on inducing other p=
eople's email clients to send to you (which even that goes awry when get_ma=
intainers isn't used or git history is ignored, etc)=2E

https://people=2Ekernel=2Eorg/monsieuricon/lore-lei-part-1-getting-started


--=20
Kees Cook
