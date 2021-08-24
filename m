Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C75C4338F
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35F26135F
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 09:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhHXJBh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:01:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:45919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235325AbhHXJBg (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Aug 2021 05:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629795643;
        bh=CLoOoY7f6RqwpYZ2ofNITRL0yRQnd334OfPngkBM7MM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ix37279hVKQFWJZxgf2JjzmNV+4y5NT5IDcfvTIEHEypRQ6tM03dnHwjzA/u/H7lT
         /VYJUhlUK8N9oQUAamBdfTmQmp+VWuLj2x1OHA52V6I9qV2yOyq5yMhS9Smm1Rcv6L
         UARg7xVXA45lm1UMwvE1y+2Pb+RClhNDqK6tLNF8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QS2-1mMq0g3C40-004RRV; Tue, 24
 Aug 2021 11:00:42 +0200
Date:   Tue, 24 Aug 2021 11:00:39 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 3/3] staging/rtl8192u: Prefer kcalloc over open coded
 arithmetic
Message-ID: <20210824090039.GA7999@titan>
References: <20210824072545.7321-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824072545.7321-1-len.baker@gmx.com>
X-Provags-ID: V03:K1:sgtiKXn1+vejHxr5e2MNRPOe6xGIVm8EP9zcbL/dlY1H7UcYnMt
 9vGW2Mx616fKLEuOrwJRR2/+Bbct/F0z6+H9nf1cFdjtNmvbLUmWazPpU93x6VgwyuHThSR
 OJ0Dn3hkhBKzFm1yLgiV/AL+lxD6fCB4n6XoY4yYEYoyeNW5+0G3EoDFKhhcyrX1SuQhZPT
 gF+9T8E2zEGzRPkyP2GRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G9HTkscgmxU=:VCVYYSEsMbHpqbZNADh/l0
 CVIbnLRQj8J3w4Qrfxd4343Am0g5Ns6989uqxsFuNrFT3VPfAiWenjIuU8sszoFUMS/89tJBK
 ytHS0h0SVXf2KJr44ZqXV6mnZ471anTh77zXSFbGAOHdHiTiHrwLy7EPP+NlTjTEorjPDQu62
 2r0OBHfnSLmQZ9Wo1brRsAd3Wsc4E+1eYsa509XuuaCkZ2KS1CfvGsSOyF8O589KpXNzJFl7j
 MJ26/JfBjdzrkiGT0Wfi26b89ok32eRZQ4stBOOxG77tYfzJnLdSTwqP/OSSdTrOr80/vwINk
 j/Xvx1QycachOhXHmtjkGsNAu2PxKzKp549Q/ifKs7UvlOGeipaLQgo0ubG9N2RbhRF6uhwQI
 uRAYaZahd0Ypy0R/yUVTXBJB8yWL3M+vi4vV/UOZ1z6MdvlqMGAvSoefAbC74XsM4LgSdYRDj
 TO7Aa/KFEwD6fYgSAhUDYbYaMX95RowYn3PK7B/ViobzcxygoiL9mjBTfvNnws9HtRcAvz/zO
 U6j6i0ownOF5f9L6aoC8QWzSRrPpFouIih4hIt+duLw6AqzTEt6txtfPkntkNSVZRCQ/4zRx5
 m1/SVBx+j/Zy+YILdC+ppq3cfQ3TdtTpTOKkniuAZjTmlsNZhD5hZhKoF1NT3ScqJt2zau9Ac
 LWJIGuFeXeanvYNy+J00w5m48wJVpq+G3hZb2hxUtvJ3DrPiXm8SdqbfHKnVaa54C2TOHmlwz
 oknjvuJ2uSrMAR9gX+5q1lCVCjk8W3XjeAZZMLB7mE9xnoPMktidzeXh5+TPajPmsEPxK929B
 K4lj5d7njR/eDCq3umihAR6bt5csDquUDndAjLFk7V9cRztp1Y39lQqAt1fQ7KylOiAj9Elng
 KDNo8imWJmU5cfE/ZktgO9bMd621eUB9sipV2+AzDQ10MPcaM1ZpObKVanrc6GHA7FJd0z9+d
 N2fLIKOCvJxbUtFsASP/S/oO+3VIZLG7V1GDZMBRSbWvBXDuM2Mpoe0gMXu6OLQSCx9Jv8ZqE
 fJJobsj8g0lWu+0BR6rBihqcfke+3dvxJjAQ+c7wu4KWBFf0NND57OqtK+hdMaOJu5OYJonEn
 nKRMGyac871l1x9VTzd7VmtL6n6bgHfJi2xa+2H/aiv1We0pt/pzhX6eQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

In this case these aren't actually dynamic sizes: both sides of the
multiplication are constant values. However it is best to refactor these
anyway, just to keep the open-coded math idiom out of code.

So, use the purpose specific kcalloc() function instead of the argument
size * count in the kzalloc() function.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/rtl8192u/r819xU_phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl81=
92u/r819xU_phy.c
index ff6fe2ee3349..97f4d89500ae 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1195,17 +1195,17 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_=
device *dev, u8 channel,
 	u8 e_rfpath;
 	bool ret;

-	pre_cmd =3D kzalloc(sizeof(*pre_cmd) * MAX_PRECMD_CNT, GFP_KERNEL);
+	pre_cmd =3D kcalloc(MAX_PRECMD_CNT, sizeof(*pre_cmd), GFP_KERNEL);
 	if (!pre_cmd)
 		return false;

-	post_cmd =3D kzalloc(sizeof(*post_cmd) * MAX_POSTCMD_CNT, GFP_KERNEL);
+	post_cmd =3D kcalloc(MAX_POSTCMD_CNT, sizeof(*post_cmd), GFP_KERNEL);
 	if (!post_cmd) {
 		kfree(pre_cmd);
 		return false;
 	}

-	rf_cmd =3D kzalloc(sizeof(*rf_cmd) * MAX_RFDEPENDCMD_CNT, GFP_KERNEL);
+	rf_cmd =3D kcalloc(MAX_RFDEPENDCMD_CNT, sizeof(*rf_cmd), GFP_KERNEL);
 	if (!rf_cmd) {
 		kfree(pre_cmd);
 		kfree(post_cmd);
=2D-
2.25.1
