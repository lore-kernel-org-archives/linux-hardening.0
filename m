Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4A1C4708F
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 04:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310C461406
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 04:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhFDEQV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Jun 2021 00:16:21 -0400
Received: from gateway20.websitewelcome.com ([192.185.60.19]:32974 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhFDEQU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Jun 2021 00:16:20 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 920E5400CC8D7
        for <linux-hardening@vger.kernel.org>; Thu,  3 Jun 2021 23:01:17 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id p1EAlhHmI8ElSp1EAl2HaP; Thu, 03 Jun 2021 23:14:34 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WUbFs4l/NELE7dFRXcq71zunFdruCbu0ZwcaXi35V/E=; b=wgBjjVNPCkok0UCq/v0n0KUt93
        z7wslZ5GAsi98PjY1S5heo/+n8OUt7AzN8cdzKTJke5/ujt8/YxsMrB1oM1lt+0Fi7F/ujXeNakhY
        s8lVCOZEhAa07uC/CZE5CbQ09ebhw8J89tYiN1X7Jt55p5KJ6T4uFGoQu5cs5LDJfv66FgC7S9d5Y
        zdA/7J4MwIDdNx3ET+eE0fnAZ6rxHyMdgAp/4ous9batzjdXM2okRzqf4UzotfxVOJiY+R0AmvJ6l
        knriC1YkG/stZ5jJfTzNlGXyIb0k8s33mgEchGHJVLgUFtTXPwehRYNG5VQ7z8J1L8EIPzmbO3rWZ
        lfTJFCBg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:34412 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lp1E6-000sgw-FB; Thu, 03 Jun 2021 23:14:30 -0500
Subject: Re: [Nouveau] [PATCH RESEND][next] drm/nouveau: Fix fall-through
 warnings for Clang
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-hardening@vger.kernel.org
References: <20210305095657.GA142006@embeddedor>
 <79ff569a-5828-ef21-538b-12d07d34a4ff@embeddedor.com>
 <1ec627af-514e-b24a-da88-13eb561ccb15@embeddedor.com>
 <CACO55tv3o72GwG8ORcUYQ-nXFDi1Qo0uKG5T_4iVmuhdDxPdqg@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <8e6f426f-0234-a5df-08ec-b6a97a78c2da@embeddedor.com>
Date:   Thu, 3 Jun 2021 23:15:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACO55tv3o72GwG8ORcUYQ-nXFDi1Qo0uKG5T_4iVmuhdDxPdqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lp1E6-000sgw-FB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:34412
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 6/1/21 19:10, Karol Herbst wrote:
> all three nouveau patches are
> 
> Reviewed-by: Karol Herbst <kherbst@redhat.com>
> 
> and I don't think anybody would mind if those get into through other
> trees, but maybe drm-mist would be a good place for it if other
> patches involve other drm drivers?

No other person has replied after pinging multiple times and resending
these patches, so I guess people don't care.

I'll add this and the other similar patches to my -next branch for 5.14.

Thanks, Karol.
--
Gustavo

> 
> On Wed, Jun 2, 2021 at 1:16 AM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> Hi,
>>
>> Friendly second ping: who can take this?
>>
>> I can add this to my -next branch for 5.14 if you don't mind.
>>
>> JFYI: We had thousands of these sorts of warnings and now we are down
>> to just 23 in linux-next. This is one of those last remaining warnings.
>>
>> Thanks
>> --
>> Gustavo
>>
>> On 4/20/21 15:13, Gustavo A. R. Silva wrote:
>>> Hi all,
>>>
>>> Friendly ping: who can take this, please?
>>>
>>> Thanks
>>> --
>>> Gustavo
>>>
>>> On 3/5/21 03:56, Gustavo A. R. Silva wrote:
>>>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
>>>> of warnings by explicitly adding a couple of break statements instead
>>>> of letting the code fall through to the next case.
>>>>
>>>> Link: https://github.com/KSPP/linux/issues/115
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>>  drivers/gpu/drm/nouveau/nouveau_bo.c        | 1 +
>>>>  drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
>>>>  2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
>>>> index 2375711877cf..62903c3b368d 100644
>>>> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
>>>> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
>>>> @@ -443,6 +443,7 @@ nouveau_bo_pin(struct nouveau_bo *nvbo, uint32_t domain, bool contig)
>>>>                      break;
>>>>              case TTM_PL_TT:
>>>>                      error |= !(domain & NOUVEAU_GEM_DOMAIN_GART);
>>>> +                    break;
>>>>              default:
>>>>                      break;
>>>>              }
>>>> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
>>>> index 61e6d7412505..eb844cdcaec2 100644
>>>> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
>>>> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
>>>> @@ -157,6 +157,7 @@ nouveau_conn_atomic_set_property(struct drm_connector *connector,
>>>>                      default:
>>>>                              break;
>>>>                      }
>>>> +                    break;
>>>>              case DRM_MODE_SCALE_FULLSCREEN:
>>>>              case DRM_MODE_SCALE_CENTER:
>>>>              case DRM_MODE_SCALE_ASPECT:
>>>>
>> _______________________________________________
>> Nouveau mailing list
>> Nouveau@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/nouveau
>>
> 
