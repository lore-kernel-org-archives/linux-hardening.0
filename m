Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A210C77B73
	for <linux-hardening@archiver.kernel.org>; Mon,  5 Jun 2023 20:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjFEUHd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 5 Jun 2023 16:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFEUHd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 5 Jun 2023 16:07:33 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED619E;
        Mon,  5 Jun 2023 13:07:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 10B7363CC10C;
        Mon,  5 Jun 2023 22:07:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id X6roPuzR374K; Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BF45E6081100;
        Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xJjb7zySq9_X; Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9FE3863CC10C;
        Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Date:   Mon, 5 Jun 2023 22:07:30 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        oe-kbuild-all <oe-kbuild-all@lists.linux.dev>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <458187791.3685910.1685995650602.JavaMail.zimbra@nod.at>
In-Reply-To: <CADmuW3WXDg-5SFXkMDE6BmvSwLNHmXpTzBonaOL8eErc4+d3qQ@mail.gmail.com>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com> <202305311135.zGMT1gYR-lkp@intel.com> <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org> <103925562.158061.1685514200368.JavaMail.zimbra@nod.at> <CAMuHMdU70uRxnMNb8KCJe8M3BRPPxowRXtj+POcrh+KLkfQyAA@mail.gmail.com> <CADmuW3WXDg-5SFXkMDE6BmvSwLNHmXpTzBonaOL8eErc4+d3qQ@mail.gmail.com>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Replace all non-returning strlcpy with strscpy
Thread-Index: F0kvDMRUOo3WCvHaQMtuD24L4U1LkA==
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Azeem Shaikh" <azeemshaikh38@gmail.com>
> Planning to send out v2 with the fixup from Richard applied. Let me
> know if that's ok.

Fine by me. :-)

Thanks,
//richard
