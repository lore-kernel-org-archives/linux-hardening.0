Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3015C4332F
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Dec 2022 20:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiL1U5b (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Dec 2022 15:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiL1U5b (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Dec 2022 15:57:31 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [185.233.100.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E468167C2;
        Wed, 28 Dec 2022 12:57:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 867F0640;
        Wed, 28 Dec 2022 21:57:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hera.aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HCs0dfKZ8YnL; Wed, 28 Dec 2022 21:57:27 +0100 (CET)
Received: from begin.home (2a01cb008c016e00de41a9fffe47ec49.ipv6.abo.wanadoo.fr [IPv6:2a01:cb00:8c01:6e00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 0A2653E7;
        Wed, 28 Dec 2022 21:57:27 +0100 (CET)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@aquilenet.fr>)
        id 1pAdUM-005Zph-1D;
        Wed, 28 Dec 2022 21:57:26 +0100
Date:   Wed, 28 Dec 2022 21:57:26 +0100
From:   Samuel Thibault <samuel.thibault@aquilenet.fr>
To:     Kees Cook <kees@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Message-ID: <20221228205726.rfevry7ud6gmttg5@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@aquilenet.fr>,
        Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221022182828.give.717-kees@kernel.org>
 <20221022182949.2684794-2-keescook@chromium.org>
 <20221227234000.jgosvixx7eahqb3z@begin>
 <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

Kees Cook, le mar. 27 déc. 2022 19:32:55 -0800, a ecrit:
> On December 27, 2022 3:40:00 PM PST, Samuel Thibault <samuel.thibault@aquilenet.fr> wrote:
> >Kees Cook, le sam. 22 oct. 2022 11:29:49 -0700, a ecrit:
> >> TIOCSTI continues its long history of being used in privilege escalation
> >> attacks[1]. Prior attempts to provide a mechanism to disable this have
> >> devolved into discussions around creating full-blown LSMs to provide
> >> arbitrary ioctl filtering, which is hugely over-engineered -- only
> >> TIOCSTI is being used this way. 3 years ago OpenBSD entirely removed
> >> TIOCSTI[2], Android has had it filtered for longer[3], and the tools that
> >> had historically used TIOCSTI either do not need it, are not commonly
> >> built with it, or have had its use removed.
> >
> >No. The Brltty screen reader entirely relies on TIOCSTI to be able to
> >support input from various Braille devices. Please make sure to keep
> >TIOCSTI enabled by default, otherwise some people would just completely
> >lose their usual way of simply typing on Linux.
> 
> Yup, it remains default enabled:

Yes, but thining of it, very soon people in various security-sensitive
distributions will disable it, as they should indeed. And people who
need to use their Braille device on such distributions will get stuck.

Can we perhaps just introduce a CAP_TIOCSTI that the brltty daemon would
be able to use? We could even make it only allow TIOCSTI on the linux
console (tty->ops == con_ops).

> Also, what does FreeBSD use for screen readers?

FreeBSD provides poor support for that, people have to use a patched
screen tool to somehow access the console (but only after login).

Samuel
