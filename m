Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6242070;
	Sun, 16 Feb 2025 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739749891; cv=none; b=CyrXfmky8I/St0ofl4T6FVtgK3Zpb5s+tbbwHLkBEkF+zqEAyVJTtSIJHwqD6f4Dd3pvSnzyBVoGvywPSDAsP9ewez6T8Ihib6Qs6z+f/Dg3IMy/zt7AG53p7qP+S3MLXE2YJlugZkiTcYaF5nVSeK80UsmLCi/4qFIIDH8Dgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739749891; c=relaxed/simple;
	bh=fIRD6d+Q8TA1vcv9Dja8WVwUWkt4/LCL4Mx0a6QI7cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJzQ8oSqFl938I21CmISg/tR64xhwLCf6XEby8WJrdBFcfk84E9XnbmRFsE0hScH8OZI6TTw8Zv7+0C615UA3+ZI5Ee9AQHQgBe/IEa9sNlA+9OB3W4TjRoKPONASw7PgnZxgBVnYBH6eFEKvmFR8dB6Y4iqLpJ4nxicWQj8mc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra/l8uuA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra/l8uuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF716C4CEDD;
	Sun, 16 Feb 2025 23:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739749890;
	bh=fIRD6d+Q8TA1vcv9Dja8WVwUWkt4/LCL4Mx0a6QI7cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ra/l8uuA6Kg3TtTTrpl9KQM7SKrOP+piLgJybbaHC9ekL242Zl0w/b/FqQ+4SPTdi
	 rHTHo/qNtUZAWAMz0/kjtnbfoHsjJ8apgZP5nNR/8MQZ5O7AoCN8pMrEdNYwu3DCZ7
	 c/QrXKc6d1x+P86xp092zjxzG65aP7/v58M2kt3+B5kaiVBsF+PxLTHsgYxZtaD32x
	 NkqgNimpMnx2dU1JsBqImJ3hbRPLx1+H4oBPXjGb0NL0UVhL4k9wBojH/b0GiPO/ID
	 E+dYK5jpvfMG/qst30lW0+Dp9QqgNvRUadzNmNTPeU2tD25MsI0UDqZP2HRC60G2sQ
	 d+tZwLEJdJZXw==
Date: Sun, 16 Feb 2025 15:51:27 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, jannh@google.com,
	jmill@asu.edu, joao@overdrivepizza.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	luto@kernel.org, samitolvanen@google.com,
	scott.d.constable@intel.com, x86@kernel.org
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <202502161547.B05817003F@keescook>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <202502131224.D6F5A235@keescook>
 <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
 <202502131248.B6CC333@keescook>
 <20250214095751.GF21726@noisy.programming.kicks-ass.net>
 <20250215210729.GA25168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215210729.GA25168@noisy.programming.kicks-ass.net>

On Sat, Feb 15, 2025 at 10:07:29PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 14, 2025 at 10:57:51AM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 13, 2025 at 12:53:28PM -0800, Kees Cook wrote:
> > 
> > > Right, the "if they can control a function pointer" is the part I'm
> > > focusing on. This attack depends on making an indirect call with a
> > > controlled pointer. Non-FineIBT CFI will protect against that step,
> > > so I think this is only an issue for IBT-only and FineIBT, but not CFI
> > > nor CFI+IBT.
> > 
> > Yes, the whole caller side validation should stop this.
> 
> And I think we can retro-fit that in FineIBT. Notably the current call
> sites look like:
> 
> 0000000000000060 <fineibt_caller>:
>   60:   41 ba 78 56 34 12       mov    $0x12345678,%r10d
>   66:   49 83 eb 10             sub    $0x10,%r11
>   6a:   0f 1f 40 00             nopl   0x0(%rax)
>   6e:   41 ff d3                call   *%r11
>   71:   0f 1f 00                nopl   (%rax)
> 
> Of which the last 6 bytes are the retpoline site (starting at 0x6e). It
> is trivially possible to re-arrange things to have both nops next to one
> another, giving us 7 bytes to muck about with.
> 
> And I think we can just about manage to do a caller side hash validation
> in them bytes like:
> 
> 0000000000000080 <fineibt_paranoid>:
>   80:   41 ba 78 56 34 12       mov    $0x12345678,%r10d
>   86:   49 83 eb 10             sub    $0x10,%r11
>   8a:   45 3b 53 07             cmp    0x7(%r11),%r10d
>   8e:   74 01                   je     91 <fineibt_paranoid+0x11>
>   90:   ea                      (bad)
>   91:   41 ff d3                call   *%r11

Ah nice! Yes, that would be great and removes all my concerns about
FineIBT. :) (And you went with EA just to distinguish it more easily?
Can't we still use the UD2 bug tables to find this like normal?)

> And while this is somewhat daft, it would close the hole vs this entry
> point swizzle afaict, no?
> 
> Patch against tip/x86/core (which includes the latest ibt bits as per
> this morning).
> 
> Boots and builds the next kernel on my ADL.

Lovely! Based on the patch, I assume you were testing CFI crash location
reporting too?

I'll try to get this spun up for testing here too.

-- 
Kees Cook
