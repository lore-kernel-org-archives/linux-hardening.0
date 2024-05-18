Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DCA5C96
	for <linux-hardening@vger.kernel.org>; Sat, 18 May 2024 02:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716000732; cv=none; b=iH5AQ16C5odHZY1v5OuZ1jJiLFC3EutydiHnugIv+E0mckNJBK8yWCkz8f/V1VyZ1evzQ+lnPCU5jK1M+qx9/lIgM+PQxVhYXbFhVCOYxZ9Qax/GTjza4NsQ/D5nZLG2xDykNoj5wkj/3vLqKA+HQ1DNPidiiaUaGufpT0kbpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716000732; c=relaxed/simple;
	bh=lC+UuqrrhxBZ4HXaHuVXVjAyo+ZKJUa4m3pg7ARfQEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vov5jJAk8xjkLYS6+vjOZc5q/ClfiDxylCj4rBb8F7gGq4cPPRJPr1geb/swVjuPtAwoEo/4/YdPKv9q6dGDhpUEEnOXC1fdFSc+efs2DUIrPGK6psh1MF5xt4lI1tI9yVjcLmD4gTSd8Qh1VtW1S4pM1hdv1TCneeeHgPnaaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=BIzc3gPe; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="BIzc3gPe"
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44I2pgHB019399
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 22:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1716000706; bh=s6H0ekAYTqQqsWhB6DKQdfNQEET3nF5q2NYPIZQQObU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=BIzc3gPeIQcx5XQrol1l6lfy6WlGqb0D4ODTq8ZDPe7DXudG0xIVS0dNcy34aVaga
	 kAOgYra57xIdVipn1lXVcwBpZRVy1/yhOi9JsnpHkCnLLsg+xcRz1i3dQmtrzfb2yC
	 TgdUZwtMdluqbYx/L1QMxh8I7kYUyZZ33VaG+D3NH3l/MdJpJ1MCSNf9j54WI2nUEn
	 q9RzOK8SBfxEEBby04WkRaF68kASP4lwLRrLkhwND33FiIW5jUQGubD9vbchvZd3l/
	 twhLe3L1M5ocFGjkTXvp+k0XApGRZRmhMUKIyzJxgYPHglq7+bY+OnPm0nta4SFrTw
	 M2AcB2kFnALng==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 876D415C00DC; Fri, 17 May 2024 22:51:42 -0400 (EDT)
Date: Fri, 17 May 2024 22:51:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <20240518025142.GB65648@mit.edu>
References: <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <20240515073636.GY40213@noisy.programming.kicks-ass.net>
 <25882715-FE44-44C0-BB9B-57F2E7D1F0F9@kernel.org>
 <20240516140951.GK22557@noisy.programming.kicks-ass.net>
 <CAFhGd8qCCCrccQ2z5bjBD5YcMWHkym9aVz_qYkyyj662XEeHvA@mail.gmail.com>
 <20240516205134.GC287325@mit.edu>
 <202405171329.019F2F566C@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405171329.019F2F566C@keescook>

On Fri, May 17, 2024 at 02:15:01PM -0700, Kees Cook wrote:
> On Thu, May 16, 2024 at 02:51:34PM -0600, Theodore Ts'o wrote:
> > On Thu, May 16, 2024 at 12:48:47PM -0700, Justin Stitt wrote:
> > > 
> > > It is incredibly important that the exact opposite approach is taken;
> > > we need to be annotating (or adding type qualifiers to) the _expected_
> > > overflow cases. The omniscience required to go and properly annotate
> > > all the spots that will cause problems would suggest that we should
> > > just fix the bug outright. If only it was that easy.
> > 
> > It certainly isn't easy, yes.  But the problem is when you dump a huge
> > amount of work and pain onto kernel developers, when they haven't
> > signed up for it, when they don't necessarily have the time to do all
> > of the work themselves, and when their corporate overlords won't given
> > them the headcount to handle unfunded mandates which folks who are
> > looking for a bright new wonderful future --- don't be surprised if
> > kernel developers push back hard.
> 
> I never claimed this to be some kind of "everyone has to stop and make
> these changes" event. I even talked about how it would be gradual and
> not break existing code (all "WARN and continue anyway"). This is what
> we've been doing with the array bounds work. Lots of people are helping
> with that, but a lot of those patches have been from Gustavo and me; we
> tried to keep the burden away from other developers as much as we could.

Kees, sorry, I wasn't intending to be criticism of your work; I know
you've been careful.  What I was reacting was Justin's comment that
it's important to annotate every single expected overflow case.  This
sounded like the very common attitude of "type II errors must be
avoided at all costs", even in that means a huge number of "type I
errors".  And false positive errors invariably end up requiring work
on the part of over-worked maintainers.

From my perspective, it's OK if we don't find all possible security
bugs if we can keep the false negative rate down to near-zero.
Because if it's too high, I will just start ignoring all of the
"security reports", just out of self-defense.  This is now the case
with clusterfuzz reports example.  The attemp[t to shame/pressure me
with "fix this RIGHT NOW or we will make the report public in 30 days"
no longer works on me, because the vast majority of the reports
against e2fsprogs are bullshit.  And there are many syzkaller reports
which are also bullshit, and when they are reported against our data
center kernels, they get down-prioritized to P3 and ignored, because
they can't happen in real life.  But they still get reported to
upstream (me).

This is why I am worried when there are proposals to add new
sanitizers; even if they are used responsibly by you, I can easily see
them resulting in more clusterfuzz reports (for example) that I will
have to ignore as bullshit.  So please considerr this a plea to
**really** seriously reduce the false positive rate of sanitizers
whenever possible.

Cheers,

					- Ted
