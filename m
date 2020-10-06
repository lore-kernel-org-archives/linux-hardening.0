Return-Path: <SRS0=b1nQ=DN=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DD8C4363D
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Oct 2020 14:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8866320760
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Oct 2020 14:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgJFOVd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Oct 2020 10:21:33 -0400
Received: from mother.openwall.net ([195.42.179.200]:35393 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725947AbgJFOVd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Oct 2020 10:21:33 -0400
Received: (qmail 11592 invoked from network); 6 Oct 2020 14:21:31 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 6 Oct 2020 14:21:31 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 6392FAB844; Tue,  6 Oct 2020 16:21:27 +0200 (CEST)
Date:   Tue, 6 Oct 2020 16:21:27 +0200
From:   Solar Designer <solar@openwall.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org
Subject: Re: Linux-specific kernel hardening
Message-ID: <20201006142127.GA10613@openwall.com>
References: <202009281907.946FBE7B@keescook> <20200929192517.GA2718@openwall.com> <202009291558.04F4D35@keescook> <20200930090232.GA5067@openwall.com> <20201005141456.GA6528@openwall.com> <20201005160255.GA4540@mit.edu> <20201005164818.GA6878@openwall.com> <CAG48ez0MWfA8zPxh5s5i2w9W7F+MxfjMXf6ryvfTqooomg1HUQ@mail.gmail.com> <202010051538.55725193C7@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010051538.55725193C7@keescook>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 05, 2020 at 03:39:26PM -0700, Kees Cook wrote:
> On Tue, Oct 06, 2020 at 12:26:50AM +0200, Jann Horn wrote:
> > On Mon, Oct 5, 2020 at 6:48 PM Solar Designer <solar@openwall.com> wrote:
> > > If 100% of the topics on linux-hardening are supposed to be a subset of
> > > what was on kernel-hardening, I think it'd be OK for me to provide the
> > > subscriber list to a vger admin, who would subscribe those people to
> > > linux-hardening.
> > 
> > (if folks want to go that route, probably easier to subscribe the list
> > linux-hardening@ itself to kernel-hardening@ instead of syncing
> > subscriber lists?)
> 
> Yeah, that would make things a bit simpler. Solar, would you be willing
> to do that? (Then I can tweak the wiki instructions a bit more.)

Sure, I can do that.  Should I?

Per http://vger.kernel.org/vger-lists.html#linux-hardening there are
currently 39 subscribers on the new list.  I guess most of those are
also on kernel-hardening, and would start receiving two copies of
messages that are posted to kernel-hardening.  I guess they would then
need to unsubscribe from kernel-hardening if they want to see the
content of both lists, or to unsubscribe from linux-hardening if they
changed their mind and only want the content of kernel-hardening.  I
think this is still not too many people, so this is reasonable; if we
were to do it later, we'd inconvenience more people.

Alexander
