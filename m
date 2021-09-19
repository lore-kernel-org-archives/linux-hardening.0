Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8A4C433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 19 Sep 2021 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8666101C
	for <linux-hardening@archiver.kernel.org>; Sun, 19 Sep 2021 13:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhISNj1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 19 Sep 2021 09:39:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:33671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230520AbhISNj0 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 19 Sep 2021 09:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632058665;
        bh=dpjCOuKB0TZy7jl7Q6EZkoIUODpfOzZ8mzMHRj/tlR8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=aX+/dYy8K7jjYR+BNVzCTOS9DKWcZByht1WI8r1M3J+x5J9obfL3fqM5z9wz1Tyff
         CEuL60E9RuBCF8sRjK5ggoFaZVn2p+Y52BPLAaKqTJREH3EDZsxLkLD+Y+4JFiGWQI
         0KeB4TDiMRArz+h/y+VHFxP2PtxNUIyqqYJTm890=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MjS9I-1nBh9G3VgQ-00l1HA; Sun, 19 Sep 2021 15:37:45 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Len Baker <len.baker@gmx.com>,
        gushengxian <gushengxian@yulong.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usx2y: Prefer struct_size over open coded arithmetic
Date:   Sun, 19 Sep 2021 15:37:27 +0200
Message-Id: <20210919133727.44694-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P9oIxYBOWvzrzNnQljfTLmWev1T5GgHrU1V0RW+hDl7hechpNCb
 yXApUgoBWVxF/hzexad3zye4uplzArdeOjM9blm/ubzqrtsjPXSAIU3Y8mu0dQU0QAcQ1MB
 p0LIGGOCYOqIENCu1dFEnIqSFkGQbrgg9KPffwnm5rPkOZyIBZ9uvRb9ygXyTqO3TmtzITx
 zOntSI0hJjd7wfEXSwGUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NfIJcycmvpQ=:1tfk/HaLRv0twRHFyFsZY4
 8dVjG0/gT1xtsEm368V9IzmJcc8UMgvp7myybpGLqGoSdoGNO0/axAwj+rxulDg9JWUZbcbXH
 fGVgDB1Eidpj933sk24qotHY/keC+oVlxRDGnuzTyRCG06ggMN1nVqry6nd1d491/RD6uoj38
 NTNiHfgRavCvlaAvgN3KH/6QTuUz25hFNuy75CS5G6LXO/eW+1rSgdCl/8Dc/ks1fNheBdbIc
 7JGPXOUO1yNak5ahprM/+4qYTt6yz3KF9SVzhZ+x7eoEfWQdPSlwYgJq6C7fs3DeXuWR8ieQY
 lbW3rxteq6HlARDpGMTVDMmi2LTo9IST7DBvAPhRKSk22/Yq2BT5vb8eGYOeZ3mHDWgXmgdyJ
 E7klhm7uSje4BY7IC0ye1McZCQ/CwRuc3iX6cp7312sVtzx4i+FG/CzEvk291xDeR4u9AlDCN
 mnQdYv7zhI7pK4mpBbu+DDKkbMjlfVP6wlp+lP8lubg9lkHYDbSJD8qgHBlPIe9Hwmh9DgJkn
 A8GuekYYGrsRyY3iEk5IOyhNwfPvJgs9OaOLNon79zADHJ4qjTG1WDNomVGOLU9n/qQMD58z/
 mqECHEeueFqftrvCw3IY3X0sPr8oII6lqK2RRKssg5wsIF78eVWJoZqiknK0/rm52TsEbLy3E
 lFwIU2pDBRyKzQJKqqAVHbZ0O+55IXlI1lmJcG2ATtMoPvjzj2T4bvcA95XrurjcAyzr/9eXw
 VG0GsheguVeVWD8Cgy8p45gRlSbzDtVv5oz5ApMfMCI470rGnbN6/Z+BRKAgM0v4xBPV542Gd
 LOEBUjj9Ltu0faGDw9q7zP1G/PefItDyA4KAHAYyA4OYLkW0rZFW0uLFhBz6gwS5vef8oFGUu
 UEFvlHa8Dfw66IcCFBEFoP/cgV5UO7j61XJhEz4Ak9CJ5vWKHumpepAfCMFoSENxyxeM/mJXz
 P2mDicAW9R7CN6ve6TTa+YRZXPauJAPxhl7aaTMo0z2f19wq0BYsSbPWdbh6OZjw1tqmV8ew9
 ddYOD+UMLzpE3x2UHarOcpB3FAgpXQAxFAFnfBfOJ30dgxaUIoC3F+cf8FwButwAfE8DbB/0O
 1FyE8i9QMgONYw=
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

In this case this is not actually dynamic size: all the operands
involved in the calculation are constant values. However it is better to
refactor this anyway, just to keep the open-coded math idiom out of
code.

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + size * count" in the kzalloc() function.

Also, take the opportunity to refactor the declaration variables to make
it more easy to read.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 sound/usb/usx2y/usbusx2yaudio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaud=
io.c
index c39cc6851e2d..cfc1ea53978d 100644
=2D-- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -668,14 +668,15 @@ static void i_usx2y_04int(struct urb *urb)

 static int usx2y_rate_set(struct usx2ydev *usx2y, int rate)
 {
-	int			err =3D 0, i;
-	struct snd_usx2y_urb_seq	*us =3D NULL;
-	int			*usbdata =3D NULL;
-	const struct s_c2	*ra =3D rate =3D=3D 48000 ? setrate_48000 : setrate_44=
100;
+	int err =3D 0, i;
+	struct snd_usx2y_urb_seq *us =3D NULL;
+	int *usbdata =3D NULL;
+	const struct s_c2 *ra =3D rate =3D=3D 48000 ? setrate_48000 : setrate_44=
100;
 	struct urb *urb;

 	if (usx2y->rate !=3D rate) {
-		us =3D kzalloc(sizeof(*us) + sizeof(struct urb *) * NOOF_SETRATE_URBS, =
GFP_KERNEL);
+		us =3D kzalloc(struct_size(us, urb, NOOF_SETRATE_URBS),
+			     GFP_KERNEL);
 		if (!us) {
 			err =3D -ENOMEM;
 			goto cleanup;
=2D-
2.25.1

