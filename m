Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED20EEB64D8
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Jun 2023 14:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjFVOZ5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Jun 2023 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFVOZ4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Jun 2023 10:25:56 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF376E2
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 07:25:54 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 45A4E261567;
        Thu, 22 Jun 2023 14:25:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a222.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CA807261D37;
        Thu, 22 Jun 2023 14:25:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687443953; a=rsa-sha256;
        cv=none;
        b=ZoIZMiRAbUiGYhcrSOpD53+bsuD71PpCJMm9unS4RxaRw6ANoMbGsShGh1KO9E4OkcbjXW
        xmnGi9NmrAzYKpk1059qN8OxM4Gu9NVUKNRW5aeMDKmCdTES04a2pIrIuegw7aK3ySOIif
        g3lUAiOtwqJ6IEpREKREHtdmptHNqWkH2Z9aMvAfYxqNH/Ab7+bgJKlXqqVI8zdfkMVYg/
        nBwJSxCw/efXdPr8rhCJ9xXxzw4UYmM+09CtCzisBukmNZ+4CtjHXlXYETPeRlr1Nn1Bpk
        gJmlIR0P7DyHGq6GZv6GoTUbw6PnYoLmkln2Si2XuKdSu4RqjEEitdKicNd4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687443953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=1XaMIEOIpFCgVI3AkBJI+hbR5+jkWNHo0FSN5LpUksc=;
        b=T5dBldBdvlj2OSgm4C3Mw9gyfH6QP5Eu5nBtRpCAGgxIx3jDlj8GGpDyW2ezhmPoa+ua79
        xbe7oRDyNSDjxesuDASj3IfTWSzTu5Ed6osjsguUhb/3hihYybY9hq8v7CEBp2EBs/uxBK
        ULaohnlCSFq2OIl881QbUm1XKPerMPaCT2rSfbsFmeV6KSlm7SPt4FOTjY0cSCf1gF8aKi
        rHH75tRHBeSfVdtJlq8a/5np9Vn/11qkaZckq+rhb3rwBfLqFAfgZnssL+b5m0vihThtEb
        Nzyb7ePxYnDq0LGkRM8HtV+J7rcQ3mHMRRwB0uKe2mxGRPbf8lXEOlR175KceA==
ARC-Authentication-Results: i=1;
        rspamd-9fcc56855-twxqs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Supply-Gusty: 226003e74f1c2b46_1687443954065_2201362872
X-MC-Loop-Signature: 1687443954065:2513499042
X-MC-Ingress-Time: 1687443954065
Received: from pdx1-sub0-mail-a222.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.91 (trex/6.9.1);
        Thu, 22 Jun 2023 14:25:54 +0000
Received: from [192.168.0.182] (bras-vprn-toroon4834w-lp130-09-174-91-45-44.dsl.bell.ca [174.91.45.44])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a222.dreamhost.com (Postfix) with ESMTPSA id 4Qn2jF2Dqtz3V;
        Thu, 22 Jun 2023 07:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
        s=dreamhost; t=1687443953;
        bh=1XaMIEOIpFCgVI3AkBJI+hbR5+jkWNHo0FSN5LpUksc=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=loVPWD+tgUjH3kjzlu18o4WjewQm3nx6/V3OfHsvPu8j+RBa/Vw5A+qPKjylPeoCM
         Ak7PHzKEuLc1/W5nRGKnXtrxCsPPz28jK+Mir4P9l4cWiuO6pIc+vnqdXZXlFikNvl
         XRL3Iy4IV2l/ihFPjFgto+39YbVl8usQTxOff5PlWGH8ant2eCQBqzflUCEyurSyAa
         j21jJQ5GAdrh/5GRyZAgEemc/HewxLMwscICmVjRJA0tAAGdvASLnaeKRF3AExyTun
         12ZCXA0XOTdvtaGfOErpik7RtFA4s3Iplsq4la3ed9i9KS8gkBHv6inViQeTvgaipx
         24c1N0tv6LttQ==
Message-ID: <048aeae6-6357-a29d-8e2c-8f75c4ce265b@gotplt.org>
Date:   Thu, 22 Jun 2023 10:25:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: On clang vs. gcc fortify warnings
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org
References: <1f3f722c-657d-21ec-d6e2-7f79ce5462e3@yandex.ru>
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <1f3f722c-657d-21ec-d6e2-7f79ce5462e3@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2023-06-22 06:42, Dmitry Antipov wrote:
> Recently I've observed a (not so?) subtle difference using 
> CONFIG_FORTIFY_SOURCE=y
> with clang vs. gcc. The problem may be illustrated by the following tiny 
> module:
> 
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/fortify-string.h>
> 
> static const char example[][32] = {
>      "abcd",
>      "xyzt",
>      "1234",
>      "5678"
> };
> 
> static int __init test_init(void) {
>      char data0[128], data1[128];
> 
>      /* No warnings with both gcc 13.1.1 and clang 16.0.5 */
>          memcpy(data0, example, sizeof(example));
> 
>      /* No warning with gcc 13.1.1 but warning with clang 16.0.5:
> 
>         ./include/linux/fortify-string.h:529:4: warning: call to
>         '__read_overflow2_field' declared with 'warning' attribute:
>         detected read beyond size of field (2nd parameter); maybe
>         use struct_group()? [-Wattribute-warning]
>                          __read_overflow2_field(q_size_field, size);
>      */
> 
>      memcpy(data1, *example, sizeof(example));
>          return 0;
> }
> 
> static void __exit test_exit(void) {
> }
> 
> module_init(test_init);
> module_exit(test_exit);
> 
> MODULE_LICENSE("GPL");
> 
> I suppose that clang wins here because 'memcpy(data1, *example, 
> sizeof(example))'
> may be interpreted as an attempt to copy 128 bytes from 32-byte source 
> buffer.
> So the question is why gcc don't diagnose this as well.

Sorry, I can't reproduce the warning on clang 16.0.5 with the default 
config +CONFIG_FORTIFY_SOURCE on x86_64.  Could you share more details 
on your config or a preprocessed source and compiler flags that get 
passed in?

Thanks,
Sid
