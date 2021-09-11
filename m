Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263CDC433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 11 Sep 2021 11:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FA5610C8
	for <linux-hardening@archiver.kernel.org>; Sat, 11 Sep 2021 11:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhIKL2C (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 11 Sep 2021 07:28:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:57281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhIKL2C (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 11 Sep 2021 07:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631359607;
        bh=G8MUuBpNtnBNxQFmEG2ZlriHlD7R4/yuBbjO5Ngy/bk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=J7+O/q5h+I2kZg3xNyRxgirD/9jSmAllZs6+S9q5aabZCbMLWPbDy/1smQhpOOFa5
         LMamsWd5C5hj9F6PdbGIzFK+0RkEyuCkpqIhX3ZhgEm3+YnCaXz45KHbdXa/9PtCA+
         k4wdX/bSl48iiBmCa4vyAAi25ZS3ApiifahMAf9w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1My32F-1n8rk1313v-00zVbD; Sat, 11 Sep 2021 13:26:46 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: ohci: Prefer struct_size over open coded arithmetic
Date:   Sat, 11 Sep 2021 13:26:31 +0200
Message-Id: <20210911112631.10004-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SOgd2+Qv+9I1QBgs75UshmVAAaFWc90Wg57FZNwfUUC6f8n5T8f
 HJw96UmmQebgnfQYnnxxmXbKH1HcO8USYLODFrtqDgXlMR0vo7F6Titc4F19OUwwSQPMeBG
 dfHe718u1e2BtEmh0rIxyDCq8ihyGbm6nIxKQYaaO3zjNkmBLJaDVgt7Jq/BhWEIvmRLZnW
 IGGqhk3VDeYtW3tXO2eNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8h8+1ruWDmA=:554Ej/I6jXV1JUfMIWrw5J
 ake8jIw9w82IDeMl5cfWTP/XtoPS/DNg6V/FfRMlO/T87lQ1sbmSlPdXqCHzseAXJdJqOK1Wk
 1nWtgh7ZScL+XUy8ePANoIx2YFoaRTVvy02zEgvutD8e191gWOqC+tf2ShBvgGUxwjYonOio8
 wKhdqLdmHrPgMoC6ILHH9GeUcJyagc7+jTWjJq6f7zXNhNTCvoq5Mg4FXQeNBwjDEPwXrWvJV
 ynu6nAWULXw4+IUbwB9UuIpWWtukRCCiAx3x/YFHqta5GYvff3eAO37hEAHzqY06Hfk2LKmL7
 lahEv5Jhf4MCAfhO5WhD2L6W6lsVSuAMYzUb0H7QKwMciskhNVuUMTUuFckvzbnkO1F+dNVzO
 L6eP2aowal7nkAJFb/M3Cp9gbNNOG2kzLZVT8Fc+Ezj1C+A9lGklfWJEE2IsLAH45+vTdoNWM
 MeXaWDLWBwYqxhrGWKc1L52tHsrDWdTcGQbHIUPeQ8k2T9o+iNGYXynEF+fK6GoaZ0WPwdV32
 uavPGGoxnbAkyMYt52CLXbDPY0HWZXXj/+6s4weE54QrRvk33GPGj8kSvp2BMPVSFv9ZvIpoJ
 5nRO64TS4brSQuqZvoguBKbH6LbniTZDGt94A29iSEqINR4mTNxnUPJhWVvecsvpwuQ1f5RvP
 FkstAC/yBkuJxS731Y7U0oWRMOYRhdUUc5B8BU4SH+Wh+qhHOzgynqLMu4sMDV5ZCQhTkgy36
 z64Wyh1h9JXu6+eH/OXVAYyaWKesEUvTNG7p00B5qz9q90a/c/e0hQXFM8cBEzxqzNKidisAt
 1Mz2bo4OgEnJvtqTPNBLHiGSbMWk7QoV1fUk75ALnfjX8Wlb+S+/OaejTAafFiqEkI4htq+iR
 FPEaJHYvCVUQVVLnE19KGftux1zL7XHxE+I0iAziMPs49BoeOSm461ysNhiPjWo3U4RwtTM0X
 Km3oeuJ3tl1POnBt3fmq8/s1TWmkTu520VEGooSYAoarrXQ3hsBarkj2b7KnnWl8Y9X8nxU2K
 Ieqz1ew2T8uFO/rZLUn2CYMmQflqpxMoimpHo682UKYm1M1U7TQZ1HML9DA8lgSZgKANy5ZRM
 a7VcIcymeOjO20=
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

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + count * size" in the kzalloc() function.

[1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-cod=
ed-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/usb/host/ohci-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 1f5e69314a17..666b1c665188 100644
=2D-- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -191,8 +191,7 @@ static int ohci_urb_enqueue (
 	}

 	/* allocate the private part of the URB */
-	urb_priv =3D kzalloc (sizeof (urb_priv_t) + size * sizeof (struct td *),
-			mem_flags);
+	urb_priv =3D kzalloc(struct_size(urb_priv, td, size), mem_flags);
 	if (!urb_priv)
 		return -ENOMEM;
 	INIT_LIST_HEAD (&urb_priv->pending);
=2D-
2.25.1

