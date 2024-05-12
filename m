Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D5D2E620;
	Sun, 12 May 2024 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715542172; cv=none; b=hzVr6fuPA3o5uab7U6KCNfWSzbZT4pixdg5zRbWVrObTjOmuiYYBsEGxcOBUkl0NMKW5MS69bfsg2PHidFAN4EjjYGvP+2tAuHvrg4EGgm9CrL+vJZIl2TAwvOeXakw+DWkvQJtBpy7AGQ/CgQpvbWGUtjihsPwYJqMMU6TsB8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715542172; c=relaxed/simple;
	bh=0ExzLgblqzmDHiUjeSC2Nc/o1fm2eFgt9HoCEtCkHII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQjtTFFO6f72ONcuGFqDYXeMWuMepd9gjB4DvOw6NE7weaPAKd/wRj9RNsZ2YZciu2yp8XOEZkBoYxhEsId4Kf9Da4jps0OEegrIGssKJfImzuIRSXy1TQMmw3tH2QTB+6BZnyhHRFSZ/wVHuL3n84VT4s87BkwtwpFRvDC3FFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=lB6ZKZjZ; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="lB6ZKZjZ"
Received: from [192.168.0.221] (84-115-223-216.cable.dynamic.surfer.at [84.115.223.216])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Vct3H6HvGz1LLyr;
	Sun, 12 May 2024 21:29:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4Vct3H6HvGz1LLyr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1715542157;
	bh=2vPSVIunDDlKuMQTdFhwiPn7E9OmRNU/PnrIG9JkJSM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lB6ZKZjZVcastT2NMUDE3JNMNIOzAOPsWlh2wGaecybw8km35qIhLEIv/ULB4kyRU
	 qzGl3Ls59VKxAY5FEej1zci2qRO4X/CFiYAaTzTdhMfY4v+nBmfRBXa0hsjk4OOWxs
	 AevH302tCWA99T+2LWUmpyasOEmuHV0NBe1XH2oQ=
Message-ID: <bf7539e0ccb8f445984fe6dab0d7d8392a79880d.camel@tugraz.at>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
From: Martin Uecker <uecker@tugraz.at>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Justin Stitt
 <justinstitt@google.com>,  Peter Zijlstra <peterz@infradead.org>, Mark
 Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date: Sun, 12 May 2024 21:29:15 +0200
In-Reply-To: <CAHk-=wjERv03yFU7-RUuqX1y89DYHcpdsuu++ako2nR41-EjYg@mail.gmail.com>
References: <202404291502.612E0A10@keescook>
	 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
	 <202405081144.D5FCC44A@keescook>
	 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
	 <202405081354.B0A8194B3C@keescook>
	 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
	 <59f731ab619673afec4956fce6832a1cd5324fb8.camel@tugraz.at>
	 <CAHk-=wjERv03yFU7-RUuqX1y89DYHcpdsuu++ako2nR41-EjYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: -1.9
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116

Am Sonntag, dem 12.05.2024 um 09:09 -0700 schrieb Linus Torvalds:
> On Sun, 12 May 2024 at 01:03, Martin Uecker <uecker@tugraz.at> wrote:
> >=20
> > But I guess it still could be smarter. Or does it have to be a
> > sanitizer because compile-time will always have too many false
> > positives?
>=20
> Yes, there will be way too many false positives.
>=20
> I'm pretty sure there will be a ton of "intentional positives" too,
> where we do drop bits, but it's very much intentional. I think
> somebody already mentioned the "store little endian" kind of things
> where code like
>=20
>         unsigned chat *p;
>         u32 val;
>=20
>         p[0] =3D val;
>         p[1] =3D val >> 8;
>         p[2] =3D val >> 16;
>         p[3] =3D val >> 24;
>=20
> kind of code is both traditional and correct, but obviously drops bits
> very much intentionally on each of those assignments.
>=20
> Now, obviously, in a perfect world the compiler would see the above as
> "not really dropping bits", but that's not the world we live in.
>=20
> So the whole "cast drops bits" is not easy to deal with.
>=20
> In the case of the above kind of byte-wise behavior, I do think that
> we could easily make the byte masking explicit, and so in *some* cases
> it might actually be a good thing to just make these things more
> explicit, and write it as
>=20
>         p[0] =3D val & 0xff;
>         p[1] =3D (val >> 8) & 0xff;
>         ...
>=20
> and the above doesn't make the source code worse: it arguably just
> makes things more explicit both for humans and for the compiler, with
> that explicit bitwise 'and' operation making it very clear that we're
> just picking a particular set of bits out of the value.

Adding versions of the -Wconversions warning which triggers only
in very specific cases should not be too difficult, if something
like this is useful, i.e. restricting the warning to assignments.

>=20
> But I do suspect the "implicit cast truncates value" is _so_ common
> that it might be very very painful. Even with a run-time sanitizer
> check.
>=20
> And statically I think it's entirely a lost cause - it's literally
> impossible to avoid in C. Why? Because there are no bitfield
> variables, only fields in structures/unions, so if you pass a value
> around as an argument, and then end up finally assigning it to a
> bitfield, there was literally no way to pass that value around as the
> "right type" originally. The final assignment *will* drop bits from a
> static compiler standpoint.
>=20

If one wanted to, one could always pass bitfields inside a struct

typedef struct { unsigned int v:12; } b12;

int f(b12 x)
{
    int i =3D x.v;
    return i & (1 << 13);
}

the compiler is then smart enough to know how many bits are
relevant and track this to some degree inside the function.


https://godbolt.org/z/o8P3adnEK

But using this information for warnings would be more difficult
because the information is not computed in the front end. (but=C2=A0
here also other warnings generated by the backend, so not
impossible). And, of course, the=C2=A0additional wrapping and
unwrapping makes the code more ugly (*)

C23 then also has bit-precise integers.

Martin

(*) ...but compared to what some other languages require the
programmer to write, even=C2=A0 this seems relatively benign.











