Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C985BEB64DA
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Jun 2023 22:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjFVWNm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Jun 2023 18:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFVWNl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Jun 2023 18:13:41 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8961987
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 15:13:40 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 52C9E142710;
        Thu, 22 Jun 2023 22:13:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E54E4140EFE;
        Thu, 22 Jun 2023 22:13:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687472016; a=rsa-sha256;
        cv=none;
        b=zCiLEn/YO66LcX6bGXdfi+seAT977GwE5h9ESQ3tzvswTGJiZwQJWEwSAjCRQvifOwpsHl
        J4iAzfui+E/Ae7fwhtXCpJp96KNuBAeIE5B40oBS5iJgfgxBZXbKRKct0KfpbZXA5VDMRD
        SmlDC4zvXuSAYhboasrv0tee5ByevB1UX450YIpzM9VYwxffVnvsyNLdcLVVBjp38xHhHJ
        Knywj6TSEjGCqmKgaquiyGMeYqdIVuSlAmxaTidy81HUVS3k4AIW9vo+DAyvGHrlWPYEol
        DzP3FvroNv56OJe0uMUdgF0/mNc7e/xoPeOAv9QBRGRupwzL35hFgltWzTaPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687472016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=K8j9YvZBhbem71Nfb1E0v9pbsjJKliVW6oVQeMN8tGQ=;
        b=oXc1TLFLYza28d1njxAUbBSDON2/sBHpI+NRxHxMu5edkegV2xb/n+7+r6Vlva0GzBdCxU
        yqwgb5atpSl3Eey5QnK5ZCWN8ZgpUuYrSyQIv1/gKe3oY5kZj67bOhEXTxSCdCOAt9iKIL
        lQej6Bj4OPeG6TAR7y2LawBx7yKy3dDgLvVGlfDYxyMwUqGoA/N2l+U5R13gSRDCbi20DJ
        jt1OIdgd7UmeU92nkJqjhn4O79P0Gaj8OO00OGYHEq4Ya/IIQwFwBkCP3hov9Cr/ds5z6h
        Blh62E3P5GmuIqlkPey8H+CtpsygeT1XIM5Nu0tOouN1CYy23ZvDX0FNOvf/mg==
ARC-Authentication-Results: i=1;
        rspamd-9fcc56855-w4qnm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-White-Fearful: 66438e7b0cc7dcad_1687472019118_1616389307
X-MC-Loop-Signature: 1687472019118:3541296058
X-MC-Ingress-Time: 1687472019117
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.48 (trex/6.9.1);
        Thu, 22 Jun 2023 22:13:39 +0000
Received: from [192.168.0.182] (bras-vprn-toroon4834w-lp130-09-174-91-45-44.dsl.bell.ca [174.91.45.44])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4QnF4w3N3Gz7H;
        Thu, 22 Jun 2023 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
        s=dreamhost; t=1687472016;
        bh=K8j9YvZBhbem71Nfb1E0v9pbsjJKliVW6oVQeMN8tGQ=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=QBLsEE4vxeM+aHSzcrQYFt9RWUVdz2xY/7V2AUGDZdtZcDXan6R6rejlm6QV3ZA1V
         iHqjY0ufLbK7Kyd3M76Xkoo3K8mtQ3sNzNu2L+Ydhp9mnTExkUwKi/GUz0ujXJnUJG
         eJJkChi8obPaQal121WFofmRtGxbskxfDwZrK2jYVeSu1GWVKEU1UxmLYiHvrRmSZ2
         2W1EuBPp0t+zLnoXz50qw66teKFvpyoIp2q3SFyN4++SdJpzcidM8XIxGOQEBT26+d
         n1w3aMY+DrxXOiGoMTVM27pKlPaD9ea5ZIQ0XdaiP5dNdc6+5MlOgW7eDeba2dZW38
         OZKdB6aEHTvEA==
Message-ID: <bf6cbc6f-c627-5ff5-d76e-c9796af2c3a0@gotplt.org>
Date:   Thu, 22 Jun 2023 18:13:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: On clang vs. gcc fortify warnings
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <1f3f722c-657d-21ec-d6e2-7f79ce5462e3@yandex.ru>
 <048aeae6-6357-a29d-8e2c-8f75c4ce265b@gotplt.org>
 <b2316d0a-71e1-dcff-765f-293e311c4362@yandex.ru>
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <b2316d0a-71e1-dcff-765f-293e311c4362@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2023-06-22 11:16, Dmitry Antipov wrote:
> On 6/22/23 17:25, Siddhesh Poyarekar wrote:
> 
>> Sorry, I can't reproduce the warning on clang 16.0.5 with the default 
>> config +CONFIG_FORTIFY_SOURCE on x86_64.  Could you share more details 
>> on your config or a preprocessed source and compiler flags that get 
>> passed in?
> 
> Sure.

I've filed a gcc bug for this:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110373

Thanks,
Sid
