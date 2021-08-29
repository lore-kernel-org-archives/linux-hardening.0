Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E24C432BE
	for <linux-hardening@archiver.kernel.org>; Sun, 29 Aug 2021 14:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B74060F45
	for <linux-hardening@archiver.kernel.org>; Sun, 29 Aug 2021 14:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhH2Osn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 29 Aug 2021 10:48:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:34883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhH2Osm (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 29 Aug 2021 10:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630248461;
        bh=koZbqgJEfL/7Y29h7AbSuE43MIf9T4IruSs6pFqnKac=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Xrr0UjdPJdekK+lQoSnHeJCYY1T69bj04GvnZ7QFyuHrrnsKmPjT9L+5BYM2EijHl
         ZnGU/46wm0c9ZAd/ZGb34tUTScLPKyghntj4z1wXjVghQYFRKddSzeRoaqqrzSg7U+
         Zq1utD7w0b8Vj/v+j5H25WXCuIUzY15B5bRSLix4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N9Mta-1n7nUv0h9Q-015K8p; Sun, 29 Aug 2021 16:47:41 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] docs: deprecated.rst: Clarify open-coded arithmetic with literals
Date:   Sun, 29 Aug 2021 16:47:16 +0200
Message-Id: <20210829144716.2931-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cFuf6SpUGWOGCHoTzKapRRNLmNuZOZ4RFlsRAo3NnONcykQYVFe
 GP+hOF1x8ASn6qNm3+5k/QieMyTbBBLeqV3sxLxBMb52PI0agw0+NzNkkfBvoGkhxt2IZw8
 dnKuDuD3n4LdnPF6DUa8NwxCIm61q+f8AwDzR/YNGR26TSzt1kBiJNw/hJwjQv/4nO4m8+F
 g71VGbgsHoZLt0MYpkzpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PDWEanbmeF8=:XoO2JKQR49WV5Pm2ljjHtp
 u7Zqa1PYlb+Hphe1zwPL2q3Jgo/Mf2mQFuiFk/4EraPGVY/P5W7C2/ZFLIDgnSpaNE0nGc/ta
 IRJH+7WperhnSZ6JWZgv2RX/e90hapHvzvgcS4FsgTyXOquJ71Kb6Nz5cM4b2lj+IoHKvd0ZY
 HGj3DrB61cjNuKC/34AOwKyoID0tIaOvnYbRzCjULotzPp5IRlSxhgLq9clwdJUQha6/V4hYs
 7R9TXEyFKi/cM4vbxggj5w0FCbjv87BDw0s+L+FURELNpOsZ1DACCFL5XZTJ2amaqR9BLXzQL
 F9FgtyIBohWgXGHmTR77aQ52ln1XMcMBThEPsyGQtRgGRSDTwYWC6LZxdh2dZWFWo3GlKNQ/5
 DcyzvHexwpcwa10NZLGAiEzUMT0jGH6Vsv8MXLxcrh/bVMXbiwZmvPJNyoRORYm9NzCaWf7lj
 P4MpZdjAh4kzDicOQxkwZ40N2f0tOXqbNjWb9nHC4wdQvKxoJN8yzaEQxFgqhUP8jimAUa/hw
 pUqkj/pFqkR1I6zRqz3sf34Tlo15L76M7b+kfFGL+ukrhAodZqCbqVdqHrhrI4jujwYbZO1Zl
 SuBY8PzcVwobGZ3a3rPaUt6VLfy9Skj/GfPcmTnONoiWZEYsRCP2VLfsqm7BmBhBAxSEZvv8B
 aNlTw0yKB5PtgCWY6NzGQZlaL+4CBOOwW8VvoYI8gipp5VOLnxms+VNrYRXSVCYjoAY7FG1DD
 8LmP7S/k4gXHJiPGHVU77GpU3yXSzjnZLgsOOqZPjBWGGQi5JPvndycwxj3Eb1etdKipcE2xp
 +sII2VHPdZ4rX5JSmhTjAhh7yPddb9kfzQcPP0IuuRW/GZDfWdNxaadLglUp6p6qRSvIn5kZ0
 l+MLcc7wYavTE6p9VCfXbC4GJ6jwurwvmDVo6R9Ei/ToHWt0dZyg3O/7B1WiDHTtux3vXW97D
 RGBZkIYBrF+7abyhqkzwh2SZCGo04S6y6kJfQyo1GBzmcsvAh4il7g2LFyJJ28Dfr0NI+Ba5b
 EFFpvOi/t7wO+/vS8zA0/kJpRp1gdiSAeEJ1nN0b/0QuaxJw/RaYwEZxO3V8HGviMJBdfTuf1
 XgWEFF5YB3LuQiHr2cJ+ejHHaxUM52z7Pu+cRslRYCrP3qDwnA5ESCV5A==
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Although using literals for size calculation in allocator arguments may
be harmless due to compiler warnings in case of overflows, it is better
to refactor the code to avoid the use of open-coded math idiom.

So, clarify the preferred way in these cases.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Changelog v1 -> v2
 - Clarify the sentence by changing "keep <foo> out" with "avoid <foo>"
   (Joe Perches).

 Documentation/process/deprecated.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/=
deprecated.rst
index 9d83b8db8874..b5a8be914178 100644
=2D-- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -60,7 +60,8 @@ smaller allocation being made than the caller was expect=
ing. Using those
 allocations could lead to linear overflows of heap memory and other
 misbehaviors. (One exception to this is literal values where the compiler
 can warn if they might overflow. Though using literals for arguments as
-suggested below is also harmless.)
+suggested below is also harmless. So, the preferred way in these cases is
+to refactor the code to avoid the open-coded math idiom.)

 For example, do not use ``count * size`` as an argument, as in::

=2D-
2.25.1

