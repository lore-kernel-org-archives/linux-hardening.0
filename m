Return-Path: <SRS0=pEkV=DM=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A755C4363A
	for <linux-hardening@archiver.kernel.org>; Mon,  5 Oct 2020 16:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E054820774
	for <linux-hardening@archiver.kernel.org>; Mon,  5 Oct 2020 16:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgJEQsY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 5 Oct 2020 12:48:24 -0400
Received: from mother.openwall.net ([195.42.179.200]:53801 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726772AbgJEQsY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 5 Oct 2020 12:48:24 -0400
Received: (qmail 8139 invoked from network); 5 Oct 2020 16:48:22 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 5 Oct 2020 16:48:22 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 6F195AB844; Mon,  5 Oct 2020 18:48:18 +0200 (CEST)
Date:   Mon, 5 Oct 2020 18:48:18 +0200
From:   Solar Designer <solar@openwall.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: Linux-specific kernel hardening
Message-ID: <20201005164818.GA6878@openwall.com>
References: <202009281907.946FBE7B@keescook> <20200929192517.GA2718@openwall.com> <202009291558.04F4D35@keescook> <20200930090232.GA5067@openwall.com> <20201005141456.GA6528@openwall.com> <20201005160255.GA4540@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005160255.GA4540@mit.edu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 05, 2020 at 12:02:55PM -0400, Theodore Y. Ts'o wrote:
> On Mon, Oct 05, 2020 at 04:14:56PM +0200, Solar Designer wrote:
> > > So your suggested use of kernel-hardening@ is for discussions of Linux
> > > kernel hardening projects or work-in-progress that isn't to be submitted
> > > upstream or isn't yet submitted upstream.  If, and as soon as, a patch
> > > series is sent upstream, that should go on the new linux-hardening@
> > > list?  And only in there or also CC'ed to kernel-hardening@?  I'm just
> > > trying to understand.
> > 
> > We need you to comment on the above.  I hope you did have some idea of
> > how the topics would be split between the two lists, but you haven't
> > really specified that yet.  I tried to make guesses in the paragrapht
> > above, so at least you need to confirm whether my guesses are correct,
> > or correct me if they are not.
> 
> Perhaps this would be a helpful way of framing the issue.  The list
> specified in the MAINTAINERS list is the one that is going to be
> automatically returned by the scripts/get_maintainer_pl script.  This
> gets used by kernel newbies who send things like white space fixes and
> spelling corrections to said developer's list.  For most
> vger.kernel.org lists, we mix high-level architectural discussions
> with things like trivial patches.  It sounds like you don't want these
> sorts of administrivia messages sent to the openwall list.  Is that
> correct?

I don't care much whether it's "to the Openwall list" or not, but I do
feel that actual kernel hardening discussions are hampered by the
administrivia, no matter where they occur.  I suggested an easy way to
remove a small portion of the administrivia (by far not all of it, but
a portion that's the easiest to remove): drop the list from MAINTAINERS.
Unfortunately, this contributed to the split of the list in two, which
I'm concerned might not work well.  If I knew where this would lead, I
wouldn't have suggested that.

> If that is true, it's not something that moderation will fix by
> somewhere,

Sure.  I never suggested we could fix that with moderation.

> but it that traffic needs to go *somewhere*.

I thought it wasn't an absolute requirement to have a mailing list
specified for every entry in MAINTAINERS, but if it is then I'm fine
with replacing the two mentions of kernel-hardening in MAINTAINERS with
another list, and I'm also fine with keeping kernel-hardening in there
if the alternative is even worse.

> > I see there are already a few threads on linux-hardening, and those are
> > not CC'ed to kernel-hardening.  I am pleasantly surprised that those
> > threads are about rather minor changes, which while acceptable to have
> > on kernel-hardening as well IMO do not add much value to discussions
> > desirable on kernel-hardening: "Replace one-element array with
> > flexible-array member", "Use flex_array_size() helper", "Use
> > array_size() helper", "Replace one-element array and save heap space",
> > "Use fallthrough pseudo-keyword".
> 
> Exactly, that's the sort of thing that needs its own mailing list, and
> moderation won't fix.

Right, but like you say this is challenging.  It's a surprise to me it
worked OK for a few days, and I doubt that will always be the case.

> The challenge is whether we can get people to subscribe to two lists,

If 100% of the topics on linux-hardening are supposed to be a subset of
what was on kernel-hardening, I think it'd be OK for me to provide the
subscriber list to a vger admin, who would subscribe those people to
linux-hardening.  However, after that point the subscriber lists will
start to differ, and that's actually what we should want if we want a
split of topics at all.  If the same sets of people were on both lists
at all times, then there's obviously no point in the split.

> and redirect messages to the right list when the topic changes.
> Sometimes what starts off as a seemingly trivial patch fix turns intot
> an arhitectural discussion.

This also happens the other way around - an architectural discussion can
result in many administrivia sub-threads resulting from patch review.

> Expecting people to change the mailing
> list name when the scope of the discussion changes is probably not
> realistic --- not to mention that when such a change *does* happen,
> there may be missing context that will be lost since the original
> message started out on "administrivia" list.  (Which is why we
> generally don't separate out those two buckets on the standard kernel
> subsystem lists on vger.)

Right, and this is also why I wouldn't have suggested splitting the
kernel-hardening list, and found this so problematic.  I just felt the
two mentions in MAINTAINERS were unlikely to result in such problems (if
removed or re-pointed to elsewhere), based on what I saw directed to
kernel-hardening via those so far (although I admit I have no reliable
way to determine why exactly a thread was CC'ed to kernel-hardening).

Alexander
