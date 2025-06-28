Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1967F17D2
	for <linux-hardening@vger.kernel.org>; Sat, 28 Jun 2025 01:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751075560; cv=none; b=sDtYTHyBLIpgNRwOZrnsI0BV7Al8YaS9DrhWt6x6MqMMPRs/HCiB9cB+VGkVyRI1XBLmKVM0NkOHButthdPeG/9nC+dfIOUPrsuDRHpYwiFZpNR13BixEHaE3zxhiBDqiL1R7UDxdl06E7rO4H/Aq4wxuWZpm4QtDf7jQBdzu64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751075560; c=relaxed/simple;
	bh=NffUPSkbj1gfeu1piPJZyezUcJfgslp/p6HerefCQtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF5HmRJ2+fZq9Q6+NJj9jjKQW+Zt5zClw6EEOs5+PPnJFD9JliUGFfPM9hBrAt92Gez14fSjf4gufltIeui44IS+UKF/rk35p/zNDAjy+IgyUwYUrEus7JuiW6ogkQnp7hCtkZDF3BvJQZfvIVoqAtOOGysZCvI+q1mShsRdn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([70.33.172.117])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55S1q3WA024139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 21:52:03 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 1736E340663; Fri, 27 Jun 2025 21:52:03 -0400 (EDT)
Date: Fri, 27 Jun 2025 21:52:03 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        selinux@vger.kernel.org, kees@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] Possible TTY privilege escalation in TIOCSTI ioctl
Message-ID: <20250628015203.GA4253@mit.edu>
References: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com>
 <87y0tcu23d.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0tcu23d.fsf@gmail.com>

On Fri, Jun 27, 2025 at 06:38:42PM -0600, Abhinav Saxena wrote:
> >
> > As noted in previous discussion, while CONFIG_LEGACY_TIOCSTI can restrict
> > TIOCSTI usage, it is enabled by default in most distributions. Even when
> > CONFIG_LEGACY_TIOCSTI=n, processes with CAP_SYS_ADMIN can still use TIOCSTI
> > according to the Kconfig documentation.
> >
> > Additionally, CONFIG_LEGACY_TIOCSTI controls the default value for the
> > dev.tty.legacy_tiocsti sysctl, which remains runtime-configurable. This
> > means the described attack vector could work on systems even with
> > CONFIG_LEGACY_TIOCSTI=n, particularly on Ubuntu 24.04 where it’s “restricted”
> > but still functional.

What is the threat scenario that you are concerned about?  The concern
with TIOSTI is that it is a privilege escalation mechanism.  But you
need to have root (well, CAP_SYS_ADMIN) to either enable the
dev.tty.legacy_tiocsti sysctl, or to use TIOCSTI.  So what's the
privilege escalation that you're concerned about?

I could imagine some fairly esoteric ways that this might be a
problem, but if it's not a common case concern, maybe using some kind
of LSM to more forcibly disable TIOCSTI is sufficient?

Yes, we could imagine ways in which it could be permanently disabled
(perhaps via a boot command line option) such that it can't be
re-enabled without rebooting.  But is the extra complexity worth it,
especially when there is always the LSM solution for the
super-paranoid sysadmins?

							- Ted
