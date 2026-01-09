Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFC3321BD
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982972; cv=none; b=b5m7wfHmilEEeSNh5kJBzVTAJQDTK9VqWutAUKrkZYSWR+L/etWxX+EOaUGa30ItBUdROEyLxYln99BW8HpoGvzZVT5P4+w9jmxQKG5gumby6F+uAXqAlUkNV5FVMMt2fUWE+IXMfCDIgkr26C49v8mJW/XgGV3LzFS9Nz2yjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982972; c=relaxed/simple;
	bh=Gu1GEL+TBmJSYiMBdu1iCaBVInZ1tZkipCsxOAO6v2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8O0xwkw4Z1TaXDN0HQetCQ1y1M45HhIQ9EDIIEAXR5+IT3CBEqQy6ZJ0n++wXb7Om0j0okCPky+eZMoHEBiDMf3w+++u+yMVQySIsWXSX/H8MYP9Wqx6GrhaLQe7V8prdWP/x8+MRV/hPZaMaDv5aUUPcFWHjGALCh/rFet1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ4upx/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ4upx/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C29C4CEF1;
	Fri,  9 Jan 2026 18:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767982972;
	bh=Gu1GEL+TBmJSYiMBdu1iCaBVInZ1tZkipCsxOAO6v2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZ4upx/TAwehFc0Xa8A2bJQd6oySd3YILWeaCXxUmHbZjdE/lA/+CSHlBba0DGrK2
	 gEyrWYmf3PV6blCwGGpECtzaDVhVYd3F0633HrBGSnE8zNVOEiTw1ClullA7u133TX
	 Cvhevoigb0CrIIz1E1RDDcYNWWKdTWpVM5/YuanEqv+xFUh9HzF6GdKJCkmMc3vtmf
	 FmNKkCj0VnQBRgzL8/uTfxNgjTf+PVyN0YtL+lApAAUmtWSWmUc1Ix2s+rDPSGXKDe
	 SSx87Xuf1HuORDXC9rW9GZmFTOndMNJJCVLaauy12KrUXE69VCtqDi22jo6uZ1K1cV
	 vHYbxlww1RzEQ==
Date: Fri, 9 Jan 2026 10:22:52 -0800
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
Subject: Re: [PATCH v9 0/7] Introduce Kernel Control Flow Integrity ABI
 [PR107048]
Message-ID: <202601091022.F01CFC86F@keescook>
References: <20251210022025.harder.803-kees@kernel.org>
 <CALvbMcACT19UHPJme0w1rStX5XEJwNWdAMTuJ=cERkY38+EMQg@mail.gmail.com>
 <269C524E-2FDB-4156-98FE-548993666B03@kernel.org>
 <CALvbMcCi8SZs415AE8WYFiijh6K0HYixqz68Nbios=BvuB_jsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcCi8SZs415AE8WYFiijh6K0HYixqz68Nbios=BvuB_jsg@mail.gmail.com>

On Thu, Jan 08, 2026 at 09:48:58PM -0800, Andrew Pinski wrote:
> On Thu, Jan 1, 2026 at 7:42 PM Kees Cook <kees@kernel.org> wrote:
> >
> >
> >
> > On January 1, 2026 2:42:59 PM PST, Andrew Pinski <andrew.pinski@oss.qualcomm.com> wrote:
> > >On Tue, Dec 9, 2025 at 6:22 PM Kees Cook <kees@kernel.org> wrote:
> > >>
> > >> Hi,
> > >>
> > >> This series implements[1][2] the Linux Kernel Control Flow Integrity
> > >> ABI, which provides a function prototype based forward edge control flow
> > >> integrity protection by instrumenting every indirect call to check for
> > >> a hash value before the target function address. If the hash at the call
> > >> site and the hash at the target do not match, execution will trap.
> > >>
> > >> I'm hoping we can land front- and middle-end and do architectures as
> > >> they also pass review. What do folks think? I'd really like to get this
> > >> in a position where more people can test with GCC snapshots, etc.
> > >
> > >So looking back into the other implementation that was submitted a few
> > >years back (https://patchwork.sourceware.org/project/gcc/patch/20230325081117.93245-3-ashimida.1990@gmail.com/),
> > >a regnote (REG_CALL_CFI_TYPEID) was used instead of the wrapping with
> > >kfci rtl.
> > >I get the feeling a regnote would be better as there is less for the
> > >backend to deal with including new patterns.
> > >What do others think?
> >
> > I started there and it created way too many problems that I had to continuously hack around. Switching to RTL solved all of it. (See v1 and v2 of this series where that was how it was implemented.)
> 
> Ok, thanks for confirming that. I will try to give v10 a full review
> by the end of next week. But since GCC is starting stage 4 on Monday
> and I think it is too late to add this feature so this might be the
> first thing to be pushed once GCC 17 stage 1 starts (mid to late March
> depending on how fast regressions are fixed).

Thanks! Yeah, I'm not expecting to land this in GCC 16. We're very late
in the cycle. :)

-Kees

-- 
Kees Cook
