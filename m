Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3026245FFA6
	for <linux-hardening@vger.kernel.org>; Sun, 11 Oct 2026 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791730237; cv=none; b=er+9oAqtqQtpy/fmUGArbNi0JJS5sSzxfJiMi4ccRJ4/1oXxUOEIFS9pk7b9DQlN4sUHhWTiQVyIfoNpJB7b1EpaorwI8Dh5xrEYU1nLHJCXJBIrMKYcxO5/YM4CqCrjs9NWRooO5Mdpw9ARnyTiPc9VZ6vitpQ9B+jzUrxxqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791730237; c=relaxed/simple;
	bh=451U8wT6306fQVR8c3dY211dJoLz8Bbcz/mm3qFJUQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzMCRPF5BRyE17K0yZLi7YXOVvvgS5e8u2BIutdPpqq5M0Qtf83mqCjr0Z8Sa5giblkTIjeBoXwspqVY3M5tevKm/mwLivBY7rr018HoB5hL58Jh3/5w89HEuhiRBOt1nOKZ42Y5Yf0/xzany1CCdhy9u5LKBWkbj0mMdqyWtS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=E9lN6Yf5; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="E9lN6Yf5"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j2jjK2d7WzPVF;
	Sun, 11 Oct 2026 16:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791729125;
	bh=9wL5SmyG8IO2xoRgdgsn4ftkOzFmBpqAbzkKDufb874=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9lN6Yf5KPacMG7RJkNghhavnhABKEqAaFzJGDMMn1d5vN8TUaqvB+wOSdTWXZif7
	 btsPeU6wgZPKLQuJu6O4soORJsdvuUGmEnugIw68NiWO9p6qXE2GvPMieq1wIbYJMs
	 /JpxzgbVuv3eppHbLAWImqeuDYHZH8yysUjELC4g=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4j2jjJ1DJLzkrw;
	Sun, 11 Oct 2026 16:32:04 +0200 (CEST)
Date: Sun, 11 Oct 2026 16:31:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Tingmao Wang <m@maowtm.org>, 
	linux-security-module@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Subject: Re: [PATCH] landlock: Drop __counted_by from landlock_domain.layers
Message-ID: <20261011.oe8teu2LahTh@digikod.net>
References: <6ac91e98.bbc4c7f9.15faa7.0023.GAE@google.com>
 <20261010164450.194439-1-ngocthang2710.1999@gmail.com>
 <20261011.c1055cd53b32@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011.c1055cd53b32@gnoack.org>
X-Infomaniak-Routing: alpha

On Sun, Oct 11, 2026 at 03:11:12PM +0200, Günther Noack wrote:
> On Sat, Oct 10, 2026 at 11:44:49PM +0700, Nguyen Ngoc Thang wrote:
> > With clang 22 and CONFIG_FORTIFY_SOURCE, the second
> > landlock_restrict_self() call hits a bogus fortify report in
> > inherit_ruleset():
> > 
> >   memcpy: detected buffer overflow: 16 byte read of buffer size 0
> >   Call Trace:
> >    __fortify_panic
> >    landlock_merge_ruleset+0xc46/0xc90
> >    __se_sys_landlock_restrict_self+0x2bc/0xd40
> > 
> > layers[] lives in an anonymous struct inside the anonymous union
> > that overlays work_free.  For such a flexible array, clang computes the
> > address of the __counted_by counter as the start of the array instead of
> > &num_layers.  The bound is then read from layers[0], i.e. from
> > the first layer's configuration, which is not a count.  The same layout
> > crashes clang itself in a standalone test.
> > 
> > The annotation was added as documentation, so drop it rather than
> > restructure the union.  Keep the information in the member comment.
> > 
> > Reported-by: syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=a0eecb22de4d821a9e5d
> > Fixes: bd3a19800dd1 ("landlock: Add counted_by in landlock_domain")
> > Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Thanks for the patch.

> > ---
> > Reproduced with clang 22.1.8 and FORTIFY_SOURCE on mic/next (64b9e6eff524):
> > the second landlock_restrict_self() hits the report, while 16 nested
> > restricts run clean with this patch.  Mickaël, if you prefer to just drop
> > bd3a19800dd1 from next, that works as well.
> >  security/landlock/domain.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> > index 60e8eb2d6ac2..4bf1555a4349 100644
> > --- a/security/landlock/domain.h
> > +++ b/security/landlock/domain.h
> > @@ -246,8 +246,12 @@ struct landlock_domain {
> >  			 * properly handle merged rulesets without overlapping
> >  			 * access rights.  These layers are set once and never
> >  			 * changed for the lifetime of the domain.
> > +			 *
> > +			 * Not annotated with __counted_by(@num_layers): clang
> > +			 * miscomputes the counter address for a FAM nested in an
> > +			 * anonymous struct within a union, which trips FORTIFY.
> >  			 */
> > -			struct layer_config layers[] __counted_by(num_layers);
> > +			struct layer_config layers[];
> >  		};
> >  	};
> >  };
> > -- 
> > 2.43.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> 
> I agree - it seems better to drop the __counted_by rather than
> restructuring the entire struct for that.
> 
> Thanks also for adding a comment about it.  The __counted_by() has
> only been added very recently in September, in commit bd3a19800dd1
> ("landlock: Add counted_by in landlock_domain").  Better to have a
> note about it so that we don't accidentally add it back. :)

Actually, I independently wrote a quite similar patch (while traveling),
but it applies to v7.3-rc5 instead of mic/next.  I removed the patch
series that I applied on mic/next because it conflicts with my patch and
I need to send a new version anyway.  If you don't mind, I'll keep
Günther's Reviewed-by tag and credit other contributors in my patch.
I'll propose it for v7.3-rc7 (today) because it is trivial and will help
new patches on top of that.
