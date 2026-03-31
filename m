Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE662C3251;
	Tue, 31 Mar 2026 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959548; cv=none; b=gwwOZIE7Ia4r0nDBHBND7k2dbjxrnBcD1TNUn+FWWV8EmgeMfuuslQhy0t505ek7OJDbUs4ySNCYJzr7QXjZ0MDnxe/xl0naPrs1V9Rmf+HrOCnsGvzdnic5IIR3A4mM8eaZF/PJcj8kZCotqI1OPElIjJrU4MWIynX+xUHlHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959548; c=relaxed/simple;
	bh=IoKsvtd48J50hGopDTPZHO3H0Qtmdx4qyk2G80xYZ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyduvfdcxbBxr1GgO0wMZRdK+yDQlcN2V53PLkHCG8X1L0sppaGUsgAwkTudILqmYmyPc3TKjaAUvEr1ODqMjDq1GYml/DHyp21LDmzT3J7ounx2AIvNOBNHhNrMdIKUL9J9+1jlMHegjBY0RlRa8tQctxHZtxRcuWD0TfFs7Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EI7cCg+3 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EI7cCg+3"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CB1C940E0140;
	Tue, 31 Mar 2026 12:19:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pgDay8YWXZd3; Tue, 31 Mar 2026 12:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774959539; bh=d1u0+wv5FEEX+a8pKDpmBWxkgo2JpNEjkQFb3OF7LI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EI7cCg+3sY0FRKKuoKeffLk5Q5ielx/mMiYmTIKQcWenKZMgMzWzn3PYSpakXJUbL
	 rGFaHP06EwZCqePCrvzp7OeM0u6dE9hgdd/e3sBZ0RmS1k1mBZTKnThuvH8kGEPKF6
	 YGUSwWbTXa3gIRcuAAMkLr+/Oe5h8uLVdDVzHFwAsUNErb6zqj/g6ZanlFwpTPlDvS
	 XTLwIf305XeOe/7KT5gWkvTFixoiA+DMyg2NufdrgYELH1BeUaUyV3bSWlZHXjpvaV
	 +ZOk2bhVzufxJpvIQ1NfB9g2WW+lCeUsHZ/yfFrCunOkbUEJQWfz12B7wriZkDHzFn
	 ObANBBkMevmr+tbuTIHEqFkp8oAgxQGh1OWA5BO3ZzJoMbURbEK6gWHA+EaB52pnGj
	 UGGvdXob/BUdTvUMDvrKG5iM+lZKKad/uvCTPKyCTyV7A0MfrYeYxN31EzLqoZ64gK
	 Jsxn4JBj86xXN+tzmNZi7K0IVzL00tcCG9/bvMk/o1yc5qnFpyhcoVVuO2URg2DMiw
	 fI6XeFLkRZgknqFdAyURGVrFuu+EGB9Br6EYT7cawhNwvfp4T0jxX55uN9G3O1O8/v
	 eZ4zz+3IegDfL4LCOw5O7eie5+Wm7+NpkvMMwogr3EqZ6itaT7qBoTs5cOJy4rSRbZ
	 brNz+DTgRm1AeIocW6pg0j/4=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6424340E00DC;
	Tue, 31 Mar 2026 12:18:52 +0000 (UTC)
Date: Tue, 31 Mar 2026 14:18:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] EDAC/mc: Use kzalloc_flex()
Message-ID: <20260331121840.GBacu7oF3AjjkLtcBZ@fat_crate.local>
References: <20260327024828.7377-1-rosenp@gmail.com>
 <20260330151536.GDacqTmBlWRznyeoMG@fat_crate.local>
 <CAKxU2N8HqFRT+qb5ctCVckC6c=viR7u+xyUaHgm-87C5=yo1ig@mail.gmail.com>
 <20260330211123.GHacrm-03xUU_3yX66@fat_crate.local>
 <CAKxU2N__gE-bWBU6EkJmEK2gR7VE=Va+oN6EB2hpJoHbUiYVxg@mail.gmail.com>
 <20260330223222.GJacr59uiTZzPRYbWX@fat_crate.local>
 <CAKxU2N_H4mvrJh+zgoikY8J9-u3nnWK-1dQwZanDNksoE75hvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKxU2N_H4mvrJh+zgoikY8J9-u3nnWK-1dQwZanDNksoE75hvg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 04:25:26PM -0700, Rosen Penev wrote:
> On Mon, Mar 30, 2026 at 3:32=E2=80=AFPM Borislav Petkov <bp@alien8.de> =
wrote:
> >
> > On Mon, Mar 30, 2026 at 02:26:10PM -0700, Rosen Penev wrote:
> > > > Oh, hypothetical what-if. Yeah, pls drop all that gunk from commi=
t messages
> > > > pls and simply concentrate on why the patch exists.
> > > Not sure what you mean.
> >
> > I mean this: a commit message should simply state why a patch exists.=
 Here's
> > what I did with yours:
> >
> >     Convert struct mem_ctl_info to use flex array and use the new fle=
x array
> >     helpers to enable runtime bounds checking, including annotating t=
he array
> >     length member with __counted_by() for extra runtime analysis when=
 requested.
> >
> >     Move counter assignment immediately after allocation as required =
by
> >     __counted_by().
> >
> >     Move memcpy() after the counter assignment so that it is initiali=
zed before
> >     the first reference to the flex array, as the new attribute requi=
res.
> Looks great.
> >
> > The idea is that when one reads the commit message months, or even ye=
ars from
> > now - something we all have to do on a daily basis - it should have a=
ll the
> > necessary information why the change was done.
> >
> > And nothing else. The emphasis being on the latter part. In this case=
, what
> > this should have been and what some tools can do when lines are magic=
ally
> > ordered doesn't really matter. The change must be worth to exist for =
itself.
> > In this case, runtime bounds checking, which is something we all want=
.

Applied, thanks.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
