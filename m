Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED242C432BE
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 17:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC6260FD9
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 17:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhH0RNt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Aug 2021 13:13:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:56999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235695AbhH0RNs (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Aug 2021 13:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630084370;
        bh=YGrt/tZqC6Fgg1MGVMuVmS6neQk6AN33ybHRfOyG7U4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=HexiUg1W5x2Jo15hbQizUtOvWIGA7i04Ksg6C4jYtc9xdf/4EcF+Hr5T+y3uwh2H+
         nnkZ+QOQRvYtD/qi1VtgNc8k+jlMk9UcdGH+PxQhFIhw+Jl1mFyaEDoCRGzSF3YIQY
         tG5kWehi9jn49B5WbDbQ9g0/CCDKAAJZtZr6vpMM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N8XPt-1n60o70u0H-014Vvb; Fri, 27 Aug 2021 19:12:50 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] docs: deprecated.rst: Clarify open-coded arithmetic with literals
Date:   Fri, 27 Aug 2021 19:12:26 +0200
Message-Id: <20210827171226.2938-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I4VWPP58QCGSuKHAt9e7f4B6GR0oJLIbfsgC5vaEc4Jc+JHrAW/
 M8cvyz1w4tH1262z1GzwPm7Yy/QsCM+Vv0UAV7x/DqOpdjRa/hRByyP3Xzbyi67knQD8aek
 b/m8TnEg9IQROi9C2I+iIjWx20VYjJerMA2GtIpeY2noVT6Eg4G1DQH3ncBfar9gb+6SNM/
 jwcjwJobLqQzVzi+IC+LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eJgriy0mrwI=:BRr/Xj1/Ce77Qxj3YGdtWH
 900bbVsHm6mQeIWxP1zoB9sgWuq1885wFtslqEN/+l9wJxXfaqyuSDE9wvAT2tWOhDCGeagc/
 VlfRsgzJQr54TnB8gELEbfCWRNPeJioRovPh0znkMooyZkF0D/ZfOYD8wclbvq3Un4NrGlOR0
 IOx/UjqmDrOrZ7wOiCppKuvfb/hW/8GKAxXvUAg8l1pZz88/gmBsLgsdC0louSCm2/rLM//+V
 dWvvYh+OnmkgcBnIw3pVZmQvBoFJSNbAFByOIv0GH37kp3UGmonNtk+GHvW/fcEq67AXZCd/c
 xNRAGUcCxKzjEyYEKffDQVfK1ANPMjdTOZbGunJaOGlfzuTNbZ+BA+jkJYlGukrwO8VfiDKDd
 Y27ly0uCWBcixtHZgrCaXv5jSRL9Y9MmIgbCvsdHx0R6P/nGBMQOy726KonYpsOClhdoFgWZY
 vdAG/PbNRyQgRUikzqCB6w7zA/lyzm5HOKtDi/O5cikXMXSCgiJmEyGwAyjFYdMoyDQ99PPaL
 ZYPUTMjimH8qeUj8Twz1pYydnX2G/c3dYC4i4+8K0FbK3jQ+CbnWAa1jwvm1IgmOe9Khu/xbj
 +TqUzfJSimkaP6kjlEurxyslOiIRLmI3XoelrXcDNPQmItrd9Jy0hcxxvo9RVNP1jp5bqUXrT
 d8xM5IxrMLiDxw23aUKi84aQqw0l56OeoU4fjsz5IUje3QJQk5e8e+4DTaz2gsGuaJ66sS8TQ
 RHhyxP1syRFD6vwuUsjghqjW3CeCTZkghqKl3fcFIBZIBCYgF7dP6qhcs/cJjBCFL7xM6Edvx
 AfEhL9+U9AxsvuPNjLd6ilGSziwDsImiCncZFN1JbT50oZKQfI5e/LIr5qpW8veg60b6wEmut
 ELPlaLfSCOBaFluHWvY4Hs4Zu8QIXCHAiWPfWI9EOBCeWrBDji6hbCg8ktpjShbTm60kf9HM8
 QLU8wmOMoQ/5nMPw8Yjfd9u6DhDrdrxzkyryZXjsc4/HQWJsWZckcaTpVcgCgT1kuZL3CqzuK
 OBWzcAVfLKlQ5SYxGc8JN/Q0D8EqCYFWh+eNUiutQL56GRL943xFGlgogzhfghmtmvbxCDuOk
 qPHbgb5oqk0DIqJN4/X4I6kJ1a22yoKAAMjCk6iOEmqUppnS6R73Ovmgw==
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
 Documentation/process/deprecated.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/=
deprecated.rst
index 9d83b8db8874..fdfafdefe296 100644
=2D-- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -60,7 +60,8 @@ smaller allocation being made than the caller was expect=
ing. Using those
 allocations could lead to linear overflows of heap memory and other
 misbehaviors. (One exception to this is literal values where the compiler
 can warn if they might overflow. Though using literals for arguments as
-suggested below is also harmless.)
+suggested below is also harmless. So, the preferred way in these cases is
+to refactor the code to keep the open-coded math idiom out.)

 For example, do not use ``count * size`` as an argument, as in::

=2D-
2.25.1

