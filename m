Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230139185E;
	Fri,  4 Sep 2026 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564875; cv=none; b=TDNaVbTBhKr5RKJNzIiYyWEO2XGEkrpJSiZ+PoxyM4Zk2l1D1LsiGuXxE7EH25eF2lqsD+Y1g23fT9D9kPsWLhWLiOxooRy7Mh3Iqcg9t53tEpe1gnK7Gri1aBp74WwILByh7HsrHFqL1ZIWydLeU+ljJ21TIiCfiGODXOhIEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564875; c=relaxed/simple;
	bh=vLKLtc6DsKV4Uo/b6kp9DxmZQan2o1S1atw2yN2MGlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9v521apBjBpgoU4Y8znL90buNbYy4XdoxXvwHB4bWiVU3uxVt4/jN+oLSoTuBYCe7MWusqZKnlbNjGSbpouOWcbN+FRZZXyz+Ej4k8v1+NVPq0m3l4GIQKipNCPlS4DCjGoGlNEvFlHWR6A/kin95je0fZEx8uvvxiudx5ikxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jt4p7vy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt4p7vy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514051F00A3D;
	Fri,  4 Sep 2026 23:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788564873;
	bh=Z1h6AbZU7N8JIvRkcwd6on/Y+M5Pw4rMc16HoaDvh0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jt4p7vy44okBO1duOsblAXefxOpHrj65FhTrzLDBr5fkYyXi967S1XOmcvvRFx1PE
	 5rk338U3Drs4aciMjVJkzg7VgQmr0Op9Ujng53lVbSJpdDyzRK0j9GCwpC6CwNorSQ
	 yLJDyjf5TIrlOxxfYwZz481tLlhEyaK0AmOw/GNQvD+cHbleP9nq7KVs7lXYbS3nCg
	 9gMGc6M227OF+cKaEZBuQI65po1BoejItDD4jpml0fOVCaHIBXzDuxnhu7uE6OaQeN
	 3i+PEnlUgeTu31oPDxnMmefiPLQb8vpU241yU21GEZVwoi+o9zQU1lTOYQUwYLiutc
	 MMr7NYJF+PFEw==
Date: Fri, 4 Sep 2026 16:34:33 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Bradley Morgan <brads@mainlining.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Anand Moon <linux.amoon@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	codemender-patching+linux@google.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 2/2] userns: Add KUnit test suite for uid_gid_map
Message-ID: <202609041620.81446C2A@keescook>
References: <20260823125155.1136740-1-morbo@google.com>
 <20260826220041.4075333-1-morbo@google.com>
 <20260826220041.4075333-2-morbo@google.com>
 <20260827152612-d0c71c10-cbe5-49f3-9be0-47eb76cd9b48@linutronix.de>
 <CAGG=3QWPTL5z8MfAxJLpHb0P-3Ah6K+FzgrVHyRRcvRK7-6dSA@mail.gmail.com>
 <20260831111423-400ed79e-6e52-438c-aa9f-f289e6dbdee5@linutronix.de>
 <CAGG=3QUAY4BDiJM64uTX8C1A2WPg6dPRexbgUQZoi4QKkkpP9Q@mail.gmail.com>
 <20260904091410-3a87d211-edf8-4ead-8b91-004a4a96a161@linutronix.de>
 <CAGG=3QV1G0=19riYPPWhTXrW2X0YvyESdY=GesWm2F_8FEZwMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGG=3QV1G0=19riYPPWhTXrW2X0YvyESdY=GesWm2F_8FEZwMg@mail.gmail.com>

