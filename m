Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBCC327204
	for <linux-hardening@vger.kernel.org>; Fri,  7 Aug 2026 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127888; cv=none; b=bIwYflQu7dSdVWa2Lhim+CPC7W1pkCTCNi0oZhzzfyqDxyuYuyeI2V+7CyMx0XYlWoq3DXBbXO1vlSy+X21m4L7Agn7JgjeUgfv+guID8gKOA3299W9gqbCQDmJXn3/wBNg6JhtxhrpsqWzgE/Med+cBBU+mZcqNJYAVMPWp2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127888; c=relaxed/simple;
	bh=ESydb33A3p3cOtcxBH6bNNgp207IWeg9ETn4Xes9oyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9Nu/xSDS00Krwg7zl7oBciwfi850cRqpAhiyNv+mP9SvySSVSZaz/SE4AMUU4/9SeMEaeNiSpVdOEVQVyXiHLxyN3eoyQTJr/yEgW5D6eVm1Rfg8Plt509Fh2e5fNv52k9i1u5QSCVA+6T8rv7frj+NnV6qv4n/QtmkijGUJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5aaR9eJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5aaR9eJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51391F000E9;
	Fri,  7 Aug 2026 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786127886;
	bh=73Uf+i95x1AAxjwZ4Vxe6MAJoSYlLPDS9Yqa1HSGI/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J5aaR9eJNMWev7NPN0DUm1mWnEVpoxug2wpBwfXJuO911M3gfELaDvibn6A8ll7ni
	 PJBGyD5fKHfSlmspj42TlXTgc+WBdP2optjdRQ0/0KO2JcM55AsgwVm5sn9Sj7eGvD
	 Vy+3L7IW5roffl/fr3JTzF6rrZcYfujyeJz5xbmbsTBR4rIyoh560EN4eXtdMwczsK
	 qVisQVnanjsGpn19FtUvZqH5QUqtqLkfSyJdGlIS7wB0N6+zIgiXFqgJm2nqLD+Ny/
	 ZB2Kb8wzMQtd2I0OGTQ3GM8/r0Zd1704xVU/Z0k7zVPNNBMhHAdVVYDntGpP663fG0
	 W8VJSUVnMwaPA==
Date: Fri, 7 Aug 2026 11:38:06 -0700
From: Kees Cook <kees@kernel.org>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v13 1/7] kcfi: Introduce KCFI typeinfo mangling API
Message-ID: <202608071122.1988A82C97@keescook>
References: <20260618204530.work.910-kees@kernel.org>
 <20260618204539.824446-1-kees@kernel.org>
 <CALvbMcCiQ1b0KDrJHS-irGMWNEk5oWaWs31KQor2ZHPSVewQ=A@mail.gmail.com>
 <202607151151.AB5F1BD0@keescook>
 <202607151636.1AA31A76@keescook>
 <CALvbMcB9iEc8vp4WahmOZK-w1WZjmDDp3-U0ui61PqLZox0D=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcB9iEc8vp4WahmOZK-w1WZjmDDp3-U0ui61PqLZox0D=Q@mail.gmail.com>

On Wed, Jul 15, 2026 at 05:28:39PM -0700, Andrea Pinski wrote:
> On Wed, Jul 15, 2026 at 5:07 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Wed, Jul 15, 2026 at 12:06:17PM -0700, Kees Cook wrote:
> > > On Sat, Jun 27, 2026 at 03:00:42PM -0700, Andrea Pinski wrote:
> > > > On Thu, Jun 18, 2026 at 1:45 PM Kees Cook <kees@kernel.org> wrote:
> > > > > [...]
> > > > > +
> > > > > +    printf("\n================================================================\n");
> > > > > +    printf("Passed: %d Failed: %d (%d total tests)\n", pass, fail, pass + fail);
> > > > > +    return fail;
> > > > > +}
> > > >
> > > > It would be a good idea to add a random generated testing here. See
> > > > testsuite/objc.dg/gnu-encoding and testsuite/gcc.dg/compat for
> > > > examples.
> > >
> > > Okay, thanks for the pointer; I'll see what I can come up with. I
> > > generally dislike random testing since they may appear to be "flaky"
> > > when they trip, but I'll give it a shot.
> >
> > I don't see anything we can do valuably here. There's no round-trip
> > parsing going on (there's no independent oracle). For the existing
> > mangling tests, I have hard-coded all the expected strings/hashes. I have
> > gone through the TYPE enums, though, and added a few other missed types
> > for the mangler. But I built a python-based fuzzer anyway, just to see if
> > I could find any other combinatorial ICEs, in case I missed some mixture,
> > and I could only crash the ToT GCC frontend. :P It's okay in 16.1?
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=126284
> 
> What about Adding something like gcc/testsuite/gcc.dg/compat/ where
> you compile with 1 or 2 compilers? to make sure you can call the
> function indirectly with the check?
> Or is there some extra code that is needed to support that?
> That is you compile one side with say clang and the other side with
> GCC and you try to invoke the functions indirectly?

Oh, very cool. I didn't know about this infrastructure! I've added
compat tests now.

-- 
Kees Cook
