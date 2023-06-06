Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9723C7EE37
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Jun 2023 20:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjFFUwG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Jun 2023 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbjFFUwE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Jun 2023 16:52:04 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC101717;
        Tue,  6 Jun 2023 13:52:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8F00B63CC103;
        Tue,  6 Jun 2023 22:51:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PHgZNUdjvgcB; Tue,  6 Jun 2023 22:51:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BE5DF608F44F;
        Tue,  6 Jun 2023 22:51:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aN1OkdMjbyuq; Tue,  6 Jun 2023 22:51:57 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 940C063CC103;
        Tue,  6 Jun 2023 22:51:57 +0200 (CEST)
Date:   Tue, 6 Jun 2023 22:51:57 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Message-ID: <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
In-Reply-To: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
Subject: Re: [PATCH v2] uml: Replace strlcpy with strscpy
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Replace strlcpy with strscpy
Thread-Index: kDC0hXVrB1XbeTt1tCVxurpE9ug2qA==
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Azeem Shaikh" <azeemshaikh38@gmail.com>
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@intel.com/

Are you sure Reported-by and Closes make sense?
AFAIK the report was only on your first patch and nothing against upstream.
So stating this in the updated patch is in vain.

Other than that,
Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
