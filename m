Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981164;
	b=kRa/sGTFldmHXKYyWotQnGo80JI6+vBI2J3Pz8aZDiOWXaX6ck1eJEmwKI2w6Taewh/x
	 aQ+CeWqrsQYdlYQFhSd7XUZQITRiPSGLintsSFr4cv8814j2qZejM3fJTRl1NUyejEZlK
	 EMpXKgEmdvoSqdO5lStBo2svYa180jhhgrgd6L7RungzTBGY1yf6eNjZEiWh8GRwD7mwQ
	 rtMQrFlZbAiViUeMB8KSxOsypKKpD/n2DqJ1ijzTEM+oHGBYP1+frsNAUyoeO+WOhv0Qt
	 1HNozvBm4KSV7k3claJcqquXayZmmNw60LmKk01aPe8AAdN2hkxZ4fAj6DY8U2wSH4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981164;
	h=Received:DKIM-Signature:Date:From:To:List-Id:CC:Subject:User-Agent:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/mhag25y81gUMkrL3EENy8sQBewx7mU++psw5ygJKWg=;
	b=rABduRXZPpJWLYMittmgOWvgCngFNCuBe7+mpDVpYH2SNARyp+fbh1lJXcFVs7uZALgg
	 iP/2x/4xzrs4HIbdU8bt4y1Hvix17RTIgmTOlvyJDETI6MKELBE8sHfBRVUHVTnsIspa5
	 Fhz46nMQMOX4i8UOebbnhji9L1uKwsy+Ie62Bs4DJ3FycmVoPNi0IkEdcnvi3gxhfO1W8
	 8ghpLFLhTjm5HpFw0hLzFKCzs6X2wJJj2yp2w+9ET5jO8DFYofkgvv37oZVSUZxmB8X+v
	 qyc5qlYWrdSHXjO4z1z6MIu6rWWSowDOm7V61hLrdpe9weiK71kEt7tWinMmBBi2LwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZV1/1gBT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909D606A329;
	Fri,  6 Nov 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZV1/1gBT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3FF1F008A7;
	Fri,  6 Nov 2026 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981163;
	bh=/mhag25y81gUMkrL3EENy8sQBewx7mU++psw5ygJKWg=;
	h=Date:From:To:List-Id:CC:Subject:In-Reply-To:References;
	b=ZV1/1gBT0ez6/v4J7hq0Ek6jYvfhONe+zTr8ay8eTFQXGo3nbEpm7nEbf1+yqfI5l
	 oicQM/WRSfW6b8NbtZlCjiiTzu1iUWryTYI9fooONaH5cTKgu6E5VCFvapuQse699i
	 1hW5LwFN9ExmliYnhW+b2FCkA55Be3xMx004p/NvwxEwAMPo1D/gjpXomSPrhG0awG
	 4tI1Ui0DBFcAFwq13o2rla090EJwGx3NM8maMgsc8cLDgFYZurumq51Aa7nny1d6ZM
	 F/+jz5ceBo3Gm7xSi/784uBbzpNghe8541SH8qJ4ebFbaa97n+ba0FmXXtTXIdmaK3
	 hG9tkKNeuu/qw==
Date: Fri, 06 Nov 2026 08:06:02 -0800
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>,
 Mariia Nikitash <nikitash.mariiaw@gmail.com>
CC: Alejandro Colomar <alx+linux-hardening@kernel.org>, mchehab@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, justinstitt@google.com, morbo@google.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_media=3A_siano=3A_Replace_strl?=
 =?US-ASCII?Q?cat=28=29_with_snprintf=28=29_in_sms=5Fir=5Finit=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20261106102723.1cc4d350@pumpkin>
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com> <ausVkYs1-3rJ5Fj0@devuan> <20261105113229.4126d872@pumpkin> <CAPDEY+X7q2yeWaa7J=Nre+pQqUa2C760Hh9NovdGNSQ=VsEr8w@mail.gmail.com> <20261106102723.1cc4d350@pumpkin>
Message-ID: <1EAA42AE-92F8-4CB7-B490-CDB6DA9FFCE9@kernel.org>
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



On November 6, 2026 2:27:23 AM PST, David Laight <david=2Elaight=2Elinux@g=
mail=2Ecom> wrote:
>On Thu, 5 Nov 2026 17:44:00 -0800
>Mariia Nikitash <nikitash=2Emariiaw@gmail=2Ecom> wrote:
>
>> On Thu, Nov 5, 2026 at 3:32=E2=80=AFAM David Laight <david=2Elaight=2El=
inux@gmail=2Ecom>
>> wrote:
>> >
>> > On Wed, 4 Nov 2026 12:25:17 +0100
>> > Alejandro Colomar <alx+linux-hardening@kernel=2Eorg> wrote:
>> > =20
>> > > Hi Mariia,
>> > > =20
>> > > > Date: 2026-11-04 01:02:39-0800
>> > > > From: Mariia Nikitash <nikitash=2Emariiaw@gmail=2Ecom>
>> > > >
>> > > > In preparation for removing the deprecated strlcat() API[1],
>> > > > replace the strscpy() and strlcat() calls with a single snprintf(=
)
>> > > > call to construct the IR device path=2E
>> > > >
>> > > > Both the source and destination buffers have the same capacity, =
=20
>> > >
>> > > The line above seems irrelevant, and potentially confusing=2E
>> > > The size of the input is not important, because since we're appendi=
ng
>> > > stuff after it, truncation may actually happen=2E =20
>> >
>> > And gcc's stupid format overflow check is going to complain=2E =20
>>=20
>> Thanks for pointing this out! I initially tested with Clang, but reprod=
uced
>> the warning with GCC=2E I've switched to seq_buf for v3=2E
>
>That is entirely OTT=2E
>Currently scnprintf() doesn't complain=2E


What does GCC say about it? Is it mad about src >=3D dest length but the f=
ormat adds chars?

I agree that seq_buf isn't needed here; that's really only for complicated=
 cases where the simpler solutions don't fit=2E (In this case, snprintf-lik=
e is best=2E)

Both seq_buf and scnprintf avoid the warning because GCC just happens to n=
ot recognize the pattern when using those helpers, so this is just silencin=
g the warning, much like strlcat() did too=2E

Truncation was the norm already, so scnprintf is probably the best fit, bu=
t I think it may be worth looking at the surrounding code and conventions t=
o decide if truncation should be communicated upward to the caller (i=2Ee=
=2E fail), or if the structures involved should be adjusted to avoid trunca=
tion chance, etc etc=2E If possible we should avoid the weakness, but if no=
t, just use the minimal solution here, which is scnprintf, though that kick=
s the warning down the road=2E=2E=2E

-Kees


--=20
Kees Cook
