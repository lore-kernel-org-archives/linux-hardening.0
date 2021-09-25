Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252BEC433FE
	for <linux-hardening@archiver.kernel.org>; Sat, 25 Sep 2021 14:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1550610CF
	for <linux-hardening@archiver.kernel.org>; Sat, 25 Sep 2021 14:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhIYOhI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 25 Sep 2021 10:37:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:57531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234315AbhIYOhF (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 25 Sep 2021 10:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632580522;
        bh=MHVNmpDUt2XZPVZrOM2d7kRTrM7UqM+ZYl72eMrWMME=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=EYFOf0pd80lIeAmrrF9xiwCTop6iHe8MGKnQ7iy9jptY7gK+akqQv73Im3JJPALbc
         vZEsXQ+WBGeNmGOIGI+GuUI2FTsaqcG7YeQWInTV+lVyYso60dHfUV0x+TDj98aTWd
         mONpLJuJBiZgxJp2djBvjmowtzEjUJCxHadrxzXo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MUXpQ-1mLNLV3bWa-00QV4r; Sat, 25 Sep 2021 16:35:22 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] docs: deprecated.rst: Clarify open-coded arithmetic with literals
Date:   Sat, 25 Sep 2021 16:34:55 +0200
Message-Id: <20210925143455.21221-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dKt9E5k2asKF84fAquzb74NHveNdHh+ovMnxXCyH7zLXmdvVEcH
 KByLAuwijWKpIc0AfZtSkzP9Ov6z4Td57DjOOhbUg0kZ6a6RjuwOT7IfswEoNvgW8DAZP+r
 sJ++nx5cGlEctopNDfiBuoVy3lunn3nu/obbkvH/Kleoz5dk9bM7PX0vyVqBGgeVKhf8LPK
 bNExmUWyM7e1Y4w3Zfapg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xbofEEqLQZA=:gGT/o+l4C/rY7flqbEMiCR
 1PW6/hKA4kSPeGsOpeu2QtyLVEAxX+jVjgn9tJwYxFbkBk8w+4jedLE9w3MryN6poxxTIecED
 jYlSqw8NrBA3aJYNMV1RZHYOuctsGe/ynP4TEP8NxtKIeAl3OEdDFDkErfXOd9plQLkPKdD2t
 bc4r3LNuy6EYCtdNcEGmjsIYOGL42Rp31q7fB7UMHNtTjawWPieC94UdoM2MsnndMUEot9qUk
 mT9edn8lw6AZdfe6BLX6evTm8Yr4qlNGf4PEpCLUnZATkKQYbkZoJWRdo3lVl3V7IiYM/7RvI
 Vk3b/bbTyaEOZh+0Q847sPOP5Y7mgqHAvmz+XsM30kN+xBZ8V080+9BbIGBd5PB6WAiuX8VI9
 4kAvgGP9f1IPpqId+GEfZiAFzdhBjBjPgLu5NbHPtMzCeKUshjy71XAInVHFIFVISsrt3aWmT
 UnVX30WRx3ZVEbqh7sEGu/cZ8B6QFgBGLLSDQea3GCbyGmaRfytm+TqeVMrseI9EMOH9sfWPv
 snsZFcJk8GCfjbkinpDUAGhOkIcd8bweCV1+jJZKWXOoq61H39DotvBMQRCdrVQmlImZ/UnJB
 7S2nWrpr4XUIgLN7m1HAN1p7JLiE07psOpvxUHDQB8Pt3TsX0gprWObCFkKf9ZdYtRcJBJwac
 zN08IMfp7y7/v2cVflgiE366N7zOC1byKqzUOR9n6/LpB0qvjoSdAa6oAMLB+EgXN83RQkmBD
 reUJ2XPtdfctizH/g+aeLy5lAA2Ulss3TPh7qVFfdB0+BtjllK6NnUND5nJEMm23AU+CH0WzL
 y9898UhdMnXSAoG+uIUPgPf7YwgFbhfv+0JuCoIvLcjceoXBwqrbNIuWZ4i92+ohPgbWsI1kT
 2fBJfAERLUhqG1iYIFLidf+djj3T1r3eAo4xA7Xxj+Dx9TTAZQfPOEBfVatHYF7rvW+hZxDHx
 39rci+NPxPKqbPQVgL4NDF7HGjZCUk7c1+HEsetsbzYZuAJ8/17hVuL4t1W2Z/CPn7yHM1ito
 HU5L9+tH95OybubrRH+cSzcIyqPOFBXNIa5udk+elDTGOxckLVc8t0L7JnF8MWjnbhmCckhDr
 ckYe2safHMU8lg=
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Although using literals for size calculation in allocator arguments may
be harmless due to compiler warnings in case of overflows, it is better
to refactor the code to avoid the use of open-coded arithmetic.

So, clarify the preferred way in these cases.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Changelog v1 -> v2
 - Clarify the sentence by changing "keep <foo> out" with "avoid <foo>"
   (Joe Perches).

Changelog v2 -> v3
 - Reword the sentence to comunicate better (Jonathan Corbet).

The previous version can be found here [1].

[1] https://lore.kernel.org/linux-hardening/20210829144716.2931-1-len.bake=
r@gmx.com/

 Documentation/process/deprecated.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/=
deprecated.rst
index 8ced754a5a0f..388cb19f5dbb 100644
=2D-- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -59,8 +59,9 @@ risk of them overflowing. This could lead to values wrap=
ping around and a
 smaller allocation being made than the caller was expecting. Using those
 allocations could lead to linear overflows of heap memory and other
 misbehaviors. (One exception to this is literal values where the compiler
-can warn if they might overflow. Though using literals for arguments as
-suggested below is also harmless.)
+can warn if they might overflow. However, the preferred way in these
+cases is to refactor the code as suggested below to avoid the open-coded
+arithmetic.)

 For example, do not use ``count * size`` as an argument, as in::

=2D-
2.25.1

