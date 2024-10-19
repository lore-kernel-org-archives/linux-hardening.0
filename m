Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F748632;
	Sat, 19 Oct 2024 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729311430; cv=none; b=VPmnN7cI6g3kyiPghoibU+/qZquaRBicon2pVOx2lx5shPKPp8dYBo7wOsy9RQvE7az2bXcztUiNR4sHGOzNKrgTRXogM7/ptlaHUobbOh2sRjdrNWklwamtD03/ZxirN8iUxTxXHZMT09Pub1Zq6xUOJxyk69Uc6LPeSGNcMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729311430; c=relaxed/simple;
	bh=ORboWYAB3a+WiHzlqEMwz+qMTrrxRx3it6Fi2P2A2QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs5dxZbgcElohtOGp+EBKeQ8OddzMq0fMzsBpU450DfouUI+lvD6qiyLbRBjTtyCOUkJvNgFsdpNd9KxYg/ie06me9XweHPtagBkRGoixGvPa+DRbbKBZmx6dwNcU5raqsMpFFXlFPPVCPIWazyrSD8CELZEbVujqptgjAgfNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 49J4DXwK031623;
	Fri, 18 Oct 2024 23:13:33 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 49J4DTL3031612;
	Fri, 18 Oct 2024 23:13:29 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 18 Oct 2024 23:13:29 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, maddy@linux.ibm.com, arnd@arndb.de,
        chentao@kylinos.cn, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] powerpc/spufs: Replace snprintf() with the safer scnprintf() variant
Message-ID: <20241019041329.GL29862@gate.crashing.org>
References: <ZxIcI0QRFGZLCNRl@mail.google.com> <20241018153843.GJ29862@gate.crashing.org> <ZxL0U6bziCxhySUO@mail.google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxL0U6bziCxhySUO@mail.google.com>
User-Agent: Mutt/1.4.2.3i

Hi!

On Sat, Oct 19, 2024 at 12:50:43PM +1300, Paulo Miguel Almeida wrote:
> On Fri, Oct 18, 2024 at 10:38:43AM -0500, Segher Boessenkool wrote:
> > On Fri, Oct 18, 2024 at 09:28:19PM +1300, Paulo Miguel Almeida wrote:
> > > The C99 standard specifies that {v}snprintf() returns the length of the
> > > data that *would have been* written if there were enough space.
> > 
> > Not including the trailing zero byte, and it can also return negative if
> > there was an encoding error.  Yes.
> > 
> > Not that this matters at all for your patch, so why mention it?
> > 
> > 
> > Segher
> 
> Thanks for taking the time to review this patch.
> 
> Is the objection with the change in itself or just the commit message?

Mostly the commit message.  But because it is confusing, it makes the
patch itself uncertain as well.

The patch is probably fine fwiw, as far as I can see.  But the commit
message is not. And the commit message is by far the most important
part of any patch!

> If it's the later, I'm happy to tweak it to what you would like see.

It is not about what I want to see.  It is about what you want to say
to justify the patch!

In this case, just leave out all the irrelevant stuff, just say why you
think scnprintf is better than what you replace?

Everythihng you did say is about why what you are removing was good.
Not a great patch justification :-)


Segher
