Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016DE202997;
	Mon,  7 Jul 2025 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920190; cv=none; b=tzeFnXAy/sWypFOA/QRYycQJVyy/YB5Y/Many4p15qxpaes6++YB1Ps1jKH3p+I99mXva225XszZOp1H+HRuK+RjrNKcmFbd2dDavhLV4yOYxBN/CHSOoOcCki4bnC0DkU0Ld3L+JhfFnXVnhwNr+k2JRvPlgcvi/D9tn37zv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920190; c=relaxed/simple;
	bh=KaVF9Ika1Iq/rw5JBpEqeImU31PCs6bqzlHNSQVTiWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB3LatktiH9Mo/SfPBUBmKAWENfnqJuRk+7yK2wvczCq2hxM7B752wXcqsHq582gy2whtU8F90JNYB9/wuOIXSbvzru3ceJqFm/GFUFnT4GaGLNnOV0XBnIWn7MdGs6tP7uWvwXs3w9vZHrgcwiOfDFgaw2tTQIL5EbImPZefXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoB2iX7G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoB2iX7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678F2C4CEE3;
	Mon,  7 Jul 2025 20:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751920189;
	bh=KaVF9Ika1Iq/rw5JBpEqeImU31PCs6bqzlHNSQVTiWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoB2iX7GwIPMHbCQequWgcamiRQuaMGvkg4ELR1vaCbhzPPF3h58ByrezX1MhEAL+
	 WT2Tbg9Tdb92vUry9ZKvo2yXI7nlUqoWcF8wMvOnYq/GwNm2aqJFMAWPzaknfM+20C
	 3wcPXqVIeRtwTZyivD6ttTBM5CJqoT38d7dJAfCOL/Wh0vEnvBtQFNy/QMZAFKGEDI
	 rUsO2bMmtlgneg5LR5ZgL5DS+3G2N+Euph0bycMVA7pgSj0279Ei9R2idnA0YK/oJJ
	 6FEa+0ZLOq6n/bWt61LeSAnhFLE8XRrosmOC6X+CThJlchIix0KgOiOZQpyuwb8XwC
	 xgh4hU16jbQDQ==
Date: Mon, 7 Jul 2025 22:29:40 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chao Yu <chao.yu@oppo.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
Message-ID: <ugf4pu7qrojegz7arkcpa4cyde6hoyh73h66oc4f6ncc7jg23t@bklkbbotyzvp>
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hm3euuqedab7podc"
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>


--hm3euuqedab7podc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chao Yu <chao.yu@oppo.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>

Hi Linus,

On Mon, Jul 07, 2025 at 12:17:11PM -0700, Linus Torvalds wrote:
> On Sun, 6 Jul 2025 at 22:06, Alejandro Colomar <alx@kernel.org> wrote:
> >
> > -       p +=3D snprintf(p, ID_STR_LENGTH - (p - name), "%07u", s->size);
> > +       p =3D seprintf(p, e, "%07u", s->size);
>=20
> I am *really* not a fan of introducing yet another random non-standard
> string function.

I am in the C Committee, and have proposed this API for standardization.
I have a feeling that the committee might be open to it.

> This 'seprintf' thing really seems to be a completely made-up thing.
> Let's not go there. It just adds more confusion - it may be a simpler
> interface, but it's another cogniitive load thing,

I understand the part of your concern that relates to
<https://xkcd.com/927/>.

However, I've shown how in mm/, I got rid of most snprintf() and
scnprintf() calls.  I could even get rid of the remaining snprintf()
ones; I didn't do it to avoid churn, but they're just 3, so I could do
it, as a way to remove all uses of snprintf(3).

I also got rid of all scnprintf() uses except for 2.  Not because those
two cannot be removed, but because the code was scary enough that I
didn't dare touch it.  I'd like someone to read it and confirm that it
can be replaced.

> and honestly, that
> "beginning and end" interface is not great.

Just look at the diffs.  It is great, in terms of writing less code.

In some cases, it makes sense to pass a size.  Those cases are when you
don't want to chain several calls.  That's the case of stprintf(), and
it's wrapper STPRINTF(), which calls ARRAY_SIZE() internally.

