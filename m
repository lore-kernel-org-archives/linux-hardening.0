Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5ABC4338F
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 07:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB7061165
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 07:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhHXH1M (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:27:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:49121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbhHXH1J (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Aug 2021 03:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629789976;
        bh=lYai3kw8tALYTD7kBUvkPaGxBm/XvOUHLBjz/wNKAzY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KgJoNt7ehH3OprqU5H6xp0YNI0QB+HFub51c3dASruE9xPI4WhIjSjQz/vphiTTlr
         +12CyawrDicuDJK94J7QvECHVA5qMkFh8RP5vem0P5/eZ8eeI8MPhOXNWaxv/vv7De
         vdzVD9LGad1EMBfXmv5oxVRZROpuE5rc7omWD2vs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M6DWi-1mP0Od2pUO-006jbv; Tue, 24 Aug 2021 09:26:15 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/3] staging/rtl8192u: Prefer kcalloc over open coded arithmetic
Date:   Tue, 24 Aug 2021 09:25:42 +0200
Message-Id: <20210824072545.7321-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZNfDVea6525BMQvl9hUl0qNX9IDyevcXkLRaOq2huhPlEFt3V2G
 V7tUuiMhRM9YJtO3EqMfqNhO71KgUOsJQOCwGFxN84xVIUB0AxLG0GzE4DInFD7mrOUdAOX
 xdP6zQubwABluDMsIHpWfVZMOTfOad7alWvq2nvAxZ0unRSAq+ZTWUtMb6p89cznPdu40Q4
 Z40Qlc3wHqUTHFyYu68TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5lK8/GbDASk=:dZ3LIlYaESza+lvsjK1hdk
 SNRPd2JKoVZiFSAmrRDiUTvRUMH7ML5JmrPaRPujRfwcvHwLpu0pwyYCH0KCNlv3KnON4Reg+
 OIUqtuiKxJBuewvqx10CAk6/XLt1Z7fbtqYshlbUckoX7QxQ7uPJnORGw/WNt07v/z/nLSdQH
 ZmnU7xR4FNvJIwUzCEMZLqaTnmG5a29MTeXMC3tYRF5KTQuUM7+rY5ye2dFCfcJqiFFuu4Yhi
 cVI1tulEjY/3QibDMYHTWrdf+9Iq9kZAIhiYIk5RvpKXERb0JSTtre58qcOdON26zj7gqfYiW
 fxaHQdwWv/5SmhkbkrzYN3EFSQRH7QUN+FUgoVXJesLKp+vjomRFhnW+U1sGm7EUkPTiLhfdA
 JZRdLXPXi7huRUog+xqyePm2tqx3p0FwCclDonLT9CTpVnwX+PiLGu987iksJD/HqWOxNc7HR
 8eSo1Ti+8ojcAueeWixKCAl0jiNsT9Bx+lUFzNJCj7zw3/AgeaxkoIxgvAbiGFbIt8IkAs81B
 2arsQ/mvZ69has1EgoLtmODwunt93BZ037oJb+Xy+dYQRvj4nv3vf9Zmg6CWjJhjXUpb0TqUE
 CuwP7KmSE//xHLsYlhPtJJkDpJwSHm6arMTgJjjtlKBVwkPVG6z4XM6B/xyHqNkuJSOqiDR8X
 mY82f3LrGdEUNfUnwpVWeilRbEvegMszG0cSkd0+qtJJFj6VhO+NDT+8FoXQWJh1lfmMwmB/d
 CiNgCvcn5dVlrI77b/QDk8G0uX5pgv9OLo9SrRv4vMITn9OFoDAAqNZrANZELUZWTkswR9KTl
 8BLh0G6hsfgbMzL7cXDXGz2lky+8xyAE5FK4LQh2eV5rU8D/pmE9a0BFrlWmX8P4tl/Gu7DXE
 Fxkpw6a3zTRACCBcILAqc/im6DWmIgrF+klpePeg6yhtla7/15WnLnF8HHP7xgaLd9j1iFLFR
 GJhmXGteZNKv0TjzDidBKnbe3CffWWp9dutxIPoAHYviqZ9omjuKwclfDYkvLqKHpIZAaaFz7
 aRUfeIcM/INTCnF2m7se5juKWL328O0u6XOfsmjhW0p3uUNq/6y05+R7tnex5Daod5C8hh6Tl
 o8ni5paFaGG5G9vT+gV2ZG7Ri2jwc4OGhGi0sMpa+1t2gnXpBRvQFlXIA==
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The main reason of this patch serie is to avoid size calculations
(especially multiplication) in memory allocator function arguments due
to the risk of them overflowing [1]. This could lead to values wrapping
around and a smaller allocation being made than the caller was
expecting. Using those allocations could lead to linear overflows of
heap memory and other misbehaviors.

At the same time, take the opportunity to refactor the function avoiding
CamelCase in the name of variables and moving some initializations to
the variables definition block.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Changelog v1 -> v2
- Split the CamelCase refactoring and the moving of initializations in
  two separate commits (Kees Cook).
- Link to the documentation to clarify the change in the 3/3 patch (Kees
  Cook).
- Modify the commit message to clarify in the 3/3 patch that these
  changes are not dynamic sizes but it is best to do the change to keep
  the open-coded math idiom out of code (Kees Cook).

Len Baker (3):
  staging/rtl8192u: Avoid CamelCase in names of variables
  staging/rtl8192u: Initialize variables in the definition block
  staging/rtl8192u: Prefer kcalloc over open coded arithmetic

 drivers/staging/rtl8192u/r819xU_phy.c | 92 +++++++++++++--------------
 1 file changed, 44 insertions(+), 48 deletions(-)

=2D-
2.25.1

