Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A29DC04A6A
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Aug 2023 20:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjHHURa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbjHHURN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Aug 2023 16:17:13 -0400
X-Greylist: delayed 5427 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 12:20:57 PDT
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2899D1657F
        for <linux-hardening@vger.kernel.org>; Tue,  8 Aug 2023 12:20:57 -0700 (PDT)
Received: from 212-39-89-7.ip.btc-net.bg ([212.39.89.7] helo=[192.168.14.227])
        by www.kot-begemot.co.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qTFpV-000Srs-NP; Tue, 08 Aug 2023 06:04:32 +0000
Message-ID: <0bdda692-25a3-227c-69ef-341f037e1dd7@cambridgegreys.com>
Date:   Tue, 8 Aug 2023 07:04:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] um: vector: refactor deprecated strncpy
To:     Justin Stitt <justinstitt@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
References: <20230807-arch-um-drivers-v1-1-10d602c5577a@google.com>
Content-Language: en-US
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230807-arch-um-drivers-v1-1-10d602c5577a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 07/08/2023 19:22, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> In this case, we are able to drop the now superfluous `... - 1`
> instances because `strscpy` will automatically truncate the last byte by
> setting it to a NUL byte if the source size exceeds the destination size
> or if the source string is not NUL-terminated.
> 
> I've also opted to remove the seemingly useless char* casts. I'm not
> sure why they're present at all since (after expanding the `ifr_name`
> macro) `ifr.ifr_ifrn.ifrn_name` is a char* already.
> 
> All in all, `strscpy` is a more robust and less ambiguous interface
> while also letting us remove some `... -1`'s which cleans things up a
> bit.
> 
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> [2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>   arch/um/drivers/vector_user.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index c650e428432b..c719e1ec4645 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -141,7 +141,7 @@ static int create_tap_fd(char *iface)
>   	}
>   	memset(&ifr, 0, sizeof(ifr));
>   	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
> -	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
> +	strscpy(ifr.ifr_name, iface, sizeof(ifr.ifr_name));
>   
>   	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
>   	if (err != 0) {
> @@ -171,7 +171,7 @@ static int create_raw_fd(char *iface, int flags, int proto)
>   		goto raw_fd_cleanup;
>   	}
>   	memset(&ifr, 0, sizeof(ifr));
> -	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
> +	strscpy(ifr.ifr_name, iface, sizeof(ifr.ifr_name));
>   	if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
>   		err = -errno;
>   		goto raw_fd_cleanup;
> 
> ---
> base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
> change-id: 20230807-arch-um-drivers-ad44050885d0
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