But most of the time you want to chain calls, and 'end' beats 'size'
there.

> I think we'd be better off with real "character buffer" interfaces,
> and they should be *named* that way, not be yet another "random
> character added to the printf family".

You might want to do that, but I doubt it's an easy change.  On the
other hand, this change is trivial, and can be done incrementally,
without needing to modify the buffer since its inception.

And you can come back later to wrap this in some API that does what you
want.  Nothing stops you from doing that.

But this fixes several cases of UB in a few files that I've looked at,
with minimal diffs.

> The whole "add a random character" thing is a disease. But at least
> with printf/fprintf/vprintf/vsnprintf/etc, it's a _standard_ disease,
> so people hopefully know about it.

seprint(2) was implemented in Plan9 many decades ago.  It's not
standard, because somehow Plan9 has been ignored by history, but the
name has a long history.

<https://plan9.io/magic/man2html/2/print>

Plus, I'm making seprintf() standard (if I can convince the committee).

Yesterday night, I presented the proposal to the committee, informally
(via email).  You can read a copy here:
<https://lore.kernel.org/linux-hardening/cover.1751747518.git.alx@kernel.or=
g/T/#m9311035d60b4595db62273844d16671601e77a50>

I'll present it formally in a month, since I have a batch of proposals
for the committee in the works.


Have a lovely day!
Alex

> So I really *really* don't like things like seprintf(). It just makes me =
go WTF?
>=20
> Interfaces that have worked for us are things like "seq_printf()", which
>=20
>  (a) has sane naming, not "add random characters"
>=20
>  (b) has real abstractions (in that case 'struct seq_file') rather
> than adding random extra arguments to the argument list.
>=20
> and we do have something like that in 'struct seq_buf'.  I'm not
> convinced that's the optimal interface, but I think it's *better*.
> Because it does both encapsulate a proper "this is my buffer" type,
> and has a proper "this is a buffer operation" function name.
>=20
> So I'd *much* rather people would try to convert their uses to things
> like that, than add random letter combinations.
>=20
>              Linus

--=20
<https://www.alejandro-colomar.es/>

--hm3euuqedab7podc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhsLi0ACgkQ64mZXMKQ
wqmzHhAAiWAsGEbvSPpIRKjHFLRmZ1qgrHgSd2MJ5KPyYritnzqRD0gE1mRApWtk
kfVZhvAa0ud09ds81/+KW/SAYw5VsHdJuyDpLxfNNaP0sKJRuTUgHPmjqBsj3N3F
4MtyXQ1P6YjydvSUQ200zKyXaPBsPTqJEz2M+gXxNgghYp07sEYcEEKKV1X1j6vK
atcQsESKA+/+V9kPiHFgGQsaX7/e/nvSVpao5gnZ8oIxsqDN/zPosSks7wxBptyJ
FSMMer6X3IUsh7innNWu4QSPXObRGS5BJol6Ev1d5IKvXTkmxipe4vXWO7OQ9Un4
LNBAqD8+SQWbqHFHjEH1VUqr9wzJNFnJrjGUsz+kwtV4dHtbATi/7peYZA7Ht0CA
arhageKLWRn2JUM5beeIug/CJHZ150+m/M1Dc0Ec6K9rxJUj10sP/t09WIljrJzF
4D8lBcrZVMjz+NkOWQNn55ZN9VU7r/6y57Dv090D0ysBmmE2fG7GzGbJJMYqEGrb
nXAFN1giVxeg2t/tlbzAGJ09EZkxinK0EHEzY/4bgT5gDw/tMMBqsX4qTp7qa9Va
JzUTGvdbS5I1Px04zRDJrOvNyx5vyFRj+ZROPop/tO3Jucf1BWE2sxBezKoCK1zl
3NiRecJc2x2mDZnh2mDRcMuEMkprSbFB/5KS56i0ayITLsqauSk=
=E6l+
-----END PGP SIGNATURE-----

--hm3euuqedab7podc--