On Fri, Sep 04, 2026 at 01:37:00PM -0700, Bill Wendling wrote:
> On Fri, Sep 4, 2026 at 1:02 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > On Thu, Sep 03, 2026 at 01:21:27PM -0700, Bill Wendling wrote:
> > > On Mon, Aug 31, 2026 at 2:22 AM Thomas Weißschuh
> > > <thomas.weissschuh@linutronix.de> wrote:
> > > > On Thu, Aug 27, 2026 at 12:27:30PM -0700, Bill Wendling wrote:
> > > > > On Thu, Aug 27, 2026 at 6:37 AM Thomas Weißschuh
> > > > > <thomas.weissschuh@linutronix.de> wrote:
> > > >
> > > > (...)
> > > >
> > > > > > > +config USER_NAMESPACE_KUNIT_TEST
> > > > > > > +     bool "Test user namespace map insertion" if !KUNIT_ALL_TESTS
> > > > > > > +     depends on KUNIT=y
> > > > > >
> > > > > > Urgh.
> > > > > >
> > > > > ?? What's wrong? It's identical to the conditional for EXEC_KUNIT_TEST:
> > > >
> > > > Sorry for this non-descript review comment.
> > > >
> > > > > config EXEC_KUNIT_TEST
> > > > >      bool "Build execve tests" if !KUNIT_ALL_TESTS
> > > > >      depends on KUNIT=y
> > > > >      default KUNIT_ALL_TESTS
> > > > >      help
> > > > >           This builds the exec KUnit tests, which tests boundary conditions
> > > > >           of various aspects of the exec internals.
> > > >
> > > > The problem is that KUNIT can be built as module, which would prevent this
> > > > test from being built. We have include/kunit/visibility.h to export certain
> > > > symbols only to tests and avoid this issue.
> > > > But I can see that some maintaines don't like this pattern, so maybe they can
> > > > chime in at some point.
> > >
> > > Bradley commented on this earlier (which is why I mentioned EXEC_KUNIT_TEST):
> > >
> > > <comment>
> > > The test is #include'd into user_namespace.c, which is builtin (USER_NS
> > > is a bool), so =m here still compiles the suite into vmlinux. With
> > > KUNIT=m that calls kunit symbols that live in a module, and the link
> > > fails. Make it bool and depend on KUNIT=y, like EXEC_KUNIT_TEST:
> > >
> > >  bool "KUnit test for user namespace map insertion" if !KUNIT_ALL_TESTS
> > >  depends on USER_NS && KUNIT=y
> > > </comment>
> > >
> > > So there's a conflict and, because I'm not a KUnit guru, I'm not sure
> > > which way is "best".
> >
> > It's subjective. So as mentioned before, the preference of the maintainers
> > should go into it. The aproach I prefer requires a bit more setup boilerplate
> > but make the tests usable in more circumstances.
> >
> Because user_namespace.c is always built-in (USER_NS is a bool),
> compiling the test into vmlinux causes linker failures if
> CONFIG_KUNIT=m. Using the "visibility.h" version also strips static
> from insert_extent() and sort_idmaps() or exporting internal user
> namespace functions into the kernel symbol table, which isn't ideal.

The export namespacing should limit it to just KUnit, so that should be
okay, I would think? My guide for this in the past has been "did the
kernel get less fast/safe because of Kunit exports, etc?" I don't
_think_ that's the case here.

So, I guess it's down to a matter of taste by USER_NS maintainers? I've
move Christian to "To:" from "Cc:", as I think he is the defacto USER_NS
maintainer? I don't know, though, there is no MAINTAINERS entry for it. 

> > > Test (3) (which I'll add in my next upload) throws a sanitizer exception.
> >
> > What is the point of testing this specifically for user namespaces?
> > Normally we expect a used subsystem to work as advertised.
> > It is that used subsystem's responsibility to test that it does so.
> > If there is currently no test that validates __counted_by then it surely
> > should be created. But not here.
> >
> This would directly test that the attribute on the struct field is
> caught by UBSAN. I'm not sure how we could more directly test it
> otherwise...

It is tricky to catch the traps sanely with KUnit. All the Oops tests
I've written for it are in LKDTM, and only __bdos is tested in
lib/tests/overflow_kunit.c. I was playing with catching Oops in KUnit
for testing KCFI recently, but haven't come back to finishing it safely:
https://lore.kernel.org/lkml/20260618210946.it.538-kees@kernel.org/

-Kees

-- 
Kees Cook
