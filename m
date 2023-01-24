Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6A7C54E94
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Jan 2023 19:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjAXTjX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjAXTjJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Jan 2023 14:39:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CE737F21;
        Tue, 24 Jan 2023 11:38:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E22EB6132F;
        Tue, 24 Jan 2023 19:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076E3C433EF;
        Tue, 24 Jan 2023 19:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674589088;
        bh=xskT3KnwkyFLprec2IlaRirgxO1LovXoHkpjNb/gJ1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGX2BR1NivoX64yXLnw2GadSQj6oZ6MwDKQwi+whK2XwKu78q1Z84/Q0KH3l1ndiu
         WRCLU4yC5YkBglzZ3/XdB7pPzqwmSDz8F8REbFFMNCUcknKIQ+q0ZO582QMFJnMVm+
         328BmjttvgFGtxPDt3bB1+WD+JBtu4xTIt5P1ZzQAJCFvI1tsjCmP8DSrp9c3EW9hW
         OvCIMCkMkH91ZyZGL4sj/irS0GnbFfmjUDpAnMM8nRmJI073Ie9H2ER3cqWhjHI/hc
         8J5xZW2Quh7v4+zXbLYfEzD6UQxWyEhYbQrm4IaqHq+E1dBZgzuqXY/a7DonF21GA2
         wVQvXA6Culsaw==
Date:   Tue, 24 Jan 2023 11:38:05 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Seth Jenkins <sethjenkins@google.com>,
        SeongJae Park <sj@kernel.org>, Jann Horn <jannh@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/6] exit: Put an upper limit on how often we can oops
Message-ID: <Y9AzndICHRElk4jI@sol.localdomain>
References: <20221117234328.594699-2-keescook@chromium.org>
 <20230119201023.4003-1-sj@kernel.org>
 <CALxfFW76Ey=QNu--Vp59u2wukr6dzvOE25PkOHVw0b13YoCSiA@mail.gmail.com>
 <202301191627.FC1E24ED5@keescook>
 <Y9ApdF5LaUl9dNFm@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9ApdF5LaUl9dNFm@sol.localdomain>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 24, 2023 at 10:54:57AM -0800, Eric Biggers wrote:
> On Thu, Jan 19, 2023 at 04:28:42PM -0800, Kees Cook wrote:
> > On Thu, Jan 19, 2023 at 03:19:21PM -0500, Seth Jenkins wrote:
> > > > Do you have a plan to backport this into upstream LTS kernels?
> > > 
> > > As I understand, the answer is "hopefully yes" with the big
> > > presumption that all stakeholders are on board for the change. There
> > > is *definitely* a plan to *submit* backports to the stable trees, but
> > > ofc it will require some approvals.
> > 
> > I've asked for at least v6.1.x (it's a clean cherry-pick). Earlier
> > kernels will need some non-trivial backporting. Is there anyone that
> > would be interested in stepping up to do that?
> > 
> > https://lore.kernel.org/lkml/202301191532.AEEC765@keescook
> > 
> 
> I've sent out a backport to 5.15:
> https://lore.kernel.org/stable/20230124185110.143857-1-ebiggers@kernel.org/T/#t

Also 5.10, which wasn't too hard after doing 5.15:
https://lore.kernel.org/stable/20230124193004.206841-1-ebiggers@kernel.org/T/#t

- Eric
