Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1A7CA0FE2
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Sep 2023 16:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjIEQXn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344760AbjIEDxi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 4 Sep 2023 23:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B49CCF
        for <linux-hardening@vger.kernel.org>; Mon,  4 Sep 2023 20:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89A306115C
        for <linux-hardening@vger.kernel.org>; Tue,  5 Sep 2023 03:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5106C433C7;
        Tue,  5 Sep 2023 03:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693886011;
        bh=2Tt27aPoIM/AL822212rYJakGr4phaOlrKxLY65dfRc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ZE8jq185aVpuTpfi+0B6tJcOKYA00muUdT5zw+lm6Nn3hB14/6s02yAKZ/lc6rjqi
         ATB3gPKpaXlRhKC1d0hYGbjMZ71NJYGc7RZnLG29md81GpQHJQ0MvC6tuuN/V4FAZF
         S9v/ngEvOzn5Kpc90pZhsc7oWpem4pK9LEWBW1pYBAGBqp6APYA2KvzV7MgHJCITrx
         D5s17RmA9zBIUoQAwuEu3nOoLcJfv7pnq+WgYo3yYA3r8Xqi6us9LyztbH740mYcKI
         F3AknOE6u+9xXvEIusbCD3PsQmDi2JjYgfoCHDU8XPE4/4B0PQcqqXHU2/qFf8qB62
         L0thO6iB7hRDg==
Date:   Mon, 04 Sep 2023 20:53:27 -0700
From:   Kees Cook <kees@kernel.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        netdev@vger.kernel.org
CC:     Kees Cook <keescook@chromium.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Anthony Nguyen <anthony.l.nguyen@intel.com>,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [RFC net-next v4 0/7] introduce DEFINE_FLEX() macro
User-Agent: K-9 Mail for Android
In-Reply-To: <20230904123107.116381-1-przemyslaw.kitszel@intel.com>
References: <20230904123107.116381-1-przemyslaw.kitszel@intel.com>
Message-ID: <78830434-CCE0-4DF5-829C-F0D78AE35E79@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On September 4, 2023 5:31:00 AM PDT, Przemek Kitszel <przemyslaw=2Ekitszel@=
intel=2Ecom> wrote:
>Add DEFINE_FLEX() macro, that helps on-stack allocation of structures
>with trailing flex array member=2E
>Expose __struct_size() macro which reads size of data allocated
>by DEFINE_FLEX()=2E
>
>Accompany new macros introduction with actual usage,
>in the ice driver - hence targeting for netdev tree
>- please me know if it is best approach here?

Yes, I'm fine with this=2E The changes to the string headers are relativel=
y localized=2E


--=20
Kees Cook
