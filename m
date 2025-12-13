Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9015624B
	for <linux-hardening@vger.kernel.org>; Sat, 13 Dec 2025 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765590197; cv=none; b=uMeqdnMYg01InIH7lGMFdUtwIeKX5VqJY4Qo55ddyW0ZbG0YTHKJpEgy54P2LJu7AdGJrzzBpoxb+Dtgz0Z7+K/DUYd625R18uudPqnrCZzm0lTIcW0ehQH7w1U22vY1Wrl2gV85o0mV0pGdpXJvb7x+7z+9QdOdNS9phZRT5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765590197; c=relaxed/simple;
	bh=4OnBVLm1BOQYvCC/fvIACN8Nylv8Dv4NSID41lmL63A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TktoB4ekWjm99Jam1IpGT3yqt5ilH2CwgmuRoKmwqt3ObnFuvu3MPX/hb+JZuo19kvbz0fqHR6KhwDb9kNGucyj588CPqwsuwbeMLhHbpjeQFJzohBtaQ6l9IDPRs4cHzCDxqJfoWA+DQ5psowqR6AGYc1fjqcrw4JenXOlAWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pag4KYwp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pag4KYwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679C5C4CEF1;
	Sat, 13 Dec 2025 01:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765590195;
	bh=4OnBVLm1BOQYvCC/fvIACN8Nylv8Dv4NSID41lmL63A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pag4KYwpr2QdnXZhu/YoM4NF8fLf9vsa0G2h//13S3kdKl4dSopgFD5Gg1dLpvCsU
	 JaQPaW0gcc4E2pU1q98HfmJpo3NTXO17CYylgoqe2MOgngZZ7P4rKfsp5MqNlIVZ3Y
	 MlrP2ayFf9OYc5d60r2f+zuyJOI61QEHwN+5mTo3Lfobl2moRlhKerOKSE+Mgx9rNK
	 ZpI81jiRY9W76zD7HvYm2p37GH+9jPkWjfwio6tKLphuAi/V70z2yiEGEI57uOXNKv
	 vdyoBC2B46bTi39ymyoPqhZQ2QAd2SGHk5oLiJP9XWiOAzXiIKXADEKXXOUaf9Ljb0
	 XGhsetYjyyD3w==
Date: Fri, 12 Dec 2025 17:43:15 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
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
Subject: Re: [PATCH v9 1/7] typeinfo: Introduce KCFI typeinfo mangling API
Message-ID: <202512121741.5583E7D@keescook>
References: <20251210022025.harder.803-kees@kernel.org>
 <20251210022035.331892-1-kees@kernel.org>
 <CALvbMcCNEf_r5kAQXAihxwMcSWC5msVcSBfBax78N2CZc6k9Kw@mail.gmail.com>
 <202512121709.F5617B17D@keescook>
 <CALvbMcBYSzi=fb0XmGrgh_aP=rR9H+f-7PbX7cnvTm_T+vZynw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcBYSzi=fb0XmGrgh_aP=rR9H+f-7PbX7cnvTm_T+vZynw@mail.gmail.com>

On Fri, Dec 12, 2025 at 05:29:43PM -0800, Andrew Pinski wrote:
> On Fri, Dec 12, 2025 at 5:24 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Fri, Dec 12, 2025 at 03:07:51PM -0800, Andrew Pinski wrote:
> > > On Tue, Dec 9, 2025 at 6:27 PM Kees Cook <kees@kernel.org> wrote:
> > > [...]
> > > > +uint32_t
> > > > +typeinfo_get_hash (tree type)
> > > > +{
> > > > +  gcc_assert (type != NULL_TREE);
> > > > +  uint32_t hash_state = 2166136261U; /* FNV-1a 32-bit offset basis.  */
> > > > +
> > > > +  mangle_type (type, nullptr, &hash_state);
> > > > +  return hash_state;
> > > > +}
> > >
> > > It might make sense to do a few self_test here instead of (in addition
> > > to) having a testcase.
> > > This way the testing is done earlier.
> >
> > I tried to do this back in v2 and could not make it work. See [1] for
> > more details on what I found, but basically I don't have access to the
> > parser itself in the selftests, so I couldn't build end-to-end testing
> > of arbitrary C (testing node types isn't really a sufficient test in my
> > view). I could to basic type tests, but it would be redundant to what
> > I ended up with in dg, and I didn't want to split up the testing.
> 
> I am asking for self-tests of the API and not depending on the C
> parser. So generating some FUNCTION_TYPE types and then getting back
> the hash and/or name.
> 
> > (testing node types isn't really a sufficient test in my view)
> It might not be a fully sufficient test in itself; it does not mean it
> is NOT a useful test to have. This is why I mentioned in addition to.
> Testing the API outside of the end-to-end testing is a good thing and
> can find bugs early on.  GCC does not have enough self-tests really
> and folks don't use it as much as we should.

Okay, yeah, if doing this kind of "manual" construction is viewed as
meaningful, I'll give it a shot to augment the existing tests.

-Kees

-- 
Kees Cook
