Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74542EB64DA
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Jul 2023 23:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjGGXKZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Jul 2023 19:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGXKY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Jul 2023 19:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11CE1FEC
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jul 2023 16:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A7BA61ABD
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jul 2023 23:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1046C433C8;
        Fri,  7 Jul 2023 23:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688771422;
        bh=dv6iWScx7lbvbV3iu51S7vQKCUAG3YSAdS49yZthJw4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=EElzBwIMVTtMxK5lvA7cie7sLsPE0FAZkoPYuYI4NtE4OSO+/s1UkxuCUwG36vXAW
         QiwkRj1KKyrz7jO+07TJZFGckO6R/XbICUkRiR7g5HJe/HrxrI0XoJ7DzqYqUl1n6m
         Y+/xhWyI9nrbU1thJRzxcjF0fkpsYRz1q0LC+JuDnnxm/Gg/CotNWQqZHfrr+jyd4+
         yKBGGtFC/LOTAwY+wQOyGrbXOwr2q7LhcOSSC/3G6CFBcGbeOaM+KpiO8QBMaD3aCa
         TF6DsAP8IKFC00CAl4JehsQkCremxgoa27aVLgJVlo0jGU9EziuWTy+ahJ05PhHc5W
         nqsgKDL7vSYng==
Date:   Fri, 07 Jul 2023 16:10:19 -0700
From:   Kees Cook <kees@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-hardening@vger.kernel.org
CC:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 1/2] pstore: Remove worst-case compression size logic
User-Agent: K-9 Mail for Android
In-Reply-To: <b610a5a3-5ae7-ae33-5501-b6748c1ac1ad@igalia.com>
References: <20230707083456.2501913-1-ardb@kernel.org> <20230707083456.2501913-2-ardb@kernel.org> <b610a5a3-5ae7-ae33-5501-b6748c1ac1ad@igalia.com>
Message-ID: <96746682-994D-4919-8D57-D40D6927A128@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On July 7, 2023 1:57:29 PM PDT, "Guilherme G=2E Piccoli" <gpiccoli@igalia=
=2Ecom> wrote:
>On 07/07/2023 05:34, Ard Biesheuvel wrote:
>> From: Kees Cook <keescook@chromium=2Eorg>
>> [=2E=2E=2E]=20
>>=20
>> Co-developed-by: Kees Cook <keescook@chromium=2Eorg>
>> Signed-off-by: Kees Cook <keescook@chromium=2Eorg>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel=2Eorg>
>> [=2E=2E=2E]
>
>
>Out of curiosity, why Kees is author but at the same time, he is a
>co-developer? heh
>
>Maybe it was Ard as either author or co-developer?

I think that when Ard added the co-dev tag for me he forget to reset the "=
author" according to git=2E

-Kees


--=20
Kees Cook
