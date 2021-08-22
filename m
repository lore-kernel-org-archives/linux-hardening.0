Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D22EC4338F
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EE16120D
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 14:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhHVO3n (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 10:29:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:45605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhHVO3n (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 10:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629642535;
        bh=OHoPvHMVl7ov+1IrCEJJ//cRmzfbOo3c5AVsORYPEEM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=OSHbHGWWTXRSroVGVp92KlmI/OCkdDPutmcELzdV8ELGo8XkP/ntB6DG34moM7n6h
         3pQDsmWsIKY5+42K5MLyZiBALYoU/DI6EAGP8g3XDYBYqTSdgijIj5SDmAi0rBVQ0H
         FbFwWnkRj7eOXzQTFa/yjaV4oS/tuGxdZ0Ml4d3Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N7R1J-1n7rDe097d-017jRD; Sun, 22 Aug 2021 16:28:55 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        Michael Straube <straube.linux@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] staging/rtl8192u: Prefer kcalloc over open coded arithmetic
Date:   Sun, 22 Aug 2021 16:28:18 +0200
Message-Id: <20210822142820.5109-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p0IOLND2I4j+neza+y2pDeupbRTGH7itS5NwcdIdmzAMgBzpoZa
 1L1WAy2w6dsSPIAxpglxWF60/GG34yMGkq46V4S8sW9sAR2jmHXcaECsIjxvC5u61wxyLQD
 lDfNHACysNucr5Psu9Bl8I0rSwPSWqcc9xeIcnYthZKG6XkDuQpsd/1qZPGQmE2E/Nh4CJZ
 QnP8LGfBfLSJOZIAFt1Iw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wlSf9zJTD58=:1TdS2kdpC92I63YFDzc43L
 bP/QUbnw5IJs+BbYDJEPe8Eyk2R6JXOcBiWua+oLCbAxzHJxqn35ux4kiALYo5+JMuJSHZWzT
 GrtrD6fAclOLsHLWm24iJEUV7GdCeZwMXkY29ktW2lhwbUrj4/oao5kR9yYppUlSnJmQ4Y15y
 3OOVogKn6rokoyUJuqvJbyNuQ5L9oFXpg9iTzBhs5834vMhoi2c/u+pH8dVvTcsB+2kvF7fOr
 /IYYJtREPwJXiBi4hm7jXUOKDQL6w9aAzON4Yp3tGAJ5fReFAzBIOmv9rIDFA3TdT4fNWVwGP
 Lfiypv1a8mQdgknhvJPcW806uDrZO/AyOY/c4i7Btx77rd6GeTrrXhKapfz+BoP8nX7DF/lpz
 YAx0CzgljkA45i4qpJ0TdzEa4YKmx2/CvnnGDLt7oOzf/ZIYR6XEbT1Xc17l7ndIHAxt7BQfE
 IPwK6EerC6Yo4XHKnDQlywOxhSXKdo8ild7Pm9SYw0DldGcDcC12HN7xrYjfVtHjXkG9OqWIF
 ZlQsrcuZsIMNjy7r5YFx3KEsyAUPKHSg22qVFPmSSdT2cIZbhGZzC0VTs0YTaxXTKl2M2tkB3
 RJ0TS3m0KawiHJcJE0/gF7RC4NyZ4LCCrerQBwcKZ27RpcUFzhqpuJkT4KWRYD394qcClWfiu
 VpnD8cEum8YUTyoUPclwxUf7wcD/wjaVvHTwnCLfd2h4PnkkkHUxUAZdh68Ddi94s5TbjX0Xn
 oXVkB+onZeR6h85hT4HY+jK/vK1AuaQyLi6RC1gUEpDrYCGgtuXhfqCW85hSMkFgsFkHmtWOq
 MOSW2q7EqZeha49rHlJ/qOtD28/CDmQ/L/x7TMn1BrJaSDGuSlyLPBnoLFP4gQXAT4uttJTGm
 Qon9tKpRfRGxtvljJWXM/e4sWejZTx7tEVeAeiZzv6YvBup42EFYOzxsq66PxO736rS3YH1R8
 21OvqP2EFfp3DBOdodJVII9WDO8odKYHCnYMWLziSIn9B8gaQwfqEIL0mVLoRcqESQ3gx4ChB
 MmvTlLMFGEm1Old18S45B5SEQMYI2F7gQZ2+CUgxF23YmRY0rAYwjwQ2cm7ldcMk8HmAHZsfF
 pV3GAFOhAzgeAZI8fQkz+GLbEHzpQc5ZDF4PWojV/UCQrsVJOZuWeENNA==
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The main reason of this patch serie is to avoid dynamic size
calculations (especially multiplication) in memory allocator function
arguments due to the risk of them overflowing. This could lead to values
wrapping around and a smaller allocation being made than the caller was
expecting. Using those allocations could lead to linear overflows of
heap memory and other misbehaviors.

However, there is a previous patch to avoid CamelCase in the name of
variables.

Len Baker (2):
  staging/rtl8192u: Avoid CamelCase in names of variables
  staging/rtl8192u: Prefer kcalloc over open coded arithmetic

 drivers/staging/rtl8192u/r819xU_phy.c | 92 +++++++++++++--------------
 1 file changed, 44 insertions(+), 48 deletions(-)

=2D-
2.25.1

