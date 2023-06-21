Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9485CEB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Jun 2023 00:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFUAPF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Jun 2023 20:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFUAPD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Jun 2023 20:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DB71987;
        Tue, 20 Jun 2023 17:15:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28CD8611D2;
        Wed, 21 Jun 2023 00:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A339C433C8;
        Wed, 21 Jun 2023 00:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687306499;
        bh=oNWBDRKApdOLxdjKV1Rj6TJLCQPQyXjERxHyoSwvcnU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=uMSEWNGYINBquxtH48bJhslQuNw5lB8rU6TotOiezIQZUXsnhRwuNsFkK1saArPiS
         LYIMEoiUF6cU0Dbls+wLnKtP0uCUglXFIVj/PrB7NYMTw3PdZdNI/yQDxhGBSxQuNo
         PX8qN1SQYOkw/a1mUZyAylOpi/mv0sFmHz0Jv6dd9mk2XrNuso72qV+sNblQTDK1zC
         1dpuWK/sBqieGeFe6ohug9/tjEBL48ZNbOKi40r7P9RnJ2ONKyDdoHvyfaKqGDhhNc
         1BiqZxFS7IUTglt2ypYlBwLAQzoEKnCe2JaLwrveMCK+YV1pKv0TH7ENjXxZurq7ZB
         X6ITcbVMPPgkA==
Date:   Tue, 20 Jun 2023 17:14:57 -0700
From:   Kees Cook <kees@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Kees Cook <keescook@chromium.org>
CC:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nios2: Replace all non-returning strlcpy with strscpy
User-Agent: K-9 Mail for Android
In-Reply-To: <40af3815-b0ee-e96f-f7a8-9f0fe9f938d0@kernel.org>
References: <20230530162358.984149-1-azeemshaikh38@gmail.com> <202305301620.346CC541@keescook> <45ed31e0-9ecd-56ea-c0d4-3c68a3fd8cf5@kernel.org> <202306201313.C425BCB@keescook> <40af3815-b0ee-e96f-f7a8-9f0fe9f938d0@kernel.org>
Message-ID: <E72EB2A4-7165-47ED-B5D2-8F468B281FA3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On June 20, 2023 3:27:29 PM PDT, Dinh Nguyen <dinguyen@kernel=2Eorg> wrote:
>
>
>On 6/20/23 15:15, Kees Cook wrote:
>> On Tue, Jun 13, 2023 at 05:15:41PM -0500, Dinh Nguyen wrote:
>>>=20
>>>=20
>>> On 5/30/23 18:20, Kees Cook wrote:
>>>> On Tue, May 30, 2023 at 04:23:58PM +0000, Azeem Shaikh wrote:
>>>>> strlcpy() reads the entire source buffer first=2E
>>>>> This read may exceed the destination size limit=2E
>>>>> This is both inefficient and can lead to linear read
>>>>> overflows if a source string is not NUL-terminated [1]=2E
>>>>> In an effort to remove strlcpy() completely [2], replace
>>>>> strlcpy() here with strscpy()=2E
>>>>> No return values were used, so direct replacement is safe=2E
>>>>>=20
>>>>> [1] https://www=2Ekernel=2Eorg/doc/html/latest/process/deprecated=2E=
html#strlcpy
>>>>> [2] https://github=2Ecom/KSPP/linux/issues/89
>>>>>=20
>>>>> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail=2Ecom>
>>>>=20
>>>> Reviewed-by: Kees Cook <keescook@chromium=2Eorg>
>>>>=20
>>>=20
>>> Applied!
>>=20
>> Thanks for taking this patch! I just wanted to double-check, though; I
>> haven't seen it show up in -next yet=2E Is this still queued?
>>=20
>> Thanks!
>
>I've queued it for v6=2E5=2E Do you need it in v6=2E4?

6=2E5 is fine, yeah=2E I just wanted to make sure it didn't get lost=2E :)=
 (I didn't see it in sfr's linux-next merges tree=2E)

Thanks!

-Kees



--=20
Kees Cook
