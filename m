Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117EA14AAD;
	Sun, 12 May 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715501464; cv=none; b=OK+Ndy7cCSlI+QXgK/fBSSb/U0NMbzDxMYSaO8HC8LjQGMicq86xognNzXnBbwdf2JbqlRdnu4wjijLGrdJDh9DuxJEK0HlInSsjG9GGAIJgyou1FEkytCEEgJAHryimx18EYO+jfiGEWNSSlm8RdYtajnGBwa2OMqEwBCoRAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715501464; c=relaxed/simple;
	bh=cBSa91IUA31x5n1Tk1msmI9aJm9T9z5OoASH+Lzq6HM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lD1IT/h3RPHLYJwqt9MrwfWW6A9obVCpDyERGJEsLftyLxvJOh/QnFQDbMnk/0VnL5wj7KT4ynWR2GCB6ktSlZeMbRl8x6AIzSEsFNmyixII3fcUN1YOXH5eryqymQzERC8Mign+lXq/KojCkWHlsSLry12zIhbIEvP9gYuxnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=rNg9kYmX; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="rNg9kYmX"
Received: from [192.168.0.221] (84-115-223-216.cable.dynamic.surfer.at [84.115.223.216])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4VcZr31J1pz3wGD;
	Sun, 12 May 2024 10:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1715501012;
	bh=8wKF3K1/gl/lH7BcMOVIXNsu0KRDMkF4mJrrwAUkDLg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=rNg9kYmXyzo63IZjtvX3G5h14CNg1OLPp4PDyztzbnWPiEiNhWWwsaXmugrpO510o
	 ph04ITw5+J2TpDrP8YeD9MEvJjmqb+dDljz539cstMwIbj+4aKTPDRlGmYeiUWrhw+
	 5OSCu34jwCJ1Lmv/68J2j3xW4Oa3c+ULLrqjQ9XY=
Message-ID: <59f731ab619673afec4956fce6832a1cd5324fb8.camel@tugraz.at>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
From: Martin Uecker <uecker@tugraz.at>
To: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook
	 <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Peter Zijlstra
 <peterz@infradead.org>,  Mark Rutland <mark.rutland@arm.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
Date: Sun, 12 May 2024 10:03:30 +0200
In-Reply-To: <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
References: <202404291502.612E0A10@keescook>
	 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
	 <202405081144.D5FCC44A@keescook>
	 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
	 <202405081354.B0A8194B3C@keescook>
	 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
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

Am Mittwoch, dem 08.05.2024 um 16:47 -0700 schrieb Linus Torvalds:
> On Wed, 8 May 2024 at 15:54, Kees Cook <keescook@chromium.org> wrote:
> >=20
...
>=20
> No, the only point where that actually failed was then when a
> (non-overflowing, non-wrapping) final value was assigned to a 16-bit
> field, ie the problem only ever happened at the final assignment:
>=20
>         event->read_size =3D size;
>=20
> where no overflow had ever happened before that.
>=20
> So in *that* case, you actually have a much more interesting
> situation. Not wrap-around, not overflow, but "implicit cast drops
> significant bits".
>=20
> And yes, I do think implicit integer casts are dangerous. Often *more*
> dangerous than arithmetic overflow and wrapping. We've had absolutely
> tons of them. Some of our most traditional bugs have very much been
> about implicit casting losing bits and causing problems as a result.

In principle, GCC has -Wconversions which looks like that it is
meant to catch this.  It seems not entirely stupid, e.g. it warns=C2=A0
about=C2=A0 the first assignment and not the second (x86):

void f(int i)
{
    unsigned short y =3D i;
    unsigned short x =3D i & 0xFFF;
}

But I guess it still could be smarter. Or does it have to be a
sanitizer because compile-time will always have too many false=C2=A0
positives?

Martin



