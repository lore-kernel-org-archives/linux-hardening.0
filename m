Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8641DC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  1 Jun 2022 20:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiFAUwN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiFAUwF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 1 Jun 2022 16:52:05 -0400
X-Greylist: delayed 1662 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 13:50:22 PDT
Received: from wp016.webpack.hosteurope.de (wp016.webpack.hosteurope.de [80.237.132.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C991EE6EE
        for <linux-hardening@vger.kernel.org>; Wed,  1 Jun 2022 13:50:22 -0700 (PDT)
Received: from [2a04:4540:6b1f:9b00:e23f:49ff:feea:1895]; authenticated
        by wp016.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nwTcx-0002EG-6D; Wed, 01 Jun 2022 21:03:31 +0200
Message-ID: <56be248f-9063-1322-7b1e-83bc59414be8@leventepolyak.net>
Date:   Wed, 1 Jun 2022 21:03:11 +0200
MIME-Version: 1.0
User-Agent: Mutt/2.1.42 (2034-12-24)
Content-Language: en-US
To:     Yann Droneaud <ydroneaud@opteya.com>,
        Simon Brand <simon.brand@postadigitale.de>,
        kernelnewbies@kernelnewbies.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <Yoy9IqTvch7lBwdT@hostpad>
 <fd5cf4a3-ba98-5c98-f823-e83f58a1d40c@opteya.com>
From:   Levente Polyak <levente@leventepolyak.net>
Subject: Re: Possibility of merge of disable icotl TIOCSTI patch
In-Reply-To: <fd5cf4a3-ba98-5c98-f823-e83f58a1d40c@opteya.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;levente@leventepolyak.net;1654116622;0edeb853;
X-HE-SMSGID: 1nwTcx-0002EG-6D
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 6/1/22 17:41, Yann Droneaud wrote:
>> I would provide a patch which leaves the current behavior as default,
>> but TIOCSTI can be disabled via Kconfig or cmdline switch.
>> Is there any chance this will get merged in 2022, since past
>> attempts failed?
>>

Small side note:

A complete version of Matt's initial patch has lived on in 
linux-hardened [0][1] with the `SECURITY_TIOCSTI_RESTRICT` Kconfig 
(default no) and a `tiocsti_restrict` sysctl.

If a re-attempt is feasible, both patchs [0][1] could potentially be 
re-proposed as is.

In linux-hardened we have an independent patch [2] which simply sets the 
default value of `SECURITY_TIOCSTI_RESTRICT` to `yes`, but that most 
likely is not desired.

cheers,
Levente


[0] 
https://github.com/anthraxx/linux-hardened/commit/d0e49deb1a39dc64e7c7db3340579cfc9ab1e0df
[1] 
https://github.com/anthraxx/linux-hardened/commit/ea8f20602a993c90125bf08da39894f01166dc73
[2] 
https://github.com/anthraxx/linux-hardened/commit/238551f7b6a138d6f9ba0d55fe70cf6ddc237f47
